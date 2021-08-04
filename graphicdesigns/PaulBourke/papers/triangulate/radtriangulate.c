/*
TRIANGULATE

Triangulate takes a file containing a random distribution of x y z
points and creates a facet gridded representation of the surface
at a user specified resolution. The grid is generated over the complex
hull of the spot heights.

This is an implementation of the original program that run on the Macintosh
and supports a number of export formats. This version acts like a generator
for the Radiance program.

Call as: 
   triangulate mat name xyzfile xcells ycells [zscale]
where
   mat      the material name for the surface
   name     the base name for the surface elements
   xyzfile  the file of spot heights arranged as x y z values
   xcells   the resolution of the gridded mesh in the x direction
   ycells   the resolution of the gridded mesh in the y direction
   zscale   height scaling
The Radiance description of the surface is written to standard output.

*/
#include "stdio.h"
#include "stdlib.h"
#include "math.h"

#define DTOR 0.01745329252
#define ABS(x) ( (x) < 0 ? -(x) : (x) )
#define MIN(x,y) ( x < y ? x : y )
#define MAX(x,y) ( x < y ? y : x )
#define MODULUS(p) (sqrt((p).x * (p).x + (p).y * (p).y + (p).z * (p).z) )
#define SIGN(x) ( x < 0 ? -1 : 1 )
#define DOTPRODUCT(v1,v2) ( v1.x*v2.x + v1.y*v2.y + v1.z*v2.z )
#define INVERTVECTOR(p1) p1.x = -p1.x; p1.y = -p1.y; p1.z = -p1.z
#define CROSSPROD(p1,p2,p3) p3.x = p1.y*p2.z - p1.z*p2.y;p3.y = p1.z*p2.x - p1.x*p2.z;p3.z = p1.x*p2.y - p1.y*p2.x

#define FALSE 0
#define TRUE 1

#define EPSILON         0.0001     /* small float for vertex closeness  */
#define INFINITY        1.0E10     /* representation of infinity        */

typedef struct {
  double x,y,z;
} XYZ;

typedef struct TRIANGLE {
  short p1,p2,p3;
} TRIANGLE;

typedef struct EDGE {
  short p1,p2;
} EDGE;

typedef struct {
  double a,b,c,d;
} PLANE;

/* Prototypes */
void randomsamples(void);
int gettriangulation(void);
void triangulate(int,XYZ *,TRIANGLE *,int *);
int intriang(double,double,XYZ,XYZ,XYZ);
double planepoint(double,double,XYZ,XYZ,XYZ);
int circumcircle(double,double,double,double,double,double,double,double,double *,double *,double *);
int whichside(double,double,double,double,double,double);
void WriteFace(XYZ *);

/* The maximum number of edges in the edge list */
#define EMAX 200
int trimax = 200;

/* Command line arguments */
char material[255];
char name[255];
char filename[255];
FILE *fptr;
int xcells=10;
int ycells=10;
double zscale = 1;

int main(argc,argv)
int argc;
char **argv;
{
  int i;

  /* Are there enough arguments */
  if (argc < 6) {
    fprintf(stderr,"TRIANGULATE - Insufficient number of arguments\n");
    fprintf(stderr,"Call as :\n");
    fprintf(stderr,"   triangulate mat name xyzfile xcells ycells [zscale]\n");
    exit(0);
  }

  /* Echo command line as a Radiance comment */
  printf("# ");
  for (i=0;i<argc;i++)
    printf("%s ",argv[i]);
  printf("\n");

  /* Get and check the arguments */
  strcpy(material,argv[1]);
  strcpy(name,argv[2]);
  strcpy(filename,argv[3]);
  if ((fptr = fopen(filename,"r")) == NULL) {
    fprintf(stderr,"TRIANGULATE - Unable to open data file\n");
    exit(0);
  }
  fclose(fptr);
  if ((xcells = atoi(argv[4])) <= 3) {
    fprintf(stderr,"TRIANGULATE - number of x direction cells must be > 3\n");
    xcells = 3;
  }
  if ((ycells = atoi(argv[5])) <= 3) {
    fprintf(stderr, "TRIANGULATE - number of y direction cells must be > 3\n");
    ycells = 3;
  }

  /* Is the optional z scaling supplied, default value is 1 */
  if (argc > 6) {
    zscale = atof(argv[6]);
  }

  randomsamples();
}

