#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include <sys/types.h>
#include <time.h>
#include "paulslib.h"
#include "bitmaplib.h"

#define NX 2000
#define NY 2000
#define N 100000000
#define SCALE (NX / 4)

int main(int argc,char **argv)
{
	int i,l,m,n,ix,iy;
	double x=1,y=1,x1,y1;
	double a[25],b[25];
	BITMAP *image,white={255,255,255},green={0,100,0},black={0,0,0};
	BITMAP colour;
	char fname[64];
	FILE *fptr;

	if (argc < 2) {
		fprintf(stderr,"Usage: %s m\n",argv[0]);
		exit(-1);
	}
	m = atoi(argv[1]);
	if (m < 2 || m > 12) {
		fprintf(stderr,"m out of range, must be between 2 and 12\n");
		exit(-1);
	}

	/* Create the image */
	image = CreateBitmap(NX,NY);
	EraseBitmap(image,NX,NY,white);
	srand(time(NULL));

	for (i=0;i<m;i++) {
		a[i] = cos(TWOPI * i / (double)m);
		b[i] = sin(TWOPI * i / (double)m);
	}
	
	for (n=0;n<N;n++) {
		l = rand() % m;
		if ((n % (N/10)) == 0)
			fprintf(stderr,"%d\n",n);
		if (rand() % 2 == 0) {
			x1 = x / 2.0 + a[l];
			y1 = y / 2.0 + b[l];
		} else {
			x1 = x * a[l] + y * b[l] + x * x * b[l];
			y1 = y * a[l] - x * b[l] + x * x * a[l];
         x1 /= 6;
         y1 /= 6;
		}
		x = x1;
		y = y1;
		if (n < 100)
			continue;
		ix = x * SCALE + NX/2;
		iy = y * SCALE + NY/2;
      DrawPixel(image,NX,NY,ix,iy,black);
	}

	/* Write the image to a ppm file */
	sprintf(fname,"roger18_%d.tiff",m);
	if ((fptr = fopen(fname,"w")) == NULL) {
		fprintf(stderr,"Unable to open bitmap file\n");
		exit(0);
	}
	WriteBitmap(fptr,image,NX,NY,5);
	fclose(fptr);
	DestroyBitmap(image);
}

#include "bitmaplib.c"
#include "paulslib.c"
