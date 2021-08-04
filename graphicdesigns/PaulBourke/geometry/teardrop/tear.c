#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "paulslib.h"

XYZ Eval(double,double);

/* Resolution */
#define N 100

/* My colour map function "GetColour()" */
int cmap = 4;

int main(int argc,char **argv)
{
   int i,j,k;
   double u,v,u1,v1,delta=0.001;
   XYZ p[4],n[4],p1,p2;
   COLOUR colour[4];
   COLOUR black = {0.0,0.0,0.0};
   COLOUR brown = {1.0,1.0,0.5};

   for (i=0;i<N;i++) {
      for (j=0;j<N;j++) {
         u  = PI * i / (double)N;
         u1 = PI * (i+1) / (double)N;
         v  = TWOPI * j / (double)N;
         v1 = TWOPI * (j+1) / (double)N;

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

         colour[0] = GetColour(v,0.0,TWOPI,cmap);
         colour[1] = GetColour(v1,0.0,TWOPI,cmap);
         colour[2] = GetColour(v1,0.0,TWOPI,cmap);
         colour[3] = GetColour(v,0.0,TWOPI,cmap);

/*
         colour[0] = brown;
         colour[1] = brown;
         colour[2] = brown;
         colour[3] = brown;
*/
         if (j % 5 == 0) {
            colour[0] = black;
            colour[1] = black;
            colour[2] = black;
            colour[3] = black;
         }
/*
         if (i % 5 == 0) {
            colour[0] = black;
            colour[1] = black;
            colour[2] = black;
            colour[3] = black;
         }
*/

         /* 
            Write a face with normals and colours
            Change this to your favorite file format
            The format here is the "geom" format
         */
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

/*
   Evaluate the function
*/
XYZ Eval(double theta,double phi)
{
   XYZ p;

   p.x = 0.5 * (1 - cos(theta)) * sin(theta) * cos(phi);
   p.y = 0.5 * (1 - cos(theta)) * sin(theta) * sin(phi);
   p.z = cos(theta);

   return(p);
}

