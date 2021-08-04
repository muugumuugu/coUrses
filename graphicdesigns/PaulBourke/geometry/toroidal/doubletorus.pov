#include "metals.inc"

#declare RR = 3;

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
  <2*RR,0,0>
  color rgb <1,0.5,0.5>
}
light_source {
  <0,2*RR,0>
  color rgb <0.5,1.0,0.5>
}
light_source {
  <0,0,2*RR>
  color rgb <0.5,0.5,1.0>
}

isosurface {
   function { 
		z*z - (-pow(x,4) + 2*pow(x,6) - pow(x,8) + 2*x*x*y*y - 2*pow(x,4)*y*y - pow(y,4) + 0.04)
	}
   contained_by { 
		sphere { <0,0,0>, 2 }
	}
	threshold 0
	accuracy 0.01
	max_gradient 100
	texture { T_Silver_5C }
}

