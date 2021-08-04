#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include <time.h>

/*
   Demonstration code to illustrate and check the solution
   to finding the center and radius of a sphere given 4 points
   on the sphere.
   A sphere center and radius are chosen randomly, then four
   random points on that sphere are generated, the original
   center and radius are then computed from the 4 points.
*/

#define TWOPI           6.283185307179586476925287
#define PI              3.141592653589793238462643
#define PID2            1.570796326794896619231322

typedef struct {
   double x,y,z;
} XYZ;
double Determinant(double **,int);

int main(int argc,char **argv)
{
   int i;
   time_t seed;
   double r,theta,phi;
   XYZ c,p[4];
   double **a=NULL,m11,m12,m13,m14,m15;

   /* Create a known test sphere */
   time(&seed);
   fprintf(stderr,"Seed: %d\n",seed);
   srand48((long)seed);
   r = drand48() * 5;
   c.x = (drand48() - 0.5) * 10;
   c.y = (drand48() - 0.5) * 10;
   c.z = (drand48() - 0.5) * 10;
   fprintf(stderr,"Sphere: (%g,%g,%g), %g\n",c.x,c.y,c.z,r);

   /* Create 4 random points on the surface */
   for (i=0;i<4;i++) {
      theta = drand48() * TWOPI;
      phi = drand48() * PI - PID2;
      p[i].x = c.x + r * cos(phi) * sin(theta);
      p[i].y = c.y + r * cos(phi) * cos(theta);
      p[i].z = c.z + r * sin(phi);
   }

   /* Malloc the array for the minor arrays */
   a = malloc(4*sizeof(double *));
   for (i=0;i<4;i++)
      a[i] = malloc(4*sizeof(double));

   /* Find determinant M11 */
   for (i=0;i<4;i++) {
      a[i][0] = p[i].x;
      a[i][1] = p[i].y;
      a[i][2] = p[i].z;
      a[i][3] = 1;
   }
   m11 = Determinant(a,4);

   /* Find determinant M12 */    
   for (i=0;i<4;i++) {
      a[i][0] = p[i].x*p[i].x + p[i].y*p[i].y + p[i].z*p[i].z;
      a[i][1] = p[i].y;
      a[i][2] = p[i].z;
      a[i][3] = 1;
   }
   m12 = Determinant(a,4);

   /* Find determinant M13 */    
   for (i=0;i<4;i++) {
      a[i][0] = p[i].x;
      a[i][1] = p[i].x*p[i].x + p[i].y*p[i].y + p[i].z*p[i].z;
      a[i][2] = p[i].z;
      a[i][3] = 1;
   }
   m13 = Determinant(a,4);

   /* Find determinant M14 */    
   for (i=0;i<4;i++) {
      a[i][0] = p[i].x;
      a[i][1] = p[i].y;
      a[i][2] = p[i].x*p[i].x + p[i].y*p[i].y + p[i].z*p[i].z;
      a[i][3] = 1;
   }
   m14 = Determinant(a,4);

   /* Find determinant M15 */    
   for (i=0;i<4;i++) {
      a[i][0] = p[i].x*p[i].x + p[i].y*p[i].y + p[i].z*p[i].z;
      a[i][1] = p[i].x;
      a[i][2] = p[i].y;
      a[i][3] = p[i].z;
   }
   m15 = Determinant(a,4);

   fprintf(stderr,"Determinants: %g %g %g %g %g\n",m11,m12,m13,m14,m15);
   if (m11 == 0) {
      fprintf(stderr,"The points don't define a sphere!\n");
      exit(-1);
   }

   c.x = 0.5 * m12 / m11;
   c.y = 0.5 * m13 / m11;
   c.z = 0.5 * m14 / m11;
   r = sqrt(c.x*c.x + c.y*c.y + c.z*c.z - m15/m11);
   fprintf(stderr,"Sphere: (%g,%g,%g), %g\n",c.x,c.y,c.z,r); 

   for (i=0;i<4;i++) 
		free(a[i]);
   free(a);
	exit(0);
}

/*
   Recursive definition of determinate using expansion by minors.
*/
double Determinant(double **a,int n)
{
   int i,j,j1,j2;
   double det = 0;
   double **m = NULL;

   if (n < 1) { /* Error */

   } else if (n == 1) { /* Shouldn't get used */
      det = a[0][0];
   } else if (n == 2) {
      det = a[0][0] * a[1][1] - a[1][0] * a[0][1];
   } else {
      det = 0;
      for (j1=0;j1<n;j1++) {
         m = malloc((n-1)*sizeof(double *));
         for (i=0;i<n-1;i++)
            m[i] = malloc((n-1)*sizeof(double));
         for (i=1;i<n;i++) {
            j2 = 0;
            for (j=0;j<n;j++) {
               if (j == j1)
                  continue;
               m[i-1][j2] = a[i][j];
               j2++;
            }
         }
         det += pow(-1.0,1.0+j1+1.0) * a[0][j1] * Determinant(m,n-1);
         for (i=0;i<n-1;i++)
            free(m[i]);
         free(m);
      }
   }
   return(det);
}

