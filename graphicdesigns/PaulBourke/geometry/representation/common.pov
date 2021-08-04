// This contains things common to all the scenes

#include "metals.inc"
#include "glass.inc"

#declare VP = <1,2.2,1.3>;
camera {
   location VP
   up y
   right x
   angle 60
   sky <0,0,1>
   look_at <0,0,0>
}

background {
   color rgb <0,0,0>
}

light_source {
   VP + <0,0,2>
   color rgb <1,1,1>
}
light_source {
   VP
   color rgb <0.5,0.5,0.5>
   shadowless
}

