/* 
c program
 based on the code of Claudio Rocchini
 http://en.wikipedia.org/wiki/Image:Color_complex_plot.jpg
 
 create 8 bit color graphic file ,  portable pixmap file = PGM P5
 
 see http://en.wikipedia.org/wiki/Portable_pixmap
 to see the file use external application ( graphic viewer)
 I think that creating graphic can't be simpler
 comments : Adam Majewski 
 fraktal.republika.pl 
 adammaj1@o2.pl
*/
#include <stdio.h>

int main(){
        
        
        
        
        double x,y,
               
               xMin=2.4,
               xMax=4.0,
               yMin=0.0,
               yMax=1.0;
               
        
        int iX,iY,
            i, /* iteration */
            iMax=99000,
            imax=1000,
            hits;
        const int iXmax = 1600; 
        const int iYmax = 1000;
        
        double dx=(xMax-xMin)/iXmax,
               dy=(yMax-yMin)/iYmax;
        
        /* color  is coded from 0 to 255 */
        /* it is 8 bit color RGB file */
        const int MaxColorComponentValue=255; 
        FILE * fp;
        char *filename="logistic_21.pgm";
        char *comment="# info";/* comment should start with # */
        unsigned char color[iYmax][iXmax];
        double dColor;
        
        /* make all points black */ 
        for(iY=0;iY<iYmax;++iY)
          for(iX=0;iX<iXmax;++iX)
            color[iY][iX]=0;
            
        /* compute */    
        for(iX=0;iX<iXmax;++iX)
        { 
          x=xMin+iX*dx;
          y=0.25;
          for(i=0;i<imax;++i) y=x*y*(1-y); 
          for(i=0;i<iMax;++i)
           {
             y=x*y*(1-y);
             iY=(int)((yMax-y)/dy);
             if (x<3.57) 
               color[iY][iX]=255;
               else if(color[iY][iX]<255)color[iY][iX]+=1; /*intensity of color is proportinal to pixel hits */
           }       
         }      
        
      

        /*create new file,give it a name and open it in binary mode  */
        fp= fopen(filename,"wb"); /* b -  binary mode */
        /*write ASCII header to the file*/
        fprintf(fp,"P5\n %s\n %d\n %d\n %d\n",comment,iXmax,iYmax,MaxColorComponentValue);
        fwrite(color,sizeof color,1,fp);/*write image data bytes to the file*/
        fclose(fp);
        
        
        printf("OK\n");
        getchar();
        return 0;
}
