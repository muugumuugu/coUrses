#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <sys/types.h>
#include <time.h> // for Random seed
#include <string.h>

/*

http://paulbourke.net/fractals/thorn/
	Create a number of randomly chosen thorn fractals
	Note this has been "minimalised" to convey the algorithm




gcc t.c -Wall -lm
./a.out
*/




// integer (pixel ) coordinate = size of image in pixels
        int iX,iY;
        int iXmax = 10000; // Generally create the image large and subsample down for higher dynamic range
        int iYmax = 10000;
        int iLength // = iXmax*iYmax;/* length of array in bytes = number of bytes = number of pixels of image * number of bytes of color */


// save data array to pgm file 
int SavePGMFile(int number, unsigned char data[])
{
  FILE * fp;
  char name [10]; /* name of file */
  sprintf(name,"%d", number); /*  */
  char *filename =strcat(name,".pgm");
  char *comment="# ";/* comment should start with # */
  const unsigned int MaxColorComponentValue=255; /* color component is coded from 0 to 255 ;  it is 8 bit color file */
  
   /* save image to the pgm file  */      
  fp= fopen(filename,"wb"); /*create new file,give it a name and open it in binary mode  */
  fprintf(fp,"P5\n %s\n %u %u\n %u\n",comment,iXmax,iYmax,MaxColorComponentValue);  /*write header to the file*/
  fwrite(data,iLength,1,fp);  /*write image data bytes to the file in one step */
  printf("File %s saved. \n", filename);
  fclose(fp);
  return 0;
}


int main()
{
	
	
        
        //
	unsigned char *density = NULL; // 1D array for image 
        unsigned char iterationMax = 255;
        unsigned char iteration;
        
        // world ( double) coordinate
        double Zx0,Zy0; // variable 
	double ZxMin,ZxMax,ZyMin,ZyMax; // Range on the plane for the image
        double Zy,Zx;
        double a,b; // temporary variable
        //
        
        int imageMax =10; // The number of random images to create
        int image; // variable , image number
        

        //ER2 = ER* ER
	double EscapeRadius2 = 10000;
	
	double Cy,Cx;


   iLength = iXmax*iYmax;/* length of array in bytes = number of bytes = number of pixels of image * number of bytes of color */

	// Range on the plane for the image
   ZxMin = -M_PI;
   ZxMax =  M_PI;
   ZyMin = -M_PI;
   ZyMax =  M_PI;

	// Random seed
	srand(time(NULL));

	// Create the image 
	density = malloc(iLength*sizeof(unsigned char));

	for (image=0;image<imageMax;image++) { // Random choice of c_x and c_y
		Cx = (rand() % 10000) / 500.0 - 10; // -10 -> 10;
		Cy = (rand() % 10000) / 500.0 - 10;

		fprintf(stderr,"Creating image %d, (c_x,c_y) = (%g,%g)\n",image,Cx,Cy);
                // fill array
		for (iX=0;iX<iXmax;iX++) {
			Zy0 = ZxMin + iX * (ZxMax - ZxMin) / iXmax;
	
			for (iY=0;iY<iYmax;iY++) {
				Zx0 = ZyMin + iY * (ZyMax - ZyMin) / iYmax;
	
				Zy = Zy0;
				Zx = Zx0;
				for (iteration=0;iteration<iterationMax;iteration++) {
					a = Zy;
					b = Zx;
					Zy = a / cos(b) + Cx;
					Zx = b / sin(a) + Cy;
					if (Zy*Zy + Zx*Zx > EscapeRadius2) break;
				}
	                        // density is proportional to last iteration ( integer Escape time )
				density[iY*iXmax+iX] = (20*iteration) % 255; // enhace gradient
			}
		}
	
		// Write the array to a pgm file
		SavePGMFile(image,density);

	} // image


         free(density);
	exit(0);
}

