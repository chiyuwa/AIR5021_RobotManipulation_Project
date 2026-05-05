cmake_minimum_required(VERSION 3.0.2)
project(sagittarius_llm_control)

find_package(catkin REQUIRED COMPONENTS
  cv_bridge
  geometry_msgs
  message_generation
  moveit_commander
  moveit_msgs
  sensor_msgs
  rospy
  std_msgs
  tf
)

catkin_python_setup()

add_service_files(
  FILES
  DetectBlock.srv
  ExecuteNaturalLanguageTask.srv
)

generate_messages(
  DEPENDENCIES
  geometry_msgs
  std_msgs
)

catkin_package(
  CATKIN_DEPENDS
    cv_bridge
    geometry_msgs
    message_runtime
    moveit_commander
    moveit_msgs
    sensor_msgs
    rospy
    std_msgs
    tf
)

catkin_install_python(PROGRAMS
  scripts/llm_task_cli.py
  scripts/llm_task_server.py
  scripts/print_current_pose.py
  scripts/yolo_block_detector.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

install(DIRECTORY
  config
  docs
  launch
  prompts
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)
