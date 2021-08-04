#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include "math.h"

/*
   Generate Waterman polyhedra.
   Single command line argument is the root.
   Creates two files
   1. PovRay file of spheres
   2. XYZ file ready for qhull
*/

/* Default: 6, Set other values on command line */
int root = 6;

#define TRUE  1
#define FALSE 0

typedef struct {
   double x,y,z;
} XYZ;
typedef struct {
   double r,g,b;
} COLOUR;

/* Protottypes */
void WritePovSphere(FILE *,XYZ);
COLOUR GetColour(double,double,double,int);
double Modulus(XYZ);

XYZ *spheres = NULL;
long nsphere = 0;

int main(int argc,char **argv) 
{
   int i,j,k,r,r2,d;
   FILE *fptr;
   char fname[64];
   COLOUR c;

   /* If there is an argument assume it is the root */
   if (argc > 1) 
      root = atoi(argv[1]);
   r2 = 2 * root;
   r = sqrt((double)r2) + 2;
   fprintf(stderr,"Waterman Root: %d, Radius: sqrt(%d)\n",root,r2);

   /*
      Scan the cube saving Waterman points
      This is inefficient but it takes almost no time
      for even large values of root.
   */
   for (k=-r-1;k<=r+1;k++) {
      for (j=-r-1;j<=r+1;j++) {
         for (i=-r-1;i<=r+1;i++) {
            if ((i+j+k) % 2 != 0)
               continue;
            if ((d = i*i+j*j+k*k) > r2)
               continue;
            if (d < 2*(root-20)) /* Filter inner layers */
               continue;
            if ((spheres = realloc(spheres,(nsphere+1)*sizeof(XYZ))) == NULL) {
               fprintf(stderr,"Memory allocation failed\n");
               exit(-1);
            }
            spheres[nsphere].x = i;
            spheres[nsphere].y = j;
            spheres[nsphere].z = k;
            nsphere++;
         }
      }
   }
   fprintf(stderr,"Created %ld spheres\n",nsphere);

   /* 
      Create Sphere file for PovRay 
      Write textures at each layer radius.
      Filter inner layers
   */
   sprintf(fname,"s%04d.pov",root);
   if ((fptr = fopen(fname,"w")) == NULL) {
      fprintf(stderr,"Failed to open PovRay file for writing\n");
      exit(-1);
   }
   fprintf(fptr,"/*\n");
   fprintf(fptr,"   Waterman Root: %d, Radius: sqrt(%d)\n",root,r2);
   fprintf(fptr,"   Paul Bourke\n");
   fprintf(fptr,"*/\n");
   fprintf(fptr,"#declare RADIUS = sqrt(%d);\n",2*root);
   fprintf(fptr,"#declare RR = sqrt(2) / 2;\n");
   fprintf(fptr,"/* #include \"scene.pov\" */\n"); 
   for (i=0;i<=r2;i++) {
      fprintf(fptr,"#declare texture%d = texture {\n",i);
      c = GetColour((double)i,0.0,r2,1);
      fprintf(fptr,"   pigment { color rgb <%g,%g,%g> }\n",c.r,c.g,c.b);
      fprintf(fptr,"   finish { specular 0.2 }\n");
      fprintf(fptr,"}\n");
   }
   fprintf(fptr,"union {\n");
   for (i=0;i<nsphere;i++) {
      /* Remove inner layers - should be a "cleaner" way to do this? */
      if (root > 50 && Modulus(spheres[i]) < 0.8*sqrt(2.0*root))
         continue;
      WritePovSphere(fptr,spheres[i]);
   }
   fprintf(fptr,"}\n");
   fclose(fptr);

   /* 
      Create file for qhull 
      qhull is so fast that filtering the inner layers isn't necessary
      eg: cat 0004.xyz | qhull i > p0040.vert
   */
   sprintf(fname,"%04d.xyz",root);
   if ((fptr = fopen(fname,"w")) == NULL) {
      fprintf(stderr,"Failed to open qhull file for writing\n");
      exit(-1);
   }
   fprintf(fptr,"3\n"); /* Dimeniosn */
   fprintf(fptr,"%ld\n",nsphere); /* Number of points */
   for (i=0;i<nsphere;i++) 
      fprintf(fptr,"%g %g %g\n",spheres[i].x,spheres[i].y,spheres[i].z);
   fclose(fptr);

   exit(-1);
}

