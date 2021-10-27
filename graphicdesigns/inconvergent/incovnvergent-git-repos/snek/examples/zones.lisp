#!/usr/bin/sbcl --script

(load "../src/load")


(defun main (size fn)
  (let ((mid (math:dfloat (half size)))
        (noise (+ 0.015d0 (rnd:rnd 0.03d0)))
        (itt 5000)
        (snk (snek:make))
        (grains 3)
        (sand (sandpaint:make size
                              :fg (pigment:black 0.01)
                              :bg (pigment:white))))

      (math:nrep 1000 (snek:add-vert! snk (rnd:in-box 500d0 500d0 :xy (vec:vec mid mid))))

      (loop for k from 1 to itt
        do (print-every k 100)
           (snek:with (snk :zwidth 40.0d0)
             (snek:itr-verts (snk v)
               (snek:move-vert? v (rnd:in-circ 0.7d0))
               (let ((verts (snek:verts-in-rad snk (snek:get-vert snk v) 40.0d0)))
                 (if (> (length verts) 0)
                   (snek:add-edge? v (rnd:rndget verts))))))
           (snek:draw-edges snk sand grains))

   (sandpaint:pixel-hack sand)
   (sandpaint:save sand fn)))


(time (main 1000 (second (cmd-args))))

