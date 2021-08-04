SET MODE "color"
SET WINDOW 0, 1026,0,750
SET COLOR MIX(1) 0,0,0
PRINT" trianglar lines function projection:fractional differential"
Print" gives a torus-like surface"
PRINT" by R. L. Bagula 10 Sept 2000©"
LET s1=250*2/3
LET s=2/3
FOR t= 0 to 1/2 step 1/200
    LET count=count+1
    LET s=1
    FOR p= 0 to 1 step 1/600
        REM recursive fractional angular differentiation variable:
        REM nonlinear dependant variable as fuzzy logic entropic "or"
        LET s=s+p-s*p
        LET x=cos(2*Pi*t-s*Pi/2)*cos(2*Pi*(-t+p)+s*Pi/2)
        LET y=cos(2*Pi*p-s*Pi/2)*cos(2*Pi*(-t+p)+s*Pi/2)
        LET Z=cos(2*Pi*p-s*Pi/2)*cos(2*Pi*t-s*Pi/2)
        SET COLOR 256-mod(count,256)
        PLOT 1026/4+s1*x/(1+Z/4),750/4+s1*(750/1026)*y/(1+Z/4)+100
        PLOT 1026/1.5+s1*z/(1+y/4),750/1.5+s1*(750/1026)*x/(1+y/4)
        SET COLOR 1
    NEXT p
    PLOT
NEXT t
END

