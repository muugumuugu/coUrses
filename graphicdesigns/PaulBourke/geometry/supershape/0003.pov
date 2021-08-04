/* --------------------------
Entry: 0003
Artist: Paul Bourke
Title: Supershape fractal
---------------------------*/

#include "metals.inc"
#include "ss_macro2.inc"
/*
   Variation on the classical glass ball fractal used in the early
   days to demo raytracers. Spheres are replaced by supershapes and
   and a slightly different fractal iterative sequence is used.
   Used my scc3 entry as the backdrop.
*/
#declare VP = <3,2,1>;
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
}
background {
   color rgb <0,0,0>
}
light_source {
   VP + <0,2,4>
   color rgb <1,1,1>
}
/* The supershape */
#declare basemesh = object {
   SuperShape(8,1,2,20,-1,-1,  8,1,2,20,-1,-1,  120)
}
#declare RADIUS = 1.25;
#declare SCALE = 0.5;
#declare level1 = union {
   mesh { basemesh scale SCALE rotate <90,0,0> translate <0,RADIUS,0> }
   mesh { basemesh scale SCALE rotate <90,0,0> rotate <0,0,90> translate <-RADIUS,0,0> }
   mesh { basemesh scale SCALE rotate <90,0,0> rotate <0,0,90> translate <RADIUS,0,0> }
   mesh { basemesh scale SCALE rotate <90,0,0> translate <0,-RADIUS,0> }
}
#declare level2 = union {
   mesh { level1 scale SCALE rotate <90,0,0> translate <0,RADIUS,0> }
   mesh { level1 scale SCALE rotate <90,0,0> rotate <0,0,90> translate <-RADIUS,0,0> }
   mesh { level1 scale SCALE rotate <90,0,0> rotate <0,0,90> translate <RADIUS,0,0> }
   mesh { level1 scale SCALE rotate <90,0,0> translate <0,-RADIUS,0> }
}
#declare level3 = union {
   mesh { level2 scale SCALE rotate <90,0,0> translate <0,RADIUS,0> }
   mesh { level2 scale SCALE rotate <90,0,0> rotate <0,0,90> translate <-RADIUS,0,0> }
   mesh { level2 scale SCALE rotate <90,0,0> rotate <0,0,90> translate <RADIUS,0,0> }
   mesh { level2 scale SCALE rotate <90,0,0> translate <0,-RADIUS,0> }
}
#declare level4 = union {
   mesh { level3 scale SCALE rotate <90,0,0> translate <0,RADIUS,0> }
   mesh { level3 scale SCALE rotate <90,0,0> rotate <0,0,90> translate <-RADIUS,0,0> }
   mesh { level3 scale SCALE rotate <90,0,0> rotate <0,0,90> translate <RADIUS,0,0> }
   mesh { level3 scale SCALE rotate <90,0,0> translate <0,-RADIUS,0> }
}
#declare level5 = union {
   mesh { level4 scale SCALE rotate <90,0,0> translate <0,RADIUS,0> }
   mesh { level4 scale SCALE rotate <90,0,0> rotate <0,0,90> translate <-RADIUS,0,0> }
   mesh { level4 scale SCALE rotate <90,0,0> rotate <0,0,90> translate <RADIUS,0,0> }
   mesh { level4 scale SCALE rotate <90,0,0> translate <0,-RADIUS,0> }
}
#declare level6 = union {
   mesh { level5 scale SCALE rotate <90,0,0> translate <0,RADIUS,0> }
   mesh { level5 scale SCALE rotate <90,0,0> rotate <0,0,90> translate <-RADIUS,0,0> }
   mesh { level5 scale SCALE rotate <90,0,0> rotate <0,0,90> translate <RADIUS,0,0> }
   mesh { level5 scale SCALE rotate <90,0,0> translate <0,-RADIUS,0> }
}
   
#declare level7 = union {
   mesh { level6 scale SCALE rotate <90,0,0> translate <0,RADIUS,0> }
   mesh { level6 scale SCALE rotate <90,0,0> rotate <0,0,90> translate <-RADIUS,0,0> }
   mesh { level6 scale SCALE rotate <90,0,0> rotate <0,0,90> translate <RADIUS,0,0> }
   mesh { level6 scale SCALE rotate <90,0,0> translate <0,-RADIUS,0> }
}
   
union { 
   union { basemesh }
   union { level1 }
   union { level2 }
   union { level3 }
   union { level4 }
   union { level5 }
   union { level6 }
   union { level7 }
   texture {
      pigment { color rgb <0.5,0.5,0.5> }
      finish { F_MetalD }
   }
}  
   
/* Mystical backdrop */
isosurface {
   function { (x*x+3)*(y*y+3)*(z*z+3)-32*x*y*z-32 }
   open
   max_gradient 20
   pigment { rgb <0.05,0.2,0.2> }
   finish { specular 0.2 reflection 0.8 }
   normal { bumps scale .4 } 
   scale 100
}
