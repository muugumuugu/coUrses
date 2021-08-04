#declare RANGESCALE = 0.7;
#declare VP = <0.9,-2,1.2>;
#include "common.inc"

// Frame
union {
   sphere { < 1/2, 1/2, 1/2>, BALLRADIUS }
   sphere { <-1/2, 1/2, 1/2>, BALLRADIUS }
   sphere { <-1/2,-1/2, 1/2>, BALLRADIUS }
   sphere { < 1/2,-1/2, 1/2>, BALLRADIUS }
   sphere { < 1/2, 1/2,-1/2>, BALLRADIUS }
   sphere { <-1/2, 1/2,-1/2>, BALLRADIUS }
   sphere { <-1/2,-1/2,-1/2>, BALLRADIUS }
   sphere { < 1/2,-1/2,-1/2>, BALLRADIUS }

	texture { BALLTEXTURE }
}

union {
   cylinder { < 1/2, 1/2, 1/2>, < 1/2,-1/2, 1/2>, RODRADIUS }
   cylinder { < 1/2,-1/2, 1/2>, <-1/2,-1/2, 1/2>, RODRADIUS }
   cylinder { <-1/2,-1/2, 1/2>, <-1/2, 1/2, 1/2>, RODRADIUS }
   cylinder { <-1/2, 1/2, 1/2>, < 1/2, 1/2, 1/2>, RODRADIUS }

   cylinder { < 1/2, 1/2,-1/2>, < 1/2,-1/2,-1/2>, RODRADIUS }
   cylinder { < 1/2,-1/2,-1/2>, <-1/2,-1/2,-1/2>, RODRADIUS }
   cylinder { <-1/2,-1/2,-1/2>, <-1/2, 1/2,-1/2>, RODRADIUS }
   cylinder { <-1/2, 1/2,-1/2>, < 1/2, 1/2,-1/2>, RODRADIUS }

   cylinder { < 1/2, 1/2, 1/2>, < 1/2, 1/2,-1/2>, RODRADIUS }
   cylinder { < 1/2,-1/2, 1/2>, < 1/2,-1/2,-1/2>, RODRADIUS }
   cylinder { <-1/2,-1/2, 1/2>, <-1/2,-1/2,-1/2>, RODRADIUS }
   cylinder { <-1/2, 1/2, 1/2>, <-1/2, 1/2,-1/2>, RODRADIUS }

   texture { RODTEXTURE }
}

#declare BOX1 = box {
	<-0.5,-0.5,-0.5>, <0.5,0.5,0.5>
	scale 1.001
}

#declare BOX2 = union {
	object { BOX1 translate <-1,-1,-1> }
   object { BOX1 translate <-1, 0,-1> }
   object { BOX1 translate <-1, 1,-1> }
   object { BOX1 translate < 0,-1,-1> }
   object { BOX1 translate < 0, 1,-1> }
   object { BOX1 translate < 1,-1,-1> }
   object { BOX1 translate < 1, 0,-1> }
   object { BOX1 translate < 1, 1,-1> }

   object { BOX1 translate <-1,-1, 1> }
   object { BOX1 translate <-1, 0, 1> }
   object { BOX1 translate <-1, 1, 1> }
   object { BOX1 translate < 0,-1, 1> }
   object { BOX1 translate < 0, 1, 1> }
   object { BOX1 translate < 1,-1, 1> }
   object { BOX1 translate < 1, 0, 1> }
   object { BOX1 translate < 1, 1, 1> }

   object { BOX1 translate <-1,-1, 0> }
   object { BOX1 translate <-1, 1, 0> }
   object { BOX1 translate < 1,-1, 0> }
   object { BOX1 translate < 1, 1, 0> }

	scale 1/3
   scale 1.001
}

