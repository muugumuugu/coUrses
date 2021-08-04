#include "metals.inc"
#include "glass.inc"
#include "colors.inc"
#include "finish.inc"

#declare VP = <0,0,1.5>;

#declare RADIUS1 = 0.0025;
#declare RADIUS2 = 0.0025;
#declare RADIUS3 = 0.0025; 

global_settings {
   ambient_light rgb <1,1,1>
   assumed_gamma 1.0
}

background {
   color rgb <0,0,0>
}

light_source {
   <0,0,0>
   color rgb <2,2,2>
}

camera {
   location VP
   up y
   right x
   angle 60
   sky <0,1,0>
   look_at <0,0,0>
}

#declare texture1 = texture {
   pigment { rgb <1,0,0> }
   finish { F_MetalE }
}
#declare texture2 = texture {
   pigment { rgb <0,1,0> }
   finish { F_MetalE }
}
#declare texture3 = texture {
   pigment { rgb <0,0,1> }
   finish { F_MetalE }
}

#include "0_0_1.inc"
#include "0_1_0.inc"
#include "1_0_0.inc"
/*
#declare texture4 = texture {
    finish { F_Glass4 }
    pigment { color rgbf <0.5, 0.5, 0.5, 0.6> }
}
*/
#declare texture4 = texture {
    pigment { color rgbf <0.5, 0.5, 0.5, 0.6> }
}
#include "rhombic.inc"

