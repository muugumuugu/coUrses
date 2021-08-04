#include "paulslib.h"

/* Crappy code to test triangulation */

int XYZCompare(void *,void *);

int main(int argc,char **argv)
{
   int i;
   int ntri = 0;
   double x,y,z;
   ITRIANGLE *v;
   XYZ *p = NULL;
   int nv = 0;
   FILE *fptr;
   
   if (argc < 2) {
      fprintf(stderr,"usage: %s datafile\n",argv[0]);
      exit(-1);
   }
   if ((fptr = fopen(argv[1],"r")) == NULL) {
      fprintf(stderr,"Failed to open file \"%s\"\n",argv[1]);
      exit(-1);
   }
   while (fscanf(fptr,"%lf %lf %lf",&x,&y,&z) == 3) {
      p = realloc(p,(nv+1)*sizeof(XYZ));
      p[nv].x = x;
      p[nv].y = y;
      p[nv].z = z;
      nv++;
   }
   fprintf(stderr,"Read %d points\n",nv);
   if (nv < 3)
      exit(-1);
   fclose(fptr);

   p = realloc(p,(nv+3)*sizeof(XYZ));
   v = malloc(3*nv*sizeof(TRIANGLE));
   qsort(p,nv,sizeof(XYZ),XYZCompare);
   Triangulate(nv,p,v,&ntri);
   fprintf(stderr,"Formed %d triangles\n",ntri);

   /* Write triangles in geom format */
   for (i=0;i<ntri;i++) {
      printf("f3 %g %g %g %g %g %g %g %g %g 1 1 1\n",
         p[v[i].p1].x,p[v[i].p1].y,p[v[i].p1].z,
         p[v[i].p2].x,p[v[i].p2].y,p[v[i].p2].z,
         p[v[i].p3].x,p[v[i].p3].y,p[v[i].p3].z);
   }
   exit(0);
}

int XYZCompare(void *v1,void *v2)
{
   XYZ *p1,*p2;
   p1 = v1;
   p2 = v2;
   if (p1->x < p2->x)
      return(-1);
   else if (p1->x > p2->x)
      return(1);
   else 
      return(0); 
}       

