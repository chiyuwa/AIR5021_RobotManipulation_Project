#!/usr/bin/env python3
import os
import threading

import cv2
from cv_bridge import CvBridge
import rospy
from sensor_msgs.msg import Image
import yaml

from sagittarius_llm_control.srv import DetectBlock, DetectBlockResponse

try:
    from ultralytics import YOLO
except ImportError:
    YOLO = None


def _normalize_label(value):
    return str(value or "").strip().lower().replace("-", "_").replace(" ", "_")


class YoloDetectorError(RuntimeError):
    pass


class YoloBlockDetectorNode(object):
    def __init__(self):
        self._bridge = CvBridge()
        self._lock = threading.Lock()
        self._latest_image = None
        self._latest_stamp = None

        self._vision = rospy.get_param("~vision", {})
        self._service_name = str(self._vision.get("service_name", "detect_block")).strip() or "detect_block"
        detection_labels = self._vision.get("detection_labels", self._vision.get("target_labels", []))
        self._allowed_labels = [_normalize_label(item) for item in detection_labels if str(item).strip()]
        self._label_aliases = {
            _normalize_label(key): _normalize_label(value)
            for key, value in self._vision.get("label_aliases", {}).items()
            if _normalize_label(key) and _normalize_label(value)
        }

        self._confidence_threshold = float(self._vision.get("confidence_threshold", 0.35))
        self._max_image_age_sec = float(self._vision.get("max_image_age_sec", 1.5))
        self._planar_z = float(self._vision.get("planar_z", 0.02))
        self._position_offset_xyz = self._load_position_offset(self._vision.get("position_offset_xyz", [0.0, 0.0, 0.0]))
        self._publish_debug_image = bool(self._vision.get("publish_debug_image", True))
        self._debug_image_pub = rospy.Publisher("vision/debug_image", Image, queue_size=1)

        self._k1, self._b1, self._k2, self._b2 = self._load_calibration(
            self._vision.get("calibration_file", "")
        )
        self._model = self._load_model(self._vision.get("model_path", ""))

        image_topic = str(self._vision.get("image_topic", "/usb_cam/image_raw")).strip()
        self._image_sub = rospy.Subscriber(image_topic, Image, self._image_callback, queue_size=1)
        self._service = rospy.Service(self._service_name, DetectBlock, self._handle_detect)
        rospy.loginfo(
            "YOLO block detector is ready. image_topic=%s service=%s",
            image_topic,
            rospy.resolve_name(self._service_name),
        )

    def _load_model(self, model_path):
        if YOLO is None:
            raise YoloDetectorError(
                "ultralytics is not installed. Please install ultralytics and torch before starting the detector."
            )
        model_path = str(model_path or "").strip()
        if not model_path:
            raise YoloDetectorError("vision.model_path is empty. Please point it to your trained YOLO model.")
        if not os.path.isfile(model_path):
            raise YoloDetectorError("YOLO model file does not exist: {}".format(model_path))
        rospy.loginfo("Loading YOLO model from %s", model_path)
        model = YOLO(model_path)
        self._configure_world_classes(model)
        return model

    def _configure_world_classes(self, model):
        class_prompts = self._vision.get("world_class_prompts", [])
        if not class_prompts:
            return
        if not hasattr(model, "set_classes"):
            rospy.logwarn("vision.world_class_prompts is set, but this YOLO model does not support set_classes.")
            return

        prompts = [str(item).strip() for item in class_prompts if str(item).strip()]
        if not prompts:
            return
        try:
            model.set_classes(prompts)
            rospy.loginfo("Configured YOLO-World class prompts: %s", prompts)
        except Exception as exc:
            raise YoloDetectorError("Failed to configure YOLO-World class prompts: {}".format(exc))

    def _load_calibration(self, calibration_file):
        calibration_file = str(calibration_file or "").strip()
        if not calibration_file:
            raise YoloDetectorError("vision.calibration_file is empty.")
        if not os.path.isfile(calibration_file):
            raise YoloDetectorError("Calibration file does not exist: {}".format(calibration_file))

        with open(calibration_file, "r", encoding="utf-8") as handle:
            content = yaml.safe_load(handle.read()) or {}

        regression = content.get("LinearRegression", {})
        try:
            return (
                float(regression["k1"]),
                float(regression["b1"]),
                float(regression["k2"]),
                float(regression["b2"]),
            )
        except (KeyError, TypeError, ValueError):
            raise YoloDetectorError(
                "Calibration file is missing LinearRegression.k1/b1/k2/b2: {}".format(calibration_file)
            )

    def _load_position_offset(self, values):
        if values is None:
            return [0.0, 0.0, 0.0]
        if not isinstance(values, (list, tuple)) or len(values) != 3:
            raise YoloDetectorError("vision.position_offset_xyz must be a list of 3 numbers.")
        try:
            return [float(item) for item in values]
        except (TypeError, ValueError):
            raise YoloDetectorError("vision.position_offset_xyz contains non-numeric values.")

    def _image_callback(self, msg):
        try:
            image = self._bridge.imgmsg_to_cv2(msg, "bgr8")
        except Exception as exc:
            rospy.logwarn_throttle(5.0, "Failed to convert image: %s", exc)
            return

        with self._lock:
            self._latest_image = image
            self._latest_stamp = msg.header.stamp if msg.header.stamp else rospy.Time.now()

    def _canonicalize_label(self, label):
        normalized = _normalize_label(label)
        if not normalized:
            return ""

        canonical = self._label_aliases.get(normalized)
        if not canonical:
            for allowed in self._allowed_labels:
                if normalized == allowed or normalized.startswith(allowed + "_") or normalized.endswith("_" + allowed):
                    canonical = allowed
                    break
        if not canonical:
            canonical = normalized

        if self._allowed_labels and canonical not in self._allowed_labels:
            return ""
        return canonical

    def _get_latest_image(self):
        with self._lock:
            if self._latest_image is None or self._latest_stamp is None:
                raise YoloDetectorError("No image has been received from the camera yet.")
            image = self._latest_image.copy()
            stamp = self._latest_stamp

        age = (rospy.Time.now() - stamp).to_sec()
        if age > self._max_image_age_sec:
            raise YoloDetectorError(
                "Latest camera image is too old ({:.2f}s > {:.2f}s).".format(age, self._max_image_age_sec)
            )
        return image

    def _predict(self, image):
        results = self._model.predict(source=image, conf=self._confidence_threshold, verbose=False)
        if not results:
            return []

        result = results[0]
        boxes = getattr(result, "boxes", None)
        if boxes is None or len(boxes) == 0:
            return []

        names = getattr(result, "names", {}) or {}
        detections = []
        xyxy_data = boxes.xyxy.cpu() if hasattr(boxes.xyxy, "cpu") else boxes.xyxy
        conf_data = boxes.conf.cpu() if hasattr(boxes.conf, "cpu") else boxes.conf
        cls_data = boxes.cls.cpu() if hasattr(boxes.cls, "cpu") else boxes.cls
        xyxy_list = xyxy_data.tolist()
        conf_list = conf_data.tolist()
        cls_list = cls_data.tolist()
        for xyxy, confidence, class_index in zip(xyxy_list, conf_list, cls_list):
            raw_label = names.get(int(class_index), str(int(class_index)))
            canonical_label = self._canonicalize_label(raw_label)
            if not canonical_label:
                continue
            x1, y1, x2, y2 = [float(item) for item in xyxy]
            center_u = int(round((x1 + x2) * 0.5))
            center_v = int(round((y1 + y2) * 0.5))
            detections.append(
                {
                    "raw_label": raw_label,
                    "label": canonical_label,
                    "confidence": float(confidence),
                    "bbox": (x1, y1, x2, y2),
                    "center_u": center_u,
                    "center_v": center_v,
                }
            )
        return detections

    def _pick_best_detection(self, detections, target_label):
        filtered = detections
        if target_label:
            filtered = [item for item in detections if item["label"] == target_label]
        if not filtered:
            raise YoloDetectorError(
                "No detection matched target label '{}'.".format(target_label) if target_label else "No detections found."
            )
        return max(filtered, key=lambda item: item["confidence"])

    def _pixel_to_base(self, center_u, center_v):
        raw_x = self._k1 * float(center_v) + self._b1
        raw_y = self._k2 * float(center_u) + self._b2
        raw_z = self._planar_z
        return (
            raw_x + self._position_offset_xyz[0],
            raw_y + self._position_offset_xyz[1],
            raw_z + self._position_offset_xyz[2],
        )

    def _publish_debug(self, image, detections, selected_detection):
        if not self._publish_debug_image:
            return

        debug_image = image.copy()
        for detection in detections:
            x1, y1, x2, y2 = [int(round(item)) for item in detection["bbox"]]
            color = (0, 255, 0) if detection is selected_detection else (255, 180, 0)
            cv2.rectangle(debug_image, (x1, y1), (x2, y2), color, 2)
            text = "{} {:.2f}".format(detection["label"], detection["confidence"])
            cv2.putText(debug_image, text, (x1, max(20, y1 - 8)), cv2.FONT_HERSHEY_SIMPLEX, 0.55, color, 2)

        try:
            self._debug_image_pub.publish(self._bridge.cv2_to_imgmsg(debug_image, "bgr8"))
        except Exception as exc:
            rospy.logwarn_throttle(5.0, "Failed to publish debug image: %s", exc)

    def _handle_detect(self, request):
        response = DetectBlockResponse()
        try:
            image = self._get_latest_image()
            target_label = self._canonicalize_label(request.target_label)
            if request.target_label and not target_label:
                raise YoloDetectorError(
                    "Unknown target label '{}'. Allowed labels: {}.".format(
                        request.target_label,
                        self._allowed_labels,
                    )
                )

            detections = self._predict(image)
            selected = self._pick_best_detection(detections, target_label)
            base_x, base_y, base_z = self._pixel_to_base(selected["center_u"], selected["center_v"])

            response.success = True
            response.detected_label = selected["label"]
            response.confidence = selected["confidence"]
            response.center_u = selected["center_u"]
            response.center_v = selected["center_v"]
            response.position.x = base_x
            response.position.y = base_y
            response.position.z = base_z
            response.error = ""

            self._publish_debug(image, detections, selected)
        except Exception as exc:
            response.success = False
            response.error = str(exc)
            rospy.logerr("YOLO detect_block failed: %s", exc)
        return response
