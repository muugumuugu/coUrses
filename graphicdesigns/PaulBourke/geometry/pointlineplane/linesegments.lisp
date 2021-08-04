;;;; Created on 2008-03-10 17:18:13

;;; Author: Paul Reiners
;;; From algorithm by Paul Bourke given here: http://local.wasp.uwa.edu.au/~pbourke/geometry/lineline2d/
(defun get-intersection (x1 y1 x2 y2 x3 y3 x4 y4)
  (let ((denom (- (* (- y4 y3) (- x2 x1)) (* (- x4 x3) (- y2 y1))))
    (ua-num (- (* (- x4 x3) (- y1 y3)) (* (- y4 y3) (- x1 x3))))
    (ub-num (- (* (- x2 x1) (- y1 y3)) (* (- y2 y1) (- x1 x3)))))
    (cond 
               ; If the denominator and numerator for the equations for ua and 
               ; ub are 0 then the two lines are coincident.
               ((and (zerop denom) (zerop ua-num) (zerop ub-num)) (list x1 y1))
               ; If the denominator for the equations for ua and ub is 0 then 
               ; the two lines are parallel.
               ((zerop denom) nil)
               (t 
                (let ((ua (/ ua-num denom))
                      (ub (/ ub-num denom)))
                  (if (and (<= 0 ua 1) (<= 0 ub 1))
                      ; x = x1 + ua (x2 - x1)
                      ; y = y1 + ua (y2 - y1) 
                      (list (+ x1 (* ua (- x2 x1)))
                            (+ y1 (* ua (- y2 y1))))
                      nil))))))

(get-intersection 0.0 0.0 5.0 5.0 5.0 0.0 0.0 5.0)
(get-intersection 1.0 3.0 9.0 3.0 0.0 1.0 2.0 1.0)
(get-intersection 1.0 5.0 6.0 8.0 0.5 3.0 6.0 4.0)
(get-intersection 1.0 1.0 3.0 8.0 0.5 2.0 4.0 7.0)
(get-intersection 1.0 2.0 3.0 6.0 2.0 4.0 4.0 8.0)
(get-intersection 3.5 9.0 3.5 0.5 3.0 1.0 9.0 1.0)
(get-intersection 2.0 3.0 7.0 9.0 1.0 2.0 5.0 7.0)
