;; Auto-generated. Do not edit!


(when (boundp 'sagittarius_llm_control::ExecuteNaturalLanguageTask)
  (if (not (find-package "SAGITTARIUS_LLM_CONTROL"))
    (make-package "SAGITTARIUS_LLM_CONTROL"))
  (shadow 'ExecuteNaturalLanguageTask (find-package "SAGITTARIUS_LLM_CONTROL")))
(unless (find-package "SAGITTARIUS_LLM_CONTROL::EXECUTENATURALLANGUAGETASK")
  (make-package "SAGITTARIUS_LLM_CONTROL::EXECUTENATURALLANGUAGETASK"))
(unless (find-package "SAGITTARIUS_LLM_CONTROL::EXECUTENATURALLANGUAGETASKREQUEST")
  (make-package "SAGITTARIUS_LLM_CONTROL::EXECUTENATURALLANGUAGETASKREQUEST"))
(unless (find-package "SAGITTARIUS_LLM_CONTROL::EXECUTENATURALLANGUAGETASKRESPONSE")
  (make-package "SAGITTARIUS_LLM_CONTROL::EXECUTENATURALLANGUAGETASKRESPONSE"))

(in-package "ROS")





(defclass sagittarius_llm_control::ExecuteNaturalLanguageTaskRequest
  :super ros::object
  :slots (_text _plan_only ))

(defmethod sagittarius_llm_control::ExecuteNaturalLanguageTaskRequest
  (:init
   (&key
    ((:text __text) "")
    ((:plan_only __plan_only) nil)
    )
   (send-super :init)
   (setq _text (string __text))
   (setq _plan_only __plan_only)
   self)
  (:text
   (&optional __text)
   (if __text (setq _text __text)) _text)
  (:plan_only
   (&optional (__plan_only :null))
   (if (not (eq __plan_only :null)) (setq _plan_only __plan_only)) _plan_only)
  (:serialization-length
   ()
   (+
    ;; string _text
    4 (length _text)
    ;; bool _plan_only
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _text
       (write-long (length _text) s) (princ _text s)
     ;; bool _plan_only
       (if _plan_only (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _text
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _text (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _plan_only
     (setq _plan_only (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass sagittarius_llm_control::ExecuteNaturalLanguageTaskResponse
  :super ros::object
  :slots (_success _summary _plan_json _error ))

(defmethod sagittarius_llm_control::ExecuteNaturalLanguageTaskResponse
  (:init
   (&key
    ((:success __success) nil)
    ((:summary __summary) "")
    ((:plan_json __plan_json) "")
    ((:error __error) "")
    )
   (send-super :init)
   (setq _success __success)
   (setq _summary (string __summary))
   (setq _plan_json (string __plan_json))
   (setq _error (string __error))
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:summary
   (&optional __summary)
   (if __summary (setq _summary __summary)) _summary)
  (:plan_json
   (&optional __plan_json)
   (if __plan_json (setq _plan_json __plan_json)) _plan_json)
  (:error
   (&optional __error)
   (if __error (setq _error __error)) _error)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ;; string _summary
    4 (length _summary)
    ;; string _plan_json
    4 (length _plan_json)
    ;; string _error
    4 (length _error)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;; string _summary
       (write-long (length _summary) s) (princ _summary s)
     ;; string _plan_json
       (write-long (length _plan_json) s) (princ _plan_json s)
     ;; string _error
       (write-long (length _error) s) (princ _error s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _summary
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _summary (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _plan_json
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _plan_json (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _error
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _error (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass sagittarius_llm_control::ExecuteNaturalLanguageTask
  :super ros::object
  :slots ())

(setf (get sagittarius_llm_control::ExecuteNaturalLanguageTask :md5sum-) "be00a685ab6aa4e4d8c4b100b3f5f4c6")
(setf (get sagittarius_llm_control::ExecuteNaturalLanguageTask :datatype-) "sagittarius_llm_control/ExecuteNaturalLanguageTask")
(setf (get sagittarius_llm_control::ExecuteNaturalLanguageTask :request) sagittarius_llm_control::ExecuteNaturalLanguageTaskRequest)
(setf (get sagittarius_llm_control::ExecuteNaturalLanguageTask :response) sagittarius_llm_control::ExecuteNaturalLanguageTaskResponse)

(defmethod sagittarius_llm_control::ExecuteNaturalLanguageTaskRequest
  (:response () (instance sagittarius_llm_control::ExecuteNaturalLanguageTaskResponse :init)))

(setf (get sagittarius_llm_control::ExecuteNaturalLanguageTaskRequest :md5sum-) "be00a685ab6aa4e4d8c4b100b3f5f4c6")
(setf (get sagittarius_llm_control::ExecuteNaturalLanguageTaskRequest :datatype-) "sagittarius_llm_control/ExecuteNaturalLanguageTaskRequest")
(setf (get sagittarius_llm_control::ExecuteNaturalLanguageTaskRequest :definition-)
      "string text
bool plan_only
---
bool success
string summary
string plan_json
string error

")

(setf (get sagittarius_llm_control::ExecuteNaturalLanguageTaskResponse :md5sum-) "be00a685ab6aa4e4d8c4b100b3f5f4c6")
(setf (get sagittarius_llm_control::ExecuteNaturalLanguageTaskResponse :datatype-) "sagittarius_llm_control/ExecuteNaturalLanguageTaskResponse")
(setf (get sagittarius_llm_control::ExecuteNaturalLanguageTaskResponse :definition-)
      "string text
bool plan_only
---
bool success
string summary
string plan_json
string error

")



(provide :sagittarius_llm_control/ExecuteNaturalLanguageTask "be00a685ab6aa4e4d8c4b100b3f5f4c6")


