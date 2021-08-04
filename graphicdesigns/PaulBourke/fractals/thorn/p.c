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


http://en.wikipedia.org/wiki/Adaptive_histogram_equalization


gcc t.c -Wall -lm
./a.out
*/




// integer (pixel ) coordinate = size of ImageNumber in pixels
        int iX,iY;
        int iXmax = 10000; // Generally create the ImageNumber large and subsample down for higher dynamic range
        int iYmax = 10000;
     
        unsigned int iterationMax = 500;
        unsigned int iteration;



/* based on Delphi function by Witold J.Janik */
void GiveRainbowColor(double position,unsigned char c[])
{
  /* if position > 1 then we have repetition of colors it maybe useful    */
      
  if (position>1.0){if (position-(int)position==0.0)position=1.0; else position=position-(int)position;}
  
  
 
  
  unsigned char nmax=6; /* number of color segments */
  double m=nmax* position;
  
  int n=(int)m; // integer of m
  
  double f=m-n;  // fraction of m
  unsigned char t=(int)(f*255);
  

  
switch( n){
   case 0: {
      c[0] = 255;
      c[1] = t;
      c[2] = 0;
       break;
    };
   case 1: {
      c[0] = 255 - t;
      c[1] = 255;
      c[2] = 0;
       break;
    };
   case 2: {
      c[0] = 0;
      c[1] = 255;
      c[2] = t;
       break;
    };
   case 3: {
      c[0] = 0;
      c[1] = 255 - t;
      c[2] = 255;
       break;
    };
   case 4: {
      c[0] = t;
      c[1] = 0;
      c[2] = 255;
       break;
    };
   case 5: {
      c[0] = 255;
      c[1] = 0;
      c[2] = 255 - t;
       break;
    };
 //   default: {
  //    c[0] = 255;
   //   c[1] = 0;
   //   c[2] = 0;
  //     break;
   // };

}; // case
}






int main()
{
	
	
        
       
        
        
        // world ( double) coordinate
        double Zx0,Zy0; // variable 
	double ZxMin,ZxMax,ZyMin,ZyMax; // Range on the plane for the ImageNumber
        double Zy,Zx;
        double a,b; // temporary variable
        //
        
        int ImageNumberMax =10; // The number of random images to create
        int ImageNumber; // variable , ImageNumber number
        

        //ER2 = ER* ER
	double EscapeRadius2 = 10000;
	
	double Cy,Cx;
        // file 
        FILE * fp;
        char name [10]; /* name of file */
        char *filename;
        // char *comment="# ";/* comment should start with # */
      const unsigned int MaxColorComponentValue=255; /* color component is coded from 0 to 255 ;  it is 8 bit color file */
      // color 
      static unsigned char color[3];
      double position;
      double p;

  

	// Range on the plane for the ImageNumber
   ZxMin = -M_PI;
   ZxMax =  M_PI;
   ZyMin = -M_PI;
   ZyMax =  M_PI;

	// Random seed
	srand(time(NULL));
         p = 50.0/iterationMax; // used to enhace gradient; change it to increase/diminish repetition of gradient

	
        fprintf(stderr,"\n"); // formatting text output
	for (ImageNumber=0;ImageNumber<ImageNumberMax;ImageNumber++) { // Random choice of c_x and c_y
		Cx = (rand() % 10000) / 500.0 - 10; // -10 -> 10;
		Cy = (rand() % 10000) / 500.0 - 10;

                

		fprintf(stderr,"creating image file number = %d for (c_x,c_y) = (%g,%g)\n",ImageNumber,Cx,Cy);
                //
                sprintf(name,"%d", ImageNumber); /*  */
                filename =strcat(name,".ppm");
                fp= fopen(filename,"wb"); /*create new file, give it a name and open it in binary mode  */
                fprintf(fp, "P6\n%d %d\n %d\n", iXmax,iYmax, MaxColorComponentValue);

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
	                        // color is proportional to last iteration ( integer EscapeRadius2 time )
				position= p*iteration; // position of color in gradient   
                                GiveRainbowColor(position,color); // compute rgb color  
                                fwrite(color,1,3,fp); // write color to ppm file
			}
		}
	
		 fclose(fp);
                 printf("File %s saved. \n\n", filename);

	} // for ImageNumber

      

	exit(0);
}

