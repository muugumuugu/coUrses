#include "stdio.h"
#include "stdlib.h"
#include "math.h"

/*
   Create a 2D and 3D version (surface of revolution
   of a Cassinian oval for PovRay.
   N is the number of points along the curve 
   M is the number of ribs in the surface of revolution 
*/

#define N 40
#define M 18
#define PI 3.141592653589793238462643
#define TWOPI 6.283185307179586476925287
#define EPSILON 0.00001
#define TRUE  1
#define FALSE 0
#define ABS(x) (x < 0 ? -(x) : (x))

typedef struct {
   double x,y,z;
} XYZ;

XYZ Eval(double,double,double,int);
XYZ XRotate(XYZ,double);
XYZ VectorSub(XYZ,XYZ);
XYZ CrossProduct(XYZ,XYZ);
int VertexEqual(XYZ,XYZ);
void Normalise(XYZ *);

int main(int argc,char **argv)
{
   int i,j,k;
   int thesign;
   double theta1,theta2;
   double tstart,tstop,t1,t2;
   XYZ p[4],q[2],n[4],zperp = {0,0,1};
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
         q[0] = Eval(t1+0.1/N,a,b,thesign);
         q[0] = VectorSub(q[0],p[0]);
         n[0] = CrossProduct(q[0],zperp);

         p[1] = Eval(t2,a,b,thesign);
         q[1] = Eval(t2-0.1/N,a,b,thesign);
         q[1] = VectorSub(p[1],q[1]);
         n[1] = CrossProduct(q[1],zperp);

         p[2] = p[1];
         n[2] = n[1];

         p[3] = p[0];
         n[3] = n[0];

         p[0] = XRotate(p[0],theta1);
         n[0] = XRotate(n[0],theta1);
         p[1] = XRotate(p[1],theta1);
         n[1] = XRotate(n[1],theta1); 
         p[2] = XRotate(p[2],theta2);
         n[2] = XRotate(n[2],theta2);
         p[3] = XRotate(p[3],theta2);
         n[3] = XRotate(n[3],theta2); 
   
         for (k=0;k<4;k++)
            Normalise(&(n[k]));

         /* Write face */
         if (!VertexEqual(p[0],p[1]) &&
             !VertexEqual(p[1],p[2]) && !VertexEqual(p[2],p[0])) {
            printf("smooth_triangle {\n");
            printf("   <%g,%g,%g>,\n",p[0].x,p[0].y,p[0].z);
            printf("   <%g,%g,%g>,\n",n[0].x,n[0].y,n[0].z);
            printf("   <%g,%g,%g>,\n",p[1].x,p[1].y,p[1].z);
            printf("   <%g,%g,%g>,\n",n[1].x,n[1].y,n[1].z);
            printf("   <%g,%g,%g>,\n",p[2].x,p[2].y,p[2].z);
            printf("   <%g,%g,%g> \n",n[2].x,n[2].y,n[2].z);
            printf("   texture { thetexture }\n");
            printf("}\n");
         }
         if (!VertexEqual(p[0],p[2]) &&
             !VertexEqual(p[2],p[3]) && !VertexEqual(p[3],p[0])) {
            printf("smooth_triangle {\n");
            printf("   <%g,%g,%g>,\n",p[0].x,p[0].y,p[0].z);
            printf("   <%g,%g,%g>,\n",n[0].x,n[0].y,n[0].z);
            printf("   <%g,%g,%g>,\n",p[2].x,p[2].y,p[2].z);
            printf("   <%g,%g,%g>,\n",n[2].x,n[2].y,n[2].z);
            printf("   <%g,%g,%g>,\n",p[3].x,p[3].y,p[3].z);
            printf("   <%g,%g,%g> \n",n[3].x,n[3].y,n[3].z);
            printf("   texture { thetexture }\n");
            printf("}\n");
         }
      }
   }
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

   /* Translate single loop case to origin */
   if (a > b)
      p.x -= a;

   return(p);
}

XYZ VectorSub(XYZ p1,XYZ p2)
{
   XYZ p;

   p.x = p2.x - p1.x;
   p.y = p2.y - p1.y;
   p.z = p2.z - p1.z;

   return(p);
}

XYZ CrossProduct(XYZ p1,XYZ p2)
{
   XYZ p;

   p.x = p1.y * p2.z - p1.z * p2.y;
   p.y = p1.z * p2.x - p1.x * p2.z;
   p.z = p1.x * p2.y - p1.y * p2.x;

   return(p);
}

int VertexEqual(XYZ v1,XYZ v2)
{
  if (ABS(v1.x - v2.x) > EPSILON)
    return(FALSE);
  if (ABS(v1.y - v2.y) > EPSILON)
    return(FALSE);
  if (ABS(v1.z - v2.z) > EPSILON)
    return(FALSE);
  return(TRUE);
}

void Normalise(XYZ *p)
{
   double length;

   length = sqrt(p->x * p->x + p->y * p->y + p->z * p->z);
   if (length != 0) {
      p->x /= length;
      p->y /= length;
      p->z /= length;
   } else {
      p->x = 0;
      p->y = 0;
      p->z = 0;
   }
}
