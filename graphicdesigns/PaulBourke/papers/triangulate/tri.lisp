;******************************************************************************************;
;** Credit to Paul Bourke (pbourke@swin.edu.au) for the original Fortran 77 Program :))  **;
;** Converted to AutoLISP by Mihai Popescu (mihai.popescu@shareit.ro)                    **;
;** You can use this code however you like providing the above credits remain in tact    **;
;******************************************************************************************;

;epsilon
(setq EPS 0.000001)

;Return t if a point (xp,yp) is inside the circumcircle made up
;of the points (x1,y1), (x2,y2), (x3,y3)
;The circumcircle centre is returned in (xc,yc) and the radius r2 (square)
(setq xc 0 yc 0 r2 0)
(defun circumcircle(xp yp x1 y1 x2 y2 x3 y3
                                       / m1 m2 mx1 mx2 my1 my2
                                       dx dy dr ay1y2 ay2y3
)

(setq   ay1y2 (abs (- y1 y2))
               ay2y3 (abs (- y2 y3))
)
;Check for coincident points
(if (and (< ay1y2 EPS) (< ay2y3 EPS))
       nil
       (progn
               (if (< ay1y2 EPS)
                       (setq   m2      (/ (- x2 x3) (- y3 y2))
                                       mx2 (/ (+ x2 x3) 2.0)
                                       my2 (/ (+ y2 y3) 2.0)
                                       xc  (/ (+ x2 x1) 2.0)
                                       yc  (+ (* m2 (- xc mx2)) my2)
                       )
                       (if (< ay2y3 EPS)
                               (setq   m1      (/ (- x1 x2) (- y2 y1))
                                               mx1     (/ (+ x1 x2) 2.0)
                                               my1 (/ (+ y1 y2) 2.0)
                                               xc  (/ (+ x3 x2) 2.0)
                                               yc      (+ (* m1 (- xc mx1)) my1)
                               )
                               (progn

                                       (setq   m1      (/ (- x1 x2) (- y2 y1))
                                                       mx1     (/ (+ x1 x2) 2.0)
                                                       my1 (/ (+ y1 y2) 2.0)
                                                       m2      (/ (- x2 x3) (- y3 y2))
                                                       mx2 (/ (+ x2 x3) 2.0)
                                                       my2 (/ (+ y2 y3) 2.0)
                                                       xc      (/ (+ (* m1 mx1) (- (* m2 mx2)) my2 (- my1)) (- m1 m2))
                                       )
                                       (if (> ay1y2 ay2y3)
                                               (setq yc (+ (* m1 (- xc mx1)) my1))
                                               (setq yc (+ (* m2 (- xc mx2)) my2))
                                       )
                               )
                       )
               )
       )
)

(setq   dx (- x2 xc)
               dy (- y2 yc)
               r2 (+ (* dx dx) (* dy dy))
               dx (- xp xc)
               dy (- yp yc)
               dr (+ (* dx dx) (* dy dy))
)
(if (<= dr r2) t nil)
)

