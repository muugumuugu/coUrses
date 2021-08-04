#include "common.pov"

#declare GreenChrome = texture { 
	pigment { color rgb <0.8, 1.0, 0.8> } 
	finish { F_MetalC  } 
}

isosurface {
   function {
      (pow(x,2)+3) * (pow(y,2)+3) * (pow(z,2)+3) - 32*(x*y*z+1)
   }
   contained_by {
      sphere { <0,0,0>, 2.5}
   }
   threshold 0.25
   accuracy 0.01
   max_gradient 100
   open
   texture { GreenChrome }
   scale 0.8
}

#include "tetrahedron.pov"

