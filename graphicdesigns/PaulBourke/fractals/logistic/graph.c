#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "time.h"
#include "paulslib.h"
#include "bitmaplib.h"

int main(int argc,char **argv) 
{
	int i,ix;
	double x,y,ylast,ymin,ymax;
	BITMAP *image;
	BITMAP cwhite = {255,255,255}, cblack = {0,0,0};
	BITMAP cred = {255,0,0},cblue = {0,0,255};
	int nx = 1000,ny = 500; /* Increase these for more resolution */
	FILE *fptr;

	image  = CreateBitmap(nx,ny);
	EraseBitmap(image,nx,ny,cwhite);

	for (ix=0;ix<nx;ix++) {
		x = 4 * ix / (double)nx;
		ylast = (rand() % 1000) / 1000.0;
		for (i=0;i<1000;i++) {
			y = x * ylast * (1 - ylast);
			ylast = y;
		}
		ymin = 1e32;
		ymax = -1e32;
		for (i=0;i<10000;i++) {
			y = x * ylast * (1 - ylast);
			if (i % 2 == 0)
				DrawPixel(image,nx,ny,ix,y*ny,cred);
			else
				DrawPixel(image,nx,ny,ix,y*ny,cblue);
			ylast = y;
			ymin = MIN(ymin,y);
			ymax = MAX(ymax,y);
		}
		/* fprintf(stderr,"%g %g -> %g\n",x,ymin,ymax); */
	}

	/* Write the image as a PPM image */
	fptr = fopen("image","w");
	WriteBitmap(fptr,image,nx,ny,1);
	fclose(fptr);
	DestroyBitmap(image);
}

