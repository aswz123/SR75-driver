;; Auto-generated. Do not edit!


(when (boundp 'demo02_sr75::candata)
  (if (not (find-package "DEMO02_SR75"))
    (make-package "DEMO02_SR75"))
  (shadow 'candata (find-package "DEMO02_SR75")))
(unless (find-package "DEMO02_SR75::CANDATA")
  (make-package "DEMO02_SR75::CANDATA"))

(in-package "ROS")
;;//! \htmlinclude candata.msg.html


(defclass demo02_sr75::candata
  :super ros::object
  :slots (_frameid _datalen _data ))

(defmethod demo02_sr75::candata
  (:init
   (&key
    ((:frameid __frameid) 0)
    ((:datalen __datalen) 0)
    ((:data __data) (make-array 64 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _frameid (round __frameid))
   (setq _datalen (round __datalen))
   (setq _data __data)
   self)
  (:frameid
   (&optional __frameid)
   (if __frameid (setq _frameid __frameid)) _frameid)
  (:datalen
   (&optional __datalen)
   (if __datalen (setq _datalen __datalen)) _datalen)
  (:data
   (&optional __data)
   (if __data (setq _data __data)) _data)
  (:serialization-length
   ()
   (+
    ;; int32 _frameid
    4
    ;; int32 _datalen
    4
    ;; int64[64] _data
    (* 8    64)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _frameid
       (write-long _frameid s)
     ;; int32 _datalen
       (write-long _datalen s)
     ;; int64[64] _data
     (dotimes (i 64)
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _data i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _data i)) (= (length ((elt _data i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _data i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _data i) . bv) 1) -1) s))
             ((and (class (elt _data i)) (= (length ((elt _data i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _data i) . bv) 0) s)
              (write-long (if (>= (elt _data i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _data i) s)(write-long (if (>= (elt _data i) 0) 0 #xffffffff) s)))
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _frameid
     (setq _frameid (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _datalen
     (setq _datalen (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int64[64] _data
   (dotimes (i (length _data))
#+(or :alpha :irix6 :x86_64)
      (setf (elt _data i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _data i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     )
   ;;
   self)
  )

(setf (get demo02_sr75::candata :md5sum-) "319167d56da088e6bf38f02430def806")
(setf (get demo02_sr75::candata :datatype-) "demo02_sr75/candata")
(setf (get demo02_sr75::candata :definition-)
      "int32 frameid
int32 datalen
int64[64] data

")



(provide :demo02_sr75/candata "319167d56da088e6bf38f02430def806")


