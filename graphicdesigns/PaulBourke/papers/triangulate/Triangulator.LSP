;;;Credit to Paul Bourke (pbourke@swin.edu.au) for the original Fortran 77 Program :))
;;;Converted to AutoLISP by Pedro Ferreira (pwp.netcabo.pt/pedro_ferreira)
;;;Check out: http://local.wasp.uwa.edu.au/~pbourke/papers/triangulate/
;;;You can use this code however you like providing the above credits remain in tact

;;;Triangulator performs the Delauney triangulation on a set of vertices.
;;;Based on Paul Bourke's "An Algorithm for Interpolating Irregularly-Spaced Data
;;;with Applications in Terrain Modelling"
;;;http://local.wasp.uwa.edu.au/~pbourke/papers/triangulate/

					;The triangulation algorithm may be described in pseudo-code as follows:

					; subroutine Triangulate
					; input : vertex list
					; output : triangle list
					;    initialize the triangle list
					;    determine the supertriangle
					;    add supertriangle vertices to the end of the vertex list
					;    add the supertriangle to the triangle list
					;    for each sample point in the vertex list
					;       initialize the edge buffer
					;       for each triangle currently in the triangle list
					;          calculate the triangle circumcircle center and radius
					;          if the point lies in the triangle circumcircle then
					;             add the three triangle edges to the edge buffer
					;             remove the triangle from the triangle list
					;          endif
					;       endfor
					;       delete all doubly specified edges from the edge buffer
					;          this leaves the edges of the enclosing polygon only
					;       add to the triangle list all triangles formed between the point 
					;          and the edges of the enclosing polygon
					;    endfor
					;    remove any triangles from the triangle list that use the supertriangle vertices
					;    remove the supertriangle vertices from the vertex list
					; end

					;O algoritmo de Triangulação pode ser descrito em Pseudo-código da seguinte forma:

					;Subrotina Triangulate
					;Input : Lista de Vértices
					;Output : Lista de triângulos
					;	1º - inicializar a lista de triângulos
					;	2º - Determinar o Supertriângulo (triângulo que contêm no seu interior todos os pontos a triangular)
					;	3º - Adicionar os vértices do Supertriângulo no fim da lista de Vértices
					;	4º - Adicionar o Supertriângulo à lista de triângulos
					;	5º - (for) para cada ponto na lista de Vértices
					;		Inicializar o edge buffer (lista temporária das faces dos triângulos)
					;		(for each) Para cada triângulo actualmente na lista de triângulos
					;                          Calcular o circuncirculo (circunferência circunscrita no triângulo), centro e raio do triângulo
					;                          (if) Se o ponto cair dentro da circunferência então adicione as três faces do triângulo ao edge buffer
					;                               Remova o triângulo da lista de triângulos
					;                          (endif)
					;		(endfor each)
					;                 Apagar todas as faces duplicadas no edge buffer deixando assim apenas as faces do poligono que contêm o ponto
					;                 Adicionar à lista de triângulos todos os triângulos formados entre o ponto e as faces do poligono
					;	    (endfor)
					;        6º - remover qualquer triângulo da lista de triângulos que use os vértices do Supertriângulo
					;        7º - remover os vértices do Supertriângulo da lista de vértices
					;       (end)

