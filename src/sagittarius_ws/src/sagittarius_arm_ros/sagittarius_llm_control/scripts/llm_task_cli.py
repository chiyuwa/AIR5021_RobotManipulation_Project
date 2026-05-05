#!/usr/bin/env python3
import argparse
import os
import sys
import threading

import rosgraph
import rospy
import rosservice
from std_msgs.msg import String

from sagittarius_llm_control.srv import ExecuteNaturalLanguageTask


def _read_task_text(args):
    if args.text:
        return args.text
    if args.file:
        with open(args.file, "r", encoding="utf-8") as handle:
            return handle.read()
    raise ValueError("Either --text or --file must be provided.")


def _list_execute_task_services():
    try:
        services = rosservice.get_service_list()
    except rosservice.ROSServiceIOException:
        return []
    return sorted(service for service in services if service == "/execute_task" or service.endswith("/execute_task"))


def _resolve_service_name(requested_service, timeout_sec):
    if not rosgraph.is_master_online():
        master_uri = os.environ.get("ROS_MASTER_URI", "http://localhost:11311")
        raise RuntimeError(
            "ROS master is unavailable at {}. Start `roscore` or launch the system first, for example: "
            "`roslaunch sagittarius_llm_control llm_task_system.launch`".format(master_uri)
        )

    try:
        rospy.wait_for_service(requested_service, timeout=timeout_sec)
        return requested_service
    except rospy.ROSException:
        candidates = _list_execute_task_services()
        if len(candidates) == 1:
            discovered_service = candidates[0]
            print(
                "cli_info: requested service {} is unavailable; using discovered service {}".format(
                    requested_service, discovered_service
                ),
                file=sys.stderr,
            )
            rospy.wait_for_service(discovered_service, timeout=max(1.0, min(timeout_sec, 3.0)))
            return discovered_service

        details = [
            "service {} did not appear within {:.1f}s".format(requested_service, timeout_sec),
            "start the server with: roslaunch sagittarius_llm_control llm_task_system.launch",
        ]
        if candidates:
            details.append("available execute_task services: {}".format(", ".join(candidates)))
        else:
            details.append("no execute_task service is currently registered")
        raise RuntimeError(". ".join(details))


class _ServiceCallRunner(object):
    def __init__(self, proxy, task_text, plan_only):
        self._proxy = proxy
        self._task_text = task_text
        self._plan_only = plan_only
        self.result = None
        self.error = None
        self.done = threading.Event()
        self._thread = threading.Thread(target=self._run, daemon=True)

    def _run(self):
        try:
            self.result = self._proxy(self._task_text, self._plan_only)
        except Exception as exc:
            self.error = exc
        finally:
            self.done.set()

    def start(self):
        self._thread.start()


def _derive_status_topic(service_name):
    if "/" not in service_name.strip("/"):
        return "/llm_task_status"
    namespace = "/" + service_name.strip("/").rsplit("/", 1)[0]
    return namespace + "/llm_task_status"


def main():
    parser = argparse.ArgumentParser(description="Send a natural language task to Sagittarius LLM control.")
    parser.add_argument("--text", help="Natural language task text.")
    parser.add_argument("--file", help="UTF-8 text file that contains the task.")
    parser.add_argument("--plan-only", action="store_true", help="Plan only. Do not execute.")
    parser.add_argument(
        "--service",
        default="/sgr532/execute_task",
        help="ROS service name. Default: /sgr532/execute_task",
    )
    parser.add_argument("--timeout", type=float, default=10.0, help="Service wait timeout in seconds.")
    args = parser.parse_args()

    task_text = _read_task_text(args)

    rospy.init_node("llm_task_cli", anonymous=True)
    service_name = _resolve_service_name(args.service, args.timeout)
    proxy = rospy.ServiceProxy(service_name, ExecuteNaturalLanguageTask)
    status_topic = _derive_status_topic(service_name)
    latest_status = {"value": None}

    def _status_callback(msg):
        value = str(msg.data or "").strip()
        if value and value != latest_status["value"]:
            latest_status["value"] = value
            print("status: {}".format(value), file=sys.stderr)

    status_sub = rospy.Subscriber(status_topic, String, _status_callback, queue_size=10)
    runner = _ServiceCallRunner(proxy, task_text, args.plan_only)
    runner.start()

    while not runner.done.wait(0.2):
        if rospy.is_shutdown():
            raise RuntimeError("ROS shutdown while waiting for task execution.")

    status_sub.unregister()
    if runner.error is not None:
        raise runner.error
    result = runner.result

    print("success: {}".format(result.success))
    if result.summary:
        print("summary: {}".format(result.summary))
    if result.error:
        print("error: {}".format(result.error))
    if result.plan_json:
        print("plan_json:")
        print(result.plan_json)

    return 0 if result.success else 1


if __name__ == "__main__":
    try:
        sys.exit(main())
    except Exception as exc:
        print("cli_error: {}".format(exc))
        sys.exit(1)
