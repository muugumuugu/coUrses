#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "paulslib.h"
#include "bitmaplib.h"

/*
   Calculate recurrence plots
*/

long CalcRecurrence(double *,int,int,int,double,char *);

#define N 400

double *data;
int npoints = 0;

int main(int argc,char **argv)
{
   int i;
   int delay,dimension;
   int dimstart=2,dimstop=5,dimstep=1;
   int delstart=1,delstop=10,delstep=1;
   long count;
   double radius = 0.05;
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
      fprintf(stderr,"       [-rad %g]\n",radius);
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
      if (strcmp(argv[i],"-rad") == 0 && argc >= i+1)
         radius = atof(argv[i+1]);
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
         count = CalcRecurrence(data,npoints,delay,dimension,radius,basename);
         fprintf(stderr,"Dimension = %-4d Delay = %-4d Count = %ld\n",
            dimension,delay,count);
      }
   }

	exit(0);
}

long CalcRecurrence(
   double *data,int n,
   int delay,int dim,double radius,
   char *base)
{
   int i,j,k,x0,y0,x1,y1;
   int indexi,indexj;
   long count = 0;
   double delta,distance;
   double scale;
   char fname[100];
   FILE *fptr;
   int buffer0[N][N],buffer1[N][N],buffer2[N][N];
   BITMAP4 *image;
   BITMAP4 cwhite = {255,255,255};
   BITMAP4 cblack = {0,0,0};

   /* Initialise the buffers */
   for (j=0;j<N;j++) {
      for (i=0;i<N;i++) {
         buffer0[i][j] = 0;
         buffer1[i][j] = 0;
         buffer2[i][j] = 0;
      }
   }

   /* Create the bitmap */
   if ((image = Create_Bitmap(N,N)) == NULL) {
      fprintf(stderr,"Unable to create bitmap\n");
      exit(0);
   }

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
               exit(0);
            }
            delta = data[indexi] - data[indexj];
            distance += delta * delta;
         }
         distance = sqrt(distance);

         /* Are the two points close enough */
         if (distance < radius * 2.0) {
            buffer2[x0][y0]++;
            buffer2[x1][y1]++;
         }
         if (distance < radius) {
            buffer1[x0][y0]++;
            buffer1[x1][y1]++;
            count++;
         }
         if (distance < radius / 2.0) {
            buffer0[x0][y0]++;
            buffer0[x1][y1]++;
         }

      }
   }

   /* Open and write bitmaps */
   for (k=0;k<=2;k++) {
      sprintf(fname,"bw_%s_%d_%d_%d.tga",base,dim,delay,k);
      if ((fptr = fopen(fname,"wb")) == NULL) {
         fprintf(stderr,"Unable to open tga file %s\n",fname);
         exit(0);
      }
      Erase_Bitmap(image,N,N,cwhite);
      for (j=0;j<N;j++) {
         for (i=0;i<N;i++) {
            if (k == 0 && buffer0[i][j] > 0) 
               Draw_Pixel(image,N,N,i,j,cblack);
            if (k == 1 && buffer1[i][j] > 0) 
               Draw_Pixel(image,N,N,i,j,cblack);
            if (k == 2 && buffer2[i][j] > 0) 
               Draw_Pixel(image,N,N,i,j,cblack);
         }
      }
      Write_Bitmap(fptr,image,N,N,12);
      fclose(fptr);
   }

   Destroy_Bitmap(image);
   return(count);
}



