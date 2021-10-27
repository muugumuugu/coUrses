
(in-package :snek)


(defstruct (snek (:constructor -make-snek))
  (name nil :type symbol :read-only t)
  (wc 0 :type fixnum)
  (verts nil :type simple-array)
  (num-verts 0 :type fixnum)
  (zmap nil)
  (prm-names nil :read-only t)
  (alt-names nil :read-only t)
  (grps (make-hash-table :test #'equal))
  (prms (make-hash-table :test #'equal))
  (vert-names (make-hash-table :test #'equal))
  (max-verts nil :type fixnum :read-only t)
  (grp-size nil :type fixnum :read-only t))


; ----- GROUPS AND PRIMITIVES -----

(defstruct (grp (:constructor -make-grp))
  (name nil :type symbol :read-only t)
  (grph nil :type graph::graph)
  (type nil :type symbol :read-only t)
  (props nil))


(defstruct (prm (:constructor -make-prm))
  (name nil :type symbol :read-only t)
  (type nil :type symbol :read-only t)
  (verts (make-adjustable-vector :type 'fixnum) :read-only nil)
  (num-verts 0 :type fixnum)
  (args nil :type list :read-only nil)
  (props nil))

; ----- END -----


(defun -make-fxns (defaults &optional extras)
  (loop with res = (make-generic-hash-table :init defaults)
        for (a fx of-type function) in extras
        do (setf (gethash a res) fx)
        finally (return res)))


(defun make (&key (max-verts 100000) (grp-size 100) name prms alts)
  "
  constructor for snek instances.

  - max-verts is the maximum number of verts in snek (across all grps).

  - alts is a list of tuples: (('alt-x #'do-alt-x) ('alt-y #'do-alt-y) ...)
    where alt-x is the name of an alteration struct and do-alt-x is the name of
    a function that applies alt-x to snek. see snek-alterations for examples.

  - prms is a list of tuples: (('type1 #'type1-rfx) ('type2 #'type2-rfx) ...)
    with prm types and corresponding rfxns used to render that prm type.
  "
  (declare (fixnum max-verts grp-size) (list prms alts) (symbol name))
  (-make-snek :name name
              :verts (make-array (* max-verts 2) :initial-element 0d0
                                                 :element-type 'double-float)
              :max-verts max-verts
              :grp-size grp-size
              :alt-names (-make-fxns (list '(add-edge-alt do-add-edge-alt)
                                           '(add-vert-alt do-add-vert-alt)
                                           '(move-vert-alt do-move-vert-alt)
                                           '(append-edge-alt do-append-edge-alt)
                                           '(append-edge-segx-alt do-append-edge-segx-alt)
                                           '(split-edge-alt do-split-edge-alt)
                                           '(del-edge-alt do-del-edge-alt)
                                           '(vadd-edge-alt do-vadd-edge-alt)
                                           '(alt-then do-alt-then)
                                           '(alt-then* do-alt-then*))
                                     alts)
              :prm-names (-make-fxns
                           (list (list nil (lambda (snk p &optional ea)
                                             (declare (ignore ea))
                                             (get-prm-vert-inds snk :p p)))
                                 (list :v (lambda (snk p &optional ea)
                                            (declare (ignore ea))
                                            (get-prm-vert-inds snk :p p)))
                                 (list :vv (lambda (snk p &optional ea)
                                             (declare (ignore ea))
                                             (get-prm-verts snk :p p))))
                           prms)
              :grps (make-generic-hash-table :init (list
                      (list nil (-make-grp :name :main :type :main
                                           :grph (graph:make :size grp-size)))))))

