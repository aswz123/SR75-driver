
(cl:in-package :asdf)

(defsystem "demo02_sr75-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "RadarCluster" :depends-on ("_package_RadarCluster"))
    (:file "_package_RadarCluster" :depends-on ("_package"))
    (:file "candata" :depends-on ("_package_candata"))
    (:file "_package_candata" :depends-on ("_package"))
  ))