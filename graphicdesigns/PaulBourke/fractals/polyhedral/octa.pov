#declare RANGESCALE = 0.7;
#declare VP = <0.8,-2,0.5>;
#include "common.inc"

#declare THETA = degrees(atan(sqrt(2)));
#declare DIST = 1 / (2 * sqrt(2));
#declare HEIGHT = sqrt(2) / 2;

#declare BALLRADIUS = 0.9 * BALLRADIUS * DIST / 0.5;
#declare RODRADIUS = 0.9 * RODRADIUS * DIST / 0.5;

// Frame
union {
	sphere { <0,0,1/2>, BALLRADIUS }
	sphere { <0,0,1/2>, BALLRADIUS }
   sphere { < DIST, DIST,0>, BALLRADIUS }
   sphere { <-DIST, DIST,0>, BALLRADIUS }
   sphere { <-DIST,-DIST,0>, BALLRADIUS }
   sphere { < DIST,-DIST,0>, BALLRADIUS }

   texture { BALLTEXTURE }
   scale 0.5/DIST
}

union {
	cylinder { <0,0,1/2>, < DIST, DIST,0>, RODRADIUS }
   cylinder { <0,0,1/2>, <-DIST, DIST,0>, RODRADIUS }
   cylinder { <0,0,1/2>, <-DIST,-DIST,0>, RODRADIUS }
   cylinder { <0,0,1/2>, < DIST,-DIST,0>, RODRADIUS }

   cylinder { <0,0,-1/2>, < DIST, DIST,0>, RODRADIUS }
   cylinder { <0,0,-1/2>, <-DIST, DIST,0>, RODRADIUS }
   cylinder { <0,0,-1/2>, <-DIST,-DIST,0>, RODRADIUS }
   cylinder { <0,0,-1/2>, < DIST,-DIST,0>, RODRADIUS }

   cylinder { < DIST, DIST,0>, <-DIST, DIST,0>, RODRADIUS }
   cylinder { <-DIST, DIST,0>, <-DIST,-DIST,0>, RODRADIUS }
   cylinder { <-DIST,-DIST,0>, < DIST,-DIST,0>, RODRADIUS }
   cylinder { < DIST,-DIST,0>, < DIST, DIST,0>, RODRADIUS }

	texture { RODTEXTURE }
	scale 0.5/DIST
}

// Upper half
#declare OCT0 = intersection {
	plane { <0,0,1>, 0 rotate <0, THETA,0> translate < DIST,0,0> }
   plane { <0,0,1>, 0 rotate <0,-THETA,0> translate <-DIST,0,0> }
   plane { <0,0,1>, 0 rotate < THETA,0,0> translate <0,-DIST,0> }
   plane { <0,0,1>, 0 rotate <-THETA,0,0> translate <0, DIST,0> }
	plane { <0,0,-1>, 0 }
}
// Add lower half
#declare OCT1 = union {
	object { OCT0 }
	object { OCT0 scale <1,1,-1> translate <0,0,0.001> }
	scale 0.5/DIST
	scale 1.001
}

#declare OCT2 = union {
	object { OCT1 translate <-0.5,-0.5,0> }
   object { OCT1 translate <-0.5, 0.5,0> }
   object { OCT1 translate < 0.5, 0.5,0> }
   object { OCT1 translate < 0.5,-0.5,0> }

   object { OCT1 translate <0,0, HEIGHT> }
   object { OCT1 translate <0,0,-HEIGHT> }

	scale 1/2
	scale 1.001
}

#declare OCT3 = union {
   object { OCT2 translate <-0.5,-0.5,0> }
   object { OCT2 translate <-0.5, 0.5,0> }
   object { OCT2 translate < 0.5, 0.5,0> }
   object { OCT2 translate < 0.5,-0.5,0> }

   object { OCT2 translate <0,0, HEIGHT> }
   object { OCT2 translate <0,0,-HEIGHT> }

   scale 1/2
	scale 1.001
}

#declare OCT4 = union {
   object { OCT3 translate <-0.5,-0.5,0> }
   object { OCT3 translate <-0.5, 0.5,0> }
   object { OCT3 translate < 0.5, 0.5,0> }
   object { OCT3 translate < 0.5,-0.5,0> }

   object { OCT3 translate <0,0, HEIGHT> }
   object { OCT3 translate <0,0,-HEIGHT> }

   scale 1/2
	scale 1.001
}

#declare OCT5 = union {
   object { OCT4 translate <-0.5,-0.5,0> }
   object { OCT4 translate <-0.5, 0.5,0> }
   object { OCT4 translate < 0.5, 0.5,0> }
   object { OCT4 translate < 0.5,-0.5,0> }
      
   object { OCT4 translate <0,0, HEIGHT> }
   object { OCT4 translate <0,0,-HEIGHT> }
      
   scale 1/2
	scale 1.001
} 

#switch (clock)
#case (0)
   object {
      OCT1
      texture { THETEXTURE1 }
   }
   #break
#case (2)
   object {
      OCT2
      texture { THETEXTURE1 }
   }
   #break
#case (4)
   object {
      OCT3
      texture { THETEXTURE1 }
   }
   #break
#case (6)
   object {
      OCT4
      texture { THETEXTURE1 }
   }
   #break
#case (8)
	object {
		OCT5
      texture { THETEXTURE1 }
	}
	#break
#case (1)
	#break
#case (3)
   difference {
      object { OCT1 }
      object { OCT2 }
      texture { THETEXTURE2 }
   }
   #break
#case (5)
	difference {
		object { OCT1 }
		object { OCT3 }
      texture { THETEXTURE2 }
	}
   #break
#case (7)
   difference {
      object { OCT1 }
      object { OCT4 }
      texture { THETEXTURE2 }
   }
   #break
#case (9)
   difference {
      object { OCT1 }
      object { OCT5 }
      texture { THETEXTURE2 }
   }
	#break
#end






