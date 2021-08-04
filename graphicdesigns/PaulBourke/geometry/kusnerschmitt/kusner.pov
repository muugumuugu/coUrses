#include "metals.inc"

camera {
   location <2,2,2>
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

isosurface {
   function { 
      (pow(x,2)+3) * (pow(y,2)+3) * (pow(z,2)+3) - 32*(x*y*z+1)
	}
   contained_by { 
		sphere { <0,0,0>, 2}
	}
	threshold 0.0
	accuracy 0.01
	max_gradient 200
	open
	texture { T_Chrome_5C }
}

