#!/usr/bin/env python3
import rospy

from sagittarius_llm_control.srv import DetectBlock


class VisionClientError(RuntimeError):
    pass


class VisionBlockDetectorClient(object):
    def __init__(self, config):
        self._config = config
        self._proxy = None

    def _get_service_name(self):
        service_name = str(self._config.vision.get("service_name", "")).strip()
        if not service_name:
            raise VisionClientError("vision.service_name is empty.")
        return service_name

    def _get_proxy(self):
        if self._proxy is None:
            service_name = self._get_service_name()
            timeout_sec = float(self._config.vision.get("service_wait_timeout_sec", 5.0))
            try:
                rospy.wait_for_service(service_name, timeout=timeout_sec)
            except Exception as exc:
                raise VisionClientError("Vision service '{}' is unavailable: {}".format(service_name, exc))
            self._proxy = rospy.ServiceProxy(service_name, DetectBlock)
        return self._proxy

    def _call_detect(self, target_label):
        try:
            return self._get_proxy()(target_label)
        except Exception as exc:
            raise VisionClientError("Vision service call failed: {}".format(exc))

    def detect(self, target_label):
        response = self._call_detect(target_label)
        if response.success:
            return response

        if target_label and "No detection matched target label" in (response.error or ""):
            rospy.logwarn(
                "Vision target '%s' not found (%s). Retrying without target label filter.",
                target_label,
                response.error,
            )
            fallback_response = self._call_detect("")
            if fallback_response.success:
                return fallback_response
            raise VisionClientError(
                "Vision target '{}' was not found, and fallback detection also failed: {}".format(
                    target_label,
                    fallback_response.error or "Vision detector returned no result.",
                )
            )

        if not response.success:
            raise VisionClientError(response.error or "Vision detector returned no result.")
        return response
