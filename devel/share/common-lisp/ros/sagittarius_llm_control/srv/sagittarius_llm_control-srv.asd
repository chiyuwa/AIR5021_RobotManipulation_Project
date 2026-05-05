
(cl:in-package :asdf)

(defsystem "sagittarius_llm_control-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "DetectBlock" :depends-on ("_package_DetectBlock"))
    (:file "_package_DetectBlock" :depends-on ("_package"))
    (:file "ExecuteNaturalLanguageTask" :depends-on ("_package_ExecuteNaturalLanguageTask"))
    (:file "_package_ExecuteNaturalLanguageTask" :depends-on ("_package"))
  ))