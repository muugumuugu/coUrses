#include "stdlib.h"
#include "stdio.h"
#include "math.h"

typedef struct {
   double x,y,z;
} XYZ;

#define DTOR 0.01745329252

void WriteDXFFacet(FILE *,XYZ *,int);

int main(int argc,char **argv)
{
   int u,v,du=10,dv=10;
   double r0=1.0,r1=0.25;
   double theta,phi;
   XYZ p[4];
   FILE *fptr;

   if ((fptr = fopen("torus.dxf","w")) == NULL) {
      fprintf(stderr,"Unable to open DXF file\n");
      return;
   }
   fprintf(fptr,"999\nModel of a torus\n");
   fprintf(fptr,"0\nSECTION\n");
   fprintf(fptr,"2\nENTITIES\n");

   for (u=0;u<360;u+=du) {
      printf("theta = %d\n",u);
      for (v=0;v<360;v+=dv) {
         theta = (u) * DTOR;
         phi   = (v) * DTOR;
         p[0].x = cos(theta) * ( r0 + r1 * cos(phi) );
         p[0].y = sin(theta) * ( r0 + r1 * cos(phi) );
         p[0].z = r1 * sin(phi);
         theta = (u+du) * DTOR;
         phi   = (v) * DTOR;
         p[1].x = cos(theta) * ( r0 + r1 * cos(phi) );
         p[1].y = sin(theta) * ( r0 + r1 * cos(phi) );
         p[1].z = r1 * sin(phi);
         theta = (u+du) * DTOR;
         phi   = (v+dv) * DTOR;
         p[2].x = cos(theta) * ( r0 + r1 * cos(phi) );
         p[2].y = sin(theta) * ( r0 + r1 * cos(phi) );
         p[2].z = r1 * sin(phi);
         theta = (u) * DTOR;
         phi   = (v+dv) * DTOR;
         p[3].x = cos(theta) * ( r0 + r1 * cos(phi) );
         p[3].y = sin(theta) * ( r0 + r1 * cos(phi) );
         p[3].z = r1 * sin(phi);
         WriteDXFFacet(fptr,p,4);
      }
   }

   fprintf(fptr,"0\nENDSEC\n");
   fprintf(fptr,"0\nEOF\n");
   fclose(fptr);
}

/*
   Write a facet out in DXF format
*/
void WriteDXFFacet(fptr,p,n)
FILE *fptr;
XYZ *p;
int n;
{
   int i;

   fprintf(fptr,"0\nPOLYLINE\n");
   fprintf(fptr,"8\ntorus\n");
   fprintf(fptr,"66\n1\n");
   fprintf(fptr,"70\n9\n");
   for (i=0;i<n;i++) {
      fprintf(fptr,"0\nVERTEX\n");
      fprintf(fptr,"8\ntorus\n");
      fprintf(fptr,"70\n32\n");
      fprintf(fptr,"10\n%g\n",p[i].x);
      fprintf(fptr,"20\n%g\n",p[i].y);
      fprintf(fptr,"30\n%g\n",p[i].z);
   }
   fprintf(fptr,"0\nSEQEND\n");
}

