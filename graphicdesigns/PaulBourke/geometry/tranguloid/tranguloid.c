#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "paulslib.h"

XYZ Eval(double,double);
#define N 100

int main(int argc,char **argv)
{
   int i,j,k;
   double u,v,u1,v1,delta=0.001;
   XYZ p[4],n[4],p1,p2;
   COLOUR colour[4];

   for (i=0;i<N;i++) {
      for (j=0;j<N;j++) {

         u  = -PI + i * TWOPI / N;
         u1 = -PI + (i+1) * TWOPI / N;
         v  = -PI + j * TWOPI / N;
         v1 = -PI + (j+1) * TWOPI / N;

         p[0] = Eval(u,v);
         p1 = Eval(u+delta,v);
         p2 = Eval(u,v+delta);
         n[0] = CalcNormal(p[0],p1,p2);

         p[1] = Eval(u1,v);
         p1 = Eval(u1+delta,v);
         p2 = Eval(u1,v+delta);
         n[1] = CalcNormal(p[1],p1,p2);

         p[2] = Eval(u1,v1);
         p1 = Eval(u1+delta,v1);
         p2 = Eval(u1,v1+delta);
         n[2] = CalcNormal(p[2],p1,p2);

         p[3] = Eval(u,v1);
         p1 = Eval(u+delta,v1);
         p2 = Eval(u,v1+delta);
         n[3] = CalcNormal(p[3],p1,p2);

         /* Apply colour mapping */
         colour[0] = GetColour(u,-PI,PI,4);
         colour[1] = GetColour(u1,-PI,PI,4);
         colour[2] = GetColour(u1,-PI,PI,4);
         colour[3] = GetColour(u,-PI,PI,4);

         /* Do something with the facet, normals, and colours */
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

   exit(0);
}

XYZ Eval(double u,double v)
{
   XYZ p;

   p.x = sin(3*u) * 2 / (2 + cos(v));
   p.y = (sin(u) + 2 * sin(2*u)) * 2 / (2 + cos(v + TWOPI / 3));
   p.z = (cos(u) - 2 * cos(2*u)) * (2 + cos(v)) * (2 + cos(v + TWOPI/3))/4;

   return(p);
}

