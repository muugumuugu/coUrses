camera {
   perspective
   location <0.7,0.7,-0.25>
   up y
   right -4*x/3
   angle 60
   sky <0,1,0>
   look_at <0.5,0,0.4>
}

global_settings {
   ambient_light
   rgb <1.0,1.0,1.0>
}

background {
   color rgb <0,0,0>
}

light_source {
   <0,1,0>
   color rgb <1,1,1>
}
light_source {
   <1,2,0.5>
   color rgb <0.5,0.5,0.5>
}

height_field {
	tga
	"lace_a.tga" /* Sharp attractor for cliffs */
	pigment { 
      gradient y
      color_map {
         [ 0.00 color rgb <0.4,0.4,0.4> ]
			[ 0.95 color rgb <0.4,0.4,0.4> ]
         [ 1.00 color rgb <0.6,1,0.6> ]
      }
	}
   finish { 
		specular 0.5 
		roughness 0.15 
	}
	scale <1,0.05,1>
}

height_field {
   tga
   "lace_b.tga" /* Smoothed surface for shoreline */
   smooth
   pigment { 
   	gradient y
   	color_map {
      	[0.00 color rgb <1,1,0.4>]
      	[0.05 color rgb <0,0.4,0>]
      	[1.00 color rgb <0,0.1,0>]
		}
	}
   finish {
		specular 0.1 
		roughness 0.2
	}
	normal {
		bozo
		translate <0,1.23456,0>
		scale 0.002
	}
   scale <1,0.07,1>
}

#declare seapigment = pigment {
   bozo
   turbulence 2
   octaves 6
   lambda 3
   omega 0.5
   color_map {
      [0.0 color rgbt <0.3,0.3,0.7,0> ]
      [1.0 color rgbt <0.5,0.5,1.0,0> ]
   }
	scale 0.5
}

global_settings { number_of_waves 10 }
#declare wavenormal = normal {
    ripples 0.2
    frequency 10
    phase 0
    scale 0.1
    rotate <0,0,13>
}

polygon {
	5
	<0,0.0001,0>, <1,0.0001,0>, <1,0.0001,1>, <0,0.0001,1>, <0,0.0001,0>
	pigment { seapigment }
	normal { wavenormal }
}

