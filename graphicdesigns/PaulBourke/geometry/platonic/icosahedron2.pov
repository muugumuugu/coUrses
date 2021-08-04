#local sA=sqrt(.3125)+.25;
#local sB=.5;

#declare ICOSA = intersection {
   plane { < sA+sB, sB,0>,.5 }
   plane { <0, sA+sB, sB>,.5 }
   plane { < sB,0, sA+sB>,.5 }
   plane { <-sA-sB, sB,0>,.5 }
   plane { <0,-sA-sB, sB>,.5 }
   plane { < sB,0,-sA-sB>,.5 }
   plane { < sA+sB,-sB,0>,.5 }
   plane { <0, sA+sB,-sB>,.5 }
   plane { <-sB,0, sA+sB>,.5 }
   plane { <-sA-sB,-sB,0>,.5 }
   plane { <0,-sA-sB,-sB>,.5 }
   plane { <-sB,0,-sA-sB>,.5 }

   plane { <-sA,-sA,-sA>,.5 }
   plane { < sA,-sA,-sA>,.5 }
   plane { <-sA, sA,-sA>,.5 }
   plane { < sA, sA,-sA>,.5 }
   plane { <-sA,-sA, sA>,.5 }
   plane { < sA,-sA, sA>,.5 }
   plane { <-sA, sA, sA>,.5 }
   plane { < sA, sA, sA>,.5 }
}

