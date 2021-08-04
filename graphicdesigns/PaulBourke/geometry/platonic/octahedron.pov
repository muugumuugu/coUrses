/*
	Octagon
*/

#declare a = 1 / (2 * sqrt(2));
#declare b = 1/2;

union {
triangle { 
 <-a,  0,  a>,   <-a,  0, -a>,   < 0,  b,  0> }
triangle { 
 <-a,  0, -a>,   < a,  0, -a>,   < 0,  b,  0> }
triangle { 
 < a,  0, -a>,   < a,  0,  a>,   < 0,  b,  0> }
triangle { 
 < a,  0,  a>,   <-a,  0,  a>,   < 0,  b,  0> }
triangle { 
 < a,  0, -a>,   <-a,  0, -a>,   < 0, -b,  0> }
triangle { 
 <-a,  0, -a>,   <-a,  0,  a>,   < 0, -b,  0> }
triangle { 
 < a,  0,  a>,   < a,  0, -a>,   < 0, -b,  0> }
triangle { 
 <-a,  0,  a>,   < a,  0,  a>,   < 0, -b,  0> }
}

