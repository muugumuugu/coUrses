#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include "math.h"
#include "paulslib.h"

void GiveUsage(char *);

/*
	Create the burning ship fractal
	Whole ship        -w 1.7 -c 0.45 0.5
	First small ship  -w 0.04 -c 1.755 0.03
	Second small ship -w .04 -c 1.625 0.035
	Tiny ship in tail -w 0.005 -c 1.941 0.004
	Another small one -w 0.008 -c 1.861 0.005
*/

int N = 4000;
XY midpoint = {0,0};
double range = 3;
int iteratemax = 255;
float *image = NULL;

int main(int argc,char **argv)
{
   int i,j,k;
	unsigned short iv;
	float v;
   char fname[256] = "ship.raw";
   FILE *fptr;
	XY c,p0,p;

   if (argc < 1) 
      GiveUsage(argv[0]);

   // Parse command line options 
   for (i=1;i<argc-1;i++) {
      if (strcmp(argv[i],"-c") == 0) {
			i++;
			midpoint.x = atof(argv[i]);
         i++;
         midpoint.y = atof(argv[i]);
		}
      if (strcmp(argv[i],"-w") == 0) {
         i++;
         range = atof(argv[i]);
		}
      if (strcmp(argv[i],"-i") == 0) {
         i++;
         iteratemax = atoi(argv[i]);
      }
   }

   // Create the image
   if ((image = malloc(N*N*sizeof(float))) == NULL) {
      fprintf(stderr,"Failed to malloc image\n");
      exit(-1);
   }

   // Create fractal
	for (i=0;i<N;i++) {
		for (j=0;j<N;j++) {
			p0.x = 0;
			p0.y = 0;
			c.x = midpoint.x + 2 * range * (i / (double)N - 0.5);
         c.y = midpoint.y + 2 * range * (j / (double)N - 0.5);
			for (k=0;k<iteratemax;k++) {
				p.x = p0.x*p0.x - p0.y*p0.y - c.x;
				p.y = 2 * fabs(p0.x*p0.y) - c.y;
				p0 = p;
				if (p.x*p.x + p.y*p.y > 10)
					break;
			}
			//if (k == iteratemax)
			//	image[j*N+i] = 0;
			//else
				image[j*N+i] = k;
		}
	}

   // Write the file 
	sprintf(fname,"ship_%d.raw",iteratemax);
   if ((fptr = fopen(fname,"w")) != NULL) {
		for (j=N-1;j>=0;j--) {
      	for (i=0;i<N;i++) {
				v = 1 - image[j*N+i] / iteratemax; // 0 .. 1
				//v = pow(v,0.5);
				iv = v * 65535;
				fwrite(&iv,sizeof(unsigned short int),1,fptr);
			}
		}
      fclose(fptr);
   } else {
      fprintf(stderr,"Failed to write output image\n");
   }
   
   exit(0);
}

void GiveUsage(char *s)
{
   fprintf(stderr,"Usage: %s [options]\n",s);
   fprintf(stderr,"Options\n");
	fprintf(stderr,"   -c x y   set the center of the image\n");
	fprintf(stderr,"   -w n     set the width of the image\n");
	fprintf(stderr,"   -i n     iteration depth\n");
   exit(-1);
}

