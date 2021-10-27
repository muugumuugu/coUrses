
(in-package :state)


(defmacro awith ((st key &key default) &body body)
  "
  access key of state as state::it,
  the final form of body is assigned to state key of state
  "
  (with-gensyms (sname kname res dname s)
    `(let* ((,sname ,st)
            (,dname ,default)
            (,kname ,key)
            (,s (state-s ,sname))
            (it (gethash ,kname (state-s ,sname) ,dname))
            (,res (progn ,@body)))
      (setf (gethash ,kname (state-s ,sname)) ,res))))


(defstruct (state (:constructor make ()))
  (s (make-hash-table :test #'equal) :type hash-table))


(defun sget (st key &key default)
  "
  get key of state (or default)
  "
  (declare (state st))
  (gethash key (state-s st) default))

(defun mget (st keys &key default)
  "
  get keys of state (or default)
  "
  (declare (state st) (list keys))
  (loop for key in keys collect (gethash key (state-s st) default)))


(defun sset (st key v)
  "
  set key of st to v, returns v
  "
  (declare (state st))
  (setf (gethash key (state-s st)) v))


(defun mset (st keys v)
  "
  set keys of st to v. returns keys.
  "
  (declare (state st) (list keys))
  (loop for k in keys do (setf (gethash k (state-s st)) v))
  keys)


(defun kset (st key v)
  "
  same as sset, returns key
  "
  (declare (state st))
  (sset st key v)
  key)

