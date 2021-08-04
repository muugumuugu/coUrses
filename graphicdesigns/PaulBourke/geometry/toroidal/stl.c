#include "stdlib.h"
#include "stdio.h"
#include "math.h"

typedef struct {
   double x,y,z;
} XYZ;

#define DTOR 0.01745329252

void WriteFacet(FILE *,XYZ *);
double power(double,double);

int main(int argc,char **argv)
{
   int u,v,du=5,dv=5;
   double r0=1.0,r1=0.25;
   double n1=1.0,n2=0.2;
   double theta,phi;
   XYZ p[4];
   FILE *fptr;

   if ((fptr = fopen("supertorus.stl","w")) == NULL) {
      fprintf(stderr,"Unable to open STL file\n");
      exit(-1);
   }
   fprintf(fptr,"solid\n");

   for (u=0;u<360;u+=du) {
      printf("theta = %d\n",u);
      for (v=0;v<360;v+=dv) {
         theta = (u) * DTOR;
         phi   = (v) * DTOR;
         p[0].x = power(cos(theta),n1) * ( r0 + r1 * power(cos(phi),n2) );
         p[0].y = power(sin(theta),n1) * ( r0 + r1 * power(cos(phi),n2) );
         p[0].z = r1 * power(sin(phi),n2);
         theta = (u+du) * DTOR;
         phi   = (v) * DTOR;
         p[1].x = power(cos(theta),n1) * ( r0 + r1 * power(cos(phi),n2) );
         p[1].y = power(sin(theta),n1) * ( r0 + r1 * power(cos(phi),n2) );
         p[1].z = r1 * power(sin(phi),n2);
         theta = (u+du) * DTOR;
         phi   = (v+dv) * DTOR;
         p[2].x = power(cos(theta),n1) * ( r0 + r1 * power(cos(phi),n2) );
         p[2].y = power(sin(theta),n1) * ( r0 + r1 * power(cos(phi),n2) );
         p[2].z = r1 * power(sin(phi),n2);
         theta = (u) * DTOR;
         phi   = (v+dv) * DTOR;
         p[3].x = power(cos(theta),n1) * ( r0 + r1 * power(cos(phi),n2) );
         p[3].y = power(sin(theta),n1) * ( r0 + r1 * power(cos(phi),n2) );
         p[3].z = r1 * power(sin(phi),n2);
         WriteFacet(fptr,p);
      }
   }

   fprintf(fptr,"endsolid\n");
   fclose(fptr);
	exit(0);
}

void WriteFacet(FILE *fptr,XYZ *p)
{
   fprintf(fptr,"facet normal 0 0 0\n");
   fprintf(fptr,"	outer loop\n");
   fprintf(fptr,"		vertex %lf %lf %lf\n",p[0].x,p[0].y,p[0].z);
   fprintf(fptr,"    vertex %lf %lf %lf\n",p[1].x,p[1].y,p[1].z);
   fprintf(fptr,"    vertex %lf %lf %lf\n",p[2].x,p[2].y,p[2].z);
   fprintf(fptr,"	endloop\n");
	fprintf(fptr,"endfacet\n");
   fprintf(fptr,"facet normal 0 0 0\n");
   fprintf(fptr," outer loop\n");
   fprintf(fptr,"    vertex %lf %lf %lf\n",p[0].x,p[0].y,p[0].z);
   fprintf(fptr,"    vertex %lf %lf %lf\n",p[2].x,p[2].y,p[2].z);
   fprintf(fptr,"    vertex %lf %lf %lf\n",p[3].x,p[3].y,p[3].z);
   fprintf(fptr," endloop\n");
   fprintf(fptr,"endfacet\n");
}

double power(double f,double p)
{
   int sign;
   double absf;

   sign = (f < 0 ? -1 : 1);
   absf = (f < 0 ? -f : f);

   if (absf < 0.00001)
      return(0.0);
   else
      return(sign * pow(absf,p));
}

