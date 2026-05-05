; Auto-generated. Do not edit!


(cl:in-package sagittarius_llm_control-srv)


;//! \htmlinclude ExecuteNaturalLanguageTask-request.msg.html

(cl:defclass <ExecuteNaturalLanguageTask-request> (roslisp-msg-protocol:ros-message)
  ((text
    :reader text
    :initarg :text
    :type cl:string
    :initform "")
   (plan_only
    :reader plan_only
    :initarg :plan_only
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ExecuteNaturalLanguageTask-request (<ExecuteNaturalLanguageTask-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ExecuteNaturalLanguageTask-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ExecuteNaturalLanguageTask-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sagittarius_llm_control-srv:<ExecuteNaturalLanguageTask-request> is deprecated: use sagittarius_llm_control-srv:ExecuteNaturalLanguageTask-request instead.")))

(cl:ensure-generic-function 'text-val :lambda-list '(m))
(cl:defmethod text-val ((m <ExecuteNaturalLanguageTask-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_llm_control-srv:text-val is deprecated.  Use sagittarius_llm_control-srv:text instead.")
  (text m))

(cl:ensure-generic-function 'plan_only-val :lambda-list '(m))
(cl:defmethod plan_only-val ((m <ExecuteNaturalLanguageTask-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_llm_control-srv:plan_only-val is deprecated.  Use sagittarius_llm_control-srv:plan_only instead.")
  (plan_only m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ExecuteNaturalLanguageTask-request>) ostream)
  "Serializes a message object of type '<ExecuteNaturalLanguageTask-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'text))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'text))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'plan_only) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ExecuteNaturalLanguageTask-request>) istream)
  "Deserializes a message object of type '<ExecuteNaturalLanguageTask-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'text) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'text) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'plan_only) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ExecuteNaturalLanguageTask-request>)))
  "Returns string type for a service object of type '<ExecuteNaturalLanguageTask-request>"
  "sagittarius_llm_control/ExecuteNaturalLanguageTaskRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ExecuteNaturalLanguageTask-request)))
  "Returns string type for a service object of type 'ExecuteNaturalLanguageTask-request"
  "sagittarius_llm_control/ExecuteNaturalLanguageTaskRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ExecuteNaturalLanguageTask-request>)))
  "Returns md5sum for a message object of type '<ExecuteNaturalLanguageTask-request>"
  "be00a685ab6aa4e4d8c4b100b3f5f4c6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ExecuteNaturalLanguageTask-request)))
  "Returns md5sum for a message object of type 'ExecuteNaturalLanguageTask-request"
  "be00a685ab6aa4e4d8c4b100b3f5f4c6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ExecuteNaturalLanguageTask-request>)))
  "Returns full string definition for message of type '<ExecuteNaturalLanguageTask-request>"
  (cl:format cl:nil "string text~%bool plan_only~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ExecuteNaturalLanguageTask-request)))
  "Returns full string definition for message of type 'ExecuteNaturalLanguageTask-request"
  (cl:format cl:nil "string text~%bool plan_only~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ExecuteNaturalLanguageTask-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'text))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ExecuteNaturalLanguageTask-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ExecuteNaturalLanguageTask-request
    (cl:cons ':text (text msg))
    (cl:cons ':plan_only (plan_only msg))
))
;//! \htmlinclude ExecuteNaturalLanguageTask-response.msg.html

(cl:defclass <ExecuteNaturalLanguageTask-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil)
   (summary
    :reader summary
    :initarg :summary
    :type cl:string
    :initform "")
   (plan_json
    :reader plan_json
    :initarg :plan_json
    :type cl:string
    :initform "")
   (error
    :reader error
    :initarg :error
    :type cl:string
    :initform ""))
)

(cl:defclass ExecuteNaturalLanguageTask-response (<ExecuteNaturalLanguageTask-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ExecuteNaturalLanguageTask-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ExecuteNaturalLanguageTask-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sagittarius_llm_control-srv:<ExecuteNaturalLanguageTask-response> is deprecated: use sagittarius_llm_control-srv:ExecuteNaturalLanguageTask-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <ExecuteNaturalLanguageTask-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_llm_control-srv:success-val is deprecated.  Use sagittarius_llm_control-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'summary-val :lambda-list '(m))
(cl:defmethod summary-val ((m <ExecuteNaturalLanguageTask-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_llm_control-srv:summary-val is deprecated.  Use sagittarius_llm_control-srv:summary instead.")
  (summary m))

(cl:ensure-generic-function 'plan_json-val :lambda-list '(m))
(cl:defmethod plan_json-val ((m <ExecuteNaturalLanguageTask-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_llm_control-srv:plan_json-val is deprecated.  Use sagittarius_llm_control-srv:plan_json instead.")
  (plan_json m))

(cl:ensure-generic-function 'error-val :lambda-list '(m))
(cl:defmethod error-val ((m <ExecuteNaturalLanguageTask-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_llm_control-srv:error-val is deprecated.  Use sagittarius_llm_control-srv:error instead.")
  (error m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ExecuteNaturalLanguageTask-response>) ostream)
  "Serializes a message object of type '<ExecuteNaturalLanguageTask-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'summary))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'summary))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'plan_json))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'plan_json))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'error))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'error))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ExecuteNaturalLanguageTask-response>) istream)
  "Deserializes a message object of type '<ExecuteNaturalLanguageTask-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'summary) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'summary) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'plan_json) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'plan_json) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ExecuteNaturalLanguageTask-response>)))
  "Returns string type for a service object of type '<ExecuteNaturalLanguageTask-response>"
  "sagittarius_llm_control/ExecuteNaturalLanguageTaskResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ExecuteNaturalLanguageTask-response)))
  "Returns string type for a service object of type 'ExecuteNaturalLanguageTask-response"
  "sagittarius_llm_control/ExecuteNaturalLanguageTaskResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ExecuteNaturalLanguageTask-response>)))
  "Returns md5sum for a message object of type '<ExecuteNaturalLanguageTask-response>"
  "be00a685ab6aa4e4d8c4b100b3f5f4c6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ExecuteNaturalLanguageTask-response)))
  "Returns md5sum for a message object of type 'ExecuteNaturalLanguageTask-response"
  "be00a685ab6aa4e4d8c4b100b3f5f4c6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ExecuteNaturalLanguageTask-response>)))
  "Returns full string definition for message of type '<ExecuteNaturalLanguageTask-response>"
  (cl:format cl:nil "bool success~%string summary~%string plan_json~%string error~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ExecuteNaturalLanguageTask-response)))
  "Returns full string definition for message of type 'ExecuteNaturalLanguageTask-response"
  (cl:format cl:nil "bool success~%string summary~%string plan_json~%string error~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ExecuteNaturalLanguageTask-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'summary))
     4 (cl:length (cl:slot-value msg 'plan_json))
     4 (cl:length (cl:slot-value msg 'error))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ExecuteNaturalLanguageTask-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ExecuteNaturalLanguageTask-response
    (cl:cons ':success (success msg))
    (cl:cons ':summary (summary msg))
    (cl:cons ':plan_json (plan_json msg))
    (cl:cons ':error (error msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ExecuteNaturalLanguageTask)))
  'ExecuteNaturalLanguageTask-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ExecuteNaturalLanguageTask)))
  'ExecuteNaturalLanguageTask-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ExecuteNaturalLanguageTask)))
  "Returns string type for a service object of type '<ExecuteNaturalLanguageTask>"
  "sagittarius_llm_control/ExecuteNaturalLanguageTask")