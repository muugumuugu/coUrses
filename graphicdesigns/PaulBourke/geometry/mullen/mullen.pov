#include "metals.inc"

#declare RR = 6;

#switch (clock) 
#case (0)
   #declare VP = <RR,0,0>;
   #break
#case (1)
   #declare VP = <0,RR,0>;
   #break
#case (2)
   #declare VP = <0,0,RR>;
   #break
#case (3)
   #declare VP = <0.7*RR,0.7*RR,0>;
   #break
#case (4)
   #declare VP = <0,0.7*RR,0.7*RR>;
   #break
#case (5)
   #declare VP = <0.7*RR,0,0.7*RR>;
   #break
#case (6)
   #declare VP = <0.7*RR,0.7*RR,0.7*RR>;
   #break
#end

camera {
   location VP
   up y
   right x
   angle 60
   sky <0,0,1>
   look_at <0,0,0>
}

light_source {
  <15,0,0>
  color rgb <1,0.5,0.5>
}
light_source {
  <0,15,0>
  color rgb <0.5,1.0,0.5>
}
light_source {
  <0,0,15>
  color rgb <0.5,0.5,1.0>
}

isosurface {
   function { 
      (1 + x*x) * (1 + y*y) * (1 + z*z) + 8 * x * y * z - 2
   }
   contained_by { 
      sphere { <0,0,0>, 4 }
   }
   threshold 0.00001
   accuracy 0.01
   max_gradient 15000
   open
   //texture { T_Copper_1C }
   //texture { T_Brass_1C }
   texture { T_Silver_5C }
}

