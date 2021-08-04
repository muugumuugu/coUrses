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

   /* Write a DXF header */
   printf("999\nDXF model of a Klein Bottle\n");
   printf("0\nSECTION\n");
   printf("2\nHEADER\n");
   printf("0\nENDSEC\n");
   printf("0\nSECTION\n");
   printf("2\nENTITIES\n");

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

         /* Write a DXF facet */
         printf("0\n3DFACE\n");
         for (k=0;k<4;k++) {
            printf("%d\n%g\n",10+k,p[k].x);
            printf("%d\n%g\n",20+k,p[k].y);
            printf("%d\n%g\n",30+k,p[k].z);
         }
      }
   }

   /* The DXF footer */
   printf("0\nENDSEC\n");
   printf("0\nEOF");
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

