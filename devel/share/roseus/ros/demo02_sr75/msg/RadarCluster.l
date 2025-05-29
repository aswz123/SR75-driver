;; Auto-generated. Do not edit!


(when (boundp 'demo02_sr75::RadarCluster)
  (if (not (find-package "DEMO02_SR75"))
    (make-package "DEMO02_SR75"))
  (shadow 'RadarCluster (find-package "DEMO02_SR75")))
(unless (find-package "DEMO02_SR75::RADARCLUSTER")
  (make-package "DEMO02_SR75::RADARCLUSTER"))

(in-package "ROS")
;;//! \htmlinclude RadarCluster.msg.html


(defclass demo02_sr75::RadarCluster
  :super ros::object
  :slots (_id _dist_long_x _dist_lat_y _velocity _height_z _dyn_prop _rcs _range _angle ))

(defmethod demo02_sr75::RadarCluster
  (:init
   (&key
    ((:id __id) 0)
    ((:dist_long_x __dist_long_x) 0.0)
    ((:dist_lat_y __dist_lat_y) 0.0)
    ((:velocity __velocity) 0.0)
    ((:height_z __height_z) 0.0)
    ((:dyn_prop __dyn_prop) 0)
    ((:rcs __rcs) 0)
    ((:range __range) 0.0)
    ((:angle __angle) 0.0)
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _dist_long_x (float __dist_long_x))
   (setq _dist_lat_y (float __dist_lat_y))
   (setq _velocity (float __velocity))
   (setq _height_z (float __height_z))
   (setq _dyn_prop (round __dyn_prop))
   (setq _rcs (round __rcs))
   (setq _range (float __range))
   (setq _angle (float __angle))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:dist_long_x
   (&optional __dist_long_x)
   (if __dist_long_x (setq _dist_long_x __dist_long_x)) _dist_long_x)
  (:dist_lat_y
   (&optional __dist_lat_y)
   (if __dist_lat_y (setq _dist_lat_y __dist_lat_y)) _dist_lat_y)
  (:velocity
   (&optional __velocity)
   (if __velocity (setq _velocity __velocity)) _velocity)
  (:height_z
   (&optional __height_z)
   (if __height_z (setq _height_z __height_z)) _height_z)
  (:dyn_prop
   (&optional __dyn_prop)
   (if __dyn_prop (setq _dyn_prop __dyn_prop)) _dyn_prop)
  (:rcs
   (&optional __rcs)
   (if __rcs (setq _rcs __rcs)) _rcs)
  (:range
   (&optional __range)
   (if __range (setq _range __range)) _range)
  (:angle
   (&optional __angle)
   (if __angle (setq _angle __angle)) _angle)
  (:serialization-length
   ()
   (+
    ;; uint8 _id
    1
    ;; float32 _dist_long_x
    4
    ;; float32 _dist_lat_y
    4
    ;; float32 _velocity
    4
    ;; float32 _height_z
    4
    ;; uint8 _dyn_prop
    1
    ;; uint8 _rcs
    1
    ;; float32 _range
    4
    ;; float32 _angle
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _id
       (write-byte _id s)
     ;; float32 _dist_long_x
       (sys::poke _dist_long_x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _dist_lat_y
       (sys::poke _dist_lat_y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _velocity
       (sys::poke _velocity (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _height_z
       (sys::poke _height_z (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint8 _dyn_prop
       (write-byte _dyn_prop s)
     ;; uint8 _rcs
       (write-byte _rcs s)
     ;; float32 _range
       (sys::poke _range (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _angle
       (sys::poke _angle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _id
     (setq _id (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _dist_long_x
     (setq _dist_long_x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _dist_lat_y
     (setq _dist_lat_y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _velocity
     (setq _velocity (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _height_z
     (setq _height_z (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint8 _dyn_prop
     (setq _dyn_prop (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _rcs
     (setq _rcs (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _range
     (setq _range (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _angle
     (setq _angle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get demo02_sr75::RadarCluster :md5sum-) "fe99fd61eb81690cb0da1c8e2444952c")
(setf (get demo02_sr75::RadarCluster :datatype-) "demo02_sr75/RadarCluster")
(setf (get demo02_sr75::RadarCluster :definition-)
      "uint8   id              # 目标ID，0~255循环
float32 dist_long_x       # 目标纵向距离，单位：米
float32 dist_lat_y        # 目标横向距离，单位：米
float32 velocity        # 目标径向速度，单位：m/s
float32 height_z          # 目标高度，单位：米
uint8   dyn_prop        # 目标动态属性
uint8   rcs             # 目标信噪比
float32 range           # 目标径向距离R，单位：米
float32 angle           # 目标角度θ，单位：弧度
")



(provide :demo02_sr75/RadarCluster "fe99fd61eb81690cb0da1c8e2444952c")


