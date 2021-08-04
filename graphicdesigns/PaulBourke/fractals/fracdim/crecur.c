#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "paulslib.h"
#include "bitmaplib.h"

/*
   Calculate continuous tone recurrence plots
*/

int CalcRecurrence(double *,int,int,int,char *);

#define N 400
double *data;
int npoints = 0;

int main(int argc,char **argv)
{
   int i;
   int delay,dimension;
   int dimstart=2,dimstop=10,dimstep=1;
   int delstart=1,delstop=5,delstep=1;
   double x,sum=0,sum2=0,mean,std;
   char basename[100];
   FILE *fptr;

   /* Check there are enough arguments */
   if (argc < 2) {
      fprintf(stderr,"Usage: %s datafilename\n",argv[0]);
      fprintf(stderr,"       [-dim1 %d] [-dim2 %d] [-dim3 %d]\n",
         dimstart,dimstop,dimstep);
      fprintf(stderr,"       [-del1 %d] [-del2 %d] [-del3 %d]\n",
         delstart,delstop,delstep);
      fprintf(stderr,"\n");
      exit(0);
   }

   /* Handle the arguments */
   for (i=0;i<argc;i++) {
      if (strcmp(argv[i],"-dim1") == 0 && argc >= i+1) 
         dimstart = atoi(argv[i+1]);
      if (strcmp(argv[i],"-dim2") == 0 && argc >= i+1) 
         dimstop = atoi(argv[i+1]);
      if (strcmp(argv[i],"-dim3") == 0 && argc >= i+1)
         dimstep = atoi(argv[i+1]);
      if (strcmp(argv[i],"-del1") == 0 && argc >= i+1)
         delstart = atoi(argv[i+1]);
      if (strcmp(argv[i],"-del2") == 0 && argc >= i+1)
         delstop = atoi(argv[i+1]);
      if (strcmp(argv[i],"-del3") == 0 && argc >= i+1)
         delstep = atoi(argv[i+1]);
   }

   /* Form the basename */
   strcpy(basename,argv[1]);
   for (i=0;i<strlen(basename);i++)
      if (basename[i] == '.')
         basename[i] = '\0';

   /* Open and read the data file */
   fprintf(stderr,"Reading datafile\n");
   if ((fptr = fopen(argv[1],"r")) == NULL) {
      fprintf(stderr,"Unable to open the datafile\n");
      exit(0);
   }   
   while (fscanf(fptr,"%lf",&x) == 1) {
      sum  += x;
      sum2 += x*x;
      npoints++;
   }
   fprintf(stderr,"Read %d points\n",npoints);
   rewind(fptr);
   if ((data = (double *)malloc(npoints*sizeof(double))) == NULL) {
      fprintf(stderr,"Unable to allocate ram\n");
      exit(0);
   }
   for (i=0;i<npoints;i++)
      fscanf(fptr,"%lf",&(data[i]));
   fclose(fptr);
   mean = sum / npoints;
   std = (sum2 - sum * sum / npoints) / (npoints -1);
   std = sqrt(std);
   fprintf(stderr,"Mean = %g\n",mean);
   fprintf(stderr,"Standard deviation = %g\n",std);

   /* Normalise the series to zero mean and unity standard deviation */
   for (i=0;i<npoints;i++) {
      data[i] -= mean;
      data[i] /= std;
   }

   /* Do it */
   for (dimension=dimstart;dimension<=dimstop;dimension+=dimstep) {
      for (delay=delstart;delay<=delstop;delay+=delstep) {
         if (!CalcRecurrence(data,npoints,delay,dimension,basename)) {
            fprintf(stderr,"CalcRecurrence failed\n");
            exit(-1);
         }
         fprintf(stderr,"Dimension = %-4d Delay = %-4d\n",dimension,delay);
      }
   }

	exit(0);
}

int CalcRecurrence(double *data,int n,int delay,int dim,char *base)
{
   int i,j,k,x0,y0,x1,y1;
   int indexi,indexj;
   double delta,distance;
   double scale;
   char fname[100];
   FILE *fptr;
   double buffer[N][N];
   double rmin=1e32,rmax=0;
   BITMAP4 *image;
   BITMAP4 col,cwhite = {255,255,255},cblack={0,0,0};
   COLOUR colour;

   /* Initialise the buffers */
   for (j=0;j<N;j++) 
      for (i=0;i<N;i++) 
         buffer[i][j] = 1e32;

   /* Create the bitmap */
   if ((image = Create_Bitmap(N,N)) == NULL) {
      fprintf(stderr,"Unable to create bitmap\n");
      exit(0);
   }
   Erase_Bitmap(image,N,N,cwhite);

   scale = N / (double)n;

   for (i=0;i<n-dim*delay;i++) {
      x0 = i * scale;
      y1 = N - 1 - i * scale;

      for (j=i;j<n-dim*delay;j++) {
         y0 = N - 1 - j * scale;
         x1 = j * scale;

         /* Calculate the euclidean distance */
         distance = 0;
         for (k=0;k<dim;k++) {
            indexi = i + k * delay;
            indexj = j + k * delay;
            if (indexi >= n || indexj >= n) {
               fprintf(stderr,"Unexpectedly passed the end of the data\n");
               return(FALSE);
            }
            delta = data[indexi] - data[indexj];
            distance += delta * delta;
         }
         distance = sqrt(distance);

         /* Store the minimum distance between the two points */
         buffer[x0][y0] = MIN(buffer[x0][y0],distance);
         buffer[x1][y1] = MIN(buffer[x1][y1],distance);
      }
   }

   /* Find the bounds */
   for (j=0;j<N;j++) {
      for (i=0;i<N;i++) {
         if (buffer[i][j] > 1e31)
            continue;
         rmin = MIN(rmin,buffer[i][j]);
         rmax = MAX(rmax,buffer[i][j]);
      }
   }
   fprintf(stderr,"\tDistance range = %g -> %g\n",rmin,rmax);

   /* Open and write bitmaps */
     sprintf(fname,"%s_%d_%d.ppm",base,dim,delay);
     if ((fptr = fopen(fname,"w")) == NULL) {
        fprintf(stderr,"Unable to open ppm file %s\n",fname);
        return(FALSE);
     }
     for (j=0;j<N;j++) {
        for (i=0;i<N;i++) {
         col = cblack;
         if (buffer[i][j] < 1e31) {
            colour = GetColour(buffer[i][j],rmin,rmax,1);
            col.r = 255 * colour.r;
            col.g = 255 * colour.g;
            col.b = 255 * colour.b;
         }
         Draw_Pixel(image,N,N,i,j,col);
      }
   }
   Write_Bitmap(fptr,image,N,N,2);
     fclose(fptr);

   Destroy_Bitmap(image);
   return(TRUE);
}

