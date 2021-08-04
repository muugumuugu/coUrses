#include "stdio.h"
#include "stdlib.h"
#include "math.h"

/*
   Create N points on a sphere aproximately equi-distant from each other
   Basically, N points are randomly placed on the sphere and then moved
   around until then moved around until the minimal distance between the
   closed two points is minimaised.
   Paul Bourke, July 1996
*/

#define ABS(x) (x < 0 ? -(x) : (x))

typedef struct {
  double x,y,z;
} XYZ;

void Normalise(XYZ *,double);
double Distance(XYZ,XYZ);

/*
   Called with three arguments, the number of points to distribute, the
   radius of the sphere, and the maximum number of iterations to perform.
*/
int main(argc,argv)
int argc;
char **argv;
{
   int i,j,n;
   int counter = 0,countmax = 100;
   int minp1,minp2;
   double r,d,mind,maxd;
   XYZ p[1000],p1,p2;

   /* Check we have the right number of arguments */
   if (argc < 4) {
      fprintf(stderr,"Usage: %s npoints radius niterations\n",argv[0]);
      exit(0);
   }
   if ((n = atoi(argv[1])) < 2)
      n = 3;
   if ((r = atof(argv[2])) < 0.001)
      r = 0.001;
   if ((countmax = atoi(argv[3])) < 100)
      countmax = 100;

   /* Create the initial random cloud */
   for (i=0;i<n;i++) {
       p[i].x = (rand()%1000)-500;
       p[i].y = (rand()%1000)-500;
       p[i].z = (rand()%1000)-500;
       Normalise(&p[i],r);
    }

    while (counter < countmax) {

        /* Find the closest two points */
        minp1 = 0;
        minp2 = 1;
        mind = Distance(p[minp1],p[minp2]);
        maxd = mind;
        for (i=0;i<n-1;i++) {
            for (j=i+1;j<n;j++) {
                if ((d = Distance(p[i],p[j])) < mind) {
                   mind = d;
                   minp1 = i;
                   minp2 = j;
                }
                if (d > maxd)
                   maxd = d;
            }
        }

        /*
           Move the two minimal points apart, in this case by 1%
           but should really vary this for refinement
        */
        p1 = p[minp1];
        p2 = p[minp2];
        p[minp2].x = p1.x + 1.01 * (p2.x - p1.x);
        p[minp2].y = p1.y + 1.01 * (p2.y - p1.y);
        p[minp2].z = p1.z + 1.01 * (p2.z - p1.z);
        p[minp1].x = p1.x - 0.01 * (p2.x - p1.x);
        p[minp1].y = p1.y - 0.01 * (p2.y - p1.y);
        p[minp1].z = p1.z - 0.01 * (p2.z - p1.z);
        Normalise(&p[minp1],r);
        Normalise(&p[minp2],r);

        counter++;
    }

    /* Write out the points in your favorite format */

}

void Normalise(p,r)
XYZ *p;
double r;
{
   double l;

   l = r / sqrt(p->x*p->x + p->y*p->y + p->z*p->z);
   p->x *= l;
   p->y *= l;
   p->z *= l;
}

double Distance(p1,p2)
XYZ p1,p2;
{
   XYZ p;

   p.x = p1.x - p2.x;
   p.y = p1.y - p2.y;
   p.z = p1.z - p2.z;
   return(sqrt(p.x*p.x + p.y*p.y + p.z*p.z));
}

