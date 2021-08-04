/*
	Dodecahedron
	Divide by factor of 2 for unit dodecahedron.
*/

#declare phi = (1 + sqrt(5)) / 2;
#declare b = 1 / phi;
#declare c = 1 / (phi * phi);

union {
polygon {5,
 < c,  0,  1>,  <-c,  0,  1>,  <-b,  b,  b>,  < 0,  1,  c>,  < b,  b,  b> }
polygon {5,
 <-c,  0,  1>,  < c,  0,  1>,  < b, -b,  b>,  < 0, -1,  c>,  <-b, -b,  b> }
polygon {5,
 < c,  0, -1>,  <-c,  0, -1>,  <-b, -b, -b>,  < 0, -1, -c>,  < b, -b, -b> }
polygon {5,
 <-c,  0, -1>,  < c,  0, -1>,  < b,  b, -b>,  < 0,  1, -c>,  <-b,  b, -b> }
polygon {5,
 < 0,  1, -c>,  < 0,  1,  c>,  < b,  b,  b>,  < 1,  c,  0>,  < b,  b, -b> }
polygon {5,
 < 0,  1,  c>,  < 0,  1, -c>,  <-b,  b, -b>,  <-1,  c,  0>,  <-b,  b,  b> } 
polygon {5,
 < 0, -1, -c>,  < 0, -1,  c>,  <-b, -b,  b>,  <-1, -c,  0>,  <-b, -b, -b> }
polygon {5,
 < 0, -1,  c>,  < 0, -1, -c>,  < b, -b, -b>,  < 1, -c,  0>,  < b, -b,  b> }
polygon {5,
 < 1,  c,  0>,  < 1, -c,  0>,  < b, -b,  b>,  < c,  0,  1>,  < b,  b,  b> }
polygon {5,
 < 1, -c,  0>,  < 1,  c,  0>,  < b,  b, -b>,  < c,  0, -1>,  < b, -b, -b> }
polygon {5,
 <-1,  c,  0>,  <-1, -c,  0>,  <-b, -b, -b>,  <-c,  0, -1>,  <-b,  b, -b> }
polygon {5,
 <-1, -c,  0>,  <-1,  c,  0>,  <-b,  b,  b>,  <-c,  0,  1>,  <-b, -b,  b> }
}

