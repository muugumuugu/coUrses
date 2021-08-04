// This defines the vertices and edges of the unit tetrahedron

// Copper vertices
#declare copper = texture {
   pigment { P_Copper5 }
   finish { F_MetalC }
}
#declare sphereradius = 0.03;
union {
   sphere { < 1,  1,  1>, sphereradius }
   sphere { <-1,  1, -1>, sphereradius }
   sphere { < 1, -1, -1>, sphereradius }
   sphere { <-1, -1,  1>, sphereradius }
   texture { copper }
}

// Cylindrical edges
#declare silver = texture {
   pigment { P_Silver3 }
   finish { F_MetalC }
}
#declare cylinderradius = 0.02;
union {
   cylinder { < 1,  1,  1>, <-1,  1, -1>, cylinderradius }
   cylinder { < 1,  1,  1>, < 1, -1, -1>, cylinderradius }
   cylinder { < 1, -1, -1>, <-1,  1, -1>, cylinderradius }
   cylinder { < 1,  1,  1>, <-1, -1,  1>, cylinderradius }
   cylinder { <-1, -1,  1>, < 1, -1, -1>, cylinderradius }
   cylinder { <-1, -1,  1>, <-1,  1, -1>, cylinderradius }
   texture { silver }
}

