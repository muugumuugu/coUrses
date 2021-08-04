// Intersection between two cylinders
#include "metals.inc"

#declare VP = 1.2*<-1,-1,1>;
#declare VU = <0,0,1>;

camera {
   perspective
   location VP
   up y
   right x
   angle 60
   sky VU
   look_at <0,0,0>
}

background {
   color rgb <1,1,1>
}

global_settings {
   ambient_light rgb <0.5,0.5,0.5>
	assumed_gamma 1
}

// Light source at camera
light_source {
   VP+<0,0,2>
   color rgb <1,1,1>
}

#declare thefinish = finish {
	ambient 0.2 diffuse 0.2 specular 0.5
}
#declare reddish = pigment {
	color rgb <1,0,0>
}
#declare blueish = pigment {
   color rgb <0,0,1>
}

// intersection
#if (frame_number = 0)
union {
	cylinder {
		<-0.75,0,0>, <0.75,0,0>, 0.4
  		texture {
			pigment { reddish }
			finish { thefinish }
		}
   }
   cylinder {
      <0,-0.75,0>, <0,0.75,0>, 0.4
      texture {
         pigment { blueish }
      	finish { thefinish }
      }
   }
}
#else 
intersection {
   cylinder {
      <-1,0,0>, <1,0,0>, 0.4
      texture {
         pigment { reddish }
         finish { thefinish }
      }
   }
   cylinder {
      <0,-1,0>, <0,1,0>, 0.4
      texture {
         pigment { blueish }
      	finish { thefinish }
      }
   }
}
#end

