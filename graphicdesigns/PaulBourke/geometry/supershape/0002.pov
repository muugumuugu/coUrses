/* --------------------------
Entry: 0002
Artist: Dalius Dobravolskas
Title: Lost in the sea
---------------------------*/

#include "colors.inc"
#include "skies.inc"
#include "functions.inc"
sky_sphere { S_Cloud2 }
  
camera {
    location <3, 3, -3>
    look_at <0, 0, 0>
    up    <0,1,0>
    right  <1,0,0>
}
light_source {
    <50, 50, -50> color White
}
 
plane {
    y, 0
    pigment { Blue }  
    finish { reflection .35 specular 1 }
    normal { ripples .5 turbulence .5 scale .25 }
}
#declare n1_1 = -1/0.5;
#declare n2_1 = 2.5;
#declare n3_1 = 2.5;
#declare m_1 = 12;
#declare n1_2 = -1/0.5;
#declare n2_2 = 2.5;
#declare n3_2 = 2.5;
#declare m_2 = 36;
#declare r0=function { pow(pow(abs(cos(m_1*u/4)),n2_1) + pow(abs(sin(m_1*u/4)),n3_1),n1_1) }
#declare r1=function { pow(pow(abs(cos(m_2*v/4)),n2_2) + pow(abs(sin(m_2*v/4)),n3_2),n1_2) }
parametric {
    function { r0(u,0,0)*cos(u)*r1(0,v,0)*cos(v) }
    function { r0(u,0,0)*sin(u)*r1(0,v,0)*cos(v) }
    function { r1(0,v,0)*sin(v) }
    <-pi/2,-pi>, <pi/2,pi>
    contained_by { box{-2, 2} }
    max_gradient 1.2
    accuracy 0.0025
    precompute 20, x,y,z
    pigment { Red filter 0.5 }
    rotate <90, 0, 0>
}
