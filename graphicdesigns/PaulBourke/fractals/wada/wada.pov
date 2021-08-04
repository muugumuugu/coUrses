#include "colors.inc"

global_settings { 
	max_trace_level 50 
	max_intersections 128
}

// Camera specification
camera {
   location <2,-2,2>
   up       y
   right    x
   angle    20
	look_at   <0,0,0>
}

// Three lights, red, green, blue located opposite four of the three gaps
light_source {
   <-3,-3,-3>
   color <1.0,0.0,0.0>
}
light_source {
   <-3,3,3>
   color <0.0,1.0,0.0>
}
light_source {
   <3,3,-3>
   color <0.0,0.0,1.0>
}

// The three spheres follow, all highly reflective and grey
sphere {
   <-0.5,-0.5,0.5>, 0.70710678118654757
   texture {
		pigment {
			color <1,1,1>
		}
      finish {
			ambient 0
			diffuse 1
			brilliance 1
         specular 1
			reflection 1
			phong 1
			phong_size 200
			metallic
      }
   }
}
sphere {
   <0.5,0.5,0.5>, 0.70710678118654757
   texture {
      pigment {
         color <1,1,1>
      }
      finish {
         ambient 0
         diffuse 1
         brilliance 1
         specular 1
         reflection 1
         phong 1
         phong_size 200
         metallic
      }
   }
}
sphere {
   <-0.5,0.5,-0.5>, 0.70710678118654757
   texture {
      pigment {
         color <1,1,1>
      }
      finish {
         ambient 0
         diffuse 1
         brilliance 1
         specular 1
         reflection 1
         phong 1
         phong_size 200
         metallic
      }
   }
}
sphere {
   <0.5,-0.5,-0.5>, 0.70710678118654757
   texture {
      pigment {
         color <1,1,1>
      }
      finish {
         ambient 0
         diffuse 1
         brilliance 1
         specular 1
         reflection 1
         phong 1
         phong_size 200
         metallic
      }
   }
}

