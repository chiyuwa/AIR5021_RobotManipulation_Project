# Install script for directory: /home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sdk_sagittarius_arm

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/sdk_sagittarius_arm" TYPE FILE FILES "/home/robotics/team8/devel/include/sdk_sagittarius_arm/SDKSagittariusArmConfig.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages/sdk_sagittarius_arm" TYPE FILE FILES "/home/robotics/team8/devel/lib/python3/dist-packages/sdk_sagittarius_arm/__init__.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/robotics/team8/devel/lib/python3/dist-packages/sdk_sagittarius_arm/cfg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages/sdk_sagittarius_arm" TYPE DIRECTORY FILES "/home/robotics/team8/devel/lib/python3/dist-packages/sdk_sagittarius_arm/cfg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sdk_sagittarius_arm/msg" TYPE FILE FILES
    "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sdk_sagittarius_arm/msg/ArmRadControl.msg"
    "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sdk_sagittarius_arm/msg/SingleRadControl.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sdk_sagittarius_arm/srv" TYPE FILE FILES
    "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sdk_sagittarius_arm/srv/ArmInfo.srv"
    "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sdk_sagittarius_arm/srv/ServoRtInfo.srv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sdk_sagittarius_arm/cmake" TYPE FILE FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sdk_sagittarius_arm/catkin_generated/installspace/sdk_sagittarius_arm-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/robotics/team8/devel/include/sdk_sagittarius_arm")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/robotics/team8/devel/share/roseus/ros/sdk_sagittarius_arm")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/robotics/team8/devel/share/common-lisp/ros/sdk_sagittarius_arm")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/robotics/team8/devel/share/gennodejs/ros/sdk_sagittarius_arm")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/robotics/team8/devel/lib/python3/dist-packages/sdk_sagittarius_arm")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/robotics/team8/devel/lib/python3/dist-packages/sdk_sagittarius_arm")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sdk_sagittarius_arm/catkin_generated/installspace/sdk_sagittarius_arm.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sdk_sagittarius_arm/cmake" TYPE FILE FILES "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sdk_sagittarius_arm/catkin_generated/installspace/sdk_sagittarius_arm-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sdk_sagittarius_arm/cmake" TYPE FILE FILES
    "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sdk_sagittarius_arm/catkin_generated/installspace/sdk_sagittarius_armConfig.cmake"
    "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sdk_sagittarius_arm/catkin_generated/installspace/sdk_sagittarius_armConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sdk_sagittarius_arm" TYPE FILE FILES "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sdk_sagittarius_arm/package.xml")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsdk_sagittarius_arm_lib.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsdk_sagittarius_arm_lib.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsdk_sagittarius_arm_lib.so"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/robotics/team8/devel/lib/libsdk_sagittarius_arm_lib.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsdk_sagittarius_arm_lib.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsdk_sagittarius_arm_lib.so")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsdk_sagittarius_arm_lib.so"
         OLD_RPATH "/usr/usr/lib/x86_64-linux-gnu:/opt/ros/noetic/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsdk_sagittarius_arm_lib.so")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/sdk_sagittarius_arm/sdk_sagittarius_arm" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/sdk_sagittarius_arm/sdk_sagittarius_arm")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/sdk_sagittarius_arm/sdk_sagittarius_arm"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/sdk_sagittarius_arm" TYPE EXECUTABLE FILES "/home/robotics/team8/devel/lib/sdk_sagittarius_arm/sdk_sagittarius_arm")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/sdk_sagittarius_arm/sdk_sagittarius_arm" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/sdk_sagittarius_arm/sdk_sagittarius_arm")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/sdk_sagittarius_arm/sdk_sagittarius_arm"
         OLD_RPATH "/usr/usr/lib/x86_64-linux-gnu:/home/robotics/team8/devel/lib:/opt/ros/noetic/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/sdk_sagittarius_arm/sdk_sagittarius_arm")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/sdk_sagittarius_arm" TYPE FILE FILES
    "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sdk_sagittarius_arm/include/sdk_sagittarius_arm/parser_base.h"
    "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sdk_sagittarius_arm/include/sdk_sagittarius_arm/sdk_sagittarius_arm_common.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sdk_sagittarius_arm/launch" TYPE DIRECTORY FILES "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sdk_sagittarius_arm/launch/")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sdk_sagittarius_arm/meshes" TYPE DIRECTORY FILES "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sdk_sagittarius_arm/meshes/")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sdk_sagittarius_arm/urdf" TYPE DIRECTORY FILES "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sdk_sagittarius_arm/urdf/")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sdk_sagittarius_arm/plugins" TYPE DIRECTORY FILES "/home/robotics/team8/src/sagittarius_ws/src/sagittarius_arm_ros/sdk_sagittarius_arm/plugins/")
endif()

