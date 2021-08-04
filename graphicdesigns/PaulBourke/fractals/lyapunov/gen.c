#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "paulslib.h"
#include "bitmaplib.h"

int MAXITERATIONS = 100000;
int NEXAMPLES = 10000;
double *x,*y;

void SaveAttractor(int,double *,double *,double,double,double,double);

int main(int argc,char **argv)
{
	double ax[6],ay[6];
	int i,n;
	int drawit;
	long secs;
	double xmin=1e32,xmax=-1e32,ymin=1e32,ymax=-1e32;
	double d0,dd,dx,dy,lyapunov;
	double xe,ye,xenew,yenew;

	x = malloc(MAXITERATIONS*sizeof(double));
   y = malloc(MAXITERATIONS*sizeof(double));
	time(&secs);
	srand48(secs);

	for (n=0;n<NEXAMPLES;n++) {
		printf("%8d ",n);

		/* Initialise things for this attractor */
		for (i=0;i<6;i++) {
			ax[i] = 4 * (drand48() - 0.5);
         ay[i] = 4 * (drand48() - 0.5);
		}
		lyapunov = 0;
		xmin =  1e32;
		xmax = -1e32;
		ymin =  1e32;
		ymax = -1e32;
	
		/* Calculate the attractor */
		drawit = TRUE;
		x[0] = drand48() - 0.5;
		y[0] = drand48() - 0.5;
		do {
			xe = x[0] + (drand48() - 0.5) / 1000.0;
      	ye = y[0] + (drand48() - 0.5) / 1000.0;
			dx = x[0] - xe;
			dy = y[0] - ye;
			d0 = sqrt(dx * dx + dy * dy);
		} while (d0 <= 0);

		for (i=1;i<MAXITERATIONS;i++) {

			/* Calculate next term */
      	x[i] = ax[0] + ax[1]*x[i-1] + ax[2]*x[i-1]*x[i-1] + 
				ax[3]*x[i-1]*y[i-1] + ax[4]*y[i-1] + ax[5]*y[i-1]*y[i-1];
      	y[i] = ay[0] + ay[1]*x[i-1] + ay[2]*x[i-1]*x[i-1] + 
				ay[3]*x[i-1]*y[i-1] + ay[4]*y[i-1] + ay[5]*y[i-1]*y[i-1];
         xenew = ax[0] + ax[1]*xe + ax[2]*xe*xe +
            ax[3]*xe*ye + ax[4]*ye + ax[5]*ye*ye;
         yenew = ay[0] + ay[1]*xe + ay[2]*xe*xe +
            ay[3]*xe*ye + ay[4]*ye + ay[5]*ye*ye;

			/* Update the bounds */
			xmin = MIN(xmin,x[i]);
			ymin = MIN(ymin,y[i]);
         xmax = MAX(xmax,x[i]);
         ymax = MAX(ymax,y[i]);

			/* Does the series tend to infinity */
			if (xmin < -1e10 || ymin < -1e10 || xmax > 1e10 || ymax > 1e10) {
				drawit = FALSE;
				printf("infinite attractor ");
				break;
			}

			/* Does the series tend to a point */
			dx = x[i] - x[i-1];
			dy = y[i] - y[i-1];
			if (ABS(dx) < 1e-10 && ABS(dy) < 1e-10) {
				drawit = FALSE;
				printf("point attractor ");
				break;
			}

			/* Calculate the lyapunov exponents */
			if (i > 1000) {
				dx = x[i] - xenew;
				dy = y[i] - yenew;
				dd = sqrt(dx * dx + dy * dy);
				lyapunov += log(fabs(dd / d0));
				xe = x[i] + d0 * dx / dd;
				ye = y[i] + d0 * dy / dd;
			}
		}

		/* Classify the series according to lyapunov */
		if (drawit) {
			if (ABS(lyapunov) < 10) {
				printf("neutrally stable ");
				drawit = FALSE;
			} else if (lyapunov < 0) {
				printf("periodic %g ",lyapunov);
				drawit = FALSE; 
			} else {
				printf("chaotic %g ",lyapunov); 
			}
		}

		/* Save the image */
		if (drawit) 
			SaveAttractor(n,ax,ay,xmin,xmax,ymin,ymax);

		printf("\n");
	}

	exit(0);
}

void SaveAttractor(int n,double *a,double *b,
	double xmin,double xmax,double ymin,double ymax) {
   char fname[128];
   FILE *fptr;
	int i,ix,iy;
	static int first = TRUE;
	BITMAP4 *image = NULL,white = {255,255,255},black = {0,0,0};
	int width = 500, height = 500;

	/* Save the parameters */
	sprintf(fname,"%05d.txt",n); 
	if ((fptr = fopen(fname,"w")) == NULL) {
		fprintf(stderr,"Failed to open output file\n");
		return;
	}
	fprintf(fptr,"%g %g %g %g\n",xmin,ymin,xmax,ymax);
	for (i=0;i<6;i++)
		fprintf(fptr,"%g %g\n",a[i],b[i]);
	fclose(fptr);

	/* Save the image */
   sprintf(fname,"%05d.tga",n);
	if (first) {
		image = Create_Bitmap(width,height);
		first = TRUE;
	}
   Erase_Bitmap(image,width,height,white);
   if ((fptr = fopen(fname,"w")) == NULL) {
		fprintf(stderr,"Failed to open output file\n");
      return;
	}
	for (i=0;i<MAXITERATIONS;i++) {
		ix = width * (x[i] - xmin) / (xmax - xmin);
		iy = height * (y[i] - ymin) / (ymax - ymin);
		if (i > 100)
			Draw_Pixel(image,width,height,ix,iy,black);
	}
	Write_Bitmap(fptr,image,width,height,1);
   fclose(fptr);
}

