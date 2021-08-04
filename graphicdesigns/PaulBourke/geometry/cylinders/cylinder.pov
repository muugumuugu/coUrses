/*
	Create intersections of various cylinder configurations
*/

/* Cylinder configuration */
#declare CYLINDER = 1; // Tetrahedron vertices
#declare CYLINDER = 2; // Octagon vertices
#declare CYLINDER = 3; // Center of cube faces
#declare CYLINDER = 4; // Two perpendicular lines
#declare CYLINDER = 5; // Opposite midpoints of cube edges
#declare CYLINDER = 6; // Midpoint of dodecahedron faces
#declare CYLINDER = 7; // Icoshedron vertices
#declare CYLINDER = 8; // Docdecahedron vertices

#declare CYLINDER = 5;
#declare INTERSECT = 0; // 0 for intersection, 1 for no intersection
#declare RADIUS = 0.5; // Cylinder radius

#if (INTERSECT = 0)
   #declare RR = 1.25; // Distance of camera
   #declare LL = 1.1;  // Extension of cylinders
#else
   #declare RR = 4;
   #declare LL = 10;
#end

// Three different camera positions
#switch (clock)
#case (0)
   #declare VP = <RR,0,0>;
   #break
#case (1)
   #declare VP = <RR,RR,0> / sqrt(2);
   #break
#case (2)
   #declare VP = <RR,RR,RR> / sqrt(3);
   #break
#end
#declare VU = <0,0,1>;
#declare VD = vnormalize(-VP);
#declare VR = vnormalize(vcross(VD,VU));
camera {
   location VP
   up y
   right x
   angle 60
   sky VU
   look_at VP + VD
}

background { color rgb <1,1,1> }

global_settings {
   ambient_light rgb <0.5,0.5,0.5>
   assumed_gamma 1.0
}

light_source {
   VP + 2*VU + VR
   color rgb <1,1,1>
}

#declare THEFINISH = finish {
   diffuse 0.2
   specular 0.5
}

#if (CYLINDER = 1) // Tetrahedron, same as through the vertices of a cube
#if (INTERSECT = 0) intersection { #else union { #end
	cylinder {
		LL*<-1,-1,-1>, LL*<1,1,1>, RADIUS
		texture { pigment { color rgb <1,0,0> } finish { THEFINISH } }
	}
   cylinder {
      LL*<1,-1,1>, LL*<-1,1,-1>, RADIUS
      texture { pigment { color rgb <1,1,0> } finish { THEFINISH } }
   }
   cylinder {
      LL*<-1,1,1>, LL*<1,-1,-1>, RADIUS
      texture { pigment { color rgb <0,0,1> } finish { THEFINISH } }
   }
   cylinder {
      LL*<1,1,-1>, LL*<-1,-1,1>, RADIUS
      texture { pigment { color rgb <0,1,0> } finish { THEFINISH } }
   }
}
#end

#if (CYLINDER = 2) // Octahedron vertices
#declare AA = 1 / sqrt(2);
#declare BB = 1; 
#if (INTERSECT = 0) intersection { #else union { #end
   cylinder {
      LL*<-AA,0,AA>, LL*<AA,0,-AA>, RADIUS
      texture { pigment { color rgb <1,0,0> } finish { THEFINISH } }
   }
   cylinder {
      LL*<0,BB,0>, LL*<0,-BB,0>, RADIUS
      texture { pigment { color rgb <0,1,0> } finish { THEFINISH } }
   }
   cylinder {
      LL*<AA,0,AA>, LL*<-AA,0,-AA>, RADIUS
      texture { pigment { color rgb <0,0,1> } finish { THEFINISH } }
   }
}
#end

#if (CYLINDER = 3) // Cube faces
#if (INTERSECT = 0) intersection { #else union { #end
   cylinder {
      LL*<-1,0,0>, LL*<1,0,0>, RADIUS
      texture { pigment { color rgb <1,0,0> } finish { THEFINISH } }
   }
   cylinder {
      LL*<0,-1,0>, LL*<0,1,0>, RADIUS
      texture { pigment { color rgb <1,1,0> } finish { THEFINISH } }
   }
   cylinder {
      LL*<0,0,-1>, LL*<0,0,1>, RADIUS
      texture { pigment { color rgb <0,0,1> } finish { THEFINISH } }
   }
}
#end

#if (CYLINDER = 4) // 2 perpendicular lines
#if (INTERSECT = 0) intersection { #else union { #end
   cylinder {
      LL*<-1,0,0>, LL*<1,0,0>, RADIUS
      texture { pigment { color rgb <1,0,0> } finish { THEFINISH } }
   }
   cylinder {
      LL*<0,-1,0>, LL*<0,1,0>, RADIUS
      texture { pigment { color rgb <0,0,1> } finish { THEFINISH } }
   }
}
#end

#if (CYLINDER = 5) // Diagonals of cube
#if (INTERSECT = 0) intersection { #else union { #end
   cylinder {
      LL*<0,-1,-1>, LL*<0,1,1>, RADIUS
      texture { pigment { color rgb <1,0,0> } finish { THEFINISH } }
   }
   cylinder {
      LL*<-1,0,-1>, LL*<1,0,1>, RADIUS
      texture { pigment { color rgb <1,1,0> } finish { THEFINISH } }
   }
   cylinder {
      LL*<1,0,-1>, LL*<-1,0,1>, RADIUS
      texture { pigment { color rgb <0,0,1> } finish { THEFINISH } }
   }
   cylinder {
      LL*<0,-1,1>, LL*<0,1,-1>, RADIUS
      texture { pigment { color rgb <0,1,1> } finish { THEFINISH } }
   }
   cylinder {
      LL*<-1,-1,0>, LL*<1,1,0>, RADIUS
      texture { pigment { color rgb <0,1,0> } finish { THEFINISH } }
   }
   cylinder {
      LL*<-1,1,0>, LL*<1,-1,0>, RADIUS
      texture { pigment { color rgb <1,0,1> } finish { THEFINISH } }
   }
}
#end

