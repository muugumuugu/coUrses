#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "paulslib.h"

/*
	Create a capsule as an obj file = cylinder + two spherical caps
	ps: Designed to illustrate/verify the apporach, not good coding practices.
*/

int N = 32; // Mesh resolution
double radius = 1;
double height = 2;

typedef struct {
   double x,y,z;
	double nx,ny,nz;
   double u,v;
} MESHVERTEX;

int main(int argc,char **argv)
{
	int i,j,index = 0;
	int i1,i2,i3,i4;
	double theta,phi;
	MESHVERTEX *p = NULL,n;
	double len;
	FILE *fptr;

	if (argc < 4) {
		fprintf(stderr,"Usage: %s res radius height\n",argv[0]);
		exit(-1);
	}
	N = atoi(argv[1]);
	radius = atof(argv[2]);
	height = atof(argv[3]);

	// Create data
   if ((p = malloc((N+1)*(N/2+2)*sizeof(MESHVERTEX))) == NULL) {
      fprintf(stderr,"malloc failed\n");
      exit(-1);
   }
	for (j=0;j<=N/4;j++) { // top cap
		for (i=0;i<=N;i++) {
			theta = i * TWOPI / N;
			phi = -PID2 + PI * j / (N/2);
			p[index].x = radius * cos(phi) * cos(theta);
			p[index].y = radius * cos(phi) * sin(theta);
			p[index].z = radius * sin(phi);
			p[index].nx = p[index].x;
   	   p[index].ny = p[index].y;
   	   p[index].nz = p[index].z;
			p[index].z -= height/2;
			index++;
		}
	}
  	for (j=N/4;j<=N/2;j++) { // bottom cap
		for (i=0;i<=N;i++) {
			theta = i * TWOPI / N;
			phi = -PID2 + PI * j / (N/2);
   	   p[index].x = radius * cos(phi) * cos(theta);
   	   p[index].y = radius * cos(phi) * sin(theta);
   	   p[index].z = radius * sin(phi);
   	   p[index].nx = p[index].x;
   	   p[index].ny = p[index].y;
   	   p[index].nz = p[index].z;
			p[index].z += height/2;
   	   index++;
		}
   }
	if (index != (N+1)*(N/2+2)) {
		fprintf(stderr,"Unexpeced number of vertices, %d != %d\n",index,(N+1)*(N/2+2));
		exit(-1);
	}
	
	// Calculate texture coordinates
	for (i=0;i<index;i++) {
      p[i].u = atan2(p[i].y,p[i].x) / TWOPI;
      if (p[i].u < 0)
         p[i].u = 1 + p[i].u;
      p[i].v = 0.5 + atan2(p[i].z,sqrt(p[i].x*p[i].x+p[i].y*p[i].y)) / PI;
	}

	// Save as textured obj file
	fptr = fopen("capsule.obj","w");
	fprintf(fptr,"mtllib capsule.mtl\n");
	// Vertices
   for (i=0;i<index;i++) 
		fprintf(fptr,"v %lf %lf %lf\n",p[i].x,p[i].y,p[i].z);
	// Normals (same as vertices in this case but normalised)
   for (i=0;i<index;i++) {
      n = p[i];
      len = sqrt(n.x*n.x + n.y*n.y + n.z*n.z);
      fprintf(fptr,"vn %lf %lf %lf\n",n.x/len,n.y/len,n.z/len);
   }
	// Texture coordinates
	for (i=0;i<index;i++) 
		fprintf(fptr,"vt %lf %lf\n",p[i].u,p[i].v);
	// Faces, each a triangle
	fprintf(fptr,"usemtl material0\n");
	for (j=0;j<=N/2;j++) {
		for (i=0;i<N;i++) {
         i1 =  j    * (N+1) + i       + 1;
         i2 =  j    * (N+1) + (i + 1) + 1;
         i3 = (j+1) * (N+1) + (i + 1) + 1;
         i4 = (j+1) * (N+1) + i       + 1;
         fprintf(fptr,"f %d/%d/%d %d/%d/%d %d/%d/%d\n",i1,i1,i1,i2,i2,i2,i3,i3,i3);
         fprintf(fptr,"f %d/%d/%d %d/%d/%d %d/%d/%d\n",i1,i1,i1,i3,i3,i3,i4,i4,i4);
		}
	}
	fclose(fptr);

   // Create placeholder material file
   fptr = fopen("capsule.mtl","w");
   fprintf(fptr,"# Create as many materials as desired\n");
   fprintf(fptr,"# Each is referenced by name before the faces it applies to in the obj file\n");
   fprintf(fptr,"\n");
   for (i=0;i<2;i++) {
      fprintf(fptr,"newmtl material%d\n",i);
      fprintf(fptr,"Ka 1.000000 1.000000 1.000000\n");
      fprintf(fptr,"Kd 1.000000 1.000000 1.000000\n");
      fprintf(fptr,"Ks 0.000000 0.000000 0.000000\n");
      fprintf(fptr,"Tr 1.000000\n");
      fprintf(fptr,"illum 1\n");
      fprintf(fptr,"Ns 0.000000\n");
      fprintf(fptr,"map_Kd capsule%d.jpg\n",i);
      fprintf(fptr,"\n");
   }
   fclose(fptr);

	exit(0);
}

