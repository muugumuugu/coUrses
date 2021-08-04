#include "stdio.h"
#include "math.h"
#include "stdlib.h"

#define TWOPI           6.283185307179586476925287
#define PI              3.141592653589793238462643

double sech(double);

int main(int argc,char **argv)
{
   int i,j;
   int n = 100;
   double theta1,theta2;
   double phi1,phi2;
   double x,y,z;
   FILE *fptr;

   fptr = fopen("surf1a.geom","w");
   for (i=0;i<n;i++) {
      theta1 = -PI + TWOPI * i / (double)n;
      theta2 = -PI + TWOPI * (i+1) / (double)n;
   
      for (j=0;j<2*n;j++) {
         phi1 = -TWOPI + 2 * TWOPI * j / (2.0*n); 
         phi2 = -TWOPI + 2 * TWOPI * (j+1) / (2.0*n);

         fprintf(fptr,"f4 ");
         x = phi1-tanh(phi1);
         y = sech(phi1)*sin(theta1);
         z = sech(phi1)*cos(theta1);
         fprintf(fptr,"%g %g %g ",x,y,z);
         x = phi1-tanh(phi1);
         y = sech(phi1)*sin(theta2);
         z = sech(phi1)*cos(theta2);
         fprintf(fptr,"%g %g %g ",x,y,z);
         x = phi2-tanh(phi2);
         y = sech(phi2)*sin(theta2);
         z = sech(phi2)*cos(theta2);
         fprintf(fptr,"%g %g %g ",x,y,z);
         x = phi2-tanh(phi2);
         y = sech(phi2)*sin(theta1);
         z = sech(phi2)*cos(theta1);
         fprintf(fptr,"%g %g %g ",x,y,z);
         fprintf(fptr,"1 0 0\n");
      }
   }
   fclose(fptr);

   fptr = fopen("surf1b.geom","w");
   for (i=0;i<n;i++) {
      theta1 = -PI + TWOPI * i / (double)n;
      theta2 = -PI + TWOPI * (i+1) / (double)n;

      for (j=0;j<2*n;j++) {
         phi1 = -TWOPI + 2 * TWOPI * j / (2.0*n);
         phi2 = -TWOPI + 2 * TWOPI * (j+1) / (2.0*n);

         fprintf(fptr,"f4 ");
         x = (phi1 - tanh(phi1)) / (phi1*phi1 - 2 * tanh(phi1) + 1); 
         y = -sech(phi1) * sin(theta1) / (phi1*phi1 - 2 * tanh(phi1) + 1);
         z = -sech(phi1) * cos(theta1) / (phi1*phi1 - 2 * tanh(phi1) + 1);
         fprintf(fptr,"%g %g %g ",x,y,z);
         x = (phi1 - tanh(phi1)) / (phi1*phi1 - 2 * tanh(phi1) + 1);
         y = -sech(phi1) * sin(theta2) / (phi1*phi1 - 2 * tanh(phi1) + 1);
         z = -sech(phi1) * cos(theta2) / (phi1*phi1 - 2 * tanh(phi1) + 1);
         fprintf(fptr,"%g %g %g ",x,y,z);
         x = (phi2 - tanh(phi2)) / (phi2*phi2 - 2 * tanh(phi2) + 1);
         y = -sech(phi2) * sin(theta2) / (phi2*phi2 - 2 * tanh(phi2) + 1);
         z = -sech(phi2) * cos(theta2) / (phi2*phi2 - 2 * tanh(phi2) + 1);
         fprintf(fptr,"%g %g %g ",x,y,z);
         x = (phi2 - tanh(phi2)) / (phi2*phi2 - 2 * tanh(phi2) + 1);
         y = -sech(phi2) * sin(theta1) / (phi2*phi2 - 2 * tanh(phi2) + 1);
         z = -sech(phi2) * cos(theta1) / (phi2*phi2 - 2 * tanh(phi2) + 1);
         fprintf(fptr,"%g %g %g ",x,y,z);
         fprintf(fptr,"0 0 1\n");
      }
   }

}

double sech(double d)
{
    return(1.0 / cosh(d));
}
