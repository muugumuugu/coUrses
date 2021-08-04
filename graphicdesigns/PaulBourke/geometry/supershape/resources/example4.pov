// 2D example
// By Hans de Vries

#include "metals.inc"
#include "glass.inc"
#include "colors.inc"
#include "finish.inc"

camera {
   location <2,0,2>
   up y
   right x
   angle 60
   sky <0,0,1>
   look_at <0,0,0>
}

global_settings {
   ambient_light rgb <1,1,1>
   assumed_gamma 1.0
}

background {
   color rgb <0,0,0>
}

light_source {
   <5,5,10>
   color rgb <1,1,1>
}

#declare m  =  7;
#declare n1 =  5;
#declare n2 =  5;
#declare n3 =  5;
#declare a  =  1;
#declare b  =  1;

isosurface {
   function { pow(
     pow(abs(cos(0.25*m*acos(y/sqrt(x*x+y*y))*abs(y)/y)/a),n2)  +
     pow(abs(sin(0.25*m*acos(y/sqrt(x*x+y*y))*abs(y)/y)/b),n3)
     ,1/n1) * sqrt(x*x+y*y) - 1 
        }
   contained_by { box { <-2,-2,-2>, <2,2,2> } }
   scale <1,1,0.001>
   pigment { Yellow }
}


box {<0.01,0.01,1>,<-0.01,-0.01,-1> rotate<0, 0,0> pigment {Red}  } 
box {<0.01,0.01,1>,<-0.01,-0.01,-1> rotate<0,90,0> pigment {Green}}
box {<0.01,0.01,1>,<-0.01,-0.01,-1> rotate<90,0,0> pigment {Blue} }

