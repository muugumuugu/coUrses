#!/usr/bin/sbcl --script

(load "../src/load")
(load "../utils/test")

(setf *print-pretty* t)
(rnd:set-rnd-state 1)


(defun test-snek (snk)

  (do-test (snek:add-vert! snk (vec:vec 0d0 0d0)) 0)

  (do-test (snek:add-vert! snk (vec:vec 10d0 0d0)) 1)

  (do-test (snek:add-vert! snk (vec:vec 3d0 3d0)) 2)

  (do-test (snek:add-vert! snk (vec:vec 4d0 3d0)) 3)

  (do-test (snek:add-vert! snk (vec:vec 7d0 200d0)) 4)

  (do-test (snek:add-vert! snk (vec:vec 2d0 10d0)) 5)

  (do-test (snek:add-vert! snk (vec:vec 4d0 11d0)) 6)

  (do-test (snek:add-vert! snk (vec:vec 3d0 10d0)) 7)

  (do-test (snek:add-vert! snk (vec:vec 0d0 0.5d0)) 8)

  (do-test (snek:add-vert! snk (vec:vec 2d0 1.0d0)) 9)

  (do-test (snek:add-vert! snk (vec:vec 3.0d0 10d0)) 10)

  (do-test (snek:ladd-edge! snk '(0 0)) nil)

  (do-test (snek:ladd-edge! snk '(0 2)) '(0 2))

  (do-test (snek:ladd-edge! snk '(0 1)) '(0 1))

  (do-test (snek:ladd-edge! snk '(5 0)) '(0 5))

  (do-test (snek:ladd-edge! snk '(1 0)) nil)

  (do-test (snek:ladd-edge! snk '(5 0)) nil)

  (do-test (snek:ladd-edge! snk '(0 2)) nil)

  (do-test (snek:add-edge! snk 5 2) '(2 5))

  (do-test (snek:add-edge! snk 4 1) '(1 4))

  (do-test (snek:ladd-edge! snk '(4 0)) '(0 4))

  (do-test (snek:ladd-edge! snk '(5 1)) '(1 5))

  (do-test (snek:ladd-edge! snk '(9 9)) nil)

  (do-test (snek:ladd-edge! snk '(3 9)) '(3 9))

  (do-test (snek:ladd-edge! snk '(0 1)) nil)

  (do-test (snek:ladd-edge! snk '(0 4)) nil)

  (do-test (snek:ladd-edge! snk '(10 9)) '(9 10))

  (do-test (snek:edge-exists snk '(0 2)) t)

  (do-test (snek:edge-exists snk '(5 0)) t)

  (do-test (snek:edge-exists snk '(9 2)) nil)

  (do-test (snek:edge-exists snk '(2 2)) nil)

  (do-test (snek:get-vert snk 2) (vec:vec 3.0d0 3.0d0))

  (do-test (snek:add-vert! snk (vec:vec 0d0 1d0)) 11)

  (do-test (snek:ladd-edge! snk '(0 1)) nil)

  (do-test (snek:add-vert! snk (vec:vec 0d0 7d0)) 12)

  (do-test (snek:ledge-length snk '(0 4)) 200.12246250733574d0)

  (do-test (snek:edge-length snk 2 5) 7.0710678118654755d0)

  (do-test (snek:ledge-length snk '(1 2)) 7.615773105863909d0)

  (do-test (snek:move-vert! snk 3 (vec:vec 1d0 3d0)) (vec:vec 5d0 6d0))

  (do-test (snek:move-vert! snk 3 (vec:vec 0.5d0 0.6d0) :rel t)
           (vec:vec 5.5d0 6.6d0))

  (do-test (snek:get-vert snk 3) (vec:vec 5.5d0 6.6d0)))

(defun test-snek-2 (snk)

  (do-test (snek:add-vert! snk (vec:vec 0d0 0d0)) 0)

  (do-test (snek:add-vert! snk (vec:vec 20d0 20d0)) 1)

  (do-test (snek:add-vert! snk (vec:vec 30d0 30d0)) 2)

  (do-test (snek:add-vert! snk (vec:vec 40d0 40d0)) 3)

  (do-test (snek:ladd-edge! snk '(0 1)) '(0 1))

  (do-test (snek:ladd-edge! snk '(1 2)) '(1 2))

  (do-test (snek:ladd-edge! snk '(2 3)) '(2 3))

  (do-test (snek:get-edges snk) '#((0 1) (1 2) (2 3)))

  (do-test (snek:del-edge! snk 0 1) t)

  (do-test (snek:ldel-edge! snk '(0 1)) nil)

  (do-test (snek:ldel-edge! snk '(3 2)) t)

  (do-test (snek:ldel-edge! snk '(1 2)) t)

  (do-test (snek:get-num-edges snk) 0)

  (do-test (snek::snek-num-verts snk) 4))


(defun test-snek-3 (snk)

  (do-test (snek:add-vert! snk (vec:vec 10d0 10d0)) 0)

  (do-test (snek:add-vert! snk (vec:vec 20d0 10d0)) 1)

  (do-test (snek:add-vert! snk (vec:vec 30d0 10d0)) 2)

  (do-test (snek:add-vert! snk (vec:vec 40d0 10d0)) 3)

  (do-test (snek:ladd-edge! snk '(0 1)) '(0 1))

  (do-test (snek:ladd-edge! snk '(1 2)) '(1 2))

  (do-test (snek:ladd-edge! snk '(2 3)) '(2 3))

  (do-test (snek:ladd-edge! snk '(2 3)) nil))


(defun init-snek ()
  (let ((snk (snek:make :max-verts 16)))
    (snek:add-vert! snk (vec:vec 0d0 2d0))
    (snek:add-vert! snk (vec:vec 2d0 3d0))
    (snek:add-vert! snk (vec:vec 3d0 4d0))
    (snek:add-vert! snk (vec:vec 4d0 7d0))
    (snek:add-vert! snk (vec:vec 5d0 4d0))
    (snek:add-vert! snk (vec:vec 0d0 6d0))
    (snek:add-vert! snk (vec:vec -1d0 7d0))
    (snek:add-vert! snk (vec:vec 0d0 8d0))
    (snek:add-vert! snk (vec:vec 0d0 9d0))
    (snek:add-vert! snk (vec:vec 10d0 1d0))
    (snek:add-vert! snk (vec:vec 3d0 1d0))

    (snek:ladd-edge! snk '(1 2))
    (snek:ladd-edge! snk '(0 1))
    (snek:ladd-edge! snk '(3 1))
    (snek:ladd-edge! snk '(5 6))
    (snek:ladd-edge! snk '(7 3))
    snk))


(defun test-snek-incident ()
  (let ((snk (init-snek)))
    (do-test
      (snek:get-incident-edges snk 1)
      '((1 2) (0 1) (1 3)))

    (do-test (snek:get-incident-edges snk 100) nil)))


(defun test-snek-with ()
  (let ((snk (init-snek)))
    (snek:with (snk)

      (snek:add-vert? (vec:vec 11d0 3d0))
      (list 4.5
            (snek:move-vert? 0 (vec:vec 1d0 0d0))
            nil
            t
            (list 5 (snek:add-vert? (vec:vec 12d0 3d0))
                    (snek:add-vert? (vec:vec 13d0 3d0)))
            (list nil)
            (list (list))))

    (do-test (sort (snek:get-vert-inds snk) #'<)
             (list 0 1 2 3 5 6 7)))

    (let ((snk (init-snek)))

      (do-test (snek:edge-exists snk '(7 2)) nil)

      (snek:cwith (snk %)
        (list)
        1 nil
        (% (snek:add-vert? (vec:vec 12d0 3d0)))
        (% (snek:add-vert? (vec:vec 13d0 6d0)))
        (% (snek:add-edge? 1 2))
        (% (snek:add-edge? 2 7))
        (% nil))

      (do-test (snek:get-vert snk 12) (vec:vec 13d0 6d0))
      (do-test (snek:get-vert snk 11) (vec:vec 12d0 3d0))

      (do-test (snek:edge-exists snk '(1 2)) t)
      (do-test (snek:edge-exists snk '(2 7)) t)
      (do-test (snek:edge-exists snk '(7 2)) t)))


(defun test-snek-add ()
  (let ((snk (init-snek)))
    (snek:with (snk)
      (snek:add-vert? (vec:vec 10d0 3d0)))

    (do-test (snek:get-vert snk 11) (vec:vec 10d0 3d0))

    (do-test
      (snek:with (snk :collect t)
        (snek:add-vert? (vec:vec 80d0 3d0))
        (snek:add-vert? (vec:vec 70d0 3d0)))
      '(12 13))

    (do-test (snek::snek-num-verts snk) 14)

    (snek:with (snk)
      (snek:vadd-edge? (vec:vec 7d0 3d0) (vec:vec 100d0 0.99d0)))

    (do-test (snek:get-edges snk)
             '#((1 2) (1 3) (0 1) (3 7) (5 6) (14 15)))))

(defun test-snek-move ()
  (let ((snk (init-snek)))
    (do-test
      (snek:with (snk :collect t)
        (snek:move-vert? 0 (vec:vec 3d0 3d0))
        (snek:move-vert? 1 (vec:vec 1d0 3d0))
        (snek:move-vert? 3 (vec:vec 2d0 3d0) :rel nil)
        (snek:move-vert? 2 (vec:vec 3d0 4d0)))
      (list (vec:vec 3.0d0 5.0d0)
            (vec:vec 3.0d0 6.0d0)
            (vec:vec 2.0d0 3.0d0)
            (vec:vec 6.0d0 8.0d0)))

    (do-test (snek:get-vert snk 0) (vec:vec 3d0 5d0))

    (do-test (snek:get-vert snk 1) (vec:vec 3d0 6d0))

    (do-test (snek:get-vert snk 3) (vec:vec 2d0 3d0))

    (do-test (snek:get-vert snk 2) (vec:vec 6d0 8d0))))

(defun test-snek-join ()
  (let ((snk (init-snek)))
    (snek:with (snk)
      (snek:add-edge? 3 3)
      (snek:add-edge? 3 3)
      (snek:add-edge? 3 6)
      (snek:add-edge? 7 1))

  (do-test (snek:get-num-edges snk) 14)

  (do-test
    (snek:with (snk :collect t)
      (snek:add-edge? 3 3)
      (snek:add-edge? 1 6)
      (snek:add-edge? 1 100))
    '(nil (1 6) nil))))


(defun test-snek-append ()
  (let ((snk (init-snek)))

    (do-test (snek::snek-num-verts snk) 11)

    (do-test
      (snek:with (snk :collect t)
        (snek:append-edge? 3 (vec:vec 3d0 4d0))
        (snek:append-edge? 3 (vec:vec 8d0 5d0) :rel nil)
        (snek:append-edge? 7 (vec:vec 1d0 2d0)))
      '(11 12 13))

    (do-test (snek:get-num-edges snk) 16)

    (do-test (snek::snek-num-verts snk) 14)

    (do-test
      (to-list (snek::snek-verts snk))
      (list 0.0d0 2.0d0 2.0d0 3.0d0 3.0d0 4.0d0 4.0d0 7.0d0 5.0d0 4.0d0
            0.0d0 6.0d0 -1.0d0 7.0d0 0.0d0 8.0d0 0.0d0 9.0d0 10.0d0 1.0d0
            3.0d0 1.0d0 7.0d0 11.0d0 8.0d0 5.0d0 1.0d0 10.0d0 0.0d0 0.0d0
            0.0d0 0.0d0))))


(defun test-snek-split ()
  (let ((snk (init-snek)))
    (do-test
      (snek:with (snk :collect t)
        (snek:split-edge? 1 2)
        (snek:lsplit-edge? '(1 2))
        (snek:lsplit-edge? '(5 6)))
      '(((1 11) (2 11)) NIL ((5 12) (6 12))))

  (do-test (snek:get-num-edges snk) 14)

  (do-test (snek::snek-num-verts snk) 13)

  (do-test
    (to-list (snek::snek-verts snk))
    (list 0.0d0 2.0d0 2.0d0 3.0d0 3.0d0 4.0d0 4.0d0 7.0d0 5.0d0 4.0d0
          0.0d0 6.0d0 -1.0d0 7.0d0 0.0d0 8.0d0 0.0d0 9.0d0 10.0d0 1.0d0
          3.0d0 1.0d0 2.5d0 3.5d0 -0.5d0 6.5d0 0.0d0 0.0d0 0.0d0 0.0d0
          0.0d0 0.0d0))))


(defun test-snek-itrs ()
  (let ((snk (init-snek)))
    (snek:with (snk)
      (snek:with-rnd-vert (snk v)
        (snek:append-edge? v (vec:vec 3d0 2d0))
        (snek:move-vert? v (vec:vec 2d0 2d0))))

    (do-test (snek:get-num-edges snk) 12)

    (do-test (snek::snek-num-verts snk) 12)

    (do-test (snek::snek-wc snk) 1)

    (snek:with (snk)
      (snek:itr-verts (snk v)
        (snek:move-vert? v (vec:vec 2d0 2d0))))

    (do-test
      (sort (flatten (snek:itr-verts (snk i) i)) #'<)
      '(0 1 2 3 4 5 6 7 8 9 10 11))

    (do-test
      (flatten (snek:itr-verts (snk i :collect nil) i))
      nil)

    (do-test
      (sort (flatten (snek:itr-grp-verts (snk i) i)) #'<)
      '(0 1 2 3 5 6 7 11))

    (do-test
      (snek:itr-edges (snk e) e)
      '(((1 2)) ((1 3)) ((0 1)) ((3 7)) ((5 6)) ((5 11))))

    (do-test
      (sort (flatten (snek:itr-edges (snk e) (snek:ledge-length snk e))) #'<)
      '(1.0d0 1.4142135623730951d0 2.23606797749979d0 3.1622776601683795d0
        4.123105625617661d0 4.47213595499958d0))

    (do-test (snek::snek-wc snk) 2)

    (snek:with (snk)
      (snek:with-rnd-edge (snk e)
        (snek:lsplit-edge? e)))

    (do-test (snek:get-num-edges snk) 14)

    (do-test (snek::snek-num-verts snk) 13)))

(defun test-snek-zmap ()
  (let ((snk (snek:make)))

    (snek:add-vert! snk (vec:vec 100d0 200d0))
    (snek:add-vert! snk (vec:vec 200d0 300d0))
    (snek:add-vert! snk (vec:vec 300d0 400d0))
    (snek:add-vert! snk (vec:vec 400d0 500d0))
    (snek:add-vert! snk (vec:vec 500d0 600d0))
    (snek:add-vert! snk (vec:vec 600d0 700d0))
    (snek:add-vert! snk (vec:vec 700d0 800d0))
    (snek:add-vert! snk (vec:vec 800d0 900d0))

    (zmap:make (snek::snek-verts snk)
               (snek::snek-num-verts snk)
               100.0d0)

    (snek:with (snk :zwidth 50.0d0)
      (do-test
        (sort (snek:verts-in-rad snk
                (vec:vec 500d0 500d0) 50.0d0) #'<)
        #())

      (do-test
        (sort (snek:verts-in-rad snk
                (vec:vec -500d0 500d0) 50.0d0) #'<)
        #()))

    (snek:with (snk :zwidth 200.0d0)
      (do-test
        (sort (snek:verts-in-rad snk
                (vec:vec 800d0 800d0) 200.0d0) #'<)
        #(6 7))

      (do-test
        (let ((a (list)))
          (snek:with-verts-in-rad (snk (vec:vec 800d0 800d0) 200d0 v)
            (setf a (append a (list v))))
          a)
        (list 6 7))

      (do-test
        (sort (snek:verts-in-rad snk
                (vec:vec 500d0 500d0) 200.0d0) #'<)
        #(3 4))

      (do-test
        (let ((a (list)))
          (snek:with-verts-in-rad (snk (vec:vec 500d0 500d0) 200d0 v)
            (setf a (append a (list v))))
          a)
        (list 3 4)))

    (snek:with (snk :zwidth 1000.0d0)
      (do-test
        (sort (snek:verts-in-rad snk (vec:vec 500d0 500d0) 1000.0d0) #'<)
        #(0 1 2 3 4 5 6 7)))))


(defun test-snek-grp ()
  (let ((snk (snek:make :max-verts 22 :grp-size 30)))

    (let ((g1 (snek:add-grp! snk :type 'path))
          (g2 (snek:add-grp! snk))
          (g3 (snek:add-grp! snk :type 'path)))
      (snek:add-vert! snk (vec:vec 100d0 200d0))
      (snek:add-vert! snk (vec:vec 200d0 300d0))
      (snek:add-vert! snk (vec:vec 300d0 400d0))
      (snek:add-vert! snk (vec:vec 400d0 500d0))
      (snek:add-vert! snk (vec:vec 600d0 700d0))
      (snek:add-vert! snk (vec:vec 700d0 800d0))
      (snek:add-vert! snk (vec:vec 800d0 900d0))
      (snek:add-vert! snk (vec:vec 500d0 600d0))
      (snek:add-vert! snk (vec:vec 900d0 600d0))

      (snek:ladd-edge! snk '(1 2) :g g1)
      (snek:ladd-edge! snk '(1 2))
      (snek:ladd-edge! snk '(1 2) :g g2)
      (snek:ladd-edge! snk '(3 2) :g g2)
      (snek:ladd-edge! snk '(1 5) :g g3)

      (do-test (sort (flatten (snek:itr-grp-verts (snk i :g g2) i)) #'<)
               '(1 2 3))

      (do-test (sort (flatten (snek:itr-grp-verts (snk i :g nil) i)) #'<)
               '(1 2))

      (do-test (sort (flatten (snek:itr-edges (snk e :g g1) e)) #'<) '(1 2))

      (do-test (sort (snek:get-vert-inds snk :g g1) #'<) '(1 2))

      (do-test (sort (snek:get-vert-inds snk :g g3) #'<) '(1 5))

      (do-test (length (snek:get-vert-inds snk)) 2)

      (do-test (length (snek:itr-grps (snk g) g)) 3)))

  (let* ((snk (snek:make))
         (g (snek:add-grp! snk :type :closed)))
    (snek:add-vert! snk (vec:vec 1d0 1d0))
    (snek:add-vert! snk (vec:vec 1d0 1d0))
    (snek:add-vert! snk (vec:vec 1d0 1d0))

    (do-test (snek:get-grp-loop snk :g g) nil)

    (snek:ladd-edge! snk (list 2 0) :g g)
    (do-test (snek:get-grp-loop snk :g g) nil)
    (snek:ladd-edge! snk (list 1 2) :g g)
    (snek:ladd-edge! snk (list 1 0) :g g)

    (do-test (to-list (snek:get-grp-loop snk :g g )) (list 2 0 1))))

(defun test-snek-prm ()
  (let ((snk (snek:make :max-verts 22 :grp-size 30
                        :prms (list
                                (list :path
                                      (lambda (snk p &optional extra-args)
                                        (snek:get-prm-vert-inds snk :p p)))))))
    (let ((p1 (snek:add-prm! snk :type :path))
          (p2 (snek:add-prm! snk))
          (p3 (snek:add-prm! snk :type :path)))
      (snek:add-vert! snk (vec:vec 100d0 200d0) :p p1)
      (snek:add-vert! snk (vec:vec 200d0 300d0) :p p2)
      (snek:add-vert! snk (vec:vec 300d0 400d0) :p p3)
      (snek:add-vert! snk (vec:vec 400d0 500d0) :p p1)
      (snek:add-vert! snk (vec:vec 600d0 700d0) :p p1)
      (snek:add-vert! snk (vec:vec 700d0 800d0) :p p2)

      (do-test (flatten (snek:itr-prm-verts (snk i :p p2) i)) '(1 5))

      (do-test (flatten (snek:itr-prm-verts (snk i :p p1) i)) '(0 3 4))

      (do-test
        (snek:get-prm-verts snk :p p1)
        (list (vec:vec 100.0d0 200.0d0)
              (vec:vec 400.0d0 500.0d0)
              (vec:vec 600.0d0 700.0d0)))

      (do-test (to-list (snek:prmr snk :p p1)) '(0 3 4))

      (do-test (to-list (snek:prmr snk :p p2)) '(1 5))

      (do-test (length (snek:itr-prms (snk p) p)) 3))))


(defun main ()
  (test-title (test-snek (snek:make)))
  (test-title (test-snek-2 (snek:make)))
  (test-title (test-snek-3 (snek:make)))
  (test-title (test-snek-incident))
  (test-title (test-snek-with))
  (test-title (test-snek-add))
  (test-title (test-snek-move))
  (test-title (test-snek-join))
  (test-title (test-snek-append))
  (test-title (test-snek-split))
  (test-title (test-snek-itrs))
  (test-title (test-snek-zmap))
  (test-title (test-snek-grp))
  (test-title (test-snek-prm))
  (test-title (test-summary)))

(main)

