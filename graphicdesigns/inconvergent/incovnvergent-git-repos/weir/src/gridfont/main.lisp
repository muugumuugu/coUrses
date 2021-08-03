
(in-package :gridfont)

; json docs https://common-lisp.net/project/cl-json/cl-json.html

(defun -jsn-get (jsn k) (cdr (assoc k jsn)))

(defstruct (gridfont (:constructor -make-gridfont))
  (scale 1d0 :type double-float :read-only nil)
  (sp 1d0 :type double-float :read-only nil)
  (nl 13d0 :type double-float :read-only nil)
  (pos (vec:zero) :type vec:vec :read-only nil)
  (prev nil :read-only nil)
  (symbols (make-hash-table :test #'equal) :read-only t))

(defun make (&key (fn (internal-path-string "src/gridfont/smooth"))
                  (scale 1d0) (nl 13d0) (sp 1d0) (xy (vec:zero)))
  (with-open-file (fstream (ensure-filename fn ".json" t)
                           :direction :input)
    (loop with res = (make-hash-table :test #'equal)
          with jsn = (json:decode-json fstream) ; jsn is an alist
          with symbols = (-jsn-get jsn :symbols)
          for (k . v) in symbols
          do (setf (gethash (symbol-name k) res) v)
          finally (return (-make-gridfont :symbols res :scale scale
                                          :sp sp :pos xy :nl nl)))))

(defun -coerce-vec (p &optional (s 1d0))
  (declare (list p) (double-float s))
  (vec:vec* (mapcar (lambda (x) (* s (coerce x 'double-float))) p)))

(defun -coerce-paths (paths pos s)
  (declare (list paths) (vec:vec pos) (double-float s))
  (loop for path in paths
        collect (vec:ladd* (loop for p in path
                                 collect (-coerce-vec p s)) pos)))

(defun -closed (p &key (tol 0.001d0))
  (declare (list p))
  (< (vec:dst (first p) (first (last p))) tol))

(defun -detect-closed (paths)
  (declare (list paths))
  (loop for p in paths collect (list p (-closed p))))


(defun update (gf &key pos scale sp nl)
  (declare (gridfont gf))
  "update gridfont properties"
  (when pos (vec:set! (gridfont-pos gf) pos))
  (when scale (setf (gridfont-scale gf) scale))
  (when sp (setf (gridfont-sp gf) sp))
  (when nl (setf (gridfont-nl nl) sp)))


(defun nl (gf &key (left 0d0))
  (declare (gridfont gf) (double-float left))
  "write a newline"
  (setf (gridfont-prev gf) nil)
  (with-struct (gridfont- pos nl scale) gf
    (vec:set! pos (vec:vec left (+ (vec:vec-y pos) (* nl scale))))))


(defun -get-meta (symbols c &aux (c* (string c)))
  (multiple-value-bind (meta exists)
    (gethash (funcall json:*json-identifier-name-to-lisp* c*) symbols)
    (unless exists (error "symbol does not exist: ~a (representation: ~a)" c c*))
    meta))

(defun wc (gf c &key xy)
  (declare (gridfont gf))
  "write single character, c"
  (with-struct (gridfont- symbols scale sp pos) gf
    (when xy (vec:set! pos xy))
    (let* ((meta (-get-meta symbols c))
           (paths (-jsn-get meta :paths))
           (w (coerce (-jsn-get meta :w) 'double-float))
           (res (-detect-closed (-coerce-paths paths pos scale))))
      (vec:add! pos (vec:vec (* scale (+ w sp)) 0d0))
      (setf (gridfont-prev gf) (string c))
      res)))


(defun get-phrase-box (gf str)
  (declare (gridfont gf) (string str))
  "width and height of phrase"
  (with-struct (gridfont- symbols scale sp) gf
    (loop for c across str
          summing (+ (-jsn-get (-get-meta symbols c) :w) sp) into width
          maximizing (-jsn-get (-get-meta symbols c) :h) into height
          finally (return (-coerce-vec (list width height) scale)))))


;TODO: left in make
;      left in nl
;      top in make