(defun c:triangulator ()
  (setq vertexlist nil)
  (setq trianglelist nil)
  (setq edgelist nil)
  (inputpoints)
  (if (/= point nil)
    (addpointtolist point)
  )
  (while (/= point nil)
    (progn
      (inputpoints)
      (if (/= point nil)
	(addpointtolist point)
      )
      ;;end if
      (if (> vertexlistlength 2)
	;;Perform Triangulation if there are more than 2 points in the collection
	(progn
	  (if (/= point nil)
	    (progn
	      (triangulate)
	      ;;Draw the created triangles
	      (redraw)
	      (setq count 0)
	      (while (< count trianglelistlength)
		(progn
		  (setq	list1 (car (nth count trianglelist))
			list2 (cadr (nth count trianglelist))
			list3 (caddr (nth count trianglelist))
		  )
		  (grdraw list1 list2 1)
		  (grdraw list2 list3 2)
		  (grdraw list3 list1 3)
		  (setq count (1+ count))
		)
	      )
	      ;;end while
	    )
	  )
	  ;;end if
	)
      )
      ;;end if
    )
  )
  ;;end while




  (princ)
)
;;----------------------------------;;
(defun inputpoints ()
  (setq point (getpoint "\nSpecify a point:"))
  (if (/= point nil)
    (vl-cmdf "point" point)
  )
)
;;----------------------------------;;
(defun addpointtolist (point)		;First in Last out
  (setq vertexlist (reverse (append (reverse vertexlist) (list point))))
  (setq vertexlistlength (length vertexlist))
)
;;----------------------------------;;
(defun addpointtoendoflist (point)
  (setq vertexlist (append vertexlist (list point)))
  (setq vertexlistlength (length vertexlist))
)
;;----------------------------------;;
(defun addtriangletolist (trianglevertex)
  (setq trianglevertex (sortlistbyx trianglevertex))
  (setq trianglevertex (reverse trianglevertex))
  (setq trianglelist (append trianglelist (list trianglevertex)))
  (setq trianglelistlength (length trianglelist))
)
;;----------------------------------;;
(defun addtriangletobegginingoflist (trianglevertex)
  (setq	trianglelist
	 (reverse
	   (append (reverse trianglelist) (list trianglevertex))
	 )
  )
  (setq trianglelistlength (length trianglelist))
)
;;----------------------------------;;
(defun edgebuffer (pt1 pt2 pt3)
  (setq	edgelist
	 (append
	   edgelist
	   (list (list pt1 pt2) (list pt2 pt3) (list pt3 pt1))
	 )
  )
  (setq edgelistlength (length edgelist))
)
;;----------------------------------;;
(defun supertriangle ()
  (if (>= vertexlistlength 3)
    (progn
      (setq supertrianglevertices nil)
      (setq xmax (car (last (sortlistbyx vertexlist)))
	    ymax (cadr (last (sortlistbyy vertexlist)))
	    xmin (car (car (sortlistbyx vertexlist)))
	    ymin (cadr (car (sortlistbyy vertexlist)))
      )
      (setq centerpoint
	     (list (+ (/ (- xmax xmin) 2.0) xmin)
		   (+ (/ (- ymax ymin) 2.0) ymin)
	     )
      )
      (setq radius (distance centerpoint (list xmin ymin)))

      (setq angledegrees 30)
      (setq tan (/ (sin (Dtr angledegrees)) (cos (Dtr angledegrees))))

      (setq pt1	(list (car centerpoint)
		      (+ (cadr centerpoint) (* radius 2.0))
		)
	    pt2	(list (- (car centerpoint) (/ radius tan))
		      (- (cadr centerpoint) radius)
		)
	    pt3	(list (+ (car centerpoint) (/ radius tan))
		      (- (cadr centerpoint) radius)
		)
      )

      ;;(vl-cmdf "._pline" pt1 pt2 pt3 pt1 "") ;test only



      (setq supertrianglevertices (list pt1 pt2 pt3))
      (addpointtoendoflist pt1)
      (addpointtoendoflist pt2)
      (addpointtoendoflist pt3)
      (addtriangletobegginingoflist supertrianglevertices)



    )
  )
)
;;----------------------------------;;
(defun sortlistbyy (sortedlist)
  (setq	sortedlist
	 (vl-sort sortedlist
		  (function (lambda (e1 e2)
			      (< (cadr e1) (cadr e2))
			    )
		  )
	 )
  )					;list points by y value (smaller value first)
)
;;----------------------------------;;
(defun sortlistbyx (sortedlist)
  (setq	sortedlist
	 (vl-sort sortedlist
		  (function (lambda (e1 e2)
			      (< (car e1) (car e2))
			    )
		  )
	 )
  )					;list points by x value (smaller value first)
)
;;----------------------------------;;
(defun RtD (nbrOfRadians)
  (* 180.0 (/ nbrOfRadians pi))
)

