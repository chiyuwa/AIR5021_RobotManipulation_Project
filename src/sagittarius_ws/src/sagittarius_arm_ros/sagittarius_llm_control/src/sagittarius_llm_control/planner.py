#!/usr/bin/env python3
import json


class PlanningError(RuntimeError):
    pass


def _ensure_float_list(values, expected_len, field_name):
    if values is None:
        return None
    if not isinstance(values, (list, tuple)) or len(values) != expected_len:
        raise PlanningError("{} must be a list with {} numeric elements.".format(field_name, expected_len))
    try:
        return [float(item) for item in values]
    except (TypeError, ValueError):
        raise PlanningError("{} contains non-numeric values.".format(field_name))


def _check_workspace(position, workspace):
    if position is None:
        return
    x, y, z = position
    x_range = workspace.get("x", [])
    y_range = workspace.get("y", [])
    z_range = workspace.get("z", [])
    if x_range and not (float(x_range[0]) <= x <= float(x_range[1])):
        raise PlanningError("x={} is outside the configured workspace {}.".format(x, x_range))
    if y_range and not (float(y_range[0]) <= y <= float(y_range[1])):
        raise PlanningError("y={} is outside the configured workspace {}.".format(y, y_range))
    if z_range and not (float(z_range[0]) <= z <= float(z_range[1])):
        raise PlanningError("z={} is outside the configured workspace {}.".format(z, z_range))


