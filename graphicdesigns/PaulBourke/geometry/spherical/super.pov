#include "colors.inc"
#include "stones.inc"
#include "textures.inc"
#include "skies.inc"
#include "shapes.inc"
#include "glass.inc"
#include "metals.inc"
#include "woods.inc"
#include "finish.inc"

// Define the location of the camera
camera {
	location <-1,18,1>
	direction <0,-1,0>
	up <0,0,1>
	right <1,0,0>
	orthographic
}

// Lights
light_source { 
	<0,50,20> 
	White 
	shadowless
}
light_source {
   <0,50,-20>
   color rgb <0.3,0.3,0.3>
   shadowless
}

// Create a ground plane
plane {
	<0,1,0>,0
	texture {
		pigment {
			color rgb <0.1,0.8,0.2>
		}
		finish {
			phong 0.1
		}
	}
}

// Define the texture for the objects
#declare thetexture = 
   texture {
      pigment {
         color rgb <0.6,0.6,0.6>
      }
      finish {
         phong 0.5
      }
   }

// Grid separators
cylinder { <-7.5,0.2,-7.5>, <7.5,0.2,-7.5>, 0.1
	texture { T_Copper_1D }
}
cylinder { <-7.5,0.2,-4.5>, <7.5,0.2,-4.5>, 0.1
   texture { T_Copper_1D }
}
cylinder { <-7.5,0.2,-1.5>, <7.5,0.2,-1.5>, 0.1
   texture { T_Copper_1D }
}
cylinder { <-7.5,0.2,1.5>, <7.5,0.2,1.5>, 0.1
   texture { T_Copper_1D }
}
cylinder { <-7.5,0.2,4.5>, <7.5,0.2,4.5>, 0.1
   texture { T_Copper_1D }
}
cylinder { <-7.5,0.2,7.5>, <7.5,0.2,7.5>, 0.1
   texture { T_Copper_1D }
}

cylinder { <-7.5,0.2,-7.5>, <-7.5,0.2,7.5>, 0.1
   texture { T_Copper_1D }
}
cylinder { <-4.5,0.2,-7.5>, <-4.5,0.2,7.5>, 0.1
   texture { T_Copper_1D }
}
cylinder { <-1.5,0.2,-7.5>, <-1.5,0.2,7.5>, 0.1
   texture { T_Copper_1D }
}
cylinder { <1.5,0.2,-7.5>, <1.5,0.2,7.5>, 0.1
   texture { T_Copper_1D }
}
cylinder { <4.5,0.2,-7.5>, <4.5,0.2,7.5>, 0.1
   texture { T_Copper_1D }
}
cylinder { <7.5,0.2,-7.5>, <7.5,0.2,7.5>, 0.1
   texture { T_Copper_1D }
}

sphere {
	<-7.5,0.2,-7.5>, 0.1
	texture { T_Copper_1D }
}
sphere {
   <-7.5,0.2,7.5>, 0.1
   texture { T_Copper_1D }
}
sphere {
   <7.5,0.2,7.5>, 0.1
   texture { T_Copper_1D }
}
sphere {
   <7.5,0.2,-7.5>, 0.1
   texture { T_Copper_1D }
}

// Text labels
text { ttf "timrom.ttf" "0.2" 0.1, 0
	pigment { Red }
	scale <0.6,0.6,0.6> rotate <90,0,0> translate <-7,0.1,7.7>
}
text { ttf "timrom.ttf" "0.8" 0.1, 0
   pigment { Red }
   scale <0.6,0.6,0.6> rotate <90,0,0> translate <-4,0.1,7.7>
}
text { ttf "timrom.ttf" "1.0" 0.1, 0
   pigment { Red }
   scale <0.6,0.6,0.6> rotate <90,0,0> translate <-1,0.1,7.7>
}
text { ttf "timrom.ttf" "2.0" 0.1, 0
   pigment { Red }
   scale <0.6,0.6,0.6> rotate <90,0,0> translate <2,0.1,7.7>
}
text { ttf "timrom.ttf" "3.0" 0.1, 0
   pigment { Red }
   scale <0.6,0.6,0.6> rotate <90,0,0> translate <5,0.1,7.7>
}
text { ttf "timrom.ttf" "e" 0.1, 0
   pigment { Blue }
   scale <1,1,1> rotate <90,0,0> translate <0,0.1,8.6>
}

text { ttf "timrom.ttf" "0.2" 0.1, 0
   pigment { Red }
   scale <0.6,0.6,0.6> rotate <90,0,0> translate <-8.5,0.1,5.8>
}
text { ttf "timrom.ttf" "0.8" 0.1, 0
   pigment { Red }
   scale <0.6,0.6,0.6> rotate <90,0,0> translate <-8.5,0.1,2.8>
}
text { ttf "timrom.ttf" "1.0" 0.1, 0
   pigment { Red }
   scale <0.6,0.6,0.6> rotate <90,0,0> translate <-8.5,0.1,-0.2>
}
text { ttf "timrom.ttf" "2.0" 0.1, 0
   pigment { Red }
   scale <0.6,0.6,0.6> rotate <90,0,0> translate <-8.5,0.1,-3.2>
}
text { ttf "timrom.ttf" "3.0" 0.1, 0
   pigment { Red }
   scale <0.6,0.6,0.6> rotate <90,0,0> translate <-8.5,0.1,-6.2>
}
text { ttf "timrom.ttf" "n" 0.1, 0
   pigment { Blue }
   scale <1,1,1> rotate <90,0,0> translate <-9.5,0.1,0>
}

// Place the superellipsoids
superellipsoid { <0.2,0.2>
	texture { thetexture }
	rotate <0,20,0> rotate <30,0,0> translate <-6,3,6>
}

superellipsoid { <0.8,0.2>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <-3,3,6>
}

superellipsoid { <1,0.2>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <0,3,6>
}

superellipsoid { <2,0.2>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <3,3,6>
}

superellipsoid { <3,0.2>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <6,3,6>
}

// --------------------

superellipsoid { <0.2,0.8>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <-6,3,3>
}

superellipsoid { <0.8,0.8>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <-3,3,3>
}

superellipsoid { <1,0.8>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <0,3,3>
}

superellipsoid { <2,0.8>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <3,3,3>
}

superellipsoid { <3,0.8>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <6,3,3>
}

// ---------------------

superellipsoid { <0.2,1>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <-6,3,0>
}

superellipsoid { <0.8,1>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <-3,3,0>
}

superellipsoid { <1,1>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <0,3,0>
}

superellipsoid { <2,1>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <3,3,0>
}

superellipsoid { <3,1>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <6,3,0>
}

// ---------------------

superellipsoid { <0.2,2>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <-6,3,-3>
}

superellipsoid { <0.8,2>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <-3,3,-3>
}

superellipsoid { <1,2>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <0,3,-3>
}

superellipsoid { <2,2>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <3,3,-3>
}

superellipsoid { <3,2>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <6,3,-3>
}

// ---------------------

superellipsoid { <0.2,3>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <-6,3,-6>
}

superellipsoid { <0.8,3>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <-3,3,-6>
}

superellipsoid { <1,3>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <0,3,-6>
}

superellipsoid { <2,3>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <3,3,-6>
}

superellipsoid { <3,3>
   texture { thetexture }
   rotate <0,20,0> rotate <30,0,0> translate <6,3,-6>
}

