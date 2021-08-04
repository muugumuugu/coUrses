#include "metals.inc"

#declare RR = 7;
#declare VP = <0.7*RR,0.4*RR,0.5*RR>;

camera {
   location VP
   up y
   right x
   angle 60
   sky <0.4,0,1>
   look_at <0,0,0>
}

light_source {
  VP + <5,0,5>
  color rgb <1,1,1>
}

#declare a = 1/2.3;
#declare b = 1/2.0;

isosurface {
   function { 
		1 - pow(a*a*(x*x+y*y+z*z),-6) - 
		pow(pow(b,8)*(pow(x,8)+pow(y,8) + pow(z,8)),6)
	}
   contained_by { 
		box { <-2,-2,-2>, <2,2,2> }
	}
	threshold clock
	accuracy 0.01
	max_gradient 1e18
	open
	texture { 
		pigment {
			color <0.3,0.3,1.0>
		}
  		finish {
    		ambient 0.2
    		diffuse 0.7
    		reflection 0.0
    		brilliance 1.0
    		phong 0.3
    		phong_size 50
    		specular 0.3
   	}
	}
}

