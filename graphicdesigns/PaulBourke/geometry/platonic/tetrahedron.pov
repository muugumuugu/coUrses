/* 
	Tetrahedron 
	Scale by factor of 2 for unit tetrahedron.
*/
union {
triangle {
 < 1,  1,  1>,  <-1,  1, -1>,  < 1, -1, -1> }
triangle {
 <-1,  1, -1>,  <-1, -1,  1>,  < 1, -1, -1> }
triangle {
 < 1,  1,  1>,  < 1, -1, -1>,  <-1, -1,  1> }
triangle {
 < 1,  1,  1>,  <-1, -1,  1>,  <-1,  1, -1> }
}
