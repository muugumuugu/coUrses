#include "metals.inc"

#declare RR = 3;
#declare VP = RR*vnormalize(<cos(clock*2*pi/6),sin(clock*2*pi/6),clock/6>);

camera {
   location VP
   up y
   right x
   angle 60
   sky <0,0,1>
   look_at <0,0,0>
}

light_source {
  <5,0,0>
  color rgb <1,0.5,0.5>
}
light_source {
  <0,5,0>
  color rgb <0.5,1.0,0.5>
}
light_source {
  <0,0,5>
  color rgb <0.5,0.5,1.0>
}

#declare c1 = 0.075 * 0.075;
#declare c2 = 3;

isosurface {
   function { 
		(pow(x*x + y*y - 1,2) + z*z) * (pow(y*y + z*z - 1,2) + x*x) * 
		(pow(z*z + x*x - 1,2) + y*y) - c1 * (1 + c2*(x*x + y*y + z*z))
	}
   contained_by { 
		sphere { <0,0,0>, 2}
	}
	threshold 0
	accuracy 0.01
	max_gradient 1000
	open
	//texture { T13 }
	texture { 
		pigment {P_Silver3 }
		finish { F_MetalB }
	}
}