/*****************************************************************************
   Control the overall triangulation process
*/
void randomsamples(void)
{
   int i,j,k,nv,ntri,found[4],corner,duplicate;
   double x,y,z,xmin,xmax,ymin,ymax,zmin,zmax,dx,dy;
   double xp,yp,xp1,yp1;
   XYZ ptemp,p[5],p1,p2,p3;
	
   XYZ *pxyz;
   TRIANGLE *v;
	
   /* Read the number of samples (lines) */
   fptr = fopen(filename,"r");
   nv = 0;
   while (fscanf(fptr,"%lf %lf %lf\n",&x,&y,&z) == 3)
      nv++;
   printf("# TRIANGULATE found %d vertices in sample file\n",nv);
   fclose(fptr);
	
   /* Must be 3 or more vertices */
   if (nv < 3) {
      fprintf(stderr,"TRIANGULATE - Insufficient data points\n");
      return;
   }
	
   /* Allocate any necessary memory */
   if ((pxyz = (XYZ *)malloc((nv+4)*(long)sizeof(XYZ))) == NULL) {
     fprintf(stderr,"TRIANGULATE - Unable to allocate enough memory\n");
     return;
   }
   trimax = 2 * (nv + 10);
   if ((v = (TRIANGLE *)malloc(trimax*(long)sizeof(TRIANGLE))) == NULL) {
      fprintf(stderr,"TRIANGULATE - Unable to allocate enough memory\n");
      free(pxyz);
      return;
   }
	
   /* Read coordinates while computing the bounds */
   fptr = fopen(filename,"r");
   nv = 0;
   xmin =   INFINITY;	xmax = - INFINITY;
   ymin =   INFINITY;	ymax = - INFINITY;
   zmin =   INFINITY;	zmax = - INFINITY;
   while (fscanf(fptr,"%lf %lf %lf\n",&x,&y,&z) == 3) {
      pxyz[nv+1].x = x;
      pxyz[nv+1].y = y;
      pxyz[nv+1].z = z;
      nv++;
      xmin = MIN(xmin,x);	xmax = MAX(xmax,x);
      ymin = MIN(ymin,y);	ymax = MAX(ymax,y);
      zmin = MIN(zmin,z);	zmax = MAX(zmax,z);
   }
   fclose(fptr);
   printf("# TRIANGULATE sample bounds\n");
   printf("#   X range %g -> %g\n",xmin,xmax);
   printf("#   Y range %g -> %g\n",ymin,ymax);
   printf("#   Z range %g -> %g\n",zmin*zscale,zmax*zscale);
	
   /* Sort the samples in x */
   for (i=1;i<nv;i++) {
      for (j=i+1;j<=nv;j++) {
         if (pxyz[j].x < pxyz[i].x) {
       	    ptemp   = pxyz[i];
            pxyz[i] = pxyz[j];
            pxyz[j] = ptemp;
         }
      }
   }

   /* Check for coincident values */
   duplicate = 0;
   for (i=1;i<nv;i++) {
      for (j=i+1;j<=nv;j++) {
         if (pxyz[j].x == pxyz[i].x) {
       	    if (pxyz[j].y == pxyz[i].y) {
               duplicate++;
	       pxyz[i] = pxyz[nv];
	       nv--;
	    }
	 }
      }
   }
   if (duplicate > 0)
      printf("# TRIANGULATE found %d duplicate points\n",duplicate);

   /* Do the tirangulation */
   triangulate(nv,pxyz,v,&ntri);
   
   dx = (xmax - xmin) / xcells;
   dy = (ymax - ymin) / ycells;
		
   for (j=0;j<=ycells;j++) {
			
      p[0].y = ymin + j * dy;
      p[1].y = p[0].y;
      p[2].y = p[0].y + dy;
      p[3].y = p[2].y;
	  	
      for (i=0;i<=xcells;i++) {
          p[0].x = xmin + i * dx;
          p[1].x = p[0].x + dx;
    	  p[2].x = p[1].x;
	  p[3].x = p[0].x;
	       		
          for (corner=0;corner<4;corner++) {
              found[corner] = FALSE;
	      for (k=1;k<=ntri;k++) {
	     	  p1 = pxyz[v[k].p1];
	       	  p2 = pxyz[v[k].p2];
	       	  p3 = pxyz[v[k].p3];
	       	  if (intriang(p[corner].x,p[corner].y,p1,p2,p3)) {
	       	    p[corner].z = planepoint(p[corner].x,p[corner].y,p1,p2,p3);
	       	    found[corner] = TRUE;
	       	    break;
	       	  }
	      }
	   }
	       		
	   if (found[0] && found[1] && found[2] && found[3])
	       WriteFace(p);
       }
   }

   free(v);
   free(pxyz);
}

