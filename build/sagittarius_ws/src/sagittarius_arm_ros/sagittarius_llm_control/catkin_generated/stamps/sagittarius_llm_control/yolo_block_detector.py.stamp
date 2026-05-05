#!/usr/bin/env python3
import rospy

from sagittarius_llm_control.vision_detector import YoloBlockDetectorNode, YoloDetectorError


if __name__ == "__main__":
    rospy.init_node("yolo_block_detector")
    try:
        YoloBlockDetectorNode()
        rospy.spin()
    except YoloDetectorError as exc:
        rospy.logfatal(str(exc))
        raise SystemExit(1)
