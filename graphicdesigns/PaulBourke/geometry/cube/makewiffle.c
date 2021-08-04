#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "paulslib.h"
#include "bitmaplib.h"

#define N 200
double ***grid;

int main(int argc,char **argv)
{
   int i,j,k;
   short int si;
   double v,vmin=1e32,vmax=-1e32;
   double a,b,da,db;
   XYZ p;
   BITMAP *image,c;
   COLOUR colour;
   char fname[32];
   FILE *fptr,*fvol;

   grid = malloc((N+1)*sizeof(double **));
   for (i=0;i<=N;i++) {
      grid[i] = malloc((N+1)*sizeof(double *));
   }
   for (i=0;i<=N;i++) {
      for (j=0;j<=N;j++) {
         grid[i][j] = malloc((N+1)*sizeof(double));
      }
   }
   for (i=0;i<=N;i++) 
      for (j=0;j<=N;j++) 
         for (k=0;k<=N;k++) 
            grid[i][j][k] = 0;

   a = 1 / 2.3;
   b = 1 / 2.0;

   for (i=0;i<=N;i++) {
      fprintf(stderr,"%d ",i);
      for (j=0;j<=N;j++) {
         for (k=0;k<=N;k++) {
            p.x = 5 * (i - N/2.0) / (float)N;
            p.y = 5 * (j - N/2.0) / (float)N;
            p.z = 5 * (k - N/2.0) / (float)N;
            da = pow(a*p.x,2.0) + pow(a*p.y,2.0) + pow(a*p.z,2.0);
            db = pow(b*p.x,8.0) + pow(b*p.y,8.0) + pow(b*p.z,8.0);
            if (da < 0.0001)
               da = 0.0001;
            v = 1 - 1.0/(da*da*da*da*da*da) - db*db*db*db*db*db; 
            if (v < -20)
               v = -20;
            if (v > 20)
               v = 20;
            grid[i][j][k] = v;
            vmin = MIN(vmin,v);
            vmax = MAX(vmax,v);
         }
      }
   }
   fprintf(stderr,"\nRange  = %g -> %g\n",vmin,vmax);

   /* Write the result */
   fvol = fopen("wiffle.vol","w");
   fprintf(fvol,"Wiffle cube\n");
   fprintf(fvol,"%d %d %d\n",N,N,N);
   fprintf(fvol,"1.0 1.0 1.0\n");
   fprintf(fvol,"0.0 0.0 0.0\n");
   fprintf(fvol,"16 1\n");
   for (k=0;k<N;k++) {
      for (j=0;j<N;j++) {
         for (i=0;i<N;i++) {
            si = (short int)(10000*(grid[i][j][k]-vmin)/(vmax-vmin));
            fwrite(&si,sizeof(short int),1,fvol);
         }
      }
   }
   fclose(fvol);

   /* Create some images */
   image = CreateBitmap(N+1,N+1);
   for (k=0;k<=N/2;k+=10) {
      for (i=0;i<=N;i++) {
         for (j=0;j<=N;j++) {
            colour = GetColour(grid[i][j][k],vmin,vmax,1);
            c.r = colour.r * 255;
            c.g = colour.g * 255; 
            c.b = colour.b * 255; 
            DrawPixel(image,N+1,N+1,i,j,c);
         }
      }
      sprintf(fname,"%03d.tga",k);
      fptr = fopen(fname,"w");
      WriteBitmap(fptr,image,N+1,N+1,12);
      fclose(fptr);
   }
}

