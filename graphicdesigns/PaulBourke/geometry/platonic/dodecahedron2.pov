
#declare THETA = degrees(atan(0.5));

#declare DODECA = intersection {
   plane {-z, 1 rotate <-THETA,    0, 0>}
   plane {-z, 1 rotate <-THETA,  -72, 0>}
   plane {-z, 1 rotate <-THETA, -144, 0>}
   plane {-z, 1 rotate <-THETA, -216, 0>}
   plane {-z, 1 rotate <-THETA, -288, 0>}

   plane {-z, 1 rotate <THETA,  -36, 0>}
   plane {-z, 1 rotate <THETA, -108, 0>}
   plane {-z, 1 rotate <THETA, -180, 0>}
   plane {-z, 1 rotate <THETA, -252, 0>}
   plane {-z, 1 rotate <THETA, -324, 0>}

   plane { y, 1}
   plane {-y, 1}

   scale 1/2
}


OR

#local sA=sqrt(.3125)+.25;
#local sB=.5;

#declare DODECA = intersection {
   plane { < sA, sB,0>,.5 }
   plane { <0, sA, sB>,.5 }
   plane { < sB,0, sA>,.5 }
   plane { <-sA, sB,0>,.5 }
   plane { <0,-sA, sB>,.5 }
   plane { < sB,0,-sA>,.5 }
   plane { < sA,-sB,0>,.5 }
   plane { <0, sA,-sB>,.5 }
   plane { <-sB,0, sA>,.5 }
   plane { <-sA,-sB,0>,.5 }
   plane { <0,-sA,-sB>,.5 }
   plane { <-sB,0,-sA>,.5 }
}

