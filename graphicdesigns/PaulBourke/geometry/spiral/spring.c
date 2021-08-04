#include "stdio.h"
#include "stdlib.h"
#include "math.h"

typedef struct {
   double x,y,z;
} XYZ;
typedef struct {
   double r,g,b;
} COLOUR;

#define TWOPI 6.283185307179586476925287
#define PI    3.141592653589793238462643

XYZ Eval(double,double);
void Normalise(XYZ *);
XYZ CalcNormal(XYZ,XYZ,XYZ);

#define Nu 200
#define Nv 20
#define CYCLES 5
#define R1 0.5
#define R2 0.2
#define PERIODLENGTH 2

int main(int argc,char **argv)
{
   int i,j,k;
   double u,v,du,dv;
   XYZ q[4],n[4];
   COLOUR colour = {0.0,0.0,1.0};
   
   du = CYCLES * TWOPI / (double)Nu;
   dv = TWOPI / (double)Nv;

   for (i=0;i<Nu;i++) {
      u = i * du;
      for (j=0;j<Nv;j++) {
         v = j * dv;
         q[0] = Eval(u,v);
         n[0] = CalcNormal(q[0],Eval(u+du/10,v),Eval(u,v+dv/10));
         q[1] = Eval(u+du,v);
         n[1] = CalcNormal(q[1],Eval(u+du+du/10,v),Eval(u+du,v+dv/10));
         q[2] = Eval(u+du,v+dv);
         n[2] = CalcNormal(q[2],Eval(u+du+du/10,v+dv),Eval(u+du,v+dv+dv/10));
         q[3] = Eval(u,v+dv);
         n[3] = CalcNormal(q[3],Eval(u+du/10,v+dv),Eval(u,v+dv+dv/10));

			/* Write the facet out in your favorite format */
         printf("f4n ");
         for (k=0;k<4;k++)
            printf("%g %g %g ",q[k].x,q[k].y,q[k].z);
         for (k=0;k<4;k++)
            printf("%g %g %g ",n[k].x,n[k].y,n[k].z);
         printf("%g %g %g\n",colour.r,colour.g,colour.b);
      }
   }
}

XYZ Eval(double u,double v)
{
   XYZ q;

   q.x = (1 - R1 * cos(v)) * cos(u);
   q.y = (1 - R1 * cos(v)) * sin(u);
   q.z = R2 * (sin(v) + u*PERIODLENGTH/PI);

   return(q);
}

XYZ CalcNormal(XYZ p,XYZ p1,XYZ p2)
{
   XYZ n,pa,pb;

   pa.x = p1.x - p.x;
   pa.y = p1.y - p.y;
   pa.z = p1.z - p.z;
   pb.x = p2.x - p.x;
   pb.y = p2.y - p.y;
   pb.z = p2.z - p.z;
   Normalise(&pa);
   Normalise(&pb);

   n.x = pa.y * pb.z - pa.z * pb.y;
   n.y = pa.z * pb.x - pa.x * pb.z;
   n.z = pa.x * pb.y - pa.y * pb.x;
   Normalise(&n);

   return(n);
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


