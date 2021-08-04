/* **********************************************************************

sphere.cpp

atelier iebele abel - 2001
atelier@iebele.nl
http://www.iebele.nl

sphere_line_intersection function adapted from:
http://astronomy.swin.edu.au/pbourke/geometry/sphereline
Paul Bourke pbourke@swin.edu.au

********************************************************************** */

#include <iostream.h>
#include <malloc.h>
#include "sphere.h" //    "sphere.h"
                    //    float * sphere_line_intersection (
                    //        float x1, float y1 , float z1,
                    //        float x2, float y2 , float z2,
                    //        float x3, float y3 , float z3, float r );


float square( float f ) { return (f*f) ;};

float * sphere_line_intersection (
    float x1, float y1 , float z1,
    float x2, float y2 , float z2,
    float x3, float y3 , float z3, float r )
{

 // x1,y1,z1  P1 coordinates (point of line)
 // x2,y2,z2  P2 coordinates (point of line)
 // x3,y3,z3, r  P3 coordinates and radius (sphere)
 // x,y,z   intersection coordinates
 //
 // This function returns a pointer array which first index indicates
 // the number of intersection point, followed by coordinate pairs.

 float x , y , z;
 float a, b, c, mu, i ;
 float * p;           // array containing #points and its coordinates
 p = (float*) malloc(7*sizeof(float));

 a =  square(x2 - x1) + square(y2 - y1) + square(z2 - z1);
 b =  2* ( (x2 - x1)*(x1 - x3)
      + (y2 - y1)*(y1 - y3)
      + (z2 - z1)*(z1 - z3) ) ;
 c =  square(x3) + square(y3) +
      square(z3) + square(x1) +
      square(y1) + square(z1) -
      2* ( x3*x1 + y3*y1 + z3*z1 ) - square(r) ;
 i =   b * b - 4 * a * c ;

 if ( i < 0.0 )
 {
  // no intersection
  p[0] = 0.0;
  return(p);
 }
 if ( i == 0.0 )
 {
  // one intersection
  p[0] = 1.0;

  mu = -b/(2*a) ;
  p[1] = x1 + mu*(x2-x1);
  p[2] = y1 + mu*(y2-y1);
  p[3] = z1 + mu*(z2-z1);
  return(p);
 }
 if ( i > 0.0 )
 {
  // two intersections
  p[0] = 2.0;

  // first intersection
  mu = (-b + sqrt( square(b) - 4*a*c )) / (2*a);
  p[1] = x1 + mu*(x2-x1);
  p[2] = y1 + mu*(y2-y1);
  p[3] = z1 + mu*(z2-z1);
  // second intersection
  mu = (-b - sqrt(square(b) - 4*a*c )) / (2*a);
  p[4] = x1 + mu*(x2-x1);
  p[5] = y1 + mu*(y2-y1);
  p[6] = z1 + mu*(z2-z1);

  return(p);
 }
}


// ************************************************************************
// Example use of function sphere_line_intersection (...)
//
main()
{
 int i, num ;
 float * p;

 p=sphere_line_intersection (
   0 , 0 , 0 ,
   1 , 0 , 0 ,
   0 , 0 , 0 ,
   3.0 );

 num = (int) *p++;

 cout << " Number of intersection points is " << num << endl;
 for ( i=0 ; i < num ; i++ )
 {
  cout << " X-coordinate of point " << i << " : " << *p++ << endl ;
  cout << " Y-coordinate of point " << i << " : " << *p++ << endl ;
  cout << " Z-coordinate of point " << i << " : " << *p++ << endl ;
 }
 free(&p);
}

// ********************************************************************

