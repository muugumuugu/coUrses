#include "metals.inc"

#declare RR = 5;

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
		4*(x*x*x*x + pow(y*y + z*z,2)) + 17 * x*x * (y*y + z*z) -
              20 * (x*x + y*y + z*z) + 17
	}
   contained_by { 
		sphere { <0,0,0>, 4 }
	}
	threshold 0
	accuracy 0.01
	max_gradient 1000
	open
	texture { T_Silver_5C }
}

