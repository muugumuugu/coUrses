#include "stdio.h"
#include "stdlib.h"
#include "math.h"

/*
   Experiment with texture tiling.
   Assume 256x256 square textures in "raw" format.
   Apply radial and linear masks.
   Write out intermediate files for checking/illustrative purposes.
*/

typedef struct {
   unsigned char r,g,b;
} COLOUR;

#define MAX(x,y) (x < y ? y : x)
#define MIN(x,y) (x > y ? y : x)
#define N 256

/* The mask type */
#define LINEAR 'l'
#define RADIAL 'r'
int masktype = LINEAR;

int main(int argc,char **argv)
{
   int i,j,r,g,b;
   double a1,a2,d;
   COLOUR image[N][N],diagonal[N][N],tile[N][N];
   unsigned char mask[N][N];
   char fname[128];
   FILE *fptr;

   /* Check command line arguments */
   if (argc < 3) {
      fprintf(stderr,"Usage: %s rawtexturefilename masktype[r,l]\n",argv[0]);
      exit(-1);
   }
   if (argv[2][0] == RADIAL)
      masktype = RADIAL;
   else if (argv[2][0] == LINEAR)
      masktype = LINEAR;

   /* Read the image and form the diagonal swapped image */
   if ((fptr = fopen(argv[1],"r")) == NULL) {
      fprintf(stderr,"Unable to read texture file\n");
      exit(-1);
   }
   for (j=0;j<N;j++) {
      for (i=0;i<N;i++) {
         r = fgetc(fptr);
         g = fgetc(fptr);
         b = fgetc(fptr);
         if (r == EOF || g == EOF || b == EOF) {
            fprintf(stderr,"Unexpected end of file\n");
            exit(-1);
         }
         image[i][j].r = r;
         image[i][j].g = g;
         image[i][j].b = b;
         diagonal[(i+N/2)%N][(j+N/2)%N] = image[i][j];
      }
   }
   fclose(fptr);

   /* Write the diagonal swapped image (for illustrative/test purposes) */
   if ((fptr = fopen("diagonal.raw","w")) != NULL) {
      for (j=0;j<N;j++) {
         for (i=0;i<N;i++) {
            fputc(diagonal[i][j].r,fptr);
            fputc(diagonal[i][j].g,fptr);
            fputc(diagonal[i][j].b,fptr);
         }
      }
      fclose(fptr);
   }

   /* Create the mask */
   for (i=0;i<N/2;i++) {
      for (j=0;j<N/2;j++) {
         /* d ranges from 0 to 1 */
         switch (masktype) { 
         case RADIAL:
            d = sqrt((i-N/2)*(i-N/2) + (double)(j-N/2)*(j-N/2)) / (N/2);
            break;
         case LINEAR:
            d = MAX((N/2-i),(N/2-j)) / (double)(N/2); 
            break;
         }
         /* Scale d to range from 1 to 255 */
         d = 255 - 255 * d;
         if (d < 1) d = 1;
         if (d > 255) d = 255;
         /* Form the mask in each quadrant */
         mask[    i][    j] = d;
         mask[    i][N-1-j] = d;
         mask[N-1-i][    j] = d;
         mask[N-1-i][N-1-j] = d;
      }
   }

   /* Save the mask as a grey scale raw image */
   sprintf(fname,"mask_%c.raw",masktype);
   if ((fptr = fopen(fname,"w")) != NULL) {
      for (j=0;j<N;j++) {
         for (i=0;i<N;i++) {
            fputc(mask[i][j],fptr);
         }
      }
      fclose(fptr);
   }

   /* Create the tile */
   for (j=0;j<N;j++) {
      for (i=0;i<N;i++) {
         a1 = mask[i][j];
         a2 = mask[(i+N/2)%N][(j+N/2)%N];
         tile[i][j].r = a1*image[i][j].r/(a1+a2) + a2*diagonal[i][j].r/(a1+a2);
         tile[i][j].g = a1*image[i][j].g/(a1+a2) + a2*diagonal[i][j].g/(a1+a2);
         tile[i][j].b = a1*image[i][j].b/(a1+a2) + a2*diagonal[i][j].b/(a1+a2);
      }
   }

   /* Write the tile as a RGB raw image */
   sprintf(fname,"tile_%c.raw",masktype);
   if ((fptr = fopen(fname,"w")) != NULL) {
      for (j=0;j<N;j++) {
         for (i=0;i<N;i++) {
            fputc(tile[i][j].r,fptr);
            fputc(tile[i][j].g,fptr);
            fputc(tile[i][j].b,fptr);
         }
      }
      fclose(fptr);
   }
}

