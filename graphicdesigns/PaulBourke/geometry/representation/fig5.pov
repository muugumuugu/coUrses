#include "common.pov"

#declare blueplastic = texture {
   finish { 
   	diffuse 0.3
   	specular 0.75
	}
   pigment { 
		color rgb <0.8,0.8,1.0>
	}
}

#declare iteration0 = union {
	triangle { < 1,  1,  1>,  <-1,  1, -1>,  < 1, -1, -1> }
	triangle { <-1,  1, -1>,  <-1, -1,  1>,  < 1, -1, -1> }
	triangle { < 1,  1,  1>,  < 1, -1, -1>,  <-1, -1,  1> }
	triangle { < 1,  1,  1>,  <-1, -1,  1>,  <-1,  1, -1> }
	translate <1,1,1>
}

#declare finaliteration = iteration0;
#declare niterations = 6;
#while (niterations > 0)
	#declare finaliteration = union {
   	object { finaliteration }
   	object { finaliteration translate <-2, 0, 2> }
   	object { finaliteration translate <-2, 2, 0> }
   	object { finaliteration translate < 0, 2, 2> }
   	translate <2,0,0>
   	scale 0.5
	}
	#declare niterations = niterations - 1;
#end

union {
	object { finaliteration }
	translate <-1,-1,-1>
	texture { blueplastic }
	scale 0.95
}

#include "tetrahedron.pov"