/*
   Write a PovRay primitive
*/
void WritePovSphere(FILE *fptr,XYZ s)
{
   fprintf(fptr,"sphere {\n");
   fprintf(fptr,"   <%g,%g,%g>, RR\n",s.x,s.y,s.z);
   fprintf(fptr,"   texture { texture%d }\n",(int)(s.x*s.x+s.y*s.y+s.z*s.z));
   fprintf(fptr,"}\n");
}

/*
   Return a colour from one of a number of colour ramps
   type == 1  blue -> cyan -> green -> magenta -> red
           2  blue -> red
           3  grey scale
           4  red -> yellow -> green -> cyan -> blue -> magenta -> red
           5  green -> yellow
           6  green -> magenta
           7  blue -> green -> red -> green -> blue
           8  black -> white -> black
           9  red -> blue -> cyan -> magenta
          10  blue -> cyan -> green -> yellow -> red -> white
          11  dark brown -> lighter brown (Mars colours, 2 colour transition)
          12  3 colour transition mars colours
          13  landscape colours, green -> brown -> yellow
          14  yellow -> red
          15  blue -> cyan -> green -> yellow -> brown -> white
          16  blue -> green -> red       (Chromadepth for black background)
          17  yellow -> magenta -> cyan  (Chromadepth for white background)
          18  blue -> cyan
          19  blue -> white
          20  landscape colours, modified, green -> brown -> yellow
          21  yellowish to blueish
          22  yellow to blue
   v should lie between vmin and vmax otherwise it is clipped
   The colour components range from 0 to 1
*/
COLOUR GetColour(double v,double vmin,double vmax,int type)
{
   double dv,vmid;
   COLOUR c = {1.0,1.0,1.0};
   COLOUR c1,c2,c3;
   double ratio;

   if (vmax < vmin) {
      dv = vmin;
      vmin = vmax;
      vmax = dv;
   }
   if (vmax - vmin < 0.000001) {
      vmin -= 1;
      vmax += 1;
   }
   if (v < vmin)
      v = vmin;
   if (v > vmax)
      v = vmax;
   dv = vmax - vmin;

   switch (type) {
   case 1:
      if (v < (vmin + 0.25 * dv)) {
         c.r = 0;
         c.g = 4 * (v - vmin) / dv;
         c.b = 1;
      } else if (v < (vmin + 0.5 * dv)) {
         c.r = 0;
         c.g = 1;
         c.b = 1 + 4 * (vmin + 0.25 * dv - v) / dv;
      } else if (v < (vmin + 0.75 * dv)) {
         c.r = 4 * (v - vmin - 0.5 * dv) / dv;
         c.g = 1;
         c.b = 0;
      } else {
         c.r = 1;
         c.g = 1 + 4 * (vmin + 0.75 * dv - v) / dv;
         c.b = 0;
      }
      break;
   case 2:
      c.r = (v - vmin) / dv;
      c.g = 0;
      c.b = (vmax - v) / dv;
      break;
   case 3:
      c.r = (v - vmin) / dv;
      c.b = c.r;
      c.g = c.r;
      break;
   case 4:
      if (v < (vmin + dv / 6.0)) {
         c.r = 1;
         c.g = 6 * (v - vmin) / dv;
         c.b = 0;
      } else if (v < (vmin + 2.0 * dv / 6.0)) {
         c.r = 1 + 6 * (vmin + dv / 6.0 - v) / dv;
         c.g = 1;
         c.b = 0;
      } else if (v < (vmin + 3.0 * dv / 6.0)) {
         c.r = 0;
         c.g = 1;
         c.b = 6 * (v - vmin - 2.0 * dv / 6.0) / dv;
      } else if (v < (vmin + 4.0 * dv / 6.0)) {
         c.r = 0;
         c.g = 1 + 6 * (vmin + 3.0 * dv / 6.0 - v) / dv;
         c.b = 1;
      } else if (v < (vmin + 5.0 * dv / 6.0)) {
         c.r = 6 * (v - vmin - 4.0 * dv / 6.0) / dv;
         c.g = 0;
         c.b = 1;
      } else {
         c.r = 1;
         c.g = 0;
         c.b = 1 + 6 * (vmin + 5.0 * dv / 6.0 - v) / dv;
      }
      break;
   case 5:
      c.r = (v - vmin) / (vmax - vmin);
      c.g = 1;
      c.b = 0;
      break;
   case 6:
      c.r = (v - vmin) / (vmax - vmin);
      c.g = (vmax - v) / (vmax - vmin);
      c.b = c.r;
      break;
   case 7:
      if (v < (vmin + 0.25 * dv)) {
         c.r = 0;
         c.g = 4 * (v - vmin) / dv;
         c.b = 1 - c.g;
      } else if (v < (vmin + 0.5 * dv)) {
         c.r = 4 * (v - vmin - 0.25 * dv) / dv;
         c.g = 1 - c.r;
         c.b = 0;
      } else if (v < (vmin + 0.75 * dv)) {
         c.g = 4 * (v - vmin - 0.5 * dv) / dv;
         c.r = 1 - c.g;
         c.b = 0;
      } else {
         c.r = 0;
         c.b = 4 * (v - vmin - 0.75 * dv) / dv;
         c.g = 1 - c.b;
      }
      break;
   case 8:
      if (v < (vmin + 0.5 * dv)) {
         c.r = 2 * (v - vmin) / dv;
         c.g = c.r;
         c.b = c.r;
      } else {
         c.r = 1 - 2 * (v - vmin - 0.5 * dv) / dv;
         c.g = c.r;
         c.b = c.r;
      }
      break;
   case 9:
      if (v < (vmin + dv / 3)) {
         c.b = 3 * (v - vmin) / dv;
         c.g = 0;
         c.r = 1 - c.b;
      } else if (v < (vmin + 2 * dv / 3)) {
         c.r = 0;
         c.g = 3 * (v - vmin - dv / 3) / dv;
         c.b = 1;
      } else {
         c.r = 3 * (v - vmin - 2 * dv / 3) / dv;
         c.g = 1 - c.r;
         c.b = 1;
      }
      break;
   case 10:
      if (v < (vmin + 0.2 * dv)) {
         c.r = 0;
         c.g = 5 * (v - vmin) / dv;
         c.b = 1;
      } else if (v < (vmin + 0.4 * dv)) {
         c.r = 0;
         c.g = 1;
         c.b = 1 + 5 * (vmin + 0.2 * dv - v) / dv;
      } else if (v < (vmin + 0.6 * dv)) {
         c.r = 5 * (v - vmin - 0.4 * dv) / dv;
         c.g = 1;
         c.b = 0;
      } else if (v < (vmin + 0.8 * dv)) {
         c.r = 1;
         c.g = 1 - 5 * (v - vmin - 0.6 * dv) / dv;
         c.b = 0;
      } else {
         c.r = 1;
         c.g = 5 * (v - vmin - 0.8 * dv) / dv;
         c.b = 5 * (v - vmin - 0.8 * dv) / dv;
      }
      break;
   case 11:
      c1.r = 200 / 255.0; c1.g =  60 / 255.0; c1.b =   0 / 255.0;
      c2.r = 250 / 255.0; c2.g = 160 / 255.0; c2.b = 110 / 255.0;
      c.r = (c2.r - c1.r) * (v - vmin) / dv + c1.r;
      c.g = (c2.g - c1.g) * (v - vmin) / dv + c1.g;
      c.b = (c2.b - c1.b) * (v - vmin) / dv + c1.b;
      break;
   case 12:
      c1.r =  55 / 255.0; c1.g =  55 / 255.0; c1.b =  45 / 255.0;
      /* c2.r = 200 / 255.0; c2.g =  60 / 255.0; c2.b =   0 / 255.0; */
      c2.r = 235 / 255.0; c2.g =  90 / 255.0; c2.b =  30 / 255.0;
      c3.r = 250 / 255.0; c3.g = 160 / 255.0; c3.b = 110 / 255.0;
      ratio = 0.4;
      vmid = vmin + ratio * dv;
      if (v < vmid) {
         c.r = (c2.r - c1.r) * (v - vmin) / (ratio*dv) + c1.r;
         c.g = (c2.g - c1.g) * (v - vmin) / (ratio*dv) + c1.g;
         c.b = (c2.b - c1.b) * (v - vmin) / (ratio*dv) + c1.b;
      } else {
         c.r = (c3.r - c2.r) * (v - vmid) / ((1-ratio)*dv) + c2.r;
         c.g = (c3.g - c2.g) * (v - vmid) / ((1-ratio)*dv) + c2.g;
         c.b = (c3.b - c2.b) * (v - vmid) / ((1-ratio)*dv) + c2.b;
      }
      break;
   case 13:
      c1.r =   0 / 255.0; c1.g = 255 / 255.0; c1.b =   0 / 255.0;
      c2.r = 255 / 255.0; c2.g = 150 / 255.0; c2.b =   0 / 255.0;
      c3.r = 255 / 255.0; c3.g = 250 / 255.0; c3.b = 240 / 255.0;
      ratio = 0.3;
      vmid = vmin + ratio * dv;
      if (v < vmid) {
         c.r = (c2.r - c1.r) * (v - vmin) / (ratio*dv) + c1.r;
         c.g = (c2.g - c1.g) * (v - vmin) / (ratio*dv) + c1.g;
         c.b = (c2.b - c1.b) * (v - vmin) / (ratio*dv) + c1.b;
      } else {
         c.r = (c3.r - c2.r) * (v - vmid) / ((1-ratio)*dv) + c2.r;
         c.g = (c3.g - c2.g) * (v - vmid) / ((1-ratio)*dv) + c2.g;
         c.b = (c3.b - c2.b) * (v - vmid) / ((1-ratio)*dv) + c2.b;
      }
      break;
   case 14:
      c.r = 1;
      c.g = 1 - (v - vmin) / dv;
      c.b = 0;
      break;
   case 15:
      if (v < (vmin + 0.25 * dv)) {
         c.r = 0;
         c.g = 4 * (v - vmin) / dv;
         c.b = 1;
      } else if (v < (vmin + 0.5 * dv)) {
         c.r = 0;
         c.g = 1;
         c.b = 1 - 4 * (v - vmin - 0.25 * dv) / dv;
      } else if (v < (vmin + 0.75 * dv)) {
         c.r = 4 * (v - vmin - 0.5 * dv) / dv;
         c.g = 1;
         c.b = 0;
      } else {
         c.r = 1;
         c.g = 1;
         c.b = 4 * (v - vmin - 0.75 * dv) / dv;
      }
      break;
   case 16:
      if (v < (vmin + 0.5 * dv)) {
         c.r = 0.0;
         c.g = 2 * (v - vmin) / dv;
         c.b = 1 - 2 * (v - vmin) / dv;
      } else {
         c.r = 2 * (v - vmin - 0.5 * dv) / dv;
         c.g = 1 - 2 * (v - vmin - 0.5 * dv) / dv;
         c.b = 0.0;
      }
      break;
   case 17:
      if (v < (vmin + 0.5 * dv)) {
         c.r = 1.0;
         c.g = 1 - 2 * (v - vmin) / dv;
         c.b = 2 * (v - vmin) / dv;
      } else {
         c.r = 1 - 2 * (v - vmin - 0.5 * dv) / dv;
         c.g = 2 * (v - vmin - 0.5 * dv) / dv;
         c.b = 1.0;
      }
      break;
   case 18:
      c.r = 0;
      c.g = (v - vmin) / (vmax - vmin);
      c.b = 1;
      break;
   case 19:
      c.r = (v - vmin) / (vmax - vmin);
      c.g = c.r;
      c.b = 1;
      break;
   case 20:
      c1.r =   0 / 255.0; c1.g = 160 / 255.0; c1.b =   0 / 255.0;
      c2.r = 180 / 255.0; c2.g = 220 / 255.0; c2.b =   0 / 255.0;
      c3.r = 250 / 255.0; c3.g = 220 / 255.0; c3.b = 170 / 255.0;
      ratio = 0.3;
      vmid = vmin + ratio * dv;
      if (v < vmid) {
         c.r = (c2.r - c1.r) * (v - vmin) / (ratio*dv) + c1.r;
         c.g = (c2.g - c1.g) * (v - vmin) / (ratio*dv) + c1.g;
         c.b = (c2.b - c1.b) * (v - vmin) / (ratio*dv) + c1.b;
      } else {
         c.r = (c3.r - c2.r) * (v - vmid) / ((1-ratio)*dv) + c2.r;
         c.g = (c3.g - c2.g) * (v - vmid) / ((1-ratio)*dv) + c2.g;
         c.b = (c3.b - c2.b) * (v - vmid) / ((1-ratio)*dv) + c2.b;
      }
      break;
   case 21:
      c1.r = 255 / 255.0; c1.g = 255 / 255.0; c1.b = 200 / 255.0;
      c2.r = 150 / 255.0; c2.g = 150 / 255.0; c2.b = 255 / 255.0;
      c.r = (c2.r - c1.r) * (v - vmin) / dv + c1.r;
      c.g = (c2.g - c1.g) * (v - vmin) / dv + c1.g;
      c.b = (c2.b - c1.b) * (v - vmin) / dv + c1.b;
      break;
   case 22:
      c.r = 1 - (v - vmin) / dv;
      c.g = 1 - (v - vmin) / dv;
      c.b = (v - vmin) / dv;
      break;
   }
   return(c);
}

double Modulus(XYZ p)
{
    return(sqrt(p.x * p.x + p.y * p.y + p.z * p.z));
}

