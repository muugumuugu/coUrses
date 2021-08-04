;;;   int2.lsp
;;;
;;;   Finds the intersection of two non-parallel lines in 2D or 3D, OR the
;;;   closest points between the two non-intersecting lines in 3D.
;;;
;;;   Based on Algorithm by Paul Bourke / Autolisp version by Andrew Bennett.
;;;
;;;   See Paul Bourke's discussion at:
;;;   http://local.wasp.uawa.edu.au/~pbourke/geometry/lineline3d/
;;;   Uses algorithm derived from the fact that the closest point between two
;;;   lines is a new line perpendicular to both.
;;;
;;;   On the XY plane of Autocad's current UCS, two non-parallel vectors will
;;;   always intersect, therefore the various object snaps (osnap) or
;;;   Autolisp's (inters) function are all you need.
;;;
;;;   Outside the UCS plane in the 3D environment however, these intersection
;;;   functions are over precise and can easily fail (see Paul Bourke's
;;;   discussion) leaving you with no further information.
;;;
;;;   Int2.lsp addresses this problem by working as follows:
;;;
;;;   As with Autocad/Autolisp, the program will find the intersection point
;;;   between two (non-parallel) lines in 2D, or if it exists, in 3D.
;;;
;;;   In 3D, where there may not be a precise intersection, it finds the
;;;   closest points between the two lines and draws a new line between them.
;;;
;;;   In both cases, the resultant point(s) are set by invoking the
;;;   Autocad 'Line' command which draws a rubber-band line from the last
;;;   point set to the current cursor position. This feature allows the
;;;   intersection/closest point(s) to be clearly visible on screen even if the
;;;   point(s) have been set outside the current drawing window.
;;;
;;;   If the two lines are parallel, then they are also equidistant, so there
;;;   is no intersection, and no specific closest point, and so the program
;;;   will end by giving an appropriate informative message. 


(defun c:int2
             (
               /                       ; local variables used in defun
               acad_err                ; temporary error handler
               oldsnap                 ; saved snap settings
               nearzero                ; a very small number
               currentP                ; list containing 3 reals
               checkP
               retn_val                ; value returned after defun call
               getPt_msg               ; message string
               P1 P2 P3 P4             ; xyz coordinate lists (reals)
               X1 X2 X3 X4 X5 X6       ; x value (real)
               Y1 Y2 Y3 Y4 Y5 Y6       ; y value (real)
               Z1 Z2 Z3 Z4 Z5 Z6       ; z value (real)
               RelX21 RelY21 RelZ21    ; relative x, y, and z values of P2-P1
               RelX43 RelY43 RelZ43;                                    P4-P3
               RelX13 RelY13 RelZ13;                                    P1-P3
               dot1343 dot4321         ; dot products of Relative xyz values
               dot1321 dot4343 dot2121 ; dot products of Relative xyz values
               denom numer             ; denominator & numerator of equation
               closedist               ; closest distance between two lines
               u21 u43                 ; scale factors line21 or line43 length
              )



  (init_err) ; set up temporary error handler and save previous system settings

(setq transp_cmd (getvar "cmdactive"))    ; Test value
  (if (> transp_cmd 0)                    ; if Autocad commands running
  (princ "Program cannot not be run as a transparent command") ;Then END


  (progn                              ; Else continue with the program

  (setvar "cmdecho" 0)                ; Turn off command prompt
  (setq nearzero 0.00001)             ; a very small number

  (setq
    P1 (getpt nil "\nLINE From Point: ") ;call getpt function
    P2 (getpt P1 "\nTo Point: ")
    P3 (getpt nil "\nLINE From Point: ")
    P4 (getpt P3 "\nTo Point: ")
  );setq

  (setq oldsnap (getvar "osmode"))    ; check & save current osnap settings
  (setvar "osmode" 0)                 ; before clearing all osnaps

  (setq
    ;; Strip xyz coordinates from lists P1, P2, P3 and P4, assign to variables
    X1 (car P1)    X2 (car P2)    X3 (car P3)    X4 (car P4)    ; x value
    Y1 (cadr P1)   Y2 (cadr P2)   Y3 (cadr P3)   Y4 (cadr P4)   ; y value
    Z1 (caddr P1)  Z2 (caddr P2)  Z3 (caddr P3)  Z4 (caddr P4)  ; z value

    ;; Calculate Relative coordinates of XYZ21, XYZ13 and XYZ43
    RelX21 (- X2 X1)  RelX43 (- X4 X3)  RelX13 (- X1 X3)        ; rx value
    RelY21 (- Y2 Y1)  RelY43 (- Y4 Y3)  RelY13 (- Y1 Y3)        ; ry value
    RelZ21 (- Z2 Z1)  RelZ43 (- Z4 Z3)  RelZ13 (- Z1 Z3)        ; rz value


    ;; Calculate the various dot products and denominator
    dot1343 (+ (* RelX13 RelX43) (* RelY13 RelY43) (* RelZ13 RelZ43))
    dot4321 (+ (* RelX43 RelX21) (* RelY43 RelY21) (* RelZ43 RelZ21))
    dot1321 (+ (* RelX13 RelX21) (* RelY13 RelY21) (* RelZ13 RelZ21))
    dot4343 (+ (* RelX43 RelX43) (* RelY43 RelY43) (* RelZ43 RelZ43))
    dot2121 (+ (* RelX21 RelX21) (* RelY21 RelY21) (* RelZ21 RelZ21))

    denom (- (* dot2121 dot4343) (* dot4321 dot4321))
  );setq

  (if (< (abs denom) nearzero)  ; are lines parallel?

    ;; Display message, exit loop, program ends
    (princ "\nLines Parallel and Equidistant, No intersection point exists")

    (progn

    (setq

      numer (- (* dot1343 dot4321) (* dot1321 dot4343))

      ;; u21 scale factor up line 1 to closest point to line21
      ;; if 0 > u21 < 1 closest point is within line section
      ;; if u21 < 0 closest point is beyond P1 end
      ;; or u21 > 1 closest point is beyond P2 end

      u21 (/ numer denom)

      ;; u43 is the scale factor up Line43 and works in the same way as u21

      u43 (/ (+ dot1343 (* dot4321 u21)) dot4343)

      X5 (+ X1 (* u21 RelX21))
      Y5 (+ Y1 (* u21 RelY21))
      Z5 (+ Z1 (* u21 RelZ21))

      X6 (+ X3 (* u43 RelX43))
      Y6 (+ Y3 (* u43 RelY43))
      Z6 (+ Z3 (* u43 RelZ43))

      ; Calculate the distance between the points
      closedist (distance (list X5 Y5 Z5) (list X6 Y6 Z6))

    );setq

      (if (< closedist nearzero)  ; are points nearly touching?

        (progn

          ;; intersection point found

          (princ "\nIntersection, Point set")     ; print message
          (princ)                                 ; suppress return nil
          (command "line" (list X5 Y5 Z5))        ; set point

        );progn

        (progn

          ;; No intersection point found,
          ;; new line will be drawn at closest point to both lines

          ; Print message and length of line section
          (princ (strcat "\nNo intersection, Line drawn at closest point, Length: "
                         (rtos closedist)))
          (princ)                                           ; suppress return nil
          (command "line" (list X5 Y5 Z5) (list X6 Y6 Z6))  ; set a line section

        );progn

      );if

    );progn

  );if

  (reset_err)  ; Restore standard handler and previous system settings

  );progn

  );if (Transparent command message)

  (princ)      ; suppress return value

);defun



