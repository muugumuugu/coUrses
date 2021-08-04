#include "stdio.h"
#include "stdlib.h"
#include "math.h"

/*
   Create a 2D and 3D version (surface of revolution
   of a Cassinian oval. Geometry is output in Vision3D
   text format, it should be easy to output geometry
   of your choice.
   N is the number of points along the curve 
   M is the number of ribs in the surface of revolution 
   When a > b only one half of the split surface is created.
*/

#define N 40
#define M 18
#define PI 3.141592653589793238462643
#define TWOPI 6.283185307179586476925287

typedef struct {
   double x,y,z;
} XYZ;

XYZ Eval(double,double,double,int);
XYZ XRotate(XYZ,double);

int main(int argc,char **argv)
{
   int i,j,k;
   int thesign;
   double theta1,theta2;
   double tstart,tstop,t1,t2;
   XYZ p[4];
   FILE *f2d,*f3d;
   char fname[64];
   double a,b;  /* Control parameters for the curve */

   /* Get the input parameters */
   if (argc < 3) {
      fprintf(stderr,"Usage: %s a b\n",argv[0]);
      exit(-1);
   }
   a = atof(argv[1]);
   b = atof(argv[2]);

   /* Set the bounds for the parameter t */
   tstart = 0;
   if (a <= b)
      tstop = PI;
   else
      tstop = 0.5 * asin(b*b/(a*a));

   /* Open the 2D geometry file */
   sprintf(fname,"egg_%g_%g.2d",a,b);
   f2d = fopen(fname,"w");
   fprintf(f2d,"2 1000 0.8 0.5 2\n0  0 0\n2 0 0\n1 0 0\n"); /* x axis */
   fprintf(f2d,"2 1000 0.8 0.5 2\n0 -1 0\n0 1 0\n0 1 0\n"); /* y axis */

   /* Open the 3D geometry file */
   sprintf(fname,"egg_%g_%g.3d",a,b);
   f3d = fopen(fname,"w");
   fprintf(f3d,"2 1000 0.8 0.5 2\n0  0  0\n2 0 0\n1 0 0\n"); /* x axis */
   fprintf(f3d,"2 1000 0.8 0.5 2\n0 -1  0\n0 1 0\n0 1 0\n"); /* y axis */
   fprintf(f3d,"2 1000 0.8 0.5 2\n0  0 -1\n0 0 1\n0 0 1\n"); /* z axis */

   for (j=0;j<M;j++) {       /* Rotation about x */
      theta1 = TWOPI * j / (double)M;
      theta2 = TWOPI * ((j+1)%M) / (double)M;

      for (i=0;i<N;i++) {    /* Points on x-y plane */
         thesign = 1;
         if (a <= b) {
            t1 = tstart + (tstop - tstart) * i / (double)N;
            t2 = tstart + (tstop - tstart) * (i+1) / (double)N;
         } else {
            if (i < N/2) {
               t1 = tstart + 2 * (tstop - tstart) * i / (double)N;
               t2 = tstart + 2 * (tstop - tstart) * (i+1) / (double)N;
            } else {
               t1 = tstart + 2 * (tstop - tstart) * (i-N/2) / (double)N;
               t2 = tstart + 2 * (tstop - tstart) * (i+1-N/2) / (double)N;
               thesign = -1;
            }
         }

         /* Calculate the 4 points making up a facet */
         p[0] = Eval(t1,a,b,thesign);
         p[1] = Eval(t2,a,b,thesign);
         p[2] = p[1];
         p[3] = p[0];
         p[0] = XRotate(p[0],theta1);
         p[1] = XRotate(p[1],theta1);
         p[2] = XRotate(p[2],theta2);
         p[3] = XRotate(p[3],theta2);
   
         /* Write outline */
         if (j == 0) {
            fprintf(f2d,"2 1000 0.8 0.5 2\n");
            for (k=0;k<2;k++)
               fprintf(f2d,"%g %g %g\n",p[k].x,p[k].y,p[k].z);
            fprintf(f2d,"0.5 0.5 0.5\n");
         }

         /* Write  face 
            Strictly speaking, the two end points at j=0 and N-1
            only need to be saved a 3 vertex facets
         */
         fprintf(f3d,"4 1000 0.8 0.5 2\n");
         for (k=0;k<4;k++)
            fprintf(f3d,"%g %g %g\n",p[k].x,p[k].y,p[k].z);
         fprintf(f3d,"0.5 0.5 0.5\n");
      }
   }

   fclose(f2d);
   fclose(f3d);
}

/*
   Rotate a point about the x axis
*/
XYZ XRotate(XYZ p,double theta)
{
   XYZ q;

   q.x =  p.x;
   q.y =  p.y * cos(theta) + p.z * sin(theta);
   q.z = -p.y * sin(theta) + p.z * cos(theta);

   return(q);
}

/*
   Evaluate the Cassinian Oval at t given a and b
   t is assumed to be between the correct ranges
   For a <= b, 0 < t < TWOPI
   For a >  b, -to < t < to where to = 0.5 * asin(b^2/a^2)
*/
XYZ Eval(double t,double a,double b,int sign)
{
   XYZ p;
   double c1,c2;

   c1 = b*b*b*b - a*a*a*a*sin(2*t)*sin(2*t);
   if (c1 <= 0) /* Shouldn't happen with correct usage */
      c2 = a * a * cos(2*t);
   else
      c2 = a * a * cos(2*t) + sign * sqrt(c1);
   p.x = cos(t) * sqrt(c2);
   p.y = sin(t) * sqrt(c2);
   p.z = 0.0;

   return(p);
}


