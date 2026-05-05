# Sagittarius LLM Control

`sagittarius_llm_control` is a standalone ROS package that bridges:

1. DeepSeek natural-language planning
2. A local JSON task DSL with safety checks
3. Sagittarius MoveIt execution
4. Optional YOLO-based block detection for pick-and-place

The package is intentionally separated from the existing driver and MoveIt packages so you can iterate on long-horizon task planning without modifying the vendor code.

See [docs/USAGE.md](docs/USAGE.md) for the full setup and operation flow.
See [docs/操作指南.md](docs/操作指南.md) for the YOLO vision pick-and-place workflow.
