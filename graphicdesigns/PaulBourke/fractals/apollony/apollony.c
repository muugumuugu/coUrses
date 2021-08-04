#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "paulslib.h"
#include "bitmaplib.h"

#define NX 2000
#define NY 2000
#define N 10000000
#define SCALE (NX / 8)

int main(int argc,char **argv)
{
   int n,ix,iy;
   double x=0.2,y=0.3,x1=0,y1=0,r=SQRT3;
   double a0,b0,f1x,f1y;
   BITMAP4 *image,white={255,255,255},black = {0,0,0};
   char fname[64];
   FILE *fptr;

   /* Create image */
   image = Create_Bitmap(NX,NY);
   Erase_Bitmap(image,NX,NY,white);

   /* Iterate */
   for (n=0;n<N;n++) {
      if ((n % (N/10)) == 0)
         fprintf(stderr,".");
      a0 = 3 * (1 + r - x) / (pow(1 + r - x,2.0) + y*y) - (1 + r) / (2 + r);
      b0 = 3 * y / (pow(1 + r - x,2.0) + y*y);
      f1x =  a0 / (a0*a0 + b0*b0);
      f1y = -b0 / (a0*a0 + b0*b0);
      switch (rand()%3) {
      case 0:
         x1 = a0;
         y1 = b0;
         break;
      case 1:
         x1 = -f1x / 2 - f1y * r / 2;
         y1 = f1x * r / 2 - f1y / 2;
         break;
      case 2:
         x1 = -f1x / 2 + f1y * r / 2;
         y1 = -f1x * r / 2 - f1y / 2;
         break;
      }
      if (n < 100)
         continue;
      ix = x * SCALE + NX/2;
      iy = y * SCALE + NY/2;
      x = x1;
      y = y1;
      if (ix < 0 || iy < 0 || ix >= NX || iy >= NY)
         continue;
      image[iy*NX+ix] = black;
   }

   /* Save image */
   sprintf(fname,"apollony.tga");
   if ((fptr = fopen(fname,"w")) == NULL) {
      fprintf(stderr,"Unable to open image file\n");
      exit(0);
   }
   Write_Bitmap(fptr,image,NX,NY,12);
   fclose(fptr);

   exit(0);
}

