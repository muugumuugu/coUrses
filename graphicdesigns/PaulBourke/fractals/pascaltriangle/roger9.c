#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include <sys/types.h>
#include <time.h>
#include "paulslib.h"
#include "bitmaplib.h"

#define NX 1000
#define NY 1000
#define N 5000000
#define SCALE (NX * 1.95)

int main(int argc,char **argv)
{
   int n,a;
   double x,y,x1,y1;
   BITMAP *image,white={65535,65535,65535},black={0,0,0},bitmap;
   COLOUR colour;
   FILE *fptr;

   /* Create the image */
   image = CreateBitmap(NX,NY);
   EraseBitmap(image,NX,NY,white);
   srand(time(NULL));

   x = (rand() % 10000) / 10000.0;
   y = (rand() % 10000) / 10000.0;
   
   for (n=0;n<N;n++) {
      switch (a = (rand() % 3)) {
      case 0:
         x1 = x / 2;
         y1 = y / 2;
         break;
      case 1:
         x1 = y / 2;
         y1 = -x / 2 - 0.5;
         break;
      case 2:
         x1 = -y / 2 - 0.5;
         y1 = x / 2;
         break;
      }
      x = x1;
      y = y1;
      colour = GetColour((double)a,0.0,2.0,1);
      bitmap.r = colour.r * 255;
      bitmap.g = colour.g * 255;
      bitmap.b = colour.b * 255;
      if (n < 100)
         continue;
      DrawPixel(image,NX,NY,
         (int)(x * SCALE + NX - NX / 50),
         (int)(y * SCALE + NY - NY / 50),bitmap);
   }

   /* Write the image to a ppm file */
   if ((fptr = fopen("roger9.ppm","w")) == NULL) {
      fprintf(stderr,"Unable to open bitmap file\n");
      exit(0);
   }
   WriteBitmap(fptr,image,NX,NY,2);
   fclose(fptr);
   DestroyBitmap(image);
}

#include "bitmaplib.c"
#include "paulslib.c"
