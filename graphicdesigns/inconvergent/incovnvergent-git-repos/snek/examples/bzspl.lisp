#!/usr/bin/sbcl --script

(load "../src/load")



(defun init-snek (n m s xy)
  ; a group (grp) is a collection of edges.

  ; make m grps with n verts in each grp.
  (let ((snk (snek:make)))
    (mapcar (lambda (g)
              (snek:add-path! snk
                (math:rep (p (math:linspace n 0d0 1d0)) (vec:on-circ p 600d0 :xy xy))
                :g g))
            (math:nrep m (snek:add-grp! snk)))
    snk))


(defun get-walkers-state-gen (snk)
  (let ((walkers (make-hash-table :test #'equal)))
    ; iterate all verts in all grps
    (snek:itr-grps (snk g)
      (snek:itr-grp-verts (snk v :g g)
        ; associate a random 2d walker with this vert.
        ; these walkers have a randomly changing
        ; acceleration, which gives intersting behaviour
        (setf (gethash v walkers)
              (rnd:get-acc-circ-stp*))))

    ; function that generates a move vert alteration based on the
    ; state of the corresponding walker
    (lambda (v noise)
      (snek:move-vert? v (funcall (gethash v walkers) noise)))))


(defun main (size fn)
  (let ((itt 1000000)
        (noise 0.000000000007d0)
        (grains 10)
        (snk (init-snek 40 1 (half size) (vec:rep (* 0.5d0 size))))
        (sand (sandpaint:make size
                :fg (pigment:white 0.05)
                :bg (pigment:dark))))

      (let ((state-gen (get-walkers-state-gen snk)))

        (loop for i from 0 below itt
          do
            (print-every i 100000)

            (snek:with (snk)
              (snek:itr-grps (snk g)
                (snek:itr-grp-verts (snk v :g g)
                  ; get an alteration for vert v
                  (funcall state-gen v noise))))

            ;(sandpaint:set-fg-color sand (pigment:hsv 0.51 1 1 0.05))
            (snek:itr-grps (snk g :collect nil)
              ; draw random dots along the bezier spline.
              (sandpaint:bzspl-stroke sand
                (bzspl:make (snek:get-grp-verts snk :g g) :closed t)
                grains))))

    (sandpaint:save sand fn :gamma 1.5)))

(time (main 2000 (second (cmd-args))))