/*****************************************************************************
	Triangulation subroutine
	
	Takes as input NV vertices in array pxyz
	Returned is a list of ntri triangular faces in the array v
	These triangles are arranged in clockwise order.
*/
void triangulate(nv,pxyz,v,ntri)
int nv;
XYZ *pxyz;
TRIANGLE *v;
int *ntri;
{
	int *complete;
	EDGE *edges;
	int nedge;
	
	int inside;
	int i,j,k;
	double xp,yp,x1,y1,x2,y2,x3,y3,xc,yc,r;
	double xmin,xmax,ymin,ymax,xmid,ymid;
	double dx,dy,dmax;
	
	/* Allocate memory for the edge list */
	if ((edges = (EDGE *)malloc(EMAX*(long)sizeof(EDGE))) == NULL) {
	   fprintf(stderr,"TRIANGULATE - unable to allocate enough memory\n");
	   return;
	}
	
	/* Allocate memory for the completeness list, flag for each triangle */
	if ((complete = (int *)malloc(trimax*(long)sizeof(int))) == NULL) {
	   fprintf(stderr,"TRIANGULATE - unable to allocate enough memory\n");
	   free(edges);
	   exit(0);
	}
	
	/*
	   Find the maximum and minimum vertex bounds.
	   This is to allow calculation of the bounding triangle
	*/
	xmin = pxyz[1].x;
	ymin = pxyz[1].y;
	xmax = xmin;
	ymax = ymin;
	for (i=2;i<=nv;i++) {
	   if (pxyz[i].x < xmin) xmin = pxyz[i].x;
	   if (pxyz[i].x > xmax) xmax = pxyz[i].x;
	   if (pxyz[i].y < ymin) ymin = pxyz[i].y;
	   if (pxyz[i].y > ymax) ymax = pxyz[i].y;
	}
	dx = xmax - xmin;
	dy = ymax - ymin;
	dmax = (dx > dy) ? dx : dy;
	xmid = (xmax + xmin) / 2.0;
	ymid = (ymax + ymin) / 2.0;
	
	/*
	   Set up the supertriangle
	   This is a triangle which encompasses all the sample points.
	   The supertriangle coordinates are added to the end of the 
	   vertex list. The supertriangle is the first triangle in
	   the triangle list.
	*/
	pxyz[nv + 1].x = xmid - 20 * dmax;
	pxyz[nv + 1].y = ymid - dmax;
	pxyz[nv + 1].z = 0.0;
	pxyz[nv + 2].x = xmid;
	pxyz[nv + 2].y = ymid + 20 * dmax;
	pxyz[nv + 2].z = 0.0;
	pxyz[nv + 3].x = xmid + 20 * dmax;
	pxyz[nv + 3].y = ymid - dmax;
	pxyz[nv + 3].z = 0.0;
	v[1].p1 = nv + 1;
	v[1].p2 = nv + 2;
	v[1].p3 = nv + 3;
	complete[1] = FALSE;
	*ntri = 1;

	/*
	   Include each point one at a time into the existing mesh
	*/
	for (i=1;i<=nv;i++) {
		
	   xp = pxyz[i].x;
	   yp = pxyz[i].y;
	   nedge = 0;

	   /*
	      Set up the edge buffer. 
       	      If the point (xp,yp) lies inside the circumcircle then the
	      three edges of that triangle are added to the edge buffer
	      and that triangle is removed.
	   */
	   j = 0;
	   do {
	      j++;
	      if (!complete[j]) {
	         x1 = pxyz[v[j].p1].x;
	         y1 = pxyz[v[j].p1].y;
	         x2 = pxyz[v[j].p2].x;
	         y2 = pxyz[v[j].p2].y;
	         x3 = pxyz[v[j].p3].x;
	         y3 = pxyz[v[j].p3].y;
	         inside = circumcircle(xp,yp,x1,y1,x2,y2,x3,y3,&xc,&yc,&r);
	         if (xc + r < xp)
	       	    complete[j] = TRUE;
	            if (inside) {
	               /* Check that we haven't exceeded the edge list size */
		       if (nedge+3 > EMAX) {
	     	          fprintf(stderr,"TRIANGULATE - Internal edge list exceeded\n");
              	       	  exit(0);
       	       	       }
		       edges[nedge+1].p1 = v[j].p1;
		       edges[nedge+1].p2 = v[j].p2;
		       edges[nedge+2].p1 = v[j].p2;
		       edges[nedge+2].p2 = v[j].p3;
		       edges[nedge+3].p1 = v[j].p3;
		       edges[nedge+3].p2 = v[j].p1;
		       nedge += 3;
		       v[j] = v[*ntri];
		       complete[j] = complete[*ntri];
		       j--;
		       (*ntri)--;
		    }
 		}
	    } while (j < *ntri);

	    /*
	        Tag multiple edges
	        Note: if all triangles are specified anticlockwise then all
	              interior edges are opposite pointing in direction.
	    */
	    for (j=1;j<nedge;j++) {
	        for (k=j+1;k<=nedge;k++) {
	       	   if ((edges[j].p1 == edges[k].p2) && (edges[j].p2 == edges[k].p1)) {
		      edges[j].p1 = 0;	
		      edges[j].p2 = 0;
		      edges[k].p1 = 0;	
		      edges[k].p2 = 0;
		   }
		   /* Shouldn't need the following, see note above */
		   if ((edges[j].p1 == edges[k].p1) && (edges[j].p2 == edges[k].p2)) {
		      edges[j].p1 = 0;	
		      edges[j].p2 = 0;
		      edges[k].p1 = 0;	
		      edges[k].p2 = 0;
		   }
		}  
	    }

	    /*
	       Form new triangles for the current point
	       Skipping over any tagged edges.
	       All edges are arranged in clockwise order.
	    */
	    for (j=1;j<=nedge;j++) {
	       if (edges[j].p1 != 0 && edges[j].p2 != 0) {
	          if (*ntri > trimax) {
		     fprintf(stderr,"TRIANGULATE - %d triangles exceeds maximum\n",*ntri);
	             exit(0);
		  }
		  (*ntri)++;
		  v[*ntri].p1 = edges[j].p1;
		  v[*ntri].p2 = edges[j].p2;
		  v[*ntri].p3 = i;
		  complete[*ntri] = FALSE;
	       }
	   }
       }

       /*
	   Remove triangles with supertriangle vertices
	   These are triangles which have a vertex number greater than nv
       */
       i = 0;
       do {
	   i++;
	   if ((v[i].p1 > nv) || (v[i].p2 > nv) || (v[i].p3 > nv)) {
	       v[i] = v[*ntri];
	       i--;
	       (*ntri)--;
	   }
	} while (i < *ntri);
	
        free(edges);
	free(complete);
}