; Triangulation function
; The input consist of the list of points: pts = ((x1 y1) (x2 y2) ... )
; The function will return a list of triangles specified by the position of vertices in the input list
(defun Triangulate(pts / x y xmin ymin xmax ymax s k dx dy dm xm ym all lst head tail prev out edges egg done
                                               p1 p2 p3 e1 e2 e3 xp yp x1 y2 x2 y2 x3 y3 tr found)
;  Find the maximum and minimum vertex bounds.
;  This is to allow calculation of the bounding triangle
(setq   xmin (caar pts)
               ymin (cadar pts)
               xmax xmin
               ymax ymin
               s 0
               k 0
)
(foreach p pts
       (setq   x (car p)
                       y (cadr p)
                       xmin (min xmin x)
                       xmax (max xmax x)
                       ymin (min ymin y)
                       ymax (max ymax y)
                       s (1+ s)
       )
)
(setq   dx      (- xmax xmin)
               dy      (- ymax ymin)
               dm  (max dx dy)
               xm      (/ (+ xmax xmin) 2.0)
               ym  (/ (+ ymax ymin) 2.0)
)
;      Set up the supertriangle
;      This is a triangle which encompasses all the sample points.
;      The supertriangle coordinates are added to the end of the
;      vertex list. The supertriangle is the first triangle in
;      the triangle list.
(setq p1 (list (- xm (* 20 dm)) (- ym dm)))
(setq p2 (list xm (+ ym (* 20 dm))))
(setq p3 (list (+ xm (* 20 dm)) (- ym dm)))
(setq all (append pts (list p1 p2 p3)))
(setq lst (list (list (+ 0 s) (+ 1 s) (+ 2 s))))


;  Include each point one at a time into the existing mesh
(foreach p pts
       (setq   xp (car p)
                       yp (cadr p)
                       out nil
                       edges nil
       )

       ;Set up the edge buffer.
   ; If the point (xp,yp) lies inside the circumcircle then the
   ; three edges of that triangle are added to the edge list
   ; and that triangle is removed.
       (foreach tr lst
               (setq   e1 (fix (car tr))   p1 (nth e1 all) x1 (car p1) y1 (cadr p1)
                               e2 (fix (cadr tr))  p2 (nth e2 all) x2 (car p2) y2 (cadr p2)
                               e3 (fix (caddr tr)) p3 (nth e3 all) x3 (car p3) y3 (cadr p3)
               )
               ; append edges to the edge list
               (if (circumcircle xp yp x1 y1 x2 y2 x3 y3)
                       (setq   edges (append edges (list (list e1 e2)))
                                       edges (append edges (list (list e2 e3)))
                                       edges (append edges (list (list e3 e1)))
                       )
                       (setq out (append out (list tr)))
               )
       )
       ; the triangle list is formed only from outside triangles
       (setq lst out egg nil prev nil)

       ; delete all doubly specified edges from the edge list
   ; this leaves the edges of the enclosing polygon only
       (while (/= edges nil)
               (setq head prev e1 (car edges) tail (cdr edges))

               (setq found 0)
               (foreach e2 tail
                       (if (and (= found 0) (or (equal e1 e2) (and (equal (car e1) (cadr e2)) (equal (cadr e1) (car e2)))))
                               (setq found 1)
                       )
               )
               (if (= found 0)
                       (foreach e3 head
                               (if (and (= found 0) (or (equal e1 e3) (and (equal (car e1) (cadr e3)) (equal (cadr e1) (car e3)))))
                                       (setq found 1)
                               )
                       )
               )
               (if (= found 0)
                       (setq egg (append egg (list e1)))
               )

               (setq prev (append prev (list e1)))
               (setq edges tail)
       )

       ;add to the triangle list all triangles formed between the point
   ;and the edges of the enclosing polygon
       (foreach e1 egg
               (setq   tr (list (fix (car e1)) (fix (cadr e1)) k)
                               lst (append lst (list tr))
               )
       )
       (setq k (1+ k))
)
(setq done nil)

; Remove triangles with supertriangle vertices
(foreach tr lst
       (setq   e1 (fix (car tr))
                       e2 (fix (cadr tr))
                       e3 (fix (caddr tr))
       )
       (if (and (< e1 s) (< e2 s) (< e3 s))
               (setq done (append done (list (list e1 e2 e3))))
       )
)
; return result
done
)


; Here is an example on how to use the previous function in  AutoLisp.
; AutoLisp is a dialect of Lisp programming language build for scripting in CAD applications.

; set the point list (2D and 3D as well)
(setq pts '((0 0) (1 0) (0 1) (1 1) (0.6 1.6)))

(prompt "\nTriangulating...")
(setq lst (triangulate pts))

(setvar "CMDECHO" 0)

; drawing the resulted triangles in collors
(setq i 0)
(foreach tr lst
       (command "color" i)
       (setq   e1 (car tr) p1 (nth e1 pts) p1 (list (car p1) (cadr p1))
                       e2 (cadr tr) p2 (nth e2 pts) p2 (list (car p2) (cadr p2))
                       e3 (caddr tr) p3 (nth e3 pts) p3 (list (car p3) (cadr p3))
       )
       (command "pline" p1 p2 p3 "c")
       ;(command "line" p1 p2 p3 p1 "")
       (setq i (1+ i))
)
(setvar "CMDECHO" 1)

