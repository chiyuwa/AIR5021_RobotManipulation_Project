# Install script for directory: /home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/robotics/team8/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sagittarius_object_color_detector/action" TYPE FILE FILES "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/action/SGRCtrl.action")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sagittarius_object_color_detector/msg" TYPE FILE FILES
    "/home/robotics/team8/devel/share/sagittarius_object_color_detector/msg/SGRCtrlAction.msg"
    "/home/robotics/team8/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionGoal.msg"
    "/home/robotics/team8/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionResult.msg"
    "/home/robotics/team8/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionFeedback.msg"
    "/home/robotics/team8/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg"
    "/home/robotics/team8/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg"
    "/home/robotics/team8/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sagittarius_object_color_detector/cmake" TYPE FILE FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/catkin_generated/installspace/sagittarius_object_color_detector-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/robotics/team8/devel/include/sagittarius_object_color_detector")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/robotics/team8/devel/share/roseus/ros/sagittarius_object_color_detector")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/robotics/team8/devel/share/common-lisp/ros/sagittarius_object_color_detector")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/robotics/team8/devel/share/gennodejs/ros/sagittarius_object_color_detector")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/robotics/team8/devel/lib/python3/dist-packages/sagittarius_object_color_detector")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/robotics/team8/devel/lib/python3/dist-packages/sagittarius_object_color_detector")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/sagittarius_object_color_detector" TYPE FILE FILES "/home/robotics/team8/devel/include/sagittarius_object_color_detector/HSVParamsConfig.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages/sagittarius_object_color_detector" TYPE FILE FILES "/home/robotics/team8/devel/lib/python3/dist-packages/sagittarius_object_color_detector/__init__.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/robotics/team8/devel/lib/python3/dist-packages/sagittarius_object_color_detector/cfg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages/sagittarius_object_color_detector" TYPE DIRECTORY FILES "/home/robotics/team8/devel/lib/python3/dist-packages/sagittarius_object_color_detector/cfg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/catkin_generated/installspace/sagittarius_object_color_detector.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sagittarius_object_color_detector/cmake" TYPE FILE FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/catkin_generated/installspace/sagittarius_object_color_detector-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sagittarius_object_color_detector/cmake" TYPE FILE FILES
    "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/catkin_generated/installspace/sagittarius_object_color_detectorConfig.cmake"
    "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/catkin_generated/installspace/sagittarius_object_color_detectorConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sagittarius_object_color_detector" TYPE FILE FILES "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/package.xml")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/sagittarius_object_color_detector" TYPE PROGRAM FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/catkin_generated/installspace/calibration.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/sagittarius_object_color_detector" TYPE PROGRAM FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/catkin_generated/installspace/calibration_pose.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/sagittarius_object_color_detector" TYPE PROGRAM FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/catkin_generated/installspace/color_classification.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/sagittarius_object_color_detector" TYPE PROGRAM FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/catkin_generated/installspace/color_classification_fixed.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/sagittarius_object_color_detector" TYPE PROGRAM FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/catkin_generated/installspace/grasp_once.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/sagittarius_object_color_detector" TYPE PROGRAM FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/catkin_generated/installspace/sgr_ctrl.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/sagittarius_object_color_detector" TYPE PROGRAM FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/catkin_generated/installspace/tool_get_hsv.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/sagittarius_object_color_detector" TYPE PROGRAM FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/catkin_generated/installspace/publish_start_to_cali.sh")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/sagittarius_object_color_detector" TYPE PROGRAM FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/catkin_generated/installspace/send_topic.sh")
endif()

