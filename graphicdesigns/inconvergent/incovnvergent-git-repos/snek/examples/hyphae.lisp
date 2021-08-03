#!/usr/bin/sbcl --script

(load "../src/load")



; TODO: where does this go?
(defmacro inside-border ((size xy b) &body body)
  (with-gensyms (xyname sname small large)
    `(let* ((,xyname ,xy)
            (,sname ,size)
            (,small ,b)
            (,large (- ,sname ,small)))
      (if (and (>= (vec::vec-x ,xyname) ,small) (< (vec::vec-x ,xyname) ,large)
               (>= (vec::vec-y ,xyname) ,small) (< (vec::vec-y ,xyname) ,large))
        (progn
          ,@body)))))


(defun hyphae (sand size fn itt rad mid)
  (let ((curr (make-hash-table :test #'equal))
        (hits 0))

    (labels ((init (snk n)
               (loop for i from 0 below n do
                 (setf (gethash
                         (snek:add-vert! snk (rnd:in-box 250d0 250d0 :xy (vec:vec 250d0 250d0)))
                         curr)
                       0)))

             (draw (snk a w)
               (sandpaint:set-fg-color sand (pigment:rgb 0.0 0.7 0.7 0.1))
               (sandpaint:circ sand (list (snek::append-edge-alt-xy a)) 4d0 300)
               (sandpaint:set-fg-color sand (pigment:black 0.1))
               (sandpaint:lin-path sand
                 (snek:get-verts snk (list w (snek::append-edge-alt-v a)))
                 2d0
                 50))

             (count-control (v)
               (multiple-value-bind (c exists) (gethash v curr)
                 (when exists
                       (if (> c 20)
                           (print (remhash v curr))
                           (incf (gethash v curr))))))

             (do-append-edge-alt* (snk a)
               (let ((v (snek::append-edge-alt-v a)))
                 (count-control v)
                 (inside-border (size (snek::append-edge-alt-xy a) 10)
                   (if (<= (length (snek:verts-in-rad snk (snek::append-edge-alt-xy a) rad)) 1)
                     (aif (snek::do-append-edge-alt snk a)
                       (progn (incf hits)
                              (setf (gethash it curr) 0)
                              (draw snk a it))))))))

      (let ((snk (snek:make :max-verts itt
                            :alts `((snek::append-edge-alt ,#'do-append-edge-alt*)))))

        (init snk 20)

        (loop for i from 0 below itt do
          (snek:with (snk :zwidth rad)
            (loop for k being the hash-keys in curr collect
              (snek:append-edge? k
                (vec:add (snek:get-vert snk k)
                     (rnd:in-circ rad))
                :rel nil))
            (sandpaint:save sand (append-number fn hits))))))))


(defun main (size fn)
  (let ((sand (sandpaint:make size
                              :fg (pigment:black 0.01)
                              :bg (pigment:white))))

    (hyphae sand size fn 1000 10.0d0 (vec:vec 250d0 250d0))))

(time (main 500 (second (cmd-args))))

