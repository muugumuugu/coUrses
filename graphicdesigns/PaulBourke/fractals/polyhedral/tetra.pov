#declare RANGESCALE = 0.75;
#declare VP = <0.75,-2,0.2>;
#include "common.inc"

#declare THETA = degrees(atan(sqrt(2)));
#declare DIST = sqrt(2)/2;

#declare BALLRADIUS = 0.8 * BALLRADIUS * 2 / DIST;
#declare RODRADIUS = 0.8 * RODRADIUS * 2 / DIST;

// Frame
union {
   sphere { < 2,0,-sqrt(2)>, BALLRADIUS }
   sphere { <-2,0,-sqrt(2)>, BALLRADIUS }
   sphere { < 0, 2,sqrt(2)>, BALLRADIUS }
   sphere { < 0,-2,sqrt(2)>, BALLRADIUS }

   texture { BALLTEXTURE }
	scale DIST/2
}

union {	
	cylinder { < 0,-2,sqrt(2)>, < 0, 2,sqrt(2)>, RODRADIUS }
	cylinder { < 0,-2,sqrt(2)>, < 2,0,-sqrt(2)>, RODRADIUS }
	cylinder { < 0,-2,sqrt(2)>, <-2,0,-sqrt(2)>, RODRADIUS }
	cylinder { < 0, 2,sqrt(2)>, <-2,0,-sqrt(2)>, RODRADIUS }
	cylinder { < 0, 2,sqrt(2)>, < 2,0,-sqrt(2)>, RODRADIUS }
	cylinder { <-2,0,-sqrt(2)>, < 2,0,-sqrt(2)>, RODRADIUS }

   texture { RODTEXTURE }
	scale DIST/2
}

#declare TET1 = intersection {
	plane { <0,0,1>, 0 rotate <0, THETA,0> translate < 1,0,0> }
   plane { <0,0,1>, 0 rotate <0,-THETA,0> translate <-1,0,0> }
   plane { <0,0,1>, 0 rotate <0, THETA,0> rotate <0,0,90> translate <0, 1,0> scale <1,1,-1> }
   plane { <0,0,1>, 0 rotate <0,-THETA,0> rotate <0,0,90> translate <0,-1,0> scale <1,1,-1> }
	scale DIST/2
	scale 1.001
}

#declare TET2 = union {
	object { TET1 translate <-DIST,0,-0.5> }
   object { TET1 translate < DIST,0,-0.5> }
   object { TET1 translate <0,-DIST, 0.5> }
   object { TET1 translate <0, DIST, 0.5> }
   scale 1/2
	scale 1.001
}

#declare TET3 = union {
   object { TET2 translate <-DIST,0,-0.5> }
   object { TET2 translate < DIST,0,-0.5> }
   object { TET2 translate <0,-DIST, 0.5> }
   object { TET2 translate <0, DIST, 0.5> }
   scale 1/2
   scale 1.001
}

#declare TET4 = union {
   object { TET3 translate <-DIST,0,-0.5> }
   object { TET3 translate < DIST,0,-0.5> }
   object { TET3 translate <0,-DIST, 0.5> }
   object { TET3 translate <0, DIST, 0.5> }
   scale 1/2
   scale 1.001
}

#declare TET5 = union {
   object { TET4 translate <-DIST,0,-0.5> }
   object { TET4 translate < DIST,0,-0.5> }
   object { TET4 translate <0,-DIST, 0.5> }
   object { TET4 translate <0, DIST, 0.5> }
   scale 1/2
   scale 1.001
}

#switch (clock)
#case (0)
   object {
      TET1
      texture { THETEXTURE1 }
   }
	#break
#case (2)
   object {
      TET2
      texture { THETEXTURE1 }
   }
   #break
#case (4)
	object {
		TET3
      texture { THETEXTURE1 }
	}
   #break
#case (6)
   object {
      TET4
      texture { THETEXTURE1 }
   }
   #break
#case (8)
   object {
      TET5
      texture { THETEXTURE1 }
   }
#case (1)
	#break
#case (3)
	difference {
		object { TET1 }
		object { TET2 }
      texture { THETEXTURE2 }
	}
   #break
#case (5)
   difference {
      object { TET1 }
      object { TET3 }
      texture { THETEXTURE2 }
   }
   #break
#case (7)
   difference {
      object { TET1 }
      object { TET4 }
		texture { THETEXTURE2 }
   }
   #break
#case (9)
   difference {
      object { TET1 }
      object { TET5 }
      texture { THETEXTURE2 }
   }
	#break
#end






