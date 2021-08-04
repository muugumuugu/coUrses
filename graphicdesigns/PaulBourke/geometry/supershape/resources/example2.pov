// by Mike Williams

#include "ss_macro2.inc"

// Choose one of the three examples 
#declare Example=1;

// Suitable camera positions for each example shape
#switch (Example)
#case (1)
  camera { location  <2,1,-2> look_at <0, 0, 0>}
  #break
#case (2)  
  camera { location  <2,1,-10> look_at <0, 0, 0>}
  #break
#case (3)  
  camera { location  <-0.5,0.5,-2> look_at <0, 0, 0>}
  #break
#end

light_source {<100,200,-100> colour rgb 1}
light_source {<-100,-200,-100> colour rgb 0.5}

// ----------------------------------------

object {
  #switch (Example)
  #case (1)
    SuperShape(1,1,1   77,0.81,71.7,   8,1,1,0.63,2.92,0.24, 100)
    #break
  #case (2)  
    SuperShape(9,1,1,92,0.3,-45,  4,1,1,-0.8,88,-0.35,  39)
    #break
  #case(3)
    SuperShape(4,1,1,1,1,1,  0,1,1,1,1,1,  50)
    #break
  #end

  pigment {rgb 0.9}
  finish {phong 0.5 phong_size 10}
}

