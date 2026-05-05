# Sagittarius DeepSeek Long-Sequence Control Usage

## 1. What this package adds

After reading the current workspace, the best extension point is the existing MoveIt control stack:

- `sdk_sagittarius_arm` keeps the real arm driver and trajectory execution.
- `sagittarius_moveit` keeps planning groups such as `sagittarius_arm` and `sagittarius_gripper`.
- The new `sagittarius_llm_control` package adds a clean upper layer: `natural language -> DeepSeek -> structured plan -> safety checks -> MoveIt execution`.

This separation is important because the large model should not directly control motors. It should only output a constrained task plan. The local node remains the final authority for safety and execution.

## 2. Tasks that had to be completed

To make long-sequence text control work reliably, the project needs these parts:

1. A dedicated ROS package for LLM planning and execution orchestration.
2. A fixed task DSL so the model returns structured JSON instead of free text.
3. A DeepSeek API client.
4. A safety layer that checks workspace bounds, step count, and per-step motion size.
5. A MoveIt executor for arm pose motion, named poses, and gripper commands.
6. A ROS service and a CLI script so tasks can be triggered easily.
7. A launch file and configuration files so the package can be started consistently.
8. A usage document so the full flow is reproducible.

## 3. Package structure

Main path:

`src/sagittarius_arm_ros/sagittarius_llm_control`

Important files:

- `launch/llm_task_system.launch`: starts MoveIt and the LLM task server together.
- `config/runtime.yaml`: DeepSeek, safety, workspace, waypoint, and gripper configuration.
- `prompts/task_planner_system.txt`: planner prompt template sent to DeepSeek.
- `srv/ExecuteNaturalLanguageTask.srv`: ROS service definition for long-text tasks.
- `scripts/llm_task_server.py`: ROS service server.
- `scripts/llm_task_cli.py`: command-line client for sending tasks.
- `src/sagittarius_llm_control/planner.py`: JSON plan generation and validation.
- `src/sagittarius_llm_control/executor.py`: MoveIt execution layer.

## 4. Before first run

### 4.1 Configure your DeepSeek key

Use either of these methods:

Method A: environment variable

```bash
export DEEPSEEK_API_KEY="Your_Key"
```

Method B: pass it through launch

```bash
roslaunch sagittarius_llm_control llm_task_system.launch deepseek_api_key:=your_key_here
```

### 4.2 Calibrate your workspace

Edit:

`config/runtime.yaml`

You should at minimum adjust:

- `safety.workspace`
- `named_waypoints.pick_ready`
- `named_waypoints.pick_ready_2`
- `named_waypoints.pick_ready_3`
- `named_waypoints.place_ready`
- `named_waypoints.place_ready_2`
- `named_waypoints.place_ready_3`
- `orientation_presets.vertical_down`

The default values are only safe starting examples. They are not guaranteed to match your real robot installation.

## 5. Build

From the workspace root:

```bash
cd ~/team8
catkin_make
source devel/setup.bash
```

## 6. Start the system

If you want the launch file to also start MoveIt:

```bash
roslaunch sagittarius_llm_control llm_task_system.launch use_rviz:=true
```

If MoveIt is already running elsewhere, you can start only the LLM server:

```bash
roslaunch sagittarius_llm_control llm_task_system.launch start_moveit:=false
```

The main service will be exposed at:

```bash
/sgr532/execute_task
```

Status topics:

```bash
/sgr532/llm_task_status
/sgr532/llm_task_plan_json
```

If the CLI prints `timeout exceeded while waiting for service /sgr532/execute_task`, check these items first:

```bash
source ~/team8/devel/setup.bash
rosservice list | grep execute_task
```

- If you see `ERROR: Unable to communicate with master!`, start `roscore` or launch the full system first.
- If there is no `execute_task` service at all, start the server with `roslaunch sagittarius_llm_control llm_task_system.launch`.
- If the only service is `/execute_task`, you likely started the server directly without the `sgr532` namespace. Use `--service /execute_task` or the updated CLI, which can auto-fall back to that single discovered service.

