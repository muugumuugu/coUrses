#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "paulslib.h"

/*
   Creates an OOGL mesh of the TriTorus.
   Designed for viewing with GeomView but can easily be
   modified to create a mesh for other packages.
*/

int main(int argc,char **argv)
{
   int i,j,n=200;
   double u,v;
   XYZ p;
   COLOUR colour;
   COLOUR black = {0.0,0.0,0.0};

   printf("CMESH\n%d %d\n",n+1,n+1);
   for (i=0;i<=n;i++) {
      for (j=0;j<=n;j++) {

         u = -PI + i * TWOPI / n;
         v = -PI + j * TWOPI / n;

         p.x = sin(u) * (1 + cos(v));
         p.y = sin(u + 2 * PI / 3) * (1 + cos(v + 2 * PI / 3));
         p.z = sin(u + 4 * PI / 3) * (1 + cos(v + 4 * PI / 3));

         colour = GetColour(u,-PI,PI,4);
         printf("%g %g %g %g %g %g 0.5\n",p.x,p.y,p.z,
            colour.r,colour.g,colour.b);
      }
   }
}