/*****************************************************************************
	Return TRUE if a point (xp,yp) is inside the circumcircle made up
	of the points (x1,y1), (x2,y2), (x3,y3)
	The circumcircle centre is returned in (xc,yc) and the radius r
	NOTE: A point on the edge is inside the circumcircle
*/
int circumcircle(xp,yp,x1,y1,x2,y2,x3,y3,xc,yc,r)
double xp,yp,x1,y1,x2,y2,x3,y3;
double *xc,*yc;
double *r;
{
   double m1,m2,mx1,mx2,my1,my2;
   double dx,dy,rsqr,drsqr;

   if (ABS(y1-y2) < EPSILON && ABS(y2-y3) < EPSILON) {
       fprintf(stderr,"TRIANGULATE - Coincident points\n");
       return(FALSE);
   }

   if (ABS(y2-y1) < EPSILON) {
       	m2 = - (x3-x2) / (y3-y2);
       	mx2 = (x2 + x3) / 2.0;
       	my2 = (y2 + y3) / 2.0;
       	*xc = (x2 + x1) / 2.0;
       	*yc = m2 * (*xc - mx2) + my2;
    } else if (ABS(y3-y2) < EPSILON) {
       	m1 = - (x2-x1) / (y2-y1);
       	mx1 = (x1 + x2) / 2.0;
       	my1 = (y1 + y2) / 2.0;
       	*xc = (x3 + x2) / 2.0;
       	*yc = m1 * (*xc - mx1) + my1;
    } else {
       	m1 = - (x2-x1) / (y2-y1);
       	m2 = - (x3-x2) / (y3-y2);
       	mx1 = (x1 + x2) / 2.0;
       	mx2 = (x2 + x3) / 2.0;
       	my1 = (y1 + y2) / 2.0;
       	my2 = (y2 + y3) / 2.0;
       	*xc = (m1 * mx1 - m2 * mx2 + my2 - my1) / (m1 - m2);
       	*yc = m1 * (*xc - mx1) + my1;
    }
	
    dx = x2 - *xc;
    dy = y2 - *yc;
    rsqr = dx*dx + dy*dy;
    *r = sqrt(rsqr);

    dx = xp - *xc;
    dy = yp - *yc;
    drsqr = dx*dx + dy*dy;
	
    return((drsqr <= rsqr) ? TRUE : FALSE);
}

