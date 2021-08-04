#include "stdio.h"
#include "stdlib.h"
#include "math.h"

typedef struct {
   double x,y,z;
} XYZ;

#define N 10
XYZ q[N] = {1,1,0,    1,-1,0,  -1,1,0,   -1,-1,0,   0,0,1,
            0,0,-1,   1,0,0,   -1,0,0,    0,1,0,    0,-1,0};

#define ITER 1000000
#define RADIUS 0.002

int main(int argc,char **argv)
{
   int i,j;
   double r;
   XYZ p,plast={0,0,0};

   r = sqrt(N-1.0);

   for (i=0;i<ITER+10;i++) {
      j = random() % 10;
      p.x = plast.x / r + q[j].x;
      p.y = plast.y / r + q[j].y;
      p.z = plast.z / r + q[j].z;
      if (i >= 10)
         printf("SPHERE CENTER %g %g %g RAD %g themat\n",p.x,p.y,p.z,RADIUS);
      plast = p;
   }
}
