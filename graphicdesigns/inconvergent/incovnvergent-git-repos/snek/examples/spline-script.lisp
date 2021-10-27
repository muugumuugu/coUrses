#!/usr/bin/sbcl --script

(load "../src/load")
(load "../utils/text")
(load "../utils/text-sample")
(load "../utils/spline-script")
(load "../utils/state")


(defvar *alphabet* "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,?-—:'")


(defun scale ()
  (if (< (rnd:rnd) 0.15)
    (vec:vec 1.1d0 3.9d0)
    (vec:vec 1d0 1d0)))

(defun swap (l)
  (let* ((ll (loop for k in l collect k))
         (n (length l))
         (a (rnd:rndi n))
         (b (rnd:rndi n)))
    (setf (nth a ll) (nth b l)
          (nth b ll) (nth a l))
    ll))


(defun shape (n bx by)
  ;(rnd:nin-box n bx by)
  (vec:lmult* (rnd:nin-circ n 1d0) (vec:vec bx by)))


(defun draw-pix (sand bzs grains)
  (sandpaint:bzspl-stroke sand bzs (* grains (bzspl::bzspl-n bzs))))


(defun draw-varying-pix (sand bzs grains)
  (sandpaint:pix sand (bzspl:pos* bzs
    (mapcar (lambda (x) (expt x 0.6d0))
      (rnd:rndspace (* grains (bzspl::bzspl-n bzs)) 0d0 1d0)))))


(defun draw (snk sand)
  (let ((state-gen (get-walker-state-gen (lambda () (rnd:get-acc-circ-stp*))))
        (grains 15)
        (drift (vec:scale (vec:sin-cos -0.1d0) 0.009d0)))
    (loop for p in (math:linspace 500 0d0 1d0)
          and i from 0 do
      (snek:with (snk)
        (snek:itr-verts (snk v)
          (snek:move-vert? v drift)
          (snek:move-vert? v (rnd:in-circ 0.1d0))
          ;(snek:move-vert? v (funcall state-gen v 0.000008d0))
          ))
      ;(sandpaint:set-fg-color sand (pigment:hsv 0.55 (- 1.0 i) (- 1.0 i) 0.009))
      (snek:itr-grps (snk g :collect nil)
        (aif (snek:get-grp-as-bzspl snk g)
          ;(draw-pix sand it grains)
          (draw-varying-pix sand it grains))))))


(defun main (size fn)
  (let ((trbl (list 70d0 950d0 950d0 55d0))
        (bbox (vec:vec 20d0 25d0))
        (spacebox (vec:vec 10d0 25d0))
        (sand (sandpaint:make size
                              :fg (pigment:black 0.009)
                              :bg (pigment:white))))

    (labels
      ((get-bbox-fxn ()
        (let ((bbox (vec:mult bbox (scale))))
          (vec:with-xy ((vec:scale bbox 0.5d0) bx by)
            (lambda (n)
              (mapcar (lambda (v) (vec:rot v (* PI 0.2d0)))
                      (shape n bx by))))))

       (estimate-nc-ncn-fxn (bbox-fxn)
         (let* ((samples (funcall bbox-fxn 1000))
                (mid (vec:lmid samples))
                (area (apply #'max (mapcar (lambda (a) (vec:dst a mid)) samples))))
           (if (< area 30d0) (list area 4 1)
                             (list area 7 1))))

       (sort-centroids-fxn ()
         (let ((f (if (< (rnd:rnd)) #'< #'>))
               (rot (rnd:rnd PII)))
           (lambda (centroids)
             (let ((res (sort (loop for c in centroids collect
                          (list (+ rot (apply #'atan (reverse (vec:tolist c)))) c))
                          f :key #'first)))
               (if (< (rnd:rnd) 0.6) (swap res)
                                     res))))))

      (let ((alphabet (show-alphabet (get-alphabet *alphabet*
                        :get-bbox-fxn #'get-bbox-fxn
                        :nc-ncn-fxn #'estimate-nc-ncn-fxn
                        :sort-fxn #'sort-centroids-fxn
                        :min-dst 5d0)))
            (words (remove-if (lambda (x) (= 0 (second x)))
                              (apply #'append (get-words* *alice*))) )
            (wind 0))

        (block draw-loop
          (loop for k from 0 do
            (let ((snk (snek:make))
                  (txt (subseq words wind)))
              (incf wind (aif (do-write snk alphabet spacebox trbl txt)
                              it
                              (return-from draw-loop)))
              (draw snk sand))

            (sandpaint:pixel-hack sand)
            (sandpaint:save sand (append-postfix fn (format nil "-~3,'0d" k))
                            :gamma 1.5)
            (sandpaint:clear sand (pigment:white))))))))


(time (main 1000 (second (cmd-args))))

