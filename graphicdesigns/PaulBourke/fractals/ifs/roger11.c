#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include <sys/types.h>
#include <time.h>
#include "paulslib.h"
#include "bitmaplib.h"

#define NX 1000
#define NY 1000
#define N 100000000
#define SCALE (NX / 8)

int main(int argc,char **argv)
{
	int n,c;
	double x,y,r,w,x1,y1;
	BITMAP *image,white={65535,65535,65535},green={0,30000,0};
	COLOUR colour;
	FILE *fptr;

	/* Create the image */
	image = CreateBitmap(NX,NY);
	EraseBitmap(image,NX,NY,white);
	srand(time(NULL));

	x = 1 / sqrt(2.0);
	y = x;
	
	for (n=0;n<N;n++) {
		c = 2 * (n % 2) - 1;
		r = sqrt(x*x + y*y);
		w = atan2(y,x);
		x = r * cos(w - c * PI / 12.0);
		y = r * sin(w - c * PI / 12.0);
		switch (rand() % 4) {
		case 0:
			x1 = 0.85 * x + 0.04 * y;
			y1 = -0.04 * x + 0.85 * y + 1.6;
			break;
		case 1:
			x1 = 0.2 * x - 0.26 * y;
			y1 = 0.23 * x + 0.22 * y + 1.6;
			break;
		case 2:
			x1 = -0.15 * x + 0.28 * y;
			y1 = 0.26 * x + 0.24 * y + 0.44;
			break;
		case 3:
			x1 = 0;
			y1 = 0.16 * y;
			break;
		}
		x = x1;
		y = y1;
		if (n < 100)
			continue;
      DrawPixel(image,NX,NY,
         (int)(x * SCALE + NX/2),
         (int)(y * SCALE + NY/20),green);
	}

	/* Write the image to a ppm file */
	if ((fptr = fopen("roger11.ppm","w")) == NULL) {
		fprintf(stderr,"Unable to open bitmap file\n");
		exit(0);
	}
	WriteBitmap(fptr,image,NX,NY,2);
	fclose(fptr);
	DestroyBitmap(image);
}

#include "bitmaplib.c"
#include "paulslib.c"