class NaturalLanguageTaskPlanner(object):
    def __init__(self, config, client):
        self._config = config
        self._client = client

    def plan(self, task_text):
        task_text = (task_text or "").strip()
        if not task_text:
            raise PlanningError("Task text is empty.")

        system_prompt = self._build_system_prompt()
        user_prompt = "User task:\n{}".format(task_text)
        raw_response = self._client.chat(system_prompt, user_prompt)
        plan = self._extract_json(raw_response)
        normalized = self._normalize_plan(plan)
        return normalized, raw_response

    def _build_system_prompt(self):
        template_path = self._config.prompt_template_path
        if not template_path:
            raise PlanningError("Prompt template path is empty.")
        with open(template_path, "r", encoding="utf-8") as handle:
            template = handle.read()

        context = self._config.to_prompt_context()
        return (
            template.replace("__NAMED_POSES_JSON__", context["named_poses_json"])
            .replace("__NAMED_WAYPOINTS_JSON__", context["named_waypoints_json"])
            .replace("__ORIENTATION_PRESETS_JSON__", context["orientation_presets_json"])
            .replace("__WORKSPACE_LIMITS_JSON__", context["workspace_limits_json"])
            .replace("__VISION_LABELS_JSON__", context["vision_labels_json"])
            .replace("__MAX_STEPS__", context["max_steps"])
        )

    def _extract_json(self, text):
        cleaned = (text or "").strip()
        if cleaned.startswith("```"):
            cleaned = cleaned.strip("`")
            if cleaned.startswith("json"):
                cleaned = cleaned[4:].strip()

        start = cleaned.find("{")
        end = cleaned.rfind("}")
        if start < 0 or end <= start:
            raise PlanningError("LLM response does not contain a JSON object.")

        try:
            return json.loads(cleaned[start : end + 1])
        except ValueError as exc:
            raise PlanningError("Failed to parse LLM JSON: {}".format(exc))

    def _normalize_plan(self, plan):
        if not isinstance(plan, dict):
            raise PlanningError("Plan must be a JSON object.")

        needs_clarification = bool(plan.get("needs_clarification", False))
        clarification_message = str(plan.get("clarification_message", "")).strip()
        summary = str(plan.get("task_summary", "")).strip() or "LLM-generated Sagittarius task"
        raw_steps = plan.get("steps", [])
        if not isinstance(raw_steps, list):
            raise PlanningError("steps must be a list.")

        max_steps = int(self._config.safety.get("max_steps", 20))
        if len(raw_steps) > max_steps:
            raise PlanningError("Plan has {} steps, which exceeds the limit {}.".format(len(raw_steps), max_steps))

        if needs_clarification:
            if not clarification_message:
                clarification_message = "The task is ambiguous and needs more information."
            return {
                "task_summary": summary,
                "needs_clarification": True,
                "clarification_message": clarification_message,
                "steps": [],
            }

        workspace = self._config.safety.get("workspace", {})
        normalized_steps = []
        for index, step in enumerate(raw_steps):
            if not isinstance(step, dict):
                raise PlanningError("Step {} is not a JSON object.".format(index))

            step_type = str(step.get("type", "")).strip()
            reason = str(step.get("reason", "")).strip()
            if step_type == "move_pose":
                target_name = str(step.get("target_name", "")).strip() or None
                if target_name and target_name not in self._config.named_waypoints:
                    raise PlanningError("Unknown named waypoint: {}".format(target_name))

                position = _ensure_float_list(step.get("position"), 3, "position")
                _check_workspace(position, workspace)
                orientation_preset = str(step.get("orientation_preset", "")).strip() or None
                if orientation_preset and orientation_preset not in self._config.orientation_presets:
                    raise PlanningError("Unknown orientation preset: {}".format(orientation_preset))

                if target_name:
                    waypoint_position = self._config.named_waypoints[target_name].get("position")
                    _check_workspace(waypoint_position, workspace)

                orientation_rpy = _ensure_float_list(step.get("orientation_rpy"), 3, "orientation_rpy")
                if not any([target_name, position, orientation_preset, orientation_rpy]):
                    raise PlanningError("move_pose requires target_name, position, orientation_preset, or orientation_rpy.")

                velocity_scale = float(step.get("velocity_scale", self._config.runtime.get("velocity_scaling", 0.2)))
                if velocity_scale <= 0.0 or velocity_scale > 1.0:
                    raise PlanningError("velocity_scale must be in (0, 1].")

                normalized_steps.append(
                    {
                        "type": step_type,
                        "reason": reason,
                        "target_name": target_name,
                        "position": position,
                        "orientation_preset": orientation_preset,
                        "orientation_rpy": orientation_rpy,
                        "velocity_scale": velocity_scale,
                    }
                )
            elif step_type == "move_named_pose":
                name = str(step.get("name", "")).strip()
                if name in self._config.named_waypoints:
                    waypoint = self._config.named_waypoints[name]
                    waypoint_position = waypoint.get("position")
                    _check_workspace(waypoint_position, workspace)
                    normalized_steps.append(
                        {
                            "type": "move_pose",
                            "reason": reason,
                            "target_name": name,
                            "position": None,
                            "orientation_preset": None,
                            "orientation_rpy": None,
                            "velocity_scale": float(self._config.runtime.get("velocity_scaling", 0.2)),
                        }
                    )
                    continue
                if name not in self._config.named_poses:
                    raise PlanningError("Unknown named pose: {}".format(name))
                normalized_steps.append({"type": step_type, "reason": reason, "name": name})
            elif step_type == "gripper":
                command = str(step.get("command", "")).strip()
                if command not in self._config.gripper_commands:
                    raise PlanningError("Unknown gripper command: {}".format(command))
                normalized_steps.append({"type": step_type, "reason": reason, "command": command})
            elif step_type in ("pick_detected_block", "pick_detected_object"):
                target_label_raw = str(step.get("target_label", "")).strip()
                target_label = None
                if target_label_raw:
                    target_label = self._config.canonicalize_vision_label(target_label_raw)
                    if not target_label:
                        raise PlanningError(
                            "Unknown vision target label: {}. Allowed labels: {}.".format(
                                step.get("target_label", ""),
                                self._config.get_vision_detection_labels(),
                            )
                        )
                place_target_name = str(
                    step.get("place_target_name", self._config.vision.get("place_target_name", "place_ready"))
                ).strip()
                if place_target_name and place_target_name not in self._config.named_waypoints:
                    raise PlanningError("Unknown place target waypoint: {}".format(place_target_name))
                normalized_steps.append(
                    {
                        "type": "pick_detected_block",
                        "reason": reason,
                        "target_label": target_label,
                        "place_target_name": place_target_name or None,
                    }
                )
            elif step_type == "wait":
                seconds = float(step.get("seconds", 0.0))
                if seconds < 0.0 or seconds > 60.0:
                    raise PlanningError("wait.seconds must be in [0, 60].")
                normalized_steps.append({"type": step_type, "reason": reason, "seconds": seconds})
            elif step_type == "comment":
                text = str(step.get("text", "")).strip()
                normalized_steps.append({"type": step_type, "reason": reason, "text": text})
            else:
                raise PlanningError("Unsupported step type: {}".format(step_type))

        return {
            "task_summary": summary,
            "needs_clarification": False,
            "clarification_message": "",
            "steps": normalized_steps,
        }
