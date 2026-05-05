; Auto-generated. Do not edit!


(cl:in-package sagittarius_llm_control-srv)


;//! \htmlinclude DetectBlock-request.msg.html

(cl:defclass <DetectBlock-request> (roslisp-msg-protocol:ros-message)
  ((target_label
    :reader target_label
    :initarg :target_label
    :type cl:string
    :initform ""))
)

(cl:defclass DetectBlock-request (<DetectBlock-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DetectBlock-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DetectBlock-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sagittarius_llm_control-srv:<DetectBlock-request> is deprecated: use sagittarius_llm_control-srv:DetectBlock-request instead.")))

(cl:ensure-generic-function 'target_label-val :lambda-list '(m))
(cl:defmethod target_label-val ((m <DetectBlock-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_llm_control-srv:target_label-val is deprecated.  Use sagittarius_llm_control-srv:target_label instead.")
  (target_label m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DetectBlock-request>) ostream)
  "Serializes a message object of type '<DetectBlock-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'target_label))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'target_label))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DetectBlock-request>) istream)
  "Deserializes a message object of type '<DetectBlock-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'target_label) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'target_label) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DetectBlock-request>)))
  "Returns string type for a service object of type '<DetectBlock-request>"
  "sagittarius_llm_control/DetectBlockRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DetectBlock-request)))
  "Returns string type for a service object of type 'DetectBlock-request"
  "sagittarius_llm_control/DetectBlockRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DetectBlock-request>)))
  "Returns md5sum for a message object of type '<DetectBlock-request>"
  "2067dc8c08ea01b0be7723ab7195563c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DetectBlock-request)))
  "Returns md5sum for a message object of type 'DetectBlock-request"
  "2067dc8c08ea01b0be7723ab7195563c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DetectBlock-request>)))
  "Returns full string definition for message of type '<DetectBlock-request>"
  (cl:format cl:nil "string target_label~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DetectBlock-request)))
  "Returns full string definition for message of type 'DetectBlock-request"
  (cl:format cl:nil "string target_label~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DetectBlock-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'target_label))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DetectBlock-request>))
  "Converts a ROS message object to a list"
  (cl:list 'DetectBlock-request
    (cl:cons ':target_label (target_label msg))
))
;//! \htmlinclude DetectBlock-response.msg.html

(cl:defclass <DetectBlock-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil)
   (detected_label
    :reader detected_label
    :initarg :detected_label
    :type cl:string
    :initform "")
   (confidence
    :reader confidence
    :initarg :confidence
    :type cl:float
    :initform 0.0)
   (center_u
    :reader center_u
    :initarg :center_u
    :type cl:integer
    :initform 0)
   (center_v
    :reader center_v
    :initarg :center_v
    :type cl:integer
    :initform 0)
   (position
    :reader position
    :initarg :position
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point))
   (error
    :reader error
    :initarg :error
    :type cl:string
    :initform ""))
)

(cl:defclass DetectBlock-response (<DetectBlock-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DetectBlock-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DetectBlock-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sagittarius_llm_control-srv:<DetectBlock-response> is deprecated: use sagittarius_llm_control-srv:DetectBlock-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <DetectBlock-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_llm_control-srv:success-val is deprecated.  Use sagittarius_llm_control-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'detected_label-val :lambda-list '(m))
(cl:defmethod detected_label-val ((m <DetectBlock-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_llm_control-srv:detected_label-val is deprecated.  Use sagittarius_llm_control-srv:detected_label instead.")
  (detected_label m))

(cl:ensure-generic-function 'confidence-val :lambda-list '(m))
(cl:defmethod confidence-val ((m <DetectBlock-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_llm_control-srv:confidence-val is deprecated.  Use sagittarius_llm_control-srv:confidence instead.")
  (confidence m))

(cl:ensure-generic-function 'center_u-val :lambda-list '(m))
(cl:defmethod center_u-val ((m <DetectBlock-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_llm_control-srv:center_u-val is deprecated.  Use sagittarius_llm_control-srv:center_u instead.")
  (center_u m))

(cl:ensure-generic-function 'center_v-val :lambda-list '(m))
(cl:defmethod center_v-val ((m <DetectBlock-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_llm_control-srv:center_v-val is deprecated.  Use sagittarius_llm_control-srv:center_v instead.")
  (center_v m))

(cl:ensure-generic-function 'position-val :lambda-list '(m))
(cl:defmethod position-val ((m <DetectBlock-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_llm_control-srv:position-val is deprecated.  Use sagittarius_llm_control-srv:position instead.")
  (position m))

(cl:ensure-generic-function 'error-val :lambda-list '(m))
(cl:defmethod error-val ((m <DetectBlock-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_llm_control-srv:error-val is deprecated.  Use sagittarius_llm_control-srv:error instead.")
  (error m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DetectBlock-response>) ostream)
  "Serializes a message object of type '<DetectBlock-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'detected_label))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'detected_label))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'confidence))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'center_u)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'center_v)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'position) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'error))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'error))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DetectBlock-response>) istream)
  "Deserializes a message object of type '<DetectBlock-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'detected_label) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'detected_label) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'confidence) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'center_u) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'center_v) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'position) istream)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'error) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'error) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DetectBlock-response>)))
  "Returns string type for a service object of type '<DetectBlock-response>"
  "sagittarius_llm_control/DetectBlockResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DetectBlock-response)))
  "Returns string type for a service object of type 'DetectBlock-response"
  "sagittarius_llm_control/DetectBlockResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DetectBlock-response>)))
  "Returns md5sum for a message object of type '<DetectBlock-response>"
  "2067dc8c08ea01b0be7723ab7195563c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DetectBlock-response)))
  "Returns md5sum for a message object of type 'DetectBlock-response"
  "2067dc8c08ea01b0be7723ab7195563c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DetectBlock-response>)))
  "Returns full string definition for message of type '<DetectBlock-response>"
  (cl:format cl:nil "bool success~%string detected_label~%float32 confidence~%int32 center_u~%int32 center_v~%geometry_msgs/Point position~%string error~%~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DetectBlock-response)))
  "Returns full string definition for message of type 'DetectBlock-response"
  (cl:format cl:nil "bool success~%string detected_label~%float32 confidence~%int32 center_u~%int32 center_v~%geometry_msgs/Point position~%string error~%~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DetectBlock-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'detected_label))
     4
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'position))
     4 (cl:length (cl:slot-value msg 'error))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DetectBlock-response>))
  "Converts a ROS message object to a list"
  (cl:list 'DetectBlock-response
    (cl:cons ':success (success msg))
    (cl:cons ':detected_label (detected_label msg))
    (cl:cons ':confidence (confidence msg))
    (cl:cons ':center_u (center_u msg))
    (cl:cons ':center_v (center_v msg))
    (cl:cons ':position (position msg))
    (cl:cons ':error (error msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'DetectBlock)))
  'DetectBlock-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'DetectBlock)))
  'DetectBlock-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DetectBlock)))
  "Returns string type for a service object of type '<DetectBlock>"
  "sagittarius_llm_control/DetectBlock")