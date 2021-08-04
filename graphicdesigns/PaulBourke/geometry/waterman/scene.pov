#include "metals.inc"
#include "colors.inc"
#include "finish.inc"

#declare vp = 0.7*<3*(RADIUS+0.5),(RADIUS+0.5),(RADIUS+0.5)>;

camera {
   location vp
   up y
   right -x*image_width/image_height
   angle 60
   sky <0,0,1>
   look_at <0,0,0>
}

global_settings {
  assumed_gamma 1.0
}

light_source {
	<3*RADIUS,RADIUS,2*RADIUS>
	color rgb <1,1,1>
}

/* Face texture */
#declare ptexture = texture {
	pigment {
		color rgbf <0.5,0.5,0.5,0.5>
	}
}

/* Vertex texture */
#declare vtexture = texture {
	pigment { color rgb <0.65, 0.35, 0.15> }
   finish { F_MetalC }
}

/* Edge texture */
#declare etexture = texture {
	pigment { color rgb <0.6, 0.41, 0.43> }
   finish { F_MetalC }
}

#declare sfinish = finish {
	specular 0.2
}

