#include "common.pov"

#declare blueglass = texture {
   finish { F_Glass4 }
   pigment { color rgbf <0.4, 0.4, 0.7, 0.5> }
}

union {
	triangle { < 1,  1,  1>,  <-1,  1, -1>,  < 1, -1, -1> }
	triangle { <-1,  1, -1>,  <-1, -1,  1>,  < 1, -1, -1> }
	triangle { < 1,  1,  1>,  < 1, -1, -1>,  <-1, -1,  1> }
	triangle { < 1,  1,  1>,  <-1, -1,  1>,  <-1,  1, -1> }
	texture { blueglass }
}

#include "tetrahedron.pov"

