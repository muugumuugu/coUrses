#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include <sys/types.h>
#include <time.h>
#include "paulslib.h"

XYZ Eval(double,double);

/* Change N to vary the resolution */
int N = 100;

double umin = -PI,umax = PI, vmin = -PI, vmax = PI;
double a = 1;

int main(int argc,char **argv)
{
   int i,j,k;
   double u,v,r,delta=0.01;
   XYZ p[4],n[4];
   COLOUR c[4];
   COLOUR black = {0.0,0.0,0.0};

   for (i=0;i<N;i++) {
      for (j=0;j<N;j++) {

         /* Calculate the vertices of the 4 points of the polygon face */
         /* Inefficient...... */
         u = umin + i * (umax - umin) / (double)N;
         v = vmin + j * (vmax - vmin) / (double)N;
         p[0] = Eval(u,v);
         n[0] = CalcNormal(Eval(u,v),Eval(u+delta,v),Eval(u,v+delta));
         c[0] = GetColour(u,umin,umax,4); 
         u = umin + (i+1) * (umax - umin) / (double)N;
         v = vmin + j * (vmax - vmin) / (double)N;
         p[1] = Eval(u,v);
         c[1] = GetColour(u,umin,umax,4);
         n[1] = CalcNormal(Eval(u,v),Eval(u+delta,v),Eval(u,v+delta));
         u = umin + (i+1) * (umax - umin) / (double)N;
         v = vmin + (j+1) * (vmax - vmin) / (double)N;
         p[2] = Eval(u,v);
         n[2] = CalcNormal(Eval(u,v),Eval(u+delta,v),Eval(u,v+delta));
         c[2] = GetColour(u,umin,umax,4);
         u = umin + i * (umax - umin) / (double)N;
         v = vmin + (j+1) * (vmax - vmin) / (double)N;
         p[3] = Eval(u,v);
         n[3] = CalcNormal(Eval(u,v),Eval(u+delta,v),Eval(u,v+delta));
         c[3] = GetColour(u,umin,umax,4);

         /* Optionally draw black bands at regular intervals */
         if (i % 10 == 0) {
            c[0] = black;
            c[3] = black;
         }

         /* Write the polygonal face out */
         /* Modify this to create another format */
         printf("f4nc ");
         for (k=0;k<4;k++)
            printf("%g %g %g ",p[k].x,p[k].y,p[k].z);
         for (k=0;k<4;k++)
            printf("%g %g %g ",n[k].x,n[k].y,n[k].z);
         for (k=0;k<4;k++)
            printf("%g %g %g ",c[k].r,c[k].g,c[k].b);
         printf("\n");

      }
   }
}

XYZ Eval(double u,double v)
{
   XYZ p;

   p.x = cos(u)*(a + sin(v)*cos(u/2) - sin(2*v)*sin(u/2)/2);
   p.y = sin(u)*(a + sin(v)*cos(u/2) - sin(2*v)*sin(u/2)/2);
   p.z = sin(u/2)*sin(v) + cos(u/2)*sin(2*v)/2;

   return(p);
}

#include "paulslib.c"

