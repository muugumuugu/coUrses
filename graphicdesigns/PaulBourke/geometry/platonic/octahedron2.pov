
#declare THETA = degrees(atan(sqrt(2)));
#declare DIST = 1 / (2 * sqrt(2));

// Upper half
#declare OCT0 = intersection {
   plane { <0,0,1>, 0 rotate <0, THETA,0> translate < DIST,0,0> }
   plane { <0,0,1>, 0 rotate <0,-THETA,0> translate <-DIST,0,0> }
   plane { <0,0,1>, 0 rotate < THETA,0,0> translate <0,-DIST,0> }
   plane { <0,0,1>, 0 rotate <-THETA,0,0> translate <0, DIST,0> }
   plane { <0,0,-1>, 0 }
}

// Add lower half
#declare OCTA = union {
   object { OCT0 }
   object { OCT0 scale <1,1,-1> }
   scale 0.5/DIST
}


