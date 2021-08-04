#include "common.pov"

#declare plastic = finish {
   diffuse 0.2 
   specular 0.5
}

#declare LL = 0.5;
#declare RR = 0.7;
#if (clock = 0) intersection { #else union { #end
   cylinder {
      LL*<-1,-1,-1>, LL*<1,1,1>, RR
      texture { pigment { color rgb <1,0,0> } finish { plastic } }
   }
   cylinder {
      LL*<1,-1,1>, LL*<-1,1,-1>, RR
      texture { pigment { color rgb <1,1,0> } finish { plastic } }
   }
   cylinder {
      LL*<-1,1,1>, LL*<1,-1,-1>, RR
      texture { pigment { color rgb <0,0,1> } finish { plastic } }
   }
   cylinder {
      LL*<1,1,-1>, LL*<-1,-1,1>, RR
      texture { pigment { color rgb <0,1,0> } finish { plastic } }
   }
}

#include "tetrahedron.pov"

