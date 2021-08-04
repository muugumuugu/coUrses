#include "common.pov"

parametric {
   function { cos(2*pi*u - pi/2)*cos(2*pi*(-u+v)+pi/2) }
   function { cos(2*pi*v - pi/2)*cos(2*pi*(-u+v)+pi/2) }
   function { cos(2*pi*v - pi/2)*cos(2*pi*u-pi/2) }
   <0,0>, <0.5,1>
   contained_by { sphere { <0,0,0>, 2.5 } }
   accuracy 0.001
   max_gradient 10
   texture { T_Brass_5C }
	scale 0.9
}

#include "tetrahedron.pov"

