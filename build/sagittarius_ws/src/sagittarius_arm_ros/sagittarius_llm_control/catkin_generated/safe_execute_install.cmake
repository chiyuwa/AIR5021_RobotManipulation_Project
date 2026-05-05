execute_process(COMMAND "/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/robotics/team8/build/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_llm_control/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
