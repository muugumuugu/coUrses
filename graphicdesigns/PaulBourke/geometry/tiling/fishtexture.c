#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/*
	Create a hemisphere with texture coordinates for mapping a fisheye image as texture.
	Only intended to illustrate/verify the mathematics.
*/

int N = 32; // Mesh resolution, must be multiple of 4
double radius = 1;

typedef struct {
   double x,y,z;
	double nx,ny,nz;
   double u,v;
} MESHVERTEX;

int main(int argc,char **argv)
{
	int i,j,index = 0;
	int i1,i2,i3,i4;
	double theta,phi,r;
	MESHVERTEX *p = NULL,n;
	double len;
	FILE *fptr;

	if (argc < 3) {
		fprintf(stderr,"Usage: %s res radius\n",argv[0]);
		exit(-1);
	}
	N = atoi(argv[1]);
	radius = atof(argv[2]);

	// Create data
   if ((p = malloc((N+1)*(N/4+1)*sizeof(MESHVERTEX))) == NULL) {
      fprintf(stderr,"malloc failed\n");
      exit(-1);
   }
	for (j=0;j<=N/4;j++) {
		for (i=0;i<=N;i++) {
			theta = i * 2 * M_PI / N;
			phi = M_PI_2 - M_PI_2 * j / (N/4);
			p[index].x = radius * cos(phi) * cos(theta);
			p[index].y = radius * cos(phi) * sin(theta);
			p[index].z = radius * sin(phi);
			p[index].nx = p[index].x;
   	   p[index].ny = p[index].y;
   	   p[index].nz = p[index].z;
			index++;
		}
	}
	
	// Calculate texture coordinates
	for (i=0;i<index;i++) {
		phi = atan2(sqrt(p[i].x*p[i].x+p[i].y*p[i].y),p[i].z); // 0 ... pi/2
		theta = atan2(p[i].y,p[i].x); // -pi ... pi
		r = phi / M_PI_2; // 0 ... 1
      p[i].u = 0.5 * (r * cos(theta) + 1);
      p[i].v = 0.5 * (r * sin(theta) + 1);
		if (p[i].u < 0 || p[i].u > 1 || p[i].v < 0 || p[i].v > 1)
			fprintf(stderr,"u:%8.5f v:%8.5f phi:%8.5f theta:%8.5f r:%8.5f\n",p[i].u,p[i].v,phi,theta,r);
	}

	// Save as textured obj file
	fptr = fopen("fishtexture.obj","w");
	fprintf(fptr,"mtllib fishtexture.mtl\n");
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
	for (j=0;j<N/4;j++) {
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
   fptr = fopen("fishtexture.mtl","w");
   fprintf(fptr,"# Create as many materials as desired\n");
   fprintf(fptr,"# Each is referenced by name before the faces it applies to in the obj file\n");
   fprintf(fptr,"\n");
   for (i=0;i<1;i++) {
      fprintf(fptr,"newmtl material%d\n",i);
      fprintf(fptr,"Ka 1.000000 1.000000 1.000000\n");
      fprintf(fptr,"Kd 1.000000 1.000000 1.000000\n");
      fprintf(fptr,"Ks 0.000000 0.000000 0.000000\n");
      fprintf(fptr,"Tr 1.000000\n");
      fprintf(fptr,"illum 1\n");
      fprintf(fptr,"Ns 0.000000\n");
      fprintf(fptr,"map_Kd fishtexture%d.jpg\n",i);
      fprintf(fptr,"\n");
   }
   fclose(fptr);

	exit(0);
}

