# Install script for directory: /home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control

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
  include("/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control/catkin_generated/safe_execute_install.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sagittarius_llm_control/srv" TYPE FILE FILES
    "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control/srv/DetectBlock.srv"
    "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control/srv/ExecuteNaturalLanguageTask.srv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sagittarius_llm_control/cmake" TYPE FILE FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control/catkin_generated/installspace/sagittarius_llm_control-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/robotics/team8/devel/include/sagittarius_llm_control")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/robotics/team8/devel/share/roseus/ros/sagittarius_llm_control")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/robotics/team8/devel/share/common-lisp/ros/sagittarius_llm_control")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/robotics/team8/devel/share/gennodejs/ros/sagittarius_llm_control")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/robotics/team8/devel/lib/python3/dist-packages/sagittarius_llm_control")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/robotics/team8/devel/lib/python3/dist-packages/sagittarius_llm_control" REGEX "/\\_\\_init\\_\\_\\.py$" EXCLUDE REGEX "/\\_\\_init\\_\\_\\.pyc$" EXCLUDE)
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/robotics/team8/devel/lib/python3/dist-packages/sagittarius_llm_control" FILES_MATCHING REGEX "/home/robotics/team8/devel/lib/python3/dist-packages/sagittarius_llm_control/.+/__init__.pyc?$")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control/catkin_generated/installspace/sagittarius_llm_control.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sagittarius_llm_control/cmake" TYPE FILE FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control/catkin_generated/installspace/sagittarius_llm_control-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sagittarius_llm_control/cmake" TYPE FILE FILES
    "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control/catkin_generated/installspace/sagittarius_llm_controlConfig.cmake"
    "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control/catkin_generated/installspace/sagittarius_llm_controlConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sagittarius_llm_control" TYPE FILE FILES "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control/package.xml")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/sagittarius_llm_control" TYPE PROGRAM FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control/catkin_generated/installspace/llm_task_cli.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/sagittarius_llm_control" TYPE PROGRAM FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control/catkin_generated/installspace/llm_task_server.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/sagittarius_llm_control" TYPE PROGRAM FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control/catkin_generated/installspace/print_current_pose.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/sagittarius_llm_control" TYPE PROGRAM FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control/catkin_generated/installspace/yolo_block_detector.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sagittarius_llm_control" TYPE DIRECTORY FILES
    "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control/config"
    "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control/docs"
    "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control/launch"
    "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control/prompts"
    )
endif()