#declare BOX3 = union {
   object { BOX2 translate <-1,-1,-1> }
   object { BOX2 translate <-1, 0,-1> }
   object { BOX2 translate <-1, 1,-1> }
   object { BOX2 translate < 0,-1,-1> }
   object { BOX2 translate < 0, 1,-1> }
   object { BOX2 translate < 1,-1,-1> }
   object { BOX2 translate < 1, 0,-1> }
   object { BOX2 translate < 1, 1,-1> }

   object { BOX2 translate <-1,-1, 1> }
   object { BOX2 translate <-1, 0, 1> }
   object { BOX2 translate <-1, 1, 1> }
   object { BOX2 translate < 0,-1, 1> }
   object { BOX2 translate < 0, 1, 1> }
   object { BOX2 translate < 1,-1, 1> }
   object { BOX2 translate < 1, 0, 1> }
   object { BOX2 translate < 1, 1, 1> }

   object { BOX2 translate <-1,-1, 0> }
   object { BOX2 translate <-1, 1, 0> }
   object { BOX2 translate < 1,-1, 0> }
   object { BOX2 translate < 1, 1, 0> }

   scale 1/3
   scale 1.001
}

#declare BOX4 = union {
   object { BOX3 translate <-1,-1,-1> }
   object { BOX3 translate <-1, 0,-1> }
   object { BOX3 translate <-1, 1,-1> }
   object { BOX3 translate < 0,-1,-1> }
   object { BOX3 translate < 0, 1,-1> }
   object { BOX3 translate < 1,-1,-1> }
   object { BOX3 translate < 1, 0,-1> }
   object { BOX3 translate < 1, 1,-1> }
   
   object { BOX3 translate <-1,-1, 1> }
   object { BOX3 translate <-1, 0, 1> }
   object { BOX3 translate <-1, 1, 1> }
   object { BOX3 translate < 0,-1, 1> }
   object { BOX3 translate < 0, 1, 1> }
   object { BOX3 translate < 1,-1, 1> }
   object { BOX3 translate < 1, 0, 1> }
   object { BOX3 translate < 1, 1, 1> }
   
   object { BOX3 translate <-1,-1, 0> }
   object { BOX3 translate <-1, 1, 0> }
   object { BOX3 translate < 1,-1, 0> }
   object { BOX3 translate < 1, 1, 0> }

   scale 1/3
   scale 1.001
}

#declare BOX5 = union {
   object { BOX4 translate <-1,-1,-1> }
   object { BOX4 translate <-1, 0,-1> }
   object { BOX4 translate <-1, 1,-1> }
   object { BOX4 translate < 0,-1,-1> }
   object { BOX4 translate < 0, 1,-1> }
   object { BOX4 translate < 1,-1,-1> }
   object { BOX4 translate < 1, 0,-1> }
   object { BOX4 translate < 1, 1,-1> }
   
   object { BOX4 translate <-1,-1, 1> }
   object { BOX4 translate <-1, 0, 1> }
   object { BOX4 translate <-1, 1, 1> }
   object { BOX4 translate < 0,-1, 1> }
   object { BOX4 translate < 0, 1, 1> }
   object { BOX4 translate < 1,-1, 1> }
   object { BOX4 translate < 1, 0, 1> }
   object { BOX4 translate < 1, 1, 1> }
   
   object { BOX4 translate <-1,-1, 0> }
   object { BOX4 translate <-1, 1, 0> }
   object { BOX4 translate < 1,-1, 0> }
   object { BOX4 translate < 1, 1, 0> }
   
   scale 1/3
   scale 1.001
}

#switch (clock)
#case (0)
   object {
      BOX1
      texture { THETEXTURE1 }
   }
	#break
#case (2)
   object {
      BOX2
      texture { THETEXTURE1 }
   }
	#break
#case (4)
   object {
      BOX3
      texture { THETEXTURE1 }
   }
	#break
#case (6)
   object {
      BOX4
      texture { THETEXTURE1 }
   }
	#break
#case (8)
	object {
		BOX5
      texture { THETEXTURE1 }
	}
	#break
#case (1)
	#break
#case (3)
   difference {
      object { BOX1 }
      object { BOX2 }
      texture { THETEXTURE2 }
   }
	#break
#case (5)
	difference {
		object { BOX1 }
		object { BOX3 }
      texture { THETEXTURE2 }
	}
	#break
#case (7)
   difference {
      object { BOX1 }
      object { BOX4 }
      texture { THETEXTURE2 }
   }
   #break
#case (9)
   difference {
      object { BOX1 }
      object { BOX5 }
      texture { THETEXTURE2 }
   }
	#break
#end