#if (CYLINDER = 6) // Dodecahredron face midpoints
#declare PHI = (sqrt(5)-1) / 2;
#declare AA = 4*(1+2*PHI)/10;
#declare BB = 4*(1-PHI);
#if (INTERSECT = 0) intersection { #else union { #end
   cylinder {
      LL*<0,-AA,BB>, LL*<0,AA,-BB>, RADIUS
      texture { pigment { color rgb <1,0,0> } finish { THEFINISH } }
   }
   cylinder {
      LL*<-BB,0,AA>, LL*<BB,0,-AA>, RADIUS
      texture { pigment { color rgb <0,0,1> } finish { THEFINISH } }
   }
   cylinder {
      LL*<-AA,-BB,0>, LL*<AA,BB,0>, RADIUS
      texture { pigment { color rgb <0,1,1> } finish { THEFINISH } }
   }
   cylinder {
      LL*<AA,-BB,0>, LL*<-AA,BB,0>, RADIUS
      texture { pigment { color rgb <0,1,0> } finish { THEFINISH } }
   }
   cylinder {
      LL*<BB,0,AA>, LL*<-BB,0,-AA>, RADIUS
      texture { pigment { color rgb <1,0,1> } finish { THEFINISH } }
   }
   cylinder {
      LL*<0,-AA,-BB>, LL*<0,AA,BB>, RADIUS
      texture { pigment { color rgb <1,1,0> } finish { THEFINISH } }
   }
}
#end

#if (CYLINDER = 7) // Icosahedron vertices
#declare AA = (sqrt(5)-1); // 2 * phi
#if (INTERSECT = 0) intersection { #else union { #end
   cylinder {
      LL*<0,1,AA>, LL*<0,-1,-AA>, RADIUS
      texture { pigment { color rgb <1,0,0> } finish { THEFINISH } }
   }
   cylinder {
      LL*<-1,AA,0>, LL*<1,-AA,0>, RADIUS
      texture { pigment { color rgb <0,0,1> } finish { THEFINISH } }
   }
   cylinder {
      LL*<-1,-AA,0>, LL*<1,AA,0>, RADIUS
      texture { pigment { color rgb <0,1,1> } finish { THEFINISH } }
   }
   cylinder {
      LL*<-AA,0,1>, LL*<AA,0,-1>, RADIUS
      texture { pigment { color rgb <0,1,0> } finish { THEFINISH } }
   }
   cylinder {
      LL*<AA,0,1>, LL*<-AA,0,-1>, RADIUS
      texture { pigment { color rgb <1,0,1> } finish { THEFINISH } }
   }
   cylinder {
      LL*<0,-1,AA>, LL*<0,1,-AA>, RADIUS
      texture { pigment { color rgb <1,1,0> } finish { THEFINISH } }
   }
}
#end

#if (CYLINDER = 8) // Dodecahedron vertices
#declare PHI = (sqrt(5)-1)/2;
#declare AA = 3*PHI/2;
#declare BB = 3*(1 - 0.5/PHI);
#declare CC = 3 * 0.5;
#if (INTERSECT = 0) intersection { #else union { #end
   cylinder {
      LL*<-BB,0,CC>, LL*<BB,0,-CC>, RADIUS
      texture { pigment { color rgb <1,0.5,0.5> } finish { THEFINISH } }
   }
   cylinder {
      LL*<BB,0,CC>, LL*<-BB,0,-CC>, RADIUS
      texture { pigment { color rgb <1,1,0.5> } finish { THEFINISH } }
   }
   cylinder {
      LL*<-AA,AA,AA>, LL*<AA,-AA,-AA>, RADIUS
      texture { pigment { color rgb <1,0.5,1> } finish { THEFINISH } }
   }
   cylinder {
      LL*<AA,AA,AA>, LL*<-AA,-AA,-AA>, RADIUS
      texture { pigment { color rgb <0.5,1,0.5> } finish { THEFINISH } }
   }
   cylinder {
      LL*<0,CC,BB>, LL*<0,-CC,-BB>, RADIUS
      texture { pigment { color rgb <0.5,1,1> } finish { THEFINISH } }
   }
   cylinder {
      LL*<0,CC,-BB>, LL*<0,-CC,BB>, RADIUS
      texture { pigment { color rgb <0.5,0.5,1> } finish { THEFINISH } }
   }
   cylinder {
      LL*<-AA,AA,-AA>, LL*<AA,-AA,AA>, RADIUS
      texture { pigment { color rgb <0.25,1,0> } finish { THEFINISH } }
   }
   cylinder {
      LL*<AA,AA,-AA>, LL*<-AA,-AA,AA>, RADIUS
      texture { pigment { color rgb <0,0.25,1> } finish { THEFINISH } }
   }
   cylinder {
      LL*<-CC,-BB,0>, LL*<CC,BB,0>, RADIUS
      texture { pigment { color rgb <1,0.25,0> } finish { THEFINISH } }
   }
   cylinder {
      LL*<-CC,BB,0>, LL*<CC,-BB,0>, RADIUS
      texture { pigment { color rgb <1,0,0.25> } finish { THEFINISH } }
   }
}
#end


