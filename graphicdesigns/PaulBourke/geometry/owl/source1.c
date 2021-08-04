#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "paulslib.h"

int main(int argc,char **argv)
{
   int i,j,nu=100,nv=20;
   double u,v;
   XYZ p;
   COLOUR colour;
   COLOUR black = {0.0,0.0,0.0};

   printf("CMESH\n%d %d\n",nv+1,nu+1);
   for (i=0;i<=nu;i++) {
      for (j=0;j<=nv;j++) {

         u = i * 4 * PI / nu;
         v = j / (double)nv;

         p.x = v * cos(u) - 0.5 * v * v * cos(2 * u);
         p.y = - v * sin(u) - 0.5 * v * v * sin(2 * u);
         p.z = 4 * pow(v,1.5) * cos(1.5 * u) / 3;

         colour = GetColour(u,0.0,4*PI,4);
         printf("%g %g %g %g %g %g 0.5\n",p.x,p.y,p.z,
            colour.r,colour.g,colour.b);
      }
   }
}

