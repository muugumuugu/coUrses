
#declare THETA = degrees(atan(2/sqrt(2)));
#declare DIST = sqrt(2)/2;

#declare TET1 = intersection {
   plane { <0,0,1>, 0 rotate <0, THETA,0> translate < 1,0,0> }
   plane { <0,0,1>, 0 rotate <0,-THETA,0> translate <-1,0,0> }
   plane { <0,0,1>, 0 rotate <0, THETA,0> rotate <0,0,90> translate <0, 1,0> scale <1,1,-1> }
   plane { <0,0,1>, 0 rotate <0,-THETA,0> rotate <0,0,90> translate <0,-1,0> scale <1,1,-1> }

   scale DIST/2
}

