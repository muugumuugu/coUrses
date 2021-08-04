/*
	Icosahedron
*/

#declare phi = (1 + sqrt(5)) / 2;
#declare a = 1 / 2;
#declare b = 1 / (2 * phi);

union {
triangle {
 < 0,  b, -a>,   < b,  a,  0>,  < -b,  a,  0> }
triangle { 
 < 0,  b,  a>,   <-b,  a,  0>,  <  b,  a,  0> }
triangle { 
 < 0,  b,  a>,   < 0, -b,  a>,  < -a,  0,  b> }
triangle { 
 < 0,  b,  a>,   < a,  0,  b>,  <  0, -b,  a> }
triangle { 
 < 0,  b, -a>,   < 0, -b, -a>,  <  a,  0, -b> }
triangle { 
 < 0,  b, -a>,   <-a,  0, -b>,  <  0, -b, -a> }
triangle { 
 < 0, -b,  a>,   < b, -a,  0>,  < -b, -a,  0> }
triangle { 
 < 0, -b, -a>,   <-b, -a,  0>,  <  b, -a,  0> }
triangle { 
 <-b,  a,  0>,   <-a,  0,  b>,  < -a,  0, -b> }
triangle { 
 <-b, -a,  0>,   <-a,  0, -b>,  < -a,  0,  b> }
triangle { 
 < b,  a,  0>,   < a,  0, -b>,  <  a,  0,  b> }
triangle { 
 < b, -a,  0>,   < a,  0,  b>,  <  a,  0, -b> }
triangle { 
 < 0,  b,  a>,   <-a,  0,  b>,  < -b,  a,  0> }
triangle { 
 < 0,  b,  a>,   < b,  a,  0>,  <  a,  0,  b> }
triangle { 
 < 0,  b, -a>,   <-b,  a,  0>,  < -a,  0, -b> }
triangle { 
 < 0,  b, -a>,   < a,  0, -b>,  <  b,  a,  0> }
triangle { 
 < 0, -b, -a>,   <-a,  0, -b>,  < -b, -a,  0> }
triangle { 
 < 0, -b, -a>,   < b, -a,  0>,  <  a,  0, -b> }
triangle { 
 < 0, -b,  a>,   <-b, -a,  0>,  < -a,  0,  b> }
triangle { 
 < 0, -b,  a>,   < a,  0,  b>,  <  b, -a,  0> }
}