;; Uses (getpoint) function to get valid lists of coordinates
;; Uses (initget) function to prevent ENTER being pressed accidently
;;
;; Syntax (getpt checkP/nil getpt_msg)
;; Parameter list (checkP getpt_msg currentP retn_val nearzero)
;;
;;   (checkP)    Coincidence check with previous point 
;;   (nil)       No coincidence check with previous point
;;   (getpt_msg) Message to display at the Command prompt
;; 
;; Returns retn_val to calling function as list of reals
;;
;;   example:
;;
;;   (setq P1 (getpt nil "\nPoint: ") ; returns P1, no coincidence check
;;         P2 (getpt P1 "\nLINE From Point: ") ; returns P2, check with P1
;;         P3 (getpt P2 "\nTo point: ")) ; returns P3, check with P2

(defun getpt (checkP getpt_msg)

  (setq currentP nil)                   ; initialise currentP
  (while (null currentP)                ; start loop
    (initget 1)                          ; disallows null input
    (setq currentP (getpoint getpt_msg)) ; Type/set a valid coordinate
    (if (null checkP)                   ; Do/Don't compare with previous point
      (setq retn_val currentP)          ; return currentP to calling function
      (progn
      (if (equal checkP currentP nearzero) ; compare with check point
        (progn
        (princ "\nPoints touch, Do again")    ; both points set in same place
        (setq currentP nil)                   ; nil currentP to repeat loop
        ); progn
        (setq retn_val currentP)        ; return currentP to calling function
      );if                              ; currentP nil, repeat loop
      );progn
    );if
  ); while                            ; currentP boundp, get out of loop

);defun


;;;************************** error trap functions ****************************


;; Function sets up temporary error handler and saves previous system settings

(defun init_err ()
 
 (setq acad_err *error*)  ; save standard error handler
 (setq *error* temp_err)  ; redirect error call to temporary error handler
 
 (setq oldsnap (getvar "osmode")) ; save osnaps, keep them on
 (setvar "cmdecho" 0)               ; turn off command echoing
 (princ)
 
);defun


;; Function invokes temporary error handler
;; Restores standard handler and previous system settings

(defun temp_err (msg)

(setq transp_cmd (getvar "cmdactive")); Test value
  (if (> transp_cmd 0)                ; if Autocad commands running
   (command)                          ; then cancel them
 );if
 
 (if 
   (or 
     (/= msg "Function cancelled")    ; if user cancelled
     (= msg "quit / exit abort")      ; or program aborted
   );or
   (princ)                            ; then exit quietly
   (princ (strcat "\nError: " msg))   ; else report error message
 );if
 
 (setq *error* acad_err)              ; restore standard error handler
 
 (setvar "osmode" oldsnap)            ; restore object snaps
 (setvar "cmdecho" 1)                 ; restore command echoing
 (princ)
 
);defun


;; Function restores standard handler and previous settings

(defun reset_err ()
 
 (setq *error* acad_err)             ; restore standard error handler
 
 (setvar "osmode" oldsnap)           ; restore previous osnap settings
 (setvar "cmdecho" 1)                ; restore command echoing
 (princ)
 
);defun

;***********************************************************************

(princ "int2.lsp loaded. Type INT2 to run program")
(princ)

