#!/usr/bin/env python3
import math
import sys

import moveit_commander
import rospy
import tf.transformations as transformations


def main():
    moveit_commander.roscpp_initialize(sys.argv)
    rospy.init_node("print_current_pose", anonymous=True)

    robot_name = rospy.get_param("~robot_name", "sgr532")
    arm_group_name = rospy.get_param("~arm_group", "sagittarius_arm")
    moveit_ns = "/" + str(robot_name).strip("/")
    robot_description = moveit_ns + "/robot_description"
    arm = moveit_commander.MoveGroupCommander(
        arm_group_name,
        robot_description=robot_description,
        ns=moveit_ns,
    )
    end_effector_link = arm.get_end_effector_link()
    pose = arm.get_current_pose(end_effector_link).pose

    quaternion = [pose.orientation.x, pose.orientation.y, pose.orientation.z, pose.orientation.w]
    roll, pitch, yaw = transformations.euler_from_quaternion(quaternion)

    print("end_effector_link: {}".format(end_effector_link))
    print(
        "position_xyz: [{:.4f}, {:.4f}, {:.4f}]".format(
            pose.position.x,
            pose.position.y,
            pose.position.z,
        )
    )
    print(
        "orientation_rpy_rad: [{:.4f}, {:.4f}, {:.4f}]".format(
            roll,
            pitch,
            yaw,
        )
    )
    print("orientation_rpy_deg: [{:.1f}, {:.1f}, {:.1f}]".format(
        math.degrees(roll),
        math.degrees(pitch),
        math.degrees(yaw),
    ))
    print("")
    print("moveit_namespace: {}".format(moveit_ns))
    print("robot_description: {}".format(robot_description))
    print("runtime.yaml snippet:")
    print("  observation:")
    print("    position: [{:.4f}, {:.4f}, {:.4f}]".format(
        pose.position.x,
        pose.position.y,
        pose.position.z,
    ))
    print("    orientation_rpy: [{:.4f}, {:.4f}, {:.4f}]".format(
        roll,
        pitch,
        yaw,
    ))
    print("    description: Observation pose captured from current robot state.")


if __name__ == "__main__":
    main()
