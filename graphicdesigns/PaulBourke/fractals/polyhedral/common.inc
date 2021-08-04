#include "metals.inc"

#default { texture { pigment {color rgb <1,1,1>} finish {phong 0.1 ambient 0.2 diffuse .6} }}

#declare BALLRADIUS = 0.01;
#declare RODRADIUS = 0.007;

// Yellow
#declare THETEXTURE1 = texture {
	pigment { color rgbf <0.9, 0.9, 0.5, 0.5> }
	//finish { brilliance 1.0 specular 1.0 metallic 1.0 }
}
// Blue
#declare THETEXTURE2 = texture {
	pigment { color rgbf <0.5, 0.5, 0.9, 0.5> }
	//finish { brilliance 1.0 specular 1.0 metallic 1.0 }
}

#declare RODTEXTURE = texture {
	pigment { color rgb <0.6,0.6,0.6> }
	finish {
		ambient 0.35
		brilliance 2
		diffuse 0.3
		metallic
		specular 0.80
		roughness 1/20
		reflection 0.1
	}
}

#declare BALLTEXTURE = texture {
	pigment { rgb <0.3,0.7,0.7> }
	finish {
		metallic
		ambient 0.2
		diffuse 0.7
		brilliance 6
		reflection 0.25
		phong 0.75
		phong_size 80
	}
}

#declare FRAMETEXTURE = texture { 
	pigment { P_Brass2 } 
	finish { F_MetalC  } 
}

camera {
   location RANGESCALE*VP
   up y
   right -image_width*x/image_height
   angle 60
   sky <0,0,1>
   look_at <0,0,0>
}

light_source {
  <1,-2,1>
  color rgb 1.5*<1,1,1>
}

light_source {
  <1,-2,1.2>
  color rgb 0.5*<1,1,1>
}

global_settings {
   ambient_light <1,1,1>
   max_trace_level 5
}

background {
   color rgb <1,1,1>
}

