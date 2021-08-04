SET MODE "color"
SET WINDOW 0,1922,0,1066
SET BACKGROUND COLOR "white"
LET x=.2
LET y=.3
LET a=0
LET b =0
LET s1=250
LET s2 =s1*1066/1922
RANDOMIZE
PRINT"DIM'S APPOLONIAN GASKET I.F.S."
PRINT"BY R.L.BAGULA 27 May 2004 ©"
LET r=Sqr(3)
FOR n= 1  TO  4000000
   LET a =RND
   REM CIRCLE INVERSION AROUND FIRST POINT
   LET a0=3*(1+r-x)/((1+r-x)^2+y^2)-(1+r)/(2+r)
   LET b0=3*y/((1+r-x)^2+y^2)
   IF  a<= 1/3 AND a>=0  THEN
      LET x1=3*(1+r-x)/((1+r-x)^2+y^2)-(1+r)/(2+r)
      LET y1=3*y/((1+r-x)^2+y^2)
      SET COLOR "red"
   END IF
   REM Z^3-1=0 CENTERS FOR SECOND AND THIRD POINT
   LET a1=(-1/2)
   LET b1=r/2
   LET a2=(-1/2)
   LET b2=-r/2
   LET f1x=a0/(a0^2+b0^2)
   LET f1y=-b0/(a0^2+b0^2)
   IF  a<=2/3 AND a>1/3 THEN
      LET x1=f1x*a1-f1y*b1
      LET y1=f1x*b1+f1y*a1
      SET COLOR "black"
   END IF
   IF  a<= 3/3  AND a>2/3 THEN
      LET x1=f1x*a2-f1y*b2
      LET y1=f1x*b2+f1y*a2
      SET COLOR "blue"
   END IF


   !SET COLOR 255-15*mod(int(5*a),5)
   LET x=x1
   LET y=y1
   IF n>10 THEN PLOT 1922/2+s1*x,1066/2+s2*y
NEXT n
END

