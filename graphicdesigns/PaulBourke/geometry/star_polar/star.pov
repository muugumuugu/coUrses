#include "metals.inc"
#include "glass.inc"
#include "colors.inc"
#include "finish.inc"

#declare VP = <2,1.5,1>;

#declare RADIUS = 0.015;
#declare RADIUS2 = 0.01;
#declare SCALEFACTOR = 0.4;

camera {
   location VP
   up y
   right x
   angle 60
   sky <0,0,1>
   look_at <0,0,0>
}

global_settings {
   ambient_light rgb <1,1,1>
	assumed_gamma 1.0
}

background {
   color rgb <0,0,0>
}

light_source {
   VP + <0,0,2>
   color rgb <1.5,1.5,1.5>
}
light_source {
   <0,0,0>
   color rgb <0.3,0.3,0.3>
}

#declare dodectexture = texture {
	pigment { P_Brass5 } 
	finish { F_MetalE }
}

#declare icostexture = texture {
   pigment { P_Brass5 }
   finish { F_MetalE }
}

#declare startexture = texture {
   pigment { color rgb <0.4, 0.72, 0.4> }
	finish { F_MetalC }
/*
   finish { F_Glass4 }
   pigment { color rgbf <0.4, 0.72, 0.4, 0.8> }
*/
}

#declare startexture2 = texture {
    finish { F_Glass4 }
    pigment { color rgbf <0.72, 0.4, 0.4, 0.8> }
}

#declare startexture3 = texture {
   pigment { color rgb <0.4, 0.4, 0.72> }
   finish { F_MetalC }
/*
   finish { F_Glass4 }
   pigment { color rgbf <0.4, 0.4, 0.72, 0.8> }
*/
}

mesh {
	#include "star.inc"
}

/*
mesh {
   #include "star2.inc"
}
*/

#include "frame.inc"

/*
#include "dodec.inc"
*/

/*
#include "icos.inc"
*/

union {
mesh {
   #include "star3.inc"
}
union {
   #include "frame.inc"
}
   scale <SCALEFACTOR,SCALEFACTOR,SCALEFACTOR>
   translate <0,0,0>
}

union {
mesh {
   #include "star3.inc"
}
union {
	#include "frame.inc"
}
   scale <SCALEFACTOR,SCALEFACTOR,SCALEFACTOR> 
	translate <-0.52573,-0.850652,0>
}

union {
mesh {
   #include "star3.inc"
}
union {
   #include "frame.inc"
}
   scale <SCALEFACTOR,SCALEFACTOR,SCALEFACTOR> 
   translate <-0.52573,0.850652,0>
}

union {
mesh {
   #include "star3.inc"
}
union {
   #include "frame.inc"
}
   scale <SCALEFACTOR,SCALEFACTOR,SCALEFACTOR> 
   translate <-0.850652,0,-0.52573>
}

union {
mesh {
   #include "star3.inc"
}
union {
   #include "frame.inc"
}
   scale <SCALEFACTOR,SCALEFACTOR,SCALEFACTOR> 
   translate <-0.850652,0,0.52573>
}

union {
mesh {
   #include "star3.inc"
}
union {
   #include "frame.inc"
}
   scale <SCALEFACTOR,SCALEFACTOR,SCALEFACTOR> 
   translate <0,-0.52573,-0.850652>
}

union {
mesh {
   #include "star3.inc"
}
union {
   #include "frame.inc"
}
   scale <SCALEFACTOR,SCALEFACTOR,SCALEFACTOR> 
   translate <0,-0.52573,0.850652>
}

union {
mesh {
   #include "star3.inc"
}
union {
   #include "frame.inc"
}
   scale <SCALEFACTOR,SCALEFACTOR,SCALEFACTOR> 
   translate <0,0.52573,-0.850652>
}

union {
mesh {
   #include "star3.inc"
}
union {
   #include "frame.inc"
}
   scale <SCALEFACTOR,SCALEFACTOR,SCALEFACTOR> 
   translate <0,0.52573,0.850652>
}

union {
mesh {
   #include "star3.inc"
}
union {
   #include "frame.inc"
}
   scale <SCALEFACTOR,SCALEFACTOR,SCALEFACTOR> 
   translate <0.52573,-0.850652,0>
}

union {
mesh {
   #include "star3.inc"
}
union {
   #include "frame.inc"
}
   scale <SCALEFACTOR,SCALEFACTOR,SCALEFACTOR> 
   translate <0.52573,0.850652,0>
}

union {
mesh {
   #include "star3.inc"
}
union {
   #include "frame.inc"
}
   scale <SCALEFACTOR,SCALEFACTOR,SCALEFACTOR> 
   translate <0.850652,0,-0.52573>
}

union {
mesh {
   #include "star3.inc"
}
union {
   #include "frame.inc"
}
   scale <SCALEFACTOR,SCALEFACTOR,SCALEFACTOR>
   translate <0.850652,0,0.52573>
}

