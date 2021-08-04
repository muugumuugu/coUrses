;;; intC2_app.lsp (non-line segment checking version)
;;;
;;; Finds the intersection(s) of a line and circle in 2D/3D if they exist
;;; See intC2.lsp for line segment checking version of this function
;;;
;;; Autolisp program by Andrew Bennett (paperengineer@talk21.com)
;;; Based on discussion by Paul Bourke 
;;;
;;; See discussion "intersection of a line and a sphere (or Circle)" at:
;;; http://local.wasp.uawa.edu.au/~pbourke/geometry/
;;;
;;; Tests whether intersection(s) exist between line (line32) and circle
;;; If intersection(s) found, function starts "Line" command which:
;;; Sets point(s) at each intersection (P5 and P6) 
;;; or at tangent point (P4) if line32 is tangent to circle (P4)
;;; Leaves "line" command 'active' on exit so that rubber-band line is visible
;;;
;;; If no intersection(s) exist, then function exits with an appropriate message
;;;
;;; This function is intended to be used as a call from a main function
;;; It therefore does not check for invalid point entry, nor does it contain
;;; a specialised error handler function
;;;
;;; For a purely 2D function, remove the variables and expressions containing Z

(defun c:intC2_app
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
            
            RelX52 (* Scaler5 RelX32)
            RelY52 (* Scaler5 RelY32)
            RelZ52 (* Scaler5 RelZ32)
            
            RelX62 (* Scaler6 RelX32)
            RelY62 (* Scaler6 RelY32)
            RelZ62 (* Scaler6 RelZ32)
            
            X5 (+ RelX52 X2)
            Y5 (+ RelY52 Y2)
            Z5 (+ RelX52 Z2)
            
            X6 (+ RelX62 X2)
            Y6 (+ RelY62 Y2)
            Z6 (+ RelZ62 Z2)
            
            P5 (list X5 Y5 Z5)
            P6 (list X6 Y6 Z6)
          );setq
          (princ "\nTwo intersections set")
          (command "line" P5 P6)
        );progn
      );if        
    );progn

    (princ "\nNo intersections possible")
    
  );if

  (setvar "cmdecho" 1)
  (setvar "OSMODE" oldsnap)
  (princ)
  
);defun

(princ "intC2_app.lsp loaded")
(princ)