(defun DtR (numberOfDegrees)
  (* pi (/ numberOfDegrees 180.0))
)
;;----------------------------------;;
(defun circ3pt ()
  (setq	pt1 (car triangle)
	pt2 (cadr triangle)
	pt3 (caddr triangle)
  )
  (setq	a1 (car pt1)
	b1 (cadr pt1)
	a2 (car pt2)
	b2 (cadr pt2)
	a3 (car pt3)
	b3 (cadr pt3)
  )

  (setq c 1.00)

  (setq	a1b1 (+ (expt a1 2.0) (expt b1 2.0))
	a2b2 (+ (expt a2 2.0) (expt b2 2.0))
	a3b3 (+ (expt a3 2.0) (expt b3 2.0))
  )

  (setq	d  (+ (- (* a1 (- (* b2 c) (* b3 c)))
		 (* b1 (- (* a2 c) (* a3 c)))
	      )
	      (* c (- (* a2 b3) (* a3 b2)))
	   )
	n1 (+ (- (* a1b1 (- (* b2 c) (* b3 c)))
		 (* b1 (- (* a2b2 c) (* a3b3 c)))
	      )
	      (* c (- (* a2b2 b3) (* a3b3 b2)))
	   )
	n2 (+ (- (* a1 (- (* a2b2 c) (* a3b3 c)))
		 (* a1b1 (- (* a2 c) (* a3 c)))
	      )
	      (* c (- (* a2 a3b3) (* a3 a2b2)))
	   )
  )

  (if (/= d 0.00)
    (progn
      (setq h (/ n1 (* 2.00 d))
	    k (/ n2 (* 2.00 d))
      )
      (setq radius (sqrt (+ (expt (- a1 h) 2) (expt (- b1 k) 2.00))))
      (setq center (list h k))
    )
  )
)
;;----------------------------------;;
(defun incircle	()
  (setq test nil)
  (setq dist (distance chkvertex center))
  (if (<= dist radius)
    (setq test t)
  )
)
;;----------------------------------;;
(defun triangulate ()
  (if (< vertexlistlength 3)
    (progn
      (princ
	"\nerror: need at least three points for triangulation"
      )
    )
    (progn
      ;;initialize the triangle list
      (setq trianglelist nil)

      ;;determine the supertriangle
      ;;Set up the supertriangle
      ;;This is a triangle which encompasses all the sample points.
      ;;The supertriangle coordinates are added to the end of the
      ;;vertex list. The supertriangle is the first triangle in
      ;;the triangle list.
      (supertriangle)

      ;;Include each point one at a time into the existing mesh
      (setq counter1 0)
      (while (< counter1 vertexlistlength)
	(progn
	  (setq chkvertex (nth counter1 vertexlist))
					;point to be tested

	  ;;Set up the edge buffer.
	  ;;If the point lies inside the circumcircle then the
	  ;;three edges of that triangle are added to the edge buffer and the triangle is removed from the list.
	  (setq counter2 0)
	  (setq teste1 trianglelist)

	  (while (< counter2 trianglelistlength)
	    (progn
	      (setq triangle (nth counter2 trianglelist))
	      (circ3pt)
	      (incircle)
	      (if (= test t)
		(progn
		  (setq	pt1 (car triangle)
			pt2 (cadr triangle)
			pt3 (caddr triangle)
		  )
		  (edgebuffer pt1 pt2 pt3)
		  (setq	trianglelisttest
			 (vl-remove triangle trianglelist)
		  )
		  (setq	trianglelisttestlength
			 (length trianglelisttest)
		  )
		  (setq	dif_lists (- trianglelistlength
				     trianglelisttestlength
				  )
		  )
		  (if (< dif_lists 2)
		    (progn
		      (setq trianglelist
			     (vl-remove triangle trianglelist)
		      )
		      (setq trianglelistlength (length trianglelist))
		    )
		    (progn
		      (setq trianglelist
			     (vl-remove triangle trianglelist)
		      )
		      (setq count 0)
		      (while (< count dif_lists)
			(progn
			  (setq	trianglelist
				 (append triangle trianglelist)
			  )
			  (setq count (1+ count))
			)
		      )
		      (setq trianglelistlength (length trianglelist))


		    )
		  )
		  ;;end if

		  (setq counter2 (1- counter2))
		)
	      )
	      ;;end if
	      (setq counter2 (1+ counter2))
	    )
	  )
	  ;;end while
	  (setq teste2 trianglelist)


	  ;;delete all doubly specified edges from the edge buffer
	  ;;this leaves the edges of the enclosing polygon only	  
	  (setq newedgelist edgelist)
	  (setq counter3 0)
	  (while (< counter3 edgelistlength)
	    (progn
	      (setq edgecheck (nth counter3 edgelist))

	      (setq numberedges 0)
	      (setq counter6 0)
	      (while (< counter6 edgelistlength)
		(progn
		  (setq test (nth counter6 edgelist))
		  (if (equal test edgecheck)
		    (setq numberedges (1+ numberedges))
		  )
		  (setq counter6 (1+ counter6))
		)
	      )
	      (if (>= numberedges 2)
		(progn
		  (setq newedgelist (vl-remove edgecheck newedgelist))
		)
	      )
	      (setq counter3 (1+ counter3))
	    )
	  )
	  ;;end while
	  (setq counter3 0)
	  (while (< counter3 edgelistlength)
	    (progn
	      (setq edgecheck (reverse (nth counter3 edgelist)))

	      (setq numberedges 0)
	      (setq counter6 0)
	      (while (< counter6 edgelistlength)
		(progn
		  (setq test (nth counter6 edgelist))
		  (if (equal test edgecheck)
		    (setq numberedges (1+ numberedges))
		  )
		  (setq counter6 (1+ counter6))
		)
	      )
	      (if (>= numberedges 1)
		(progn
		  (setq newedgelist (vl-remove edgecheck newedgelist))
		)
	      )
	      (setq counter3 (1+ counter3))
	    )
	  )
	  ;;end while

	  (setq edgelist newedgelist)
	  (setq edgelistlength (length edgelist))

	  ;;Form new triangles for the current point
	  (setq counter4 0)
	  (while (< counter4 edgelistlength)
	    (progn
	      (setq trianglevertex
		     (list (car (nth counter4 edgelist))
			   (cadr (nth counter4 edgelist))
			   chkvertex
		     )
	      )
	      (if (/= (car trianglevertex) (cadr trianglevertex))
		(if (/= (car trianglevertex) (caddr trianglevertex))
		  (if (/= (cadr trianglevertex) (caddr trianglevertex))
		    (addtriangletolist trianglevertex)
		  )
		)
	      )
	      (setq counter4 (1+ counter4))
	    )
	  )
	  ;;end while

	  (setq edgelist nil)
	  (setq newedgelist nil)
	  ;;empty edgelist
	  (setq counter1 (1+ counter1))
	)
      )
      ;;end while

      ;;remove any triangles from the triangle list that use the supertriangle vertices
      (setq trianglevertex1 (car supertrianglevertices)
	    trianglevertex2 (cadr supertrianglevertices)
	    trianglevertex3 (caddr supertrianglevertices)
      )

      (setq trianglevertexlist
	     (list trianglevertex1
		   trianglevertex2
		   trianglevertex3
	     )
      )
      (setq counter5 0)
      (setq newtrianglelist trianglelist)
      (while (< counter5 trianglelistlength)

	(progn
	  (setq	triangletestvertex1
		 (car (nth counter5 trianglelist))
		triangletestvertex2
		 (cadr (nth counter5 trianglelist))
		triangletestvertex3
		 (caddr (nth counter5 trianglelist))
	  )
	  (setq	test1 (member triangletestvertex1 trianglevertexlist)
		test2 (member triangletestvertex2 trianglevertexlist)
		test3 (member triangletestvertex3 trianglevertexlist)
	  )

	  (if (= test1 nil)
	    (progn
	      (if (= test2 nil)
		(progn
		  (if (/= test3 nil)
		    (progn
		      (setq newtrianglelist
			     (vl-remove	(nth counter5 trianglelist)
					newtrianglelist
			     )
		      )
		    )
		  )
		)
		(progn
		  (setq	newtrianglelist
			 (vl-remove (nth counter5 trianglelist)
				    newtrianglelist
			 )
		  )
		)
	      )
	    )
	    (progn
	      (setq newtrianglelist
		     (vl-remove	(nth counter5 trianglelist)
				newtrianglelist
		     )
	      )
	    )
	  )

	  (setq counter5 (1+ counter5))
	)
      )
      ;;end while
      (setq trianglelist newtrianglelist)
      (setq trianglelistlength (length trianglelist))
      (setq newtrianglelist nil)



      ;;Remove SuperTriangle vertices

      (setq vertexlist (reverse (cdr (reverse vertexlist))))
      (setq vertexlist (reverse (cdr (reverse vertexlist))))
      (setq vertexlist (reverse (cdr (reverse vertexlist))))

      (setq vertexlistlength (length vertexlist))
    )
  )
  ;;end if
)

(alert
  "Type [triangulator] in the command line.\n\nPress OK to continue."
)

