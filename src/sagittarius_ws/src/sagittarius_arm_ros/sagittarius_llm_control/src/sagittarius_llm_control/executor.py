#!/usr/bin/env python3
import math
import sys

import moveit_commander
import rospy
import tf.transformations as transformations

from sagittarius_llm_control.vision_client import VisionBlockDetectorClient, VisionClientError


class ExecutionError(RuntimeError):
    pass


def _angular_distance(a, b):
    diff = (a - b + math.pi) % (2.0 * math.pi) - math.pi
    return abs(diff)


def _interpolate_angle(a, b, ratio):
    diff = (b - a + math.pi) % (2.0 * math.pi) - math.pi
    return a + diff * ratio


class SagittariusTaskExecutor(object):
    def __init__(self, config):
        self._config = config
        self._runtime = config.runtime
        self._safety = config.safety
        self._vision = config.vision
        self._default_velocity = float(self._runtime.get("velocity_scaling", 0.2))
        self._default_acceleration = float(self._runtime.get("acceleration_scaling", 0.2))
        self._vision_client = None

        moveit_commander.roscpp_initialize(sys.argv)
        self.arm_group = moveit_commander.MoveGroupCommander(self._runtime.get("arm_group", "sagittarius_arm"))
        self.gripper_group = moveit_commander.MoveGroupCommander(
            self._runtime.get("gripper_group", "sagittarius_gripper")
        )

        self.arm_group.allow_replanning(False)
        self.arm_group.set_pose_reference_frame(self._config.get_reference_frame())
        self.arm_group.set_goal_position_tolerance(float(self._runtime.get("position_tolerance", 0.003)))
        self.arm_group.set_goal_orientation_tolerance(float(self._runtime.get("orientation_tolerance", 0.03)))
        self.arm_group.set_max_velocity_scaling_factor(self._default_velocity)
        self.arm_group.set_max_acceleration_scaling_factor(self._default_acceleration)
        self.gripper_group.set_goal_joint_tolerance(0.001)

        self.end_effector_link = self.arm_group.get_end_effector_link()
        rospy.loginfo("SagittariusTaskExecutor end effector: %s", self.end_effector_link)

    def _get_vision_client(self):
        if self._vision_client is None:
            self._vision_client = VisionBlockDetectorClient(self._config)
        return self._vision_client

    def validate_plan(self, plan):
        workspace = self._safety.get("workspace", {})
        for step in plan.get("steps", []):
            if step["type"] != "move_pose":
                continue
            waypoint = self._config.named_waypoints.get(step.get("target_name", ""), {})
            position = step.get("position") or waypoint.get("position")
            if position is None:
                continue
            x, y, z = position
            self._check_workspace(x, y, z, workspace)

    def execute_plan(self, plan):
        logs = []
        self.validate_plan(plan)

        for index, step in enumerate(plan.get("steps", []), start=1):
            logs.append(self._execute_step(index, step))

        summary = "Executed {} steps successfully.".format(len(plan.get("steps", [])))
        return summary, logs

    def _execute_step(self, index, step):
        step_type = step["type"]
        if step_type == "move_pose":
            description = self._execute_move_pose(step)
        elif step_type == "move_named_pose":
            description = self._execute_named_pose(step)
        elif step_type == "gripper":
            description = self._execute_gripper(step)
        elif step_type == "pick_detected_block":
            description = self._execute_pick_detected_block(step)
        elif step_type == "wait":
            rospy.sleep(step["seconds"])
            description = "step {} wait {:.2f}s".format(index, step["seconds"])
        elif step_type == "comment":
            description = "step {} comment: {}".format(index, step.get("text", ""))
        else:
            raise ExecutionError("Unsupported execution step type: {}".format(step_type))

        settle = float(self._runtime.get("execution_settle_sec", 0.5))
        if settle > 0.0 and step_type in ("move_pose", "move_named_pose", "gripper"):
            rospy.sleep(settle)
        return description

    def _execute_named_pose(self, step):
        pose_name = self._config.named_poses[step["name"]]
        self.arm_group.set_named_target(pose_name)
        self._plan_and_execute_current_target()
        return "move_named_pose -> {}".format(step["name"])

    def _execute_gripper(self, step):
        target = self._config.gripper_commands[step["command"]]
        self.gripper_group.set_joint_value_target(target)
        result = self.gripper_group.go(wait=True)
        self.gripper_group.stop()
        current = self.gripper_group.get_current_joint_values()
        tolerance = 0.003
        reached = len(current) >= len(target) and all(
            abs(float(current[index]) - float(target[index])) <= tolerance for index in range(len(target))
        )
        if result is False and not reached:
            raise ExecutionError("Gripper command failed: {}".format(step["command"]))
        return "gripper -> {}".format(step["command"])

    def _build_move_pose_step(self, position=None, target_name=None, orientation_preset=None, velocity_scale=None):
        return {
            "type": "move_pose",
            "reason": "",
            "target_name": target_name,
            "position": list(position) if position is not None else None,
            "orientation_preset": orientation_preset,
            "orientation_rpy": None,
            "velocity_scale": float(velocity_scale if velocity_scale is not None else self._default_velocity),
        }

    def _detect_block_with_fallback(self, target_label, observation_waypoint, logs):
        detect_from_current_pose_first = bool(self._vision.get("detect_from_current_pose_first", False))
        current_pose_error = "current-pose detection was not attempted"

        if detect_from_current_pose_first:
            try:
                detection = self._get_vision_client().detect(target_label)
                logs.append("vision -> detection succeeded from current pose")
                return detection, "current_pose"
            except VisionClientError as exc:
                current_pose_error = str(exc)
                logs.append("vision -> current pose detection failed: {}".format(current_pose_error))
                if not observation_waypoint:
                    raise
        else:
            current_pose_error = "current-pose detection disabled by config"
            logs.append("vision -> skipping current pose detection")

        if not observation_waypoint:
            raise ExecutionError("No observation waypoint is configured for vision detection.")

        logs.append(
            self._execute_move_pose(
                self._build_move_pose_step(target_name=observation_waypoint)
            )
        )
        try:
            detection = self._get_vision_client().detect(target_label)
            logs.append("vision -> detection succeeded after moving to {}".format(observation_waypoint))
            return detection, observation_waypoint
        except VisionClientError as observation_error:
            raise ExecutionError(
                "Detection failed from current pose ({}) and after moving to {} ({}).".format(
                    current_pose_error,
                    observation_waypoint,
                    observation_error,
                )
            )

    def _execute_pick_detected_block(self, step):
        target_label = step.get("target_label") or str(self._vision.get("default_target_label", "")).strip() or ""
        place_target_name = step.get("place_target_name") or self._vision.get("place_target_name", "place_ready")
        observation_waypoint = str(self._vision.get("observation_waypoint", "observation")).strip()
        orientation_preset = str(self._vision.get("grasp_orientation_preset", "vertical_down")).strip() or None
        velocity_scale = float(self._vision.get("velocity_scale", self._default_velocity))
        pregrasp_z = float(self._vision.get("pregrasp_z", 0.16))
        pick_z = float(self._vision.get("pick_z", 0.035))
        lift_z = float(self._vision.get("lift_z", pregrasp_z))
        open_command = str(self._vision.get("gripper_open_command", "open")).strip()
        close_command = str(self._vision.get("gripper_close_command", "close")).strip()

        logs = []
        if observation_waypoint:
            logs.append("vision -> preferred observation waypoint: {}".format(observation_waypoint))

        detection, detection_source = self._detect_block_with_fallback(target_label, observation_waypoint, logs)

        base_x = float(detection.position.x)
        base_y = float(detection.position.y)
        if detection_source == "current_pose" and bool(self._vision.get("use_current_pose_offset_for_pick", True)):
            current_position, _ = self._get_current_pose()
            offset_xyz = self._vision.get("position_offset_xyz", [0.0, 0.0, 0.0])
            try:
                offset_x = float(offset_xyz[0])
                offset_y = float(offset_xyz[1])
            except (TypeError, ValueError, IndexError):
                raise ExecutionError("vision.position_offset_xyz must contain numeric x/y offsets.")
            base_x = float(current_position[0]) + offset_x
            base_y = float(current_position[1]) + offset_y
            logs.append(
                "vision -> using current pose anchor with offset, grasp base=({:.4f}, {:.4f})".format(
                    base_x,
                    base_y,
                )
            )
        logs.append(
            "vision -> label={} confidence={:.3f} pixel=({}, {}) base=({:.4f}, {:.4f})".format(
                detection.detected_label,
                float(detection.confidence),
                int(detection.center_u),
                int(detection.center_v),
                base_x,
                base_y,
            )
        )

        logs.append(self._execute_gripper({"command": open_command}))
        logs.append(
            self._execute_move_pose(
                self._build_move_pose_step(
                    position=[base_x, base_y, pregrasp_z],
                    orientation_preset=orientation_preset,
                    velocity_scale=velocity_scale,
                )
            )
        )
        logs.append(
            self._execute_move_pose(
                self._build_move_pose_step(
                    position=[base_x, base_y, pick_z],
                    orientation_preset=orientation_preset,
                    velocity_scale=velocity_scale,
                )
            )
        )
        logs.append(self._execute_gripper({"command": close_command}))
        logs.append(
            self._execute_move_pose(
                self._build_move_pose_step(
                    position=[base_x, base_y, lift_z],
                    orientation_preset=orientation_preset,
                    velocity_scale=velocity_scale,
                )
            )
        )
        logs.append(self._execute_move_pose(self._build_move_pose_step(target_name=place_target_name)))
        logs.append(self._execute_gripper({"command": open_command}))
        return "pick_detected_block -> " + " | ".join(logs)

    def _execute_move_pose(self, step):
        current_position, current_rpy = self._get_current_pose()
        target_position, target_rpy = self._resolve_target(step, current_position, current_rpy)

        translation_limit = float(self._safety.get("max_translation_per_step", 0.25))
        rotation_limit = float(self._safety.get("max_rotation_per_step", 3.14))

        translation_delta = math.sqrt(
            (target_position[0] - current_position[0]) ** 2
            + (target_position[1] - current_position[1]) ** 2
            + (target_position[2] - current_position[2]) ** 2
        )
        rotation_delta = max(
            _angular_distance(target_rpy[0], current_rpy[0]),
            _angular_distance(target_rpy[1], current_rpy[1]),
            _angular_distance(target_rpy[2], current_rpy[2]),
        )

        segment_count = self._compute_segment_count(translation_delta, translation_limit, rotation_delta, rotation_limit)

        velocity_scale = float(step.get("velocity_scale", self._default_velocity))
        try:
            self.arm_group.set_max_velocity_scaling_factor(velocity_scale)
            self.arm_group.set_max_acceleration_scaling_factor(min(velocity_scale, self._default_acceleration))
            for segment_index in range(1, segment_count + 1):
                ratio = float(segment_index) / float(segment_count)
                intermediate_position = [
                    current_position[axis] + (target_position[axis] - current_position[axis]) * ratio for axis in range(3)
                ]
                intermediate_rpy = [_interpolate_angle(current_rpy[axis], target_rpy[axis], ratio) for axis in range(3)]
                self.arm_group.set_pose_target(intermediate_position + intermediate_rpy, self.end_effector_link)
                self._plan_and_execute_current_target()
        finally:
            self.arm_group.set_max_velocity_scaling_factor(self._default_velocity)
            self.arm_group.set_max_acceleration_scaling_factor(self._default_acceleration)

        suffix = ""
        if segment_count > 1:
            suffix = " via {} segments".format(segment_count)
        return "move_pose -> position={} rpy={}{}".format(
            [round(item, 4) for item in target_position],
            [round(item, 4) for item in target_rpy],
            suffix,
        )

    def _compute_segment_count(self, translation_delta, translation_limit, rotation_delta, rotation_limit):
        translation_segments = 1
        rotation_segments = 1

        if translation_limit > 0.0:
            translation_segments = int(math.ceil(translation_delta / translation_limit)) if translation_delta > 0.0 else 1
        elif translation_delta > 0.0:
            raise ExecutionError("max_translation_per_step must be positive when translation is required.")

        if rotation_limit > 0.0:
            rotation_segments = int(math.ceil(rotation_delta / rotation_limit)) if rotation_delta > 0.0 else 1
        elif rotation_delta > 0.0:
            raise ExecutionError("max_rotation_per_step must be positive when rotation is required.")

        return max(1, translation_segments, rotation_segments)

    def _resolve_target(self, step, current_position, current_rpy):
        waypoint = self._config.named_waypoints.get(step.get("target_name", ""), {})

        position = step.get("position")
        if position is None:
            position = waypoint.get("position", current_position)

        orientation_rpy = step.get("orientation_rpy")
        if orientation_rpy is None:
            orientation_preset = step.get("orientation_preset")
            if orientation_preset:
                orientation_rpy = self._resolve_orientation_preset(orientation_preset, current_rpy)
            elif waypoint.get("orientation_rpy") is not None:
                orientation_rpy = waypoint.get("orientation_rpy")
            elif waypoint.get("orientation_preset"):
                orientation_rpy = self._resolve_orientation_preset(waypoint["orientation_preset"], current_rpy)
            else:
                orientation_rpy = current_rpy

        if orientation_rpy is None:
            orientation_rpy = current_rpy

        self._check_workspace(position[0], position[1], position[2], self._safety.get("workspace", {}))
        return list(position), list(orientation_rpy)

    def _resolve_orientation_preset(self, preset_name, current_rpy):
        preset_value = self._config.orientation_presets[preset_name]
        if preset_value in (None, "__KEEP_CURRENT__"):
            return current_rpy
        return preset_value

    def _check_workspace(self, x, y, z, workspace):
        x_range = workspace.get("x", [])
        y_range = workspace.get("y", [])
        z_range = workspace.get("z", [])
        if x_range and not (float(x_range[0]) <= x <= float(x_range[1])):
            raise ExecutionError("x={} is outside the configured workspace {}.".format(x, x_range))
        if y_range and not (float(y_range[0]) <= y <= float(y_range[1])):
            raise ExecutionError("y={} is outside the configured workspace {}.".format(y, y_range))
        if z_range and not (float(z_range[0]) <= z <= float(z_range[1])):
            raise ExecutionError("z={} is outside the configured workspace {}.".format(z, z_range))

    def _get_current_pose(self):
        pose = self.arm_group.get_current_pose(self.end_effector_link).pose
        quaternion = [pose.orientation.x, pose.orientation.y, pose.orientation.z, pose.orientation.w]
        rpy = list(transformations.euler_from_quaternion(quaternion))
        position = [pose.position.x, pose.position.y, pose.position.z]
        return position, rpy

    def _plan_and_execute_current_target(self):
        self.arm_group.set_start_state_to_current_state()
        plan = self.arm_group.plan()
        if isinstance(plan, tuple):
            plan = plan[1]

        if not getattr(plan, "joint_trajectory", None) or not plan.joint_trajectory.points:
            self.arm_group.clear_pose_targets()
            raise ExecutionError("MoveIt could not find a valid plan for the requested target.")

        result = self.arm_group.execute(plan, wait=True)
        self.arm_group.stop()
        self.arm_group.clear_pose_targets()
        if result is False:
            raise ExecutionError("MoveIt execution failed.")
