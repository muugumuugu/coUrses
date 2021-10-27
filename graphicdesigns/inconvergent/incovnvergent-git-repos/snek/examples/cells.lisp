#!/usr/bin/sbcl --script

(load "../src/load")
(load "../utils/force")



(defun init-snek (n m size xy)
  (let ((snk (snek:make :max-verts 5000)))
    (mapcar
      (lambda (g) (let ((mid (rnd:in-circ (* 0.5d0 (- size 200d0)) :xy xy)))
                    (snek:add-path! snk
                                    (math:rep (p (math:linspace n 0d0 1d0 :end nil))
                                      (vec:on-circ p 20d0 :xy mid))
                                    :g g
                                    :closed t)))
      (math:nrep m (snek:add-grp! snk)))
  snk))



(defun main (size fn)
  (let ((itt 1000)
        (grains 30)
        (snk (init-snek 5 800 size (vec:rep (* 0.5d0 size))))
        (sand (sandpaint:make size
                              :fg (pigment:white 0.05)
                              :bg (pigment:dark))))

    (loop for i from 0 below itt do
      (print-every i 100)

      (snek:with (snk :zwidth 60.0d0)
        (snek:itr-verts (snk v)
          (map 'list (lambda (w) (force? snk v w -0.05))
                     (snek:verts-in-rad snk (snek:get-vert snk v) 60.0d0))
          ;(snek:with-verts-in-rad (snk (snek:get-vert snk v) 60d0 w)
          ;  (cons))

          )
        (snek:itr-grps (snk g)
          (snek:itr-edges (snk e :g g)
            (force? snk (first e) (second e) 0.1))))
      (snek:itr-grps (snk g :collect nil)
        (sandpaint:bzspl-stroke sand
          (bzspl:make (snek:get-grp-verts snk :g g) :closed t)
          grains)))

    (sandpaint:save sand fn :gamma 1.5)))

(time (main 1000 (second (cmd-args))))

