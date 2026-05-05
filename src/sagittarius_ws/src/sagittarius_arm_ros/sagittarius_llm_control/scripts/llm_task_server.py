#!/usr/bin/env python3
import json
import traceback

import rospy
from std_msgs.msg import String

from sagittarius_llm_control.config import RuntimeConfig
from sagittarius_llm_control.deepseek_client import DeepSeekChatClient, DeepSeekClientError
from sagittarius_llm_control.executor import ExecutionError, SagittariusTaskExecutor
from sagittarius_llm_control.planner import NaturalLanguageTaskPlanner, PlanningError
from sagittarius_llm_control.srv import (
    ExecuteNaturalLanguageTask,
    ExecuteNaturalLanguageTaskResponse,
)


class LLMTaskServer(object):
    def __init__(self):
        self._config = RuntimeConfig.from_rosparams()
        self._planner = NaturalLanguageTaskPlanner(self._config, DeepSeekChatClient(self._config))
        self._executor = None

        self._status_pub = rospy.Publisher("llm_task_status", String, queue_size=10, latch=True)
        self._plan_pub = rospy.Publisher("llm_task_plan_json", String, queue_size=10, latch=True)
        self._service = rospy.Service("execute_task", ExecuteNaturalLanguageTask, self._handle_request)

        rospy.loginfo("LLM task server is ready at %s", rospy.resolve_name("execute_task"))

    def _get_executor(self):
        if self._executor is None:
            self._executor = SagittariusTaskExecutor(self._config)
        return self._executor

    def _handle_request(self, request):
        response = ExecuteNaturalLanguageTaskResponse()
        try:
            self._publish_status("planning")
            plan, _ = self._planner.plan(request.text)
            plan_json = json.dumps(plan, ensure_ascii=False, indent=2)
            self._plan_pub.publish(plan_json)
            response.plan_json = plan_json

            if plan.get("needs_clarification"):
                response.success = False
                response.summary = plan.get("task_summary", "")
                response.error = plan.get("clarification_message", "Task needs clarification.")
                self._publish_status("needs_clarification")
                return response

            if request.plan_only:
                self._publish_status("plan_only_complete")
                response.success = True
                response.summary = "Planning succeeded. No execution was performed."
                response.error = ""
                return response

            self._publish_status("executing")
            execution_summary, logs = self._get_executor().execute_plan(plan)
            response.success = True
            response.summary = execution_summary + " Logs: " + " | ".join(logs)
            response.error = ""
            self._publish_status("execution_complete")
            return response

        except (PlanningError, DeepSeekClientError, ExecutionError) as exc:
            rospy.logerr(str(exc))
            response.success = False
            response.summary = ""
            response.error = str(exc)
            self._publish_status("error")
            return response
        except Exception as exc:
            rospy.logerr("Unhandled llm task server error: %s", exc)
            rospy.logdebug(traceback.format_exc())
            response.success = False
            response.summary = ""
            response.error = "Unhandled server error: {}".format(exc)
            self._publish_status("error")
            return response

    def _publish_status(self, value):
        self._status_pub.publish(value)


if __name__ == "__main__":
    rospy.init_node("llm_task_server")
    LLMTaskServer()
    rospy.spin()
