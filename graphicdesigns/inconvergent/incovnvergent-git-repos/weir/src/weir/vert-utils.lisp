(in-package :weir)

(declaim (inline -dimtest))
(defun -dimtest (wer)
  (declare #.*opt-settings* (weir wer))
  (when (not (= (weir-dim wer) 2)) (error "wrong dimension, expected 2.")))

(defun get-verts (wer vv &aux (vv* (if (equal (type-of vv) 'cons)
                                       vv (to-list vv))))
  (declare #.*opt-settings* (weir wer) (sequence vv))
  "get the coordinates (vec) of verts in vv"
  (-dimtest wer)
  (with-struct (weir- verts num-verts) wer
    (declare (double-array verts) (pos-int num-verts))
    (-valid-verts (num-verts vv* v)
      (avec:getv verts v))))


(defun get-grp-verts (wer &key g order)
  (declare #.*opt-settings* (weir wer) (boolean order))
  "
  returns all vertices in grp g.
  note: verts only belong to a grp if they are part of an edge in grp.
  "
  (get-verts wer (get-vert-inds wer :g g :order order)))


(defun is-vert-in-grp (wer v &key g)
  (declare #.*opt-settings* (weir wer) (pos-int v))
  "
  tests whether v is in grp g
  note: verts only belong to a grp if they are part of an edge in grp.
  "
  (with-struct (weir- grps) wer
    (multiple-value-bind (g* exists) (gethash g grps)
      (if exists (graph:vmem (grp-grph g*) v)
                 (error "grp does not exist: ~a" g)))))


(defun get-num-verts (wer)
  (declare #.*opt-settings* (weir wer))
  (weir-num-verts wer))


(defun get-grp-num-verts (wer &key g)
  (declare #.*opt-settings* (weir wer))
  (with-grp (wer g* g)
    (graph:get-num-verts (grp-grph g*))))


(defun add-vert! (wer xy)
  (declare #.*opt-settings* (weir wer) (vec:vec xy))
  "adds a new vertex to weir. returns the new vert ind"
  (-dimtest wer)
  (with-struct (weir- verts num-verts max-verts) wer
    (declare (double-array verts) (pos-int num-verts max-verts))
    (when (>= num-verts max-verts)
      (error "too many verts ~a~%." num-verts))
    (avec:setv verts num-verts xy))
  (1- (incf (weir-num-verts wer))))


(defun add-verts! (wer vv)
  (declare #.*opt-settings* (weir wer) (list vv))
  "adds new vertices to weir. returns the ids of the new vertices"
  (-dimtest wer)
  (loop for xy of-type vec:vec in vv
        collect (add-vert! wer xy)))


(defun get-vert (wer v)
  (declare #.*opt-settings* (weir wer) (pos-int v))
  "get the coordinate (vec) of vert v"
  (-dimtest wer)
  (with-struct (weir- verts num-verts) wer
    (declare (double-array verts) (pos-int num-verts))
    (-valid-vert (num-verts v)
      (avec:getv verts v))))


(defun get-all-verts (wer)
  (declare #.*opt-settings* (weir wer))
  "returns the coordinates (vec) of all vertices"
  (-dimtest wer)
  (with-struct (weir- verts num-verts) wer
    (declare (double-array verts) (pos-int num-verts))
    (loop for v of-type pos-int from 0 below num-verts
          collect (avec:getv verts v) of-type vec:vec)))


(defun make-vert-getter (wer)
  (declare (weir wer))
  (-dimtest wer)
  (let ((verts (to-vector (weir:get-all-verts wer) :type 'vec:vec)))
    (declare (type (simple-array vec:vec) verts))
    (lambda (vv) (declare (list vv))
      (mapcar (lambda (i) (declare (pos-int i)) (aref verts i))
              vv))))


(declaim (inline move-vert!))
(defun move-vert! (wer i v &key (rel t) (ret nil))
  (declare #.*opt-settings*
           (weir wer) (pos-int i) (vec:vec v) (boolean rel))
  (-dimtest wer)
  (with-struct (weir- verts num-verts) wer
    (declare (double-array verts) (pos-int num-verts))
    (when (>= i num-verts)
          (error "attempting to move invalid vert, ~a (~a)" i num-verts))
    (vec:with-xy (v vx vy)
      (avec:with-vec (verts i x y)
        (if rel (setf x (+ x vx) y (+ y vy))
                (setf x vx y vy))
        (when ret (vec:vec x y))))))


(defun transform! (wer inds fx)
  (declare (weir wer) (function fx) (list inds))
  (-dimtest wer)
  (let* ((verts (get-verts wer inds)))
    (declare (list verts))
    (loop for i of-type pos-int in inds
          and p of-type vec:vec in (funcall fx verts)
          do (move-vert! wer i p :rel nil))))

(defun grp-transform! (wer fx &key g)
  (declare (weir wer) (function fx))
  (transform! wer (get-vert-inds wer :g g) fx))


(defun split-edge! (wer u v &key xy g)
  (declare #.*opt-settings* (weir wer) (pos-int u v) (vec:vec xy))
  "
  split edge at xy (or middle if xy is nil).
  returns new vert ind (and new edges).
  "
  (-dimtest wer)
  (if (del-edge! wer u v :g g)
      (let ((c (add-vert! wer xy)))
        (declare (pos-int c))
        (let ((edges (list (add-edge! wer c u :g g)
                           (add-edge! wer c v :g g))))
          (declare (list edges))
          (values c edges)))
      (values nil nil)))

(defun lsplit-edge! (wer ll &key xy g)
  (declare #.*opt-settings* (weir wer) (list ll) (vec:vec xy))
  (-dimtest wer)
  (destructuring-bind (a b) ll
    (declare (pos-int a b))
    (split-edge! wer a b :xy xy :g g)))


(defun append-edge! (wer v xy &key (rel t) g)
  "add edge between vert v and new vert at xy"
  (declare (weir wer) (fixnum v) (vec:vec xy) (boolean rel))
  (add-edge! wer v
    (add-vert! wer
      (if rel (vec:add xy (get-vert wer v)) xy)) :g g))


(defun verts-in-rad (wer xy rad)
  (declare #.*opt-settings* (weir wer) (vec:vec xy) (double-float rad))
  (-dimtest wer)
  (with-struct (weir- verts zonemap) wer
    (declare (double-array verts))
    (zonemap:verts-in-rad zonemap verts xy rad)))


(defun edge-length (wer a b)
  (declare #.*opt-settings* (weir wer) (pos-int a b))
  "returns the length of edge (a b)"
  (-dimtest wer)
  (with-struct (weir- verts) wer
    (declare (double-array verts))
    (avec:dst verts verts a b)))


(defun ledge-length (wer e)
  (declare #.*opt-settings* (weir wer) (list e))
  "returns the length of edge e=(a b)"
  (-dimtest wer)
  (apply #'edge-length wer e))


(defun prune-edges-by-len! (wer lim &optional (fx #'>))
  (declare #.*opt-settings* (weir wer) (double-float lim) (function fx))
  "remove edges longer than lim, use fx #'< to remove edges shorter than lim"
  (-dimtest wer)
  (itr-edges (wer e)
    (when (funcall (the function fx) (ledge-length wer e) lim)
          (ldel-edge! wer e))))


(declaim (inline -center))
(defun -center (verts v mid mx my &key (s 1d0))
  (declare #.*opt-settings* (double-array verts)
           (pos-int v) (vec:vec mid) (double-float mx my s))
  (avec:with-vec (verts v x y)
    (setf x (+ (vec:vec-x mid) (* s (- x mx)))
          y (+ (vec:vec-y mid) (* s (- y my))))))

(declaim (inline -scale-by))
(defun -scale-by (max-side sx sy)
  (declare #.*opt-settings* (double-float sx sy))
  (cond ((not max-side) 1d0)
        ((> sx sy) (/ (the double-float max-side) sx))
        (t (/ (the double-float max-side) sy))))

(defun center! (wer &key (xy vec:*zero*) max-side (non-edge t) g)
  "center the verts of wer on xy. returns the previous center"
  (-dimtest wer)
  (with-struct (weir- verts num-verts) wer
    (declare (double-array verts) (pos-int num-verts))
    (multiple-value-bind (minx maxx miny maxy)
      (if non-edge (avec:minmax verts num-verts)
                   (avec::minmax* verts (get-vert-inds wer :g g)))
      (let* ((mx (* 0.5d0 (+ minx maxx)))
             (my (* 0.5d0 (+ miny maxy)))
             (w (- maxx minx))
             (h (- maxy miny))
             (s (-scale-by max-side w h)))
        (declare (double-float mx my))
        (itr-verts (wer v) (-center verts v xy mx my :s s))
        (values (vec:vec mx my) (vec:vec w h) s)))))


(defun build-zonemap (wer rad)
  (declare (weir wer) (double-float rad))
  (-dimtest wer)
  (setf (weir-zonemap wer)
        (zonemap:make (weir-verts wer) (weir-num-verts wer) rad)))


(declaim (inline -is-rel-neigh))
(defun -is-rel-neigh (verts u v near)
  (declare #.*opt-settings* (double-array verts) (pos-int u v) (list near))
  (loop with d of-type double-float = (avec:dst2 verts verts u v)
        for w of-type pos-int in near
        if (not (> (the double-float
                        (max (the double-float (avec:dst2 verts verts u w))
                             (the double-float (avec:dst2 verts verts v w)))) d))
          summing 1 into c of-type pos-int
        ; TODO: avoid this by stripping u from near
        if (> c 1) do (return-from -is-rel-neigh nil))
  t)

; TODO: this is stil more than a little inefficient
(defun relative-neighborhood! (wer rad &key g (build-zonemap t))
  (declare #.*opt-settings* (weir wer) (double-float rad)
                            (boolean build-zonemap))
  "
  find the relative neigborhood graph (limited by the radius rad) of verts
  in wer. the graph is made in grp g.
  "
  (-dimtest wer)
  (when build-zonemap (build-zonemap wer rad))
  (let ((c 0))
    (declare (pos-int c))
    (itr-verts (wer v)
      (loop with verts of-type double-array = (weir-verts wer)
            with near of-type list =
              (to-list (remove-if (lambda (x) (declare (pos-int x))
                                    (= x v))
                                  (verts-in-rad wer (get-vert wer v) rad)))
            ; TODO: strip u from near
            for u of-type pos-int in near
            if (and (< u v) (-is-rel-neigh verts u v near))
            do (when (add-edge! wer u v :g g) (incf c))))
    c))


(defun add-path! (wer points &key g closed)
  (declare #.*opt-settings* (weir wer) (list points))
  (-dimtest wer)
  (add-path-ind! wer (add-verts! wer points) :g g :closed closed))


(defun export-verts-grp (wer &key g)
  (declare #.*opt-settings* (weir wer))
  "export verts, as well as the edges in g, on the format (verts edges)"
  (-dimtest wer)
  (list (get-all-verts wer) (get-edges wer :g g)))


(defun import-verts-grp (wer o &key g)
  (declare #.*opt-settings* (weir wer) (list o))
  "import data exported using export-verts-grp"
  (-dimtest wer)
  (when (> (get-num-verts wer) 0)
        (error "ensure there are no initial verts in wer."))
  (destructuring-bind (verts edges) o
    (declare (list verts edges))
    (add-verts! wer verts)
    (loop for e of-type list in edges do (ladd-edge! wer e :g g))))

