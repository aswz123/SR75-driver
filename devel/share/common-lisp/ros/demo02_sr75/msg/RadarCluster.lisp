; Auto-generated. Do not edit!


(cl:in-package demo02_sr75-msg)


;//! \htmlinclude RadarCluster.msg.html

(cl:defclass <RadarCluster> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:fixnum
    :initform 0)
   (dist_long_x
    :reader dist_long_x
    :initarg :dist_long_x
    :type cl:float
    :initform 0.0)
   (dist_lat_y
    :reader dist_lat_y
    :initarg :dist_lat_y
    :type cl:float
    :initform 0.0)
   (velocity
    :reader velocity
    :initarg :velocity
    :type cl:float
    :initform 0.0)
   (height_z
    :reader height_z
    :initarg :height_z
    :type cl:float
    :initform 0.0)
   (dyn_prop
    :reader dyn_prop
    :initarg :dyn_prop
    :type cl:fixnum
    :initform 0)
   (rcs
    :reader rcs
    :initarg :rcs
    :type cl:fixnum
    :initform 0)
   (range
    :reader range
    :initarg :range
    :type cl:float
    :initform 0.0)
   (angle
    :reader angle
    :initarg :angle
    :type cl:float
    :initform 0.0))
)

(cl:defclass RadarCluster (<RadarCluster>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RadarCluster>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RadarCluster)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name demo02_sr75-msg:<RadarCluster> is deprecated: use demo02_sr75-msg:RadarCluster instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <RadarCluster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader demo02_sr75-msg:id-val is deprecated.  Use demo02_sr75-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'dist_long_x-val :lambda-list '(m))
(cl:defmethod dist_long_x-val ((m <RadarCluster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader demo02_sr75-msg:dist_long_x-val is deprecated.  Use demo02_sr75-msg:dist_long_x instead.")
  (dist_long_x m))

(cl:ensure-generic-function 'dist_lat_y-val :lambda-list '(m))
(cl:defmethod dist_lat_y-val ((m <RadarCluster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader demo02_sr75-msg:dist_lat_y-val is deprecated.  Use demo02_sr75-msg:dist_lat_y instead.")
  (dist_lat_y m))

(cl:ensure-generic-function 'velocity-val :lambda-list '(m))
(cl:defmethod velocity-val ((m <RadarCluster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader demo02_sr75-msg:velocity-val is deprecated.  Use demo02_sr75-msg:velocity instead.")
  (velocity m))

(cl:ensure-generic-function 'height_z-val :lambda-list '(m))
(cl:defmethod height_z-val ((m <RadarCluster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader demo02_sr75-msg:height_z-val is deprecated.  Use demo02_sr75-msg:height_z instead.")
  (height_z m))

(cl:ensure-generic-function 'dyn_prop-val :lambda-list '(m))
(cl:defmethod dyn_prop-val ((m <RadarCluster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader demo02_sr75-msg:dyn_prop-val is deprecated.  Use demo02_sr75-msg:dyn_prop instead.")
  (dyn_prop m))

(cl:ensure-generic-function 'rcs-val :lambda-list '(m))
(cl:defmethod rcs-val ((m <RadarCluster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader demo02_sr75-msg:rcs-val is deprecated.  Use demo02_sr75-msg:rcs instead.")
  (rcs m))

(cl:ensure-generic-function 'range-val :lambda-list '(m))
(cl:defmethod range-val ((m <RadarCluster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader demo02_sr75-msg:range-val is deprecated.  Use demo02_sr75-msg:range instead.")
  (range m))

(cl:ensure-generic-function 'angle-val :lambda-list '(m))
(cl:defmethod angle-val ((m <RadarCluster>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader demo02_sr75-msg:angle-val is deprecated.  Use demo02_sr75-msg:angle instead.")
  (angle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RadarCluster>) ostream)
  "Serializes a message object of type '<RadarCluster>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dist_long_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dist_lat_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'velocity))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'height_z))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'dyn_prop)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'rcs)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'range))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RadarCluster>) istream)
  "Deserializes a message object of type '<RadarCluster>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dist_long_x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dist_lat_y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'velocity) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'height_z) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'dyn_prop)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'rcs)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'range) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angle) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RadarCluster>)))
  "Returns string type for a message object of type '<RadarCluster>"
  "demo02_sr75/RadarCluster")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RadarCluster)))
  "Returns string type for a message object of type 'RadarCluster"
  "demo02_sr75/RadarCluster")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RadarCluster>)))
  "Returns md5sum for a message object of type '<RadarCluster>"
  "fe99fd61eb81690cb0da1c8e2444952c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RadarCluster)))
  "Returns md5sum for a message object of type 'RadarCluster"
  "fe99fd61eb81690cb0da1c8e2444952c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RadarCluster>)))
  "Returns full string definition for message of type '<RadarCluster>"
  (cl:format cl:nil "uint8   id              # 目标ID，0~~255循环~%float32 dist_long_x       # 目标纵向距离，单位：米~%float32 dist_lat_y        # 目标横向距离，单位：米~%float32 velocity        # 目标径向速度，单位：m/s~%float32 height_z          # 目标高度，单位：米~%uint8   dyn_prop        # 目标动态属性~%uint8   rcs             # 目标信噪比~%float32 range           # 目标径向距离R，单位：米~%float32 angle           # 目标角度θ，单位：弧度~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RadarCluster)))
  "Returns full string definition for message of type 'RadarCluster"
  (cl:format cl:nil "uint8   id              # 目标ID，0~~255循环~%float32 dist_long_x       # 目标纵向距离，单位：米~%float32 dist_lat_y        # 目标横向距离，单位：米~%float32 velocity        # 目标径向速度，单位：m/s~%float32 height_z          # 目标高度，单位：米~%uint8   dyn_prop        # 目标动态属性~%uint8   rcs             # 目标信噪比~%float32 range           # 目标径向距离R，单位：米~%float32 angle           # 目标角度θ，单位：弧度~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RadarCluster>))
  (cl:+ 0
     1
     4
     4
     4
     4
     1
     1
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RadarCluster>))
  "Converts a ROS message object to a list"
  (cl:list 'RadarCluster
    (cl:cons ':id (id msg))
    (cl:cons ':dist_long_x (dist_long_x msg))
    (cl:cons ':dist_lat_y (dist_lat_y msg))
    (cl:cons ':velocity (velocity msg))
    (cl:cons ':height_z (height_z msg))
    (cl:cons ':dyn_prop (dyn_prop msg))
    (cl:cons ':rcs (rcs msg))
    (cl:cons ':range (range msg))
    (cl:cons ':angle (angle msg))
))
