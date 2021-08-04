camera {
   location <-1,2,2>
   up y
   right -x
   angle 60
   sky <0,1,0>
   look_at <0,0,0>
}

global_settings {
   ambient_light
   rgb <1,1,1>
}

background {
   color rgb <1,1,1>
}

light_source {
	<-2,4,2>
	color rgb <1,1,1>
}

#declare thetexture = texture {
   pigment {
      color rgb <0.5,0.5,0.5>
   }
	finish {
   	ambient 0.3
   	diffuse 0.6
   	specular 0.5
   	roughness 0.001
		phong 1
	}
}

mesh {
#include "cassini.inc"
}
