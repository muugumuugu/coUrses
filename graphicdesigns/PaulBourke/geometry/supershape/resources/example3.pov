// By Paul Bourke

#include "ss_macro3.inc"

#declare RR = 5; // camera range

/* Render different views */
#switch (clock) 
#case (0)
   #declare VP = <-RR,0,0>;
   #break
#case (1)
   #declare VP = <0,-RR,0>;
   #break
#case (2)
   #declare VP = <0,0,-RR>;
   #break
#case (3)
   #declare VP = <-0.7*RR,-0.7*RR,0>;
   #break
#case (4)
   #declare VP = <0,-0.7*RR,-0.7*RR>;
   #break
#case (5)
   #declare VP = <-0.7*RR,0,-0.7*RR>;
   #break
#case (6)
   #declare VP = <-0.7*RR,-0.7*RR,-0.7*RR>;
   #break
#end

/* Perspective camera */
camera {
   location VP
   up y
   right x // square image
   angle 60
   sky <0,0,1>
   look_at <0,0,0>
}

/* Coloured lights o each axis */
light_source {
  <-2*RR,0,0>
  color rgb <1,0.5,0.5>
}
light_source {
  <0,-2*RR,0>
  color rgb <0.5,1.0,0.5>
}
light_source {
  <0,0,-2*RR>
  color rgb <0.5,0.5,1.0>
}

mesh {
   SuperShape(1,1,1   77,0.81,71.7,   8,1,1,0.63,2.92,0.24, 200)
   //SuperShape(9,1,1,92,0.3,-45,  4,1,1,-0.8,88,-0.35,  202)
   //SuperShape(4,1,1,1,1,1,  0,1,1,1,1,1,  100)
   scale <1,1,1> // Change this for scaling
   translate <0,0,0> // Change this to move the shape from the origin
   texture {
      pigment { color rgb <0.5,0.5,0.5> }
   }
}