/*****************************************************************************
   Returns TRUE if the point (xp,yp) lies inside the projection triangle
   on the x-y plane with the vertices p1,p2,p3

   A point is in the centre if it is on the same side of all the edges
   or if it lies on one of the edges.
*/
int intriang(xp,yp,p1,p2,p3)
double xp,yp;
XYZ p1,p2,p3;
{
   int side1,side2,side3;

   side1 = whichside(xp,yp,p1.x,p1.y,p2.x,p2.y);
   side2 = whichside(xp,yp,p2.x,p2.y,p3.x,p3.y);
   side3 = whichside(xp,yp,p3.x,p3.y,p1.x,p1.y);
	
   if (side1 == 0 && side2 == 0)
      return(TRUE);
   if (side1 == 0 && side3 == 0)
      return(TRUE);
   if (side2 == 0 && side3 == 0)
      return(TRUE);

   if (side1 == 0 && (side2 == side3))
      return(TRUE);
   if (side2 == 0 && (side1 == side3))
      return(TRUE);
   if (side3 == 0 && (side1 == side2))
      return(TRUE);
	
   if ((side1 == side2) && (side2 == side3))
      return(TRUE);
		
   return(FALSE);
}

/*****************************************************************************
   Given a plane through the point p1,p2,p3 and a point on the x-y
   plane determine the intersection of the perpendicular.
*/
double planepoint(xp,yp,p1,p2,p3)
double xp,yp;
XYZ p1,p2,p3;
{
   double a,b,c,d;

   a = p1.y * (p2.z - p3.z) + p2.y * (p3.z - p1.z) + p3.y * (p1.z - p2.z);
   b = p1.z * (p2.x - p3.x) + p2.z * (p3.x - p1.x) + p3.z * (p1.x - p2.x);
   c = p1.x * (p2.y - p3.y) + p2.x * (p3.y - p1.y) + p3.x * (p1.y - p2.y);
   d = - p1.x * (p2.y * p3.z - p3.y * p2.z) 
       	- p2.x * (p3.y * p1.z - p1.y * p3.z) 
       	- p3.x * (p1.y * p2.z - p2.y * p1.z);
	
   if (ABS(c) > EPSILON)
      return(- (a * xp + b * yp + d) / c);
   else
      return(0.0);
}

/*****************************************************************************
   Determines which side of a line the point (x,y) lies.
   The line goes from (x1,y1) to (x2,y2)

   Return codes are 	-1 for points to the left
		      	 0 for points on the line
		       	+1 for points to the right
*/
int whichside(x,y,x1,y1,x2,y2)
double x,y,x1,y1,x2,y2;
{
    double dist;

    dist = (y - y1) * (x2 - x1) - (y2 - y1) * (x - x1);
    if (dist > 0)
       return(-1);
    else if (dist < 0)
       return(1);
    else
       return(0);
}

void WriteFace(p)
XYZ *p;
{
  static long npoly = 0;
	
  printf("%s polygon %s.%ld\n0\n0\n9 ",material,name,npoly);
  printf("\t%f %f %f\n",p[1].x,p[1].y,p[1].z*zscale);
  printf("\t%f %f %f\n",p[0].x,p[0].y,p[0].z*zscale);
  printf("\t%f %f %f\n",p[2].x,p[2].y,p[2].z*zscale);
  npoly++;
  printf("%s polygon %s.%ld\n0\n0\n9 ",material,name,npoly);
  printf("\t%f %f %f\n",p[3].x,p[3].y,p[3].z*zscale);
  printf("\t%f %f %f\n",p[2].x,p[2].y,p[2].z*zscale);
  printf("\t%f %f %f\n",p[0].x,p[0].y,p[0].z*zscale);
  npoly++;
}
