#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include <sys/types.h>
#include <time.h>
#include "paulslib.h"

/* Change N to vary the resolution */
int N = 200;

double umin = -PI,umax = PI, vmin = -PI, vmax = PI;
double a = 1;

int main(int argc,char **argv)
{
   int i,j;
   double u,v,r;
   XYZ p;
   COLOUR colour = {1.0,0.0,0.0}, black = {0.0,0.0,0.0};
   COLOUR green = {0.0,1.0,0.0}, red = {1.0,0.0,0.0};
   COLOUR blue = {0.0,0.0,1.0};

   printf("CMESH\n%d %d\n",N+1,N+1);
   for (i=0;i<=N;i++) {
      for (j=0;j<=N;j++) {

         u = umin + i * (umax - umin) / (double)N;
         v = vmin + j * (vmax - vmin) / (double)N;

         p.x = cos(u)*(a + sin(v)*cos(u/2) - sin(2*v)*sin(u/2)/2);
         p.y = sin(u)*(a + sin(v)*cos(u/2) - sin(2*v)*sin(u/2)/2);
         p.z = sin(u/2)*sin(v) + cos(u/2)*sin(2*v)/2;

         /* Set the colour */
         colour = GetColour(u,umin,umax,4); 

         /* Create some colour bands */
         colour = red;
         if (i % 5 == 0) 
            colour = green;
         if (j % 5 == 0)
            colour = blue;

         /* Output the point on the mesh */
         printf("%g %g %g %g %g %g 1\n",p.x,p.y,p.z,
            colour.r,colour.g,colour.b);
      }
   }
}

#include "paulslib.c"






