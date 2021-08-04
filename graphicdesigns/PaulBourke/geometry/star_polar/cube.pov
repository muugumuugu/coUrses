#include "metals.inc"
#include "glass.inc"
#include "colors.inc"
#include "finish.inc"

#declare VP = <1,2,0.5>;

#declare RADIUS = 0.012;
#declare RADIUS2 = 0.007;

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

#declare cubeedgetexture = texture {
   pigment { P_Brass5 }
   finish { F_MetalE }
}

#declare cubeframetexture = texture {
	pigment { P_Silver3 }
	finish { F_MetalC }
}

#declare octatexture = texture {
   pigment { P_Silver3 }
   finish { F_MetalC }
}

#declare cubetexture = texture {
   pigment { color rgb <0.4, 0.72, 0.4> }
	finish { F_MetalC }
}

#declare cubetexture2 = texture {
    finish { F_Glass4 }
    pigment { color rgbf <0.72, 0.4, 0.4, 0.8> }
}

#declare cubetexture3 = texture {
   finish { F_Glass4 }
   pigment { color rgbf <0.5, 0.8, 0.5, 0.8> }
}

mesh {
	#include "cube.inc"
}
#include "cubeedges.inc"

#include "cubeframe.inc"
#include "octa.inc"

