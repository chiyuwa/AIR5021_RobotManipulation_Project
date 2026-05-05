# AIR5021 Robot Manipulation Project

## Introduction

This project implements an LLM-guided, vision-based robotic manipulation system for long-sequence block pick-and-place tasks. The system allows a user to input a natural language command, such as asking the robot to detect a block, pick it up, and place it at a predefined target position. A Large Language Model is used as the high-level task planner, while a YOLO-based visual detector locates the target block in the camera image. The detected pixel position is converted into the robot base coordinate frame, and the Sagittarius robotic arm executes the manipulation sequence through ROS, MoveIt, and gripper control.

The project integrates natural language understanding, visual perception, coordinate calibration, safety checking, and physical robot execution into a closed-loop robotic control pipeline. Instead of directly allowing the LLM to control the robot, the system converts user instructions into a constrained JSON-style task plan, which is then validated and executed by the local ROS-based executor. This improves both flexibility and safety. The main developed package is `sagittarius_llm_control`. :contentReference[oaicite:0]{index=0}

## Usage

### 1. Start the ROS environment

Make sure the Sagittarius arm, camera, MoveIt environment, and required ROS packages are properly installed and configured. Then build and source the workspace:

```bash
catkin_make
source devel/setup.bash
```

### 2. Launch the system

Start the integrated launch file for the robot, visual detection module, and LLM task server:

```bash
roslaunch sagittarius_llm_control llm_control.launch
```

### 3. Test visual detection

Before running the full task, test whether the camera and YOLO detector can correctly detect the target block:

```bash
rosservice call /sgr532/detect_block
```

### 4. Test LLM planning only

Use the plan-only mode to check whether the natural language instruction can be correctly converted into a structured task plan:

```bash
rosrun sagittarius_llm_control llm_task_cli.py --plan-only "识别方块，抓取后放到 place_ready"
```

The expected output should include a structured action such as:

```bash
{
  "action": "pick_detected_block",
  "target_label": "block",
  "place_target": "place_ready"
}
```

### 5. Run the full manipulation task

After confirming that the plan and visual detection are correct, execute the full task:

```bash
rosrun sagittarius_llm_control llm_task_cli.py "抓取方块并放到 place_ready"
```

The robot will move to the observation pose, detect the block, calculate its robot-frame position, grasp it, lift it, move to the predefined placement pose, and release it.

## Notes

- The LLM is only used for high-level task planning and does not directly control the robot motors.
- The local executor performs safety checks before calling MoveIt.
- The current system is designed for tabletop single-block manipulation.
- If the grasp position is slightly biased, adjust the calibration parameters or `vision.position_offset_xyz` in the configuration file.
- It is recommended to test in the following order: camera topic, YOLO detection, plan-only mode, named waypoints, and full robot execution.

