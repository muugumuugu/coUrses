#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "paulslib.h"

/*
   Create a volumetric sampling of the triternion set, typically for Drishti
*/

int nvol = 512;
float ***vol = NULL;
double xmin = -2,ymin = -1.375,zmin = -1.25;
double xmax = 0.75,ymax = 1.375,zmax = 1.5;

int Eval(double,double,double,int);

#define NMAX 2000

int main(int argc,char **argv)
{
   int i,j,k,n;
   double x,y,z;
   double vf,vmax = 0;
   unsigned char v;
   FILE *fptr;

   // Create volumetric data
   vol = malloc(nvol*sizeof(float **));
   for (i=0;i<nvol;i++)
      vol[i] = malloc(nvol*sizeof(float *));
   for (i=0;i<nvol;i++)
      for (j=0;j<nvol;j++)
         vol[i][j] = malloc(nvol*sizeof(float));
   for (i=0;i<nvol;i++)
      for (j=0;j<nvol;j++)
         for (k=0;k<nvol;k++)
            vol[i][j][k] = 0;

   // Compute volume
   for (k=0;k<nvol;k++) {
      z = zmin + k * (zmax - zmin) / (nvol - 1);
      if (k % (nvol / 10) == 0)
         fprintf(stderr,"z = %g\n",z);

      for (j=0;j<nvol;j++) {
         y = ymin + j * (ymax - ymin) / (nvol - 1);

         for (i=0;i<nvol;i++) {
            x = xmin + i * (xmax - xmin) / (nvol - 1);

            n = Eval(x,y,z,NMAX);
            vol[i][j][k] = n;
            vmax = MAX(vmax,vol[i][j][k]);

         } // i
      } // j
   } // k
   fprintf(stderr,"Maximum value: %g\n",vmax);

   // Write raw file for Drishti
   fptr = fopen("triternion.raw","w");
   fputc(0,fptr);
   fwrite(&nvol,sizeof(int),1,fptr);
   fwrite(&nvol,sizeof(int),1,fptr);
   fwrite(&nvol,sizeof(int),1,fptr);
   for (i=0;i<nvol;i++) {
      for (j=0;j<nvol;j++) {
         for (k=0;k<nvol;k++) {
            vf = vol[i][j][k] / vmax; // 0 ... 1
            vf = pow(vf,0.2);         // Non linear stretching of histogram
            v = 255 * vf;             // 0 ... 255
            fwrite(&v,1,1,fptr);
         }
      }
   }
   fclose(fptr);

   exit(0);
}

int Eval(double x,double y,double z,int nmax)
{
   int n = 0;
   double x1 = 0,y1 = 0,z1 = 0;
   double a,b,c;
   double zz = 0;

   while (zz < 100 && n < nmax) {
      a = x1*x1 + 2*y1*z1;
      b = z1*z1 + 2*x1*y1;
      c = y1*y1 + 2*x1*z1;
      x1 = a + x;
      y1 = b + y;
      z1 = c + z;
      zz = x1*x1 + y1*y1 + z1*z1;
      n++;
   }
   
   return(n);
}

