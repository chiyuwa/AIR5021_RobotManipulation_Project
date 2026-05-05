;; Auto-generated. Do not edit!


(when (boundp 'sagittarius_llm_control::DetectColoredBlock)
  (if (not (find-package "SAGITTARIUS_LLM_CONTROL"))
    (make-package "SAGITTARIUS_LLM_CONTROL"))
  (shadow 'DetectColoredBlock (find-package "SAGITTARIUS_LLM_CONTROL")))
(unless (find-package "SAGITTARIUS_LLM_CONTROL::DETECTCOLOREDBLOCK")
  (make-package "SAGITTARIUS_LLM_CONTROL::DETECTCOLOREDBLOCK"))
(unless (find-package "SAGITTARIUS_LLM_CONTROL::DETECTCOLOREDBLOCKREQUEST")
  (make-package "SAGITTARIUS_LLM_CONTROL::DETECTCOLOREDBLOCKREQUEST"))
(unless (find-package "SAGITTARIUS_LLM_CONTROL::DETECTCOLOREDBLOCKRESPONSE")
  (make-package "SAGITTARIUS_LLM_CONTROL::DETECTCOLOREDBLOCKRESPONSE"))

(in-package "ROS")



(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass sagittarius_llm_control::DetectColoredBlockRequest
  :super ros::object
  :slots (_target_label ))

(defmethod sagittarius_llm_control::DetectColoredBlockRequest
  (:init
   (&key
    ((:target_label __target_label) "")
    )
   (send-super :init)
   (setq _target_label (string __target_label))
   self)
  (:target_label
   (&optional __target_label)
   (if __target_label (setq _target_label __target_label)) _target_label)
  (:serialization-length
   ()
   (+
    ;; string _target_label
    4 (length _target_label)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _target_label
       (write-long (length _target_label) s) (princ _target_label s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _target_label
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _target_label (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass sagittarius_llm_control::DetectColoredBlockResponse
  :super ros::object
  :slots (_success _detected_label _confidence _center_u _center_v _position _error ))

(defmethod sagittarius_llm_control::DetectColoredBlockResponse
  (:init
   (&key
    ((:success __success) nil)
    ((:detected_label __detected_label) "")
    ((:confidence __confidence) 0.0)
    ((:center_u __center_u) 0)
    ((:center_v __center_v) 0)
    ((:position __position) (instance geometry_msgs::Point :init))
    ((:error __error) "")
    )
   (send-super :init)
   (setq _success __success)
   (setq _detected_label (string __detected_label))
   (setq _confidence (float __confidence))
   (setq _center_u (round __center_u))
   (setq _center_v (round __center_v))
   (setq _position __position)
   (setq _error (string __error))
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:detected_label
   (&optional __detected_label)
   (if __detected_label (setq _detected_label __detected_label)) _detected_label)
  (:confidence
   (&optional __confidence)
   (if __confidence (setq _confidence __confidence)) _confidence)
  (:center_u
   (&optional __center_u)
   (if __center_u (setq _center_u __center_u)) _center_u)
  (:center_v
   (&optional __center_v)
   (if __center_v (setq _center_v __center_v)) _center_v)
  (:position
   (&rest __position)
   (if (keywordp (car __position))
       (send* _position __position)
     (progn
       (if __position (setq _position (car __position)))
       _position)))
  (:error
   (&optional __error)
   (if __error (setq _error __error)) _error)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ;; string _detected_label
    4 (length _detected_label)
    ;; float32 _confidence
    4
    ;; int32 _center_u
    4
    ;; int32 _center_v
    4
    ;; geometry_msgs/Point _position
    (send _position :serialization-length)
    ;; string _error
    4 (length _error)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;; string _detected_label
       (write-long (length _detected_label) s) (princ _detected_label s)
     ;; float32 _confidence
       (sys::poke _confidence (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _center_u
       (write-long _center_u s)
     ;; int32 _center_v
       (write-long _center_v s)
     ;; geometry_msgs/Point _position
       (send _position :serialize s)
     ;; string _error
       (write-long (length _error) s) (princ _error s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _detected_label
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _detected_label (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float32 _confidence
     (setq _confidence (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _center_u
     (setq _center_u (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _center_v
     (setq _center_v (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; geometry_msgs/Point _position
     (send _position :deserialize buf ptr-) (incf ptr- (send _position :serialization-length))
   ;; string _error
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _error (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass sagittarius_llm_control::DetectColoredBlock
  :super ros::object
  :slots ())

(setf (get sagittarius_llm_control::DetectColoredBlock :md5sum-) "2067dc8c08ea01b0be7723ab7195563c")
(setf (get sagittarius_llm_control::DetectColoredBlock :datatype-) "sagittarius_llm_control/DetectColoredBlock")
(setf (get sagittarius_llm_control::DetectColoredBlock :request) sagittarius_llm_control::DetectColoredBlockRequest)
(setf (get sagittarius_llm_control::DetectColoredBlock :response) sagittarius_llm_control::DetectColoredBlockResponse)

(defmethod sagittarius_llm_control::DetectColoredBlockRequest
  (:response () (instance sagittarius_llm_control::DetectColoredBlockResponse :init)))

(setf (get sagittarius_llm_control::DetectColoredBlockRequest :md5sum-) "2067dc8c08ea01b0be7723ab7195563c")
(setf (get sagittarius_llm_control::DetectColoredBlockRequest :datatype-) "sagittarius_llm_control/DetectColoredBlockRequest")
(setf (get sagittarius_llm_control::DetectColoredBlockRequest :definition-)
      "string target_label
---
bool success
string detected_label
float32 confidence
int32 center_u
int32 center_v
geometry_msgs/Point position
string error


================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z
")

(setf (get sagittarius_llm_control::DetectColoredBlockResponse :md5sum-) "2067dc8c08ea01b0be7723ab7195563c")
(setf (get sagittarius_llm_control::DetectColoredBlockResponse :datatype-) "sagittarius_llm_control/DetectColoredBlockResponse")
(setf (get sagittarius_llm_control::DetectColoredBlockResponse :definition-)
      "string target_label
---
bool success
string detected_label
float32 confidence
int32 center_u
int32 center_v
geometry_msgs/Point position
string error


================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z
")



(provide :sagittarius_llm_control/DetectColoredBlock "2067dc8c08ea01b0be7723ab7195563c")


