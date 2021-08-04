;;; intC2.lsp (within/outside line segment check version)
;;;
;;; Finds the intersection(s) of a line segment and circle in 2D/3D if they exist
;;; See intC2_app.lsp for non-line segment checking version of this function
;;;
;;; Autolisp program by Andrew Bennett (paperengineer@talk21.com)
;;; Based on discussion by Paul Bourke 
;;;
;;; See discussion "intersection of a line and a sphere (or Circle)" at:
;;; http://local.wasp.uawa.edu.au/~pbourke/geometry/
;;;
;;; Tests whether intersection(s) if they exist are in/out line segment (line32)
;;; If intersection(s) found, function starts "Line" command which:
;;; Sets 1st point(s) at 1 or 2 intersections (P5 and/or P6) 
;;; or at tangent point if line32 is tangent to circle (P4)
;;; Leaves "line" command 'active' on exit so that rubber-band line is visible
;;;
;;; If no valid intersection(s) exist, then it exits with an appropriate message
;;;
;;; This function is intended to be used as a call from a main function
;;; It therefore does not check for invalid point entry, nor does it contain
;;; a specialised error handler function
;;;
;;; For a purely 2D function, remove the variables and expressions containing Z

(defun c:intC2
  ( 
    /
    oldsnap
    nearzero
    P1 P2 P3 P4 P5 P6 R
    X1 X2 X3 X4 X5 X6
    Y1 Y2 Y3 Y4 Y5 Y6
    Z1 Z2 Z3 Z4 Z5 Z6
    RX RY RZ
    RelRX RelRY RelRZ
    RelX21 RelY21 RelZ21
    RelX32 RelY32 RelZ32
    RelX52 RelY52 RelZ52
    RelX52 RelY62 RelZ62
    Radsqr
    a b c 2a mu muSqrt
    check5 check6
    ScalerTan Scaler5 Scaler6 
    )
    
    (setvar "cmdecho" 0)                   ; turn off command echoing
    
    (setq
      nearzero 0.0001
      P1 (getpoint "\nCentre of Circle: ")
      R  (getpoint "\nRadius: ")
      P2 (getpoint "\nLINE From Point: ")
      P3 (getpoint "\nTo point: ")
      oldsnap (getvar "osmode")            ; Save current Osnap settings
    ) ;setq
    
    (setvar "OSMODE" 0)                    ; Clear all Osnap settings
    
    (setq
      ;; Strip x, y and z values from coordinate lists
      X1 (car P1)       X2 (car P2)      X3 (car P3)       RX (car R); x values
      Y1 (cadr P1)      Y2 (cadr P2)     Y3 (cadr P3)      RY (cadr R); y values
      Z1 (caddr P1)     Z2 (caddr P2)    Z3 (caddr P3)     RZ (caddr R); z values
      
      ;; Translate P2 to origin
      ;; Calculate vectors RelP13 and RelP43 relative to it
      RelX21 (- X2 X1)     RelX32 (- X3 X2); Relx values
      RelY21 (- Y2 Y1)     RelY32 (- Y3 Y2); Rely values
      RelZ21 (- Z2 Z1)     RelZ32 (- Z3 Z2); Relz values
      
      ;; Calculate the relative coordinates of the radius of circle
      RelRX (- X1 RX)    RelRY (- Y1 RY)    RelRZ (- Z1 RZ); xyz values
      
      ;; Calculate radius of circle, don't calculate sqrt
      Radsqr (+ (* RelRX RelRX) (* RelRY RelRY) (* RelRZ RelRZ))
      
      ;; a = Dist32sqr length of vector Rel32, don't calculate sqrt
      a (+ (* RelX32 RelX32) (* RelY32 RelY32) (* RelZ32 RelZ32))
      
      ;; - b = Dot123 = dot product RelP1_RelP2_RelP3
      b (* 2 (+ (* RelX32 RelX21) (* RelY32 RelY21) (* RelZ32 RelZ21)))
      c (- (- (+ (* X1 X1) (* Y1 Y1) (* Z1 Z1) (* X2 X2) (* Y2 Y2) (* Z2 Z2))
        (* 2 (+ (* X1 X2) (* Y1 Y2) (* Z1 Z2)))) Radsqr)
    
      ; This a alternative equation for c also works, thus saving 7 +- and 6 */
      ; c (- (+ (* RelX21 RelX21) (* RelY21 RelY21) (* RelZ21 RelZ21)) Radsqr)
      
      ; This is why:
      ; If we translate P2 to (0, 0, 0), then any coordinate that is multiplied by P2 will have a value of 0
      ; We can therefore get rid of anything that is multiplied by X2, Y2 or Z2 in the 1st c equation above.
      ; When making the translation to P2, P1 (X1, Y1, Z1) becomes (- RelX21, - RelY1, - RelZ1), so c becomes:
      ; c (- (+ (* (- RelX21) (- RelX21)) (+ (* (- RelY21) (- RelY21)) (+ (* (- RelZ21) (- RelZ21)) Radsqr)
      ; As the minus signs become plus signs when they are squared, so + RelX21^2 = - RelX21^2
      ; so, it's a trick, but we don't need to add minuses to the alternative equation to get the correct c
      ;
      ; To try this out, put a ";" in front of the 1st c equation,
      ; and remove the ";" in front the alternative c equation

      2a (* 2 a)
      mu (- (* b b) (* 4 a c))
      
  );setq

  ;;filter all possible intersections of line and circle
  (if (> mu (- nearzero)); if mu > - nearzero
    
    (progn
      (if (equal mu 0 nearzero); 0 Tangent intersection
        
        (progn; Tangent
          (setq
            ScalerTan (/ (- b) 2a)
            X4 (+ (* ScalerTan RelX32) X2)
            Y4 (+ (* ScalerTan RelY32) Y2)
            Z4 (+ (* ScalerTan RelZ32) Z2)
            P4 (list X4 Y4 Z4)
          );setq
          (princ "\nOne intersection set at Tangent")
          (command "line" P4)
        );progn
        
        (progn; if nearzero > 0 then 2 ints possible if inside line segment
          (setq
            muSqrt (sqrt mu)
            Scaler5 (/ (- (- b) muSqrt) 2a); nearest int point to P2
            Scaler6 (/ (+ (- b) muSqrt) 2a); nearest int point to P3
          );setq
          
          ;; Inside segment test for scaler6 and 6
          (if (equal Scaler5 0.5 (+ nearzero 0.5)); if scaler5 between 0 and 1
            (setq
              check5 1
              RelX52 (* Scaler5 RelX32)
              RelY52 (* Scaler5 RelY32)
              RelZ52 (* Scaler5 RelZ32)
              
              X5 (+ RelX52 X2)
              Y5 (+ RelY52 Y2)
              Z5 (+ RelX52 Z2)
              
              P5 (list X5 Y5 Z5)
            );setq
          );if
          
          (if (equal Scaler6 0.5 (+ nearzero 0.5)); if scaler6 between 0 and 1
            (setq
              check6 1
              RelX62 (* Scaler6 RelX32)
              RelY62 (* Scaler6 RelY32)
              RelZ62 (* Scaler6 RelZ32)
              
              X6 (+ RelX62 X2)
              Y6 (+ RelY62 Y2)
              Z6 (+ RelZ62 Z2)
              
              P6 (list X6 Y6 Z6)
            );setq
          );if
          
          (if (= check5 1)
            
            (progn
              (if (= check6 1)
                (progn
                  (princ "\nTwo intersections set at P5 and P6")
                  (command "line" P5 P6)
                );progn
                (progn
                  (princ "\nOne intersection set at P5")
                  (command "line" P5)
                );progn
              );if
            );progn
            
            (progn
              (if (= check6 1)
                (progn
                  (princ "\nOne intersection set at P6")
                  (command "line" P6)
                );progn
                (progn
                  (princ "\nIntersections are outside the line segment")
                  (princ "\nNo points set")
                );progn
              );if
            );progn
          );if
          
        );progn
      );if
      
    );progn
    (princ "\nNo intersections, no points set")
  );if
  
  ;(princ "\nmu: ") (princ mu)
  (setvar "cmdecho" 1)
  (setvar "OSMODE" oldsnap)
  (princ)
  
);defun

(princ "intC2.lsp loaded")
(princ)