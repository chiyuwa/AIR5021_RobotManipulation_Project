#!/usr/bin/env python3
import json
import os

import rospy


def _normalize_label(value):
    return str(value or "").strip().lower().replace("-", "_").replace(" ", "_")


class RuntimeConfig(object):
    def __init__(self, raw):
        self.raw = raw

    @classmethod
    def from_rosparams(cls):
        return cls(
            {
                "deepseek": rospy.get_param("~deepseek", {}),
                "runtime": rospy.get_param("~runtime", {}),
                "safety": rospy.get_param("~safety", {}),
                "named_poses": rospy.get_param("~named_poses", {}),
                "gripper_commands": rospy.get_param("~gripper_commands", {}),
                "orientation_presets": rospy.get_param("~orientation_presets", {}),
                "named_waypoints": rospy.get_param("~named_waypoints", {}),
                "vision": rospy.get_param("~vision", {}),
                "prompt_template_path": rospy.get_param("~prompt_template_path", ""),
            }
        )

    @property
    def deepseek(self):
        return self.raw.get("deepseek", {})

    @property
    def runtime(self):
        return self.raw.get("runtime", {})

    @property
    def safety(self):
        return self.raw.get("safety", {})

    @property
    def named_poses(self):
        return self.raw.get("named_poses", {})

    @property
    def gripper_commands(self):
        return self.raw.get("gripper_commands", {})

    @property
    def orientation_presets(self):
        return self.raw.get("orientation_presets", {})

    @property
    def named_waypoints(self):
        return self.raw.get("named_waypoints", {})

    @property
    def vision(self):
        return self.raw.get("vision", {})

    @property
    def prompt_template_path(self):
        return self.raw.get("prompt_template_path", "")

    def get_deepseek_api_key(self):
        api_key = self.deepseek.get("api_key", "")
        if api_key:
            return api_key
        env_name = self.deepseek.get("api_key_env", "DEEPSEEK_API_KEY")
        return os.environ.get(env_name, "")

    def get_reference_frame(self):
        reference_frame = self.runtime.get("reference_frame", "")
        if reference_frame:
            return reference_frame
        namespace = rospy.get_namespace().strip("/")
        if namespace:
            return namespace + "/base_link"
        return "base_link"

    def get_vision_detection_labels(self):
        labels = self.vision.get("detection_labels", self.vision.get("target_labels", []))
        return [_normalize_label(label) for label in labels if str(label).strip()]

    def get_vision_label_aliases(self):
        aliases = {}
        for key, value in self.vision.get("label_aliases", {}).items():
            normalized_key = _normalize_label(key)
            normalized_value = _normalize_label(value)
            if normalized_key and normalized_value:
                aliases[normalized_key] = normalized_value
        return aliases

    def canonicalize_vision_label(self, value):
        normalized = _normalize_label(value)
        if not normalized:
            return ""
        aliases = self.get_vision_label_aliases()
        canonical = aliases.get(normalized, normalized)
        labels = self.get_vision_detection_labels()
        if labels and canonical not in labels:
            return ""
        return canonical

    def to_prompt_context(self):
        return {
            "named_poses_json": json.dumps(self.named_poses, ensure_ascii=False, sort_keys=True),
            "named_waypoints_json": json.dumps(self.named_waypoints, ensure_ascii=False, sort_keys=True),
            "orientation_presets_json": json.dumps(self.orientation_presets, ensure_ascii=False, sort_keys=True),
            "workspace_limits_json": json.dumps(self.safety.get("workspace", {}), ensure_ascii=False, sort_keys=True),
            "vision_labels_json": json.dumps(self.get_vision_detection_labels(), ensure_ascii=False, sort_keys=True),
            "max_steps": str(self.safety.get("max_steps", 20)),
        }
