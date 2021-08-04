;;;
;;;   int1.lsp
;;;
;;;   Finds intersection of 2 lines on the XY plane of WCS only
;;;   make sure that UCS is over the WCS
;;;   Type the following at the command line, but exclude "command:" :
;;;
;;;   command: PLAN
;;;   command: W
;;;
;;;   command: UCS
;;;   command: W


(defun c:int1
             (
               /                      ; local variables used in defun
               acad_err               ; temporary error handler
               oldsnap                ; saved snap settings
               nearzero               ; a very small number
               currentP               ; list containing 3 reals
               checkP                 ; list containing 3 reals
               retn_val               ; value returned after defun call
               getPt_msg              ; message string
               P1 P2 P3 P4            ; xyz coordinate lists (reals)
               X1 X2 X3               ; x value (real)
               Y1 Y2 Y3               ; y value (real)
               RelX21 RelY21          ; relative x, y, and z values of P2-P1
               RelX43 RelY43          ;                               P4-P3
               RelX13 RelY13          ;                               P1-P3
               denom                  ; denominator & numerator of equation
               u21 u43                ; scale factors line21 or line43 length
              )

(init_err) ; set up temporary error handler and save previous system settings

(setvar "osmode"1)

;;use getpt function to get valid coordinates

(setq nearzero 0.00001                      ; a very small REAL number
      P1 (getpt nil "\nLINE From Point: ")  ; no coincidence check
      P2 (getpt P1  "\nTo Point: ")         ; check with P1
      P3 (getpt nil "\nLINE From Point: ")  ; no coincidence check
      P4 (getpt P3  "\nTo Point: ")         ; check with P3
);setq

(setq oldsnap (getvar "osmode"))      ; check and save osnaps
(setvar "OSMODE" 0)                   ; turn off osnaps

(setq

  X1 (car P1)    X2 (car P2)    X3 (car P3)    X4 (car P4)  ; x values
  Y1 (cadr P1)   Y2 (cadr P2)   Y3 (cadr P3)   Y4 (cadr P4)	; y values

  RelX21 (- X2 X1)   RelX43 (- X4 X3)   RelX13 (- X1 X3)  ; Relative x values
  RelY21 (- Y2 Y1)   RelY43 (- Y4 Y3)   RelY13 (- Y1 Y3)  ;	Relative y values

  denom (- (* RelY43 RelX21) (* RelX43 RelY21))  ; denominator of int equation
  
);setq


(if (< (abs denom) nearzero)   ; if denominator 0 then parallel
  (progn
    (princ "\nLines parallel, no intersection possible")
  );progn
  
  (progn

    (setq
      
      ;; u21 is scale factor of Line21
      ;; if 0 > u21 < 1 intersection point is within line section,
      ;; if u21 < 0 intersection point is beyond P1 end,
      ;; or u21 > 1 intersection point is beyond P2 end
      
      
      u21 (/ (- (* RelX43 RelY13) (* RelY43 RelX13)) denom)
      
      
      ;; u43 is scale factor of Line43
      
      
      u43 (/ (- (* RelX21 RelY13) (* RelY21 RelX13)) denom)
      
      X3 (+ X1 (* u21 RelX21))
      Y3 (+ Y1 (* u21 RelY21))
      
    );setq

    ;Starts line at intersection point
    (command "line" (list X3 Y3))

  );progn
  
);if

  (reset_err)  ; Restore standard handler and previous system settings
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
    (if (null checkP)                    ; Do/Don't compare with previous point
      (setq retn_val currentP)           ; return currentP to calling function
      (progn
      (if (equal checkP currentP nearzero) ; compare with check point
        (progn
        (princ "\nPoints touch, do again")    ; both points set in same place
        (setq currentP nil)                   ; nil currentP to repeat loop
        ); progn
        (setq retn_val currentP)              ; return currentP to calling function
      );if                                   ; currentP nil, repeat loop
      );progn
    );if
  ); while                                  ; currentP boundp, get out of loop

);defun


;;;************************** error trap functions ****************************


;; Function sets up temporary error handler and saves previous system settings

(defun init_err ()
 
 (setq acad_err *error*)  ; save standard error handler
 (setq *error* temp_err)  ; redirect error call to temporary error handler
 
 (setq oldsnap (getvar "osmode"))   ; save osnaps, keep them on
 (setvar "cmdecho" 0)               ; turn off command prompt
 (princ)
 
);defun


;; Function invokes temporary error handler
;; Restores standard handler and previous system settings

(defun temp_err (msg)
 
 (if (> (getvar "cmdactive") 0)       ; if Autocad commands running
   (command)                          ; then cancel them
 );if
 
 (if 
   (or 
     (/= msg "Function cancelled")    ; if user cancelled
     (= msg "quit / exit abort")      ; or program aborted
   );or
   (princ); then exit quietly
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

; message prints on command line when loading file
(princ "\nint1.lsp loaded. Type int1 to run program")
(princ)
