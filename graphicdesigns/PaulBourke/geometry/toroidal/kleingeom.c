#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include <sys/types.h>
#include <time.h>
#include "paulslib.h"

double umin = 0,umax = TWOPI, vmin = 0, vmax = TWOPI;

XYZ Eval(double u,double v);

int main(int argc,char **argv)
{
   int i,j,k,N;
   double u,v,dudv=0.01;
   XYZ p[4],n[4];
   COLOUR colour[4];

   /* Check command line arguments */
   if (argc < 2) {
      fprintf(stderr,"Usage: %s nresol\n",argv[0]);
      exit(-1);
   }
   N = atoi(argv[1]);

   for (i=0;i<N;i++) {
      for (j=0;j<N;j++) {

         u = umin + i * (umax - umin) / (double)N;
         v = vmin + j * (vmax - vmin) / (double)N;
         p[0] = Eval(u,v);
         colour[0] = GetColour(u,umin,umax,4); 
         n[0] = CalcNormal(p[0],Eval(u+dudv,v),Eval(u,v+dudv));

         u = umin + (i+1) * (umax - umin) / (double)N;
         v = vmin + j     * (vmax - vmin) / (double)N;
         p[1] = Eval(u,v);
         colour[1] = GetColour(u,umin,umax,4);
         n[1] = CalcNormal(p[1],Eval(u+dudv,v),Eval(u,v+dudv));

         u = umin + (i+1) * (umax - umin) / (double)N;
         v = vmin + (j+1) * (vmax - vmin) / (double)N;
         p[2] = Eval(u,v);
         colour[2] = GetColour(u,umin,umax,4);
         n[2] = CalcNormal(p[2],Eval(u+dudv,v),Eval(u,v+dudv));

         u = umin + i     * (umax - umin) / (double)N;
         v = vmin + (j+1) * (vmax - vmin) / (double)N;
         p[3] = Eval(u,v);
         colour[3] = GetColour(u,umin,umax,4);
         n[3] = CalcNormal(p[3],Eval(u+dudv,v),Eval(u,v+dudv));

         /* Write the geometry */
         printf("f4nc ");
         for (k=0;k<4;k++)
            printf("%g %g %g ",p[k].x,p[k].y,p[k].z);
         for (k=0;k<4;k++)
            printf("%g %g %g ",n[k].x,n[k].y,n[k].z);
         for (k=0;k<4;k++)
            printf("%g %g %g ",colour[k].r,colour[k].g,colour[k].b);
         printf("\n");
      }
   }
}

XYZ Eval(double u, double v)
{
   XYZ p;
   double r;

   r = 4 * (1 - cos(u) / 2);
   if (u < PI) {
      p.x =  6 * cos(u) * (1 + sin(u)) + r * cos(u) * cos (v);
      p.y = 16 * sin(u) + r * sin(u) * cos(v);
   } else {
      p.x = 6 * cos(u) * (1 + sin(u)) + r * cos(v + PI);
      p.y = 16 * sin(u);
   }
   p.z = r * sin(v);

   return(p);
}

