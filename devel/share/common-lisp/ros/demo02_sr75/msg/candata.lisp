; Auto-generated. Do not edit!


(cl:in-package demo02_sr75-msg)


;//! \htmlinclude candata.msg.html

(cl:defclass <candata> (roslisp-msg-protocol:ros-message)
  ((frameid
    :reader frameid
    :initarg :frameid
    :type cl:integer
    :initform 0)
   (datalen
    :reader datalen
    :initarg :datalen
    :type cl:integer
    :initform 0)
   (data
    :reader data
    :initarg :data
    :type (cl:vector cl:integer)
   :initform (cl:make-array 64 :element-type 'cl:integer :initial-element 0)))
)

(cl:defclass candata (<candata>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <candata>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'candata)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name demo02_sr75-msg:<candata> is deprecated: use demo02_sr75-msg:candata instead.")))

(cl:ensure-generic-function 'frameid-val :lambda-list '(m))
(cl:defmethod frameid-val ((m <candata>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader demo02_sr75-msg:frameid-val is deprecated.  Use demo02_sr75-msg:frameid instead.")
  (frameid m))

(cl:ensure-generic-function 'datalen-val :lambda-list '(m))
(cl:defmethod datalen-val ((m <candata>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader demo02_sr75-msg:datalen-val is deprecated.  Use demo02_sr75-msg:datalen instead.")
  (datalen m))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <candata>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader demo02_sr75-msg:data-val is deprecated.  Use demo02_sr75-msg:data instead.")
  (data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <candata>) ostream)
  "Serializes a message object of type '<candata>"
  (cl:let* ((signed (cl:slot-value msg 'frameid)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'datalen)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    ))
   (cl:slot-value msg 'data))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <candata>) istream)
  "Deserializes a message object of type '<candata>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'frameid) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'datalen) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:setf (cl:slot-value msg 'data) (cl:make-array 64))
  (cl:let ((vals (cl:slot-value msg 'data)))
    (cl:dotimes (i 64)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<candata>)))
  "Returns string type for a message object of type '<candata>"
  "demo02_sr75/candata")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'candata)))
  "Returns string type for a message object of type 'candata"
  "demo02_sr75/candata")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<candata>)))
  "Returns md5sum for a message object of type '<candata>"
  "319167d56da088e6bf38f02430def806")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'candata)))
  "Returns md5sum for a message object of type 'candata"
  "319167d56da088e6bf38f02430def806")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<candata>)))
  "Returns full string definition for message of type '<candata>"
  (cl:format cl:nil "int32 frameid~%int32 datalen~%int64[64] data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'candata)))
  "Returns full string definition for message of type 'candata"
  (cl:format cl:nil "int32 frameid~%int32 datalen~%int64[64] data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <candata>))
  (cl:+ 0
     4
     4
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'data) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <candata>))
  "Converts a ROS message object to a list"
  (cl:list 'candata
    (cl:cons ':frameid (frameid msg))
    (cl:cons ':datalen (datalen msg))
    (cl:cons ':data (data msg))
))