## 7. Plan only

Use the CLI to inspect the model-generated JSON before real execution:

```bash
rosrun sagittarius_llm_control llm_task_cli.py \
  --text "先移动到pick_ready，然后末端垂直向下，最后闭合夹爪" \
  --plan-only
```

You can also call the service directly:

```bash
rosservice call /sgr532/execute_task \
  "text: '先移动到pick_ready，然后末端垂直向下，最后闭合夹爪'
plan_only: true"
```

## 8. Execute a real task

```bash
rosrun sagittarius_llm_control llm_task_cli.py \
  --text "先到 observation 点，再到 pick_ready，末端垂直向下，最后夹紧夹爪"
```

Another example with explicit coordinates:

```bash
rosrun sagittarius_llm_control llm_task_cli.py \
  --text "移动到坐标 x=0.20, y=0.05, z=0.12，然后夹爪垂直向下，等待1秒，再闭合夹爪"
```

Examples with additional named waypoints:

```bash
rosrun sagittarius_llm_control llm_task_cli.py \
  --text "先移动到pick_ready_2，然后闭合夹爪"
```

```bash
rosrun sagittarius_llm_control llm_task_cli.py \
  --text "抓取当前看到的方块并放到place_ready_2"
```

```bash
rosrun sagittarius_llm_control llm_task_cli.py \
  --text "抓取当前看到的方块并放到place_ready_3"
```

## 9. Recommended operating flow

For real hardware, the recommended flow is:

1. Start the robot and MoveIt normally.
2. Edit `runtime.yaml` so workspace bounds and named waypoints match your real table.
3. Run one or more `--plan-only` tests and inspect the returned JSON.
4. Confirm the requested coordinates stay inside `safety.workspace`.
5. Run the same instruction without `--plan-only`.
6. Start with slow motions by keeping `runtime.velocity_scaling` low.
7. Expand the DSL only after the basic move and gripper chain is stable.

Oversized pose moves are still safety-limited, but the executor now splits them into multiple smaller MoveIt goals automatically when they exceed `safety.max_translation_per_step` or `safety.max_rotation_per_step`.

## 10. Current capability boundary

This first version already supports:

- Long text task decomposition through DeepSeek
- Multi-step ordered execution
- Named waypoints
- Named arm poses
- Explicit Cartesian pose motion
- Orientation preset switching
- Gripper open, middle, and close
- Simple wait steps

This first version does not yet include:

- Vision-grounded object reference resolution
- Automatic failure recovery and re-planning
- Force feedback control
- Multi-object memory
- Learned skill library

## 11. Recommended next expansion order

Once this baseline is running, continue in this order:

1. Add a `skills.yaml` layer for reusable tasks such as `pick`, `place`, and `handover`.
2. Add perception grounding so text like "抓蓝色方块" resolves to coordinates.
3. Add execution feedback loops so failed grasps can trigger retries.
4. Add a world-state memory so long sequences can refer to previous results.
5. Add simulation regression cases for common text instructions.

## 12. Safety note

The LLM is only a planner. The local node should remain the only module allowed to:

- enforce workspace limits
- reject unsafe or oversized steps
- map names to calibrated coordinates
- send final commands to MoveIt

Do not bypass the local validation layer and do not let the model write raw motor commands directly.


## 中文简单版：
1 先修改 runtime.yaml 里的 safety.workspace、named_waypoints、orientation_presets.vertical_down，把它们校准成你自己的机械臂和桌面环境。
2 设置 DEEPSEEK_API_KEY，或者启动时传 deepseek_api_key:=...。
3 在 Ubuntu/ROS 环境里执行 catkin_make，然后 source devel/setup.bash。
4 启动 roslaunch sagittarius_llm_control llm_task_system.launch。
5 先用 rosrun sagittarius_llm_control llm_task_cli.py --text "先移动到pick_ready，然后末端垂直向下，最后闭合夹爪" --plan-only 看 JSON 规划结果。
6 没问题后再去掉 --plan-only 执行真机动作。
