#include "stdio.h"
#include "stdlib.h"
#include "math.h"

#ifndef MIN
#define MIN(x,y) (x < y ? x : y)
#endif
#ifndef MAX
#define MAX(x,y) (x > y ? x : y)
#endif

/*
   The following is an attempt at evaluating various estimates of the circumference of an ellipse.
*/

double Bessel(double,double, double, int);
double Exact(double,double,double,int);
void ErrorString(char *,double,double);

int main(int argc,char **argv)
{
   long i,j,n;
   double a,b,h,e,p,d,dt,t;
   double s,m,tol,len,truelen,theta;
   double x,y,xlast=0,ylast=0;
   char errstr[64];

   if (argc < 3) {
      fprintf(stderr,"Usage: %s axis1 axis2\n",argv[0]);   
      exit(-1);
   }
   a = atof(argv[1]);
   b = atof(argv[2]);
   if (a < b) {
      a = atof(argv[2]);
      b = atof(argv[1]);
   }
   e = sqrt(1 - b*b / (a*a));
   h = (a-b)*(a-b) / ((a+b)*(a+b));
   fprintf(stderr,"e  : %.10lf\n",e);
   fprintf(stderr,"h  : %.10lf\n",h);
   fprintf(stderr,"b/a: %.10lf\n",b/a);

   /* High segment estimate, calculate truelen
   truelen = 0;
   n = 100000000L;
   for (i=0;i<=n;i++) {
      theta = 0.5 * M_PI * i / (double)n;
      x = a * cos(theta);
      y = b * sin(theta);
      if (i > 0)
         truelen += sqrt((x-xlast)*(x-xlast) + (y-ylast)*(y-ylast));
      xlast = x;
      ylast = y;
   }
   truelen *= 4;
	*/
	// Revised courtesy of Charles Karney
   tol = pow(0.5,27),
   s = 0,
   m = 1;
	x = MAX(a,b);
	y = MIN(a,b);
   while (x - y > tol * y) {
      t = (x + y) / 2;
      y = sqrt(x * y);
      x = t;
      m *= 2;
      s += m * (x - y) * (x - y);
   }
   truelen = M_PI * ((a + b) * (a + b) - s) / (x + y);

   // Sum segments of one quadrant
   n = 10;
   for (j=0;j<8;j++) {
      len = 0;
      for (i=0;i<=n;i++) {
         theta = 0.5 * M_PI * i / (double)n;
         x = a * cos(theta);
         y = b * sin(theta);
         if (i > 0)
            len += sqrt((x-xlast)*(x-xlast) + (y-ylast)*(y-ylast));
         xlast = x;
         ylast = y;
      }
      len *= 4;
      ErrorString(errstr,len,truelen);
      fprintf(stderr,"Numerical             : %17.14lf %s (%9ld segments)\n",len,errstr,n);
      n *= 10;
   }

   /* Integral
   n = 10;
   for (j=0;j<8;j++) {
      len = 0;
      dt = 0.5 * M_PI / n;
      for (i=0;i<=n;i++) {
         theta = 0.5 * M_PI * i / (double)n;
         len += sqrt(1 - e*e*sin(theta)*sin(theta)) * dt;
      }
      len *= 4*a;
      ErrorString(errstr,len,truelen);
      fprintf(stderr,"Integral              : %17.14lf %s (%9ld segments)\n",len,errstr,n);
      n *= 10;
   } */
	// Revised courtesy of Charles Karney
   n = 10;
   for (j=0;j<8;j++) {
      len = 0;
      dt = 0.5 * M_PI / n;
		for (i=0;i<n;i++) {
          theta = 0.5 * M_PI * (i+0.5) / (double)n;
          len += sqrt(1 - e*e*sin(theta)*sin(theta)) * dt;
       }
      len *= 4*a;
      ErrorString(errstr,len,truelen);
      fprintf(stderr,"Integral              : %17.14lf %s (%9ld segments)\n",len,errstr,n);
      n *= 10;
   }

   if (a == b) {
      len = 2 * a * M_PI;
      ErrorString(errstr,len,truelen);
      fprintf(stderr,"Circle circumference  : %17.14lf %s\n",2*a*M_PI,errstr);
   }

   len = M_PI * sqrt(2*(a*a + b*b) - 0.5*(a-b)*(a-b));
   ErrorString(errstr,len,truelen);
   fprintf(stderr,"Anonymous             : %17.14lf %s\n",len,errstr);

   len = 0.25 * M_PI * (a+b) * (3 * (1+h/4) + 1/(1-h/4));
   ErrorString(errstr,len,truelen);
   fprintf(stderr,"Hudson                : %17.14lf %s\n",len,errstr);

   len = M_PI * (3 * (a + b) - sqrt((a + 3*b)*(3*a + b)));
   ErrorString(errstr,len,truelen);
   fprintf(stderr,"Ramanujan 1           : %17.14lf %s\n",len,errstr);

   len = M_PI * (a + b) * (1 + 3*h / (10 + sqrt(4 - 3 * h)));
   ErrorString(errstr,len,truelen);
   fprintf(stderr,"Ramanujan 11          : %17.14lf %s\n",len,errstr);

   s = log(2.0) / log(M_PI/2);
   len = 4 * pow(pow(a,s) + pow(b,s),1.0/s);
   ErrorString(errstr,len,truelen);
   fprintf(stderr,"Holder mean           : %17.14lf %s (s: %.15f)\n",len,errstr,s);

   // Cantrell
   if (e < 0.99)
      s = (3*M_PI - 8) / (8 - 2*M_PI);
   else
      s = log(2.0) / log(2.0 / (4 - M_PI));
   len = 4 * (a+b) - 2 * (4-M_PI) * a * b / pow(pow(a,s)/2 + pow(b,s)/2,1.0/s);
   ErrorString(errstr,len,truelen);
   fprintf(stderr,"Cantrell              : %17.14lf %s (s: %.15f)\n",len,errstr,s);

   // Exact method
   n = 10;
   for (i=0;i<4;i++) {
      len = Exact(a,b,e,n);
      ErrorString(errstr,len,truelen);
      fprintf(stderr,"Exact                 : %17.14lf %s (%5ld terms)\n",len,errstr,n);
      n *= 5;
   }
   
   // Various by Necat
   s = log(2.0) / log(M_PI/2);
   len = 4 * b * pow(1 + pow(a/b,s),1.0/s);
   ErrorString(errstr,len,truelen);
   fprintf(stderr,"Necat (constant s)    : %17.14lf %s (s: %.15lf)\n",len,errstr,s);

   x = 1000*(atan(a/b)-M_PI/4) / (M_PI/4);
   p = 2.25271968313295 + 0.000979362368206 * x;
   s = 1.72889475938385 - (1.72889475938385 - 1.53492853566138) * pow(1-pow(x/1000.0,p),1.0/p);
   len = 4 * b * pow(1 + pow(a/b,s),1.0/s);
   ErrorString(errstr,len,truelen);
   fprintf(stderr,"Necat (linear s)      : %17.14lf %s (s: %.15lf)\n",len,errstr,s);

   x = 1000*(atan(a/b)-M_PI/4) / (M_PI/4);
   d = 2.029 - (0.05 + 0.00005 * x + 2.026541052344580 * pow(1-pow((x-500.0)/500,4.0),1.0/4.0));
   p = d + 0.000996587790100 * x + 2.330700 * pow(1-pow((x-500.0)/500,4.0),1.0/4.0);
   s = 1.72889475938385 - (1.72889475938385 - 1.53492853566138) * pow(1-pow(x/1000.0,p),1.0/p);
   len = 4 * b * pow(1 + pow(a/b,s),1.0/s);
   ErrorString(errstr,len,truelen);
   fprintf(stderr,"Necat (power s)       : %17.14lf %s (s: %.15lf)\n",len,errstr,s);

   // Bessel solution suggested by Charles Karney
   n = 10;
   for (i=0;i<3;i++) {
      len = Bessel(a,b,h,n);
      ErrorString(errstr,len,truelen);
      fprintf(stderr,"Bessel                : %17.14lf %s (%5ld terms)\n",len,errstr,n);
      n *= 10;
   }

   return(0);
}
 
/*
   Form nice error string
*/
void ErrorString(char *s,double l1,double l2)
{
   double err;

   err = (l1 - l2) / l2;
   if (err < 0)
      err = -err;

   if (err > 1e-3) {
      sprintf(s,"   Error: %8.6lf      ",err);
      return;
   }

   err *= 1000;
   if (err > 1e-3) {
      sprintf(s,"   Error: %4.3lf x10(-3) ",err);
      return;
   }

   err *= 1000;
   if (err > 1e-3) {
      sprintf(s,"   Error: %4.3lf x10(-6) ",err);
      return;
   }

   err *= 1000;
   if (err > 1e-3) {
      sprintf(s,"   Error: %4.3lf x10(-9) ",err);
      return;
   }

   err *= 1000;
   sprintf(s,"   Error: %4.3lf x10(-12)",err);
}

/*
   Bessel formula
*/
double Bessel(double a,double b, double h, int n)
{
   double len=1,sum;
   int i,j;

   for (i=1;i<n;i++) {
      sum = 1;
      for (j=i;j>0;j--) {
         if (j > 1)
            sum *= (2*(j-1)-1);
         sum /= (2*j);
      }
      len += pow(h,(double)i) * sum * sum;
   }
   len *= M_PI * (a + b);

   return(len);
}

double Exact(double a,double b,double e,int n)
{
   double s,len;
   double fact=1;
   int i;

   len = 1;
   for (i=1;i<n;i++) {
      fact *= (2*i * (2*i-1));
      fact /= i;
      fact /= i;
      fact /= 4;

      s = fact * fact;

      s *= -pow(e,2.0*i);
      s /= (2.0 * i - 1);
      len += s;
   }
   len *= 2*M_PI*a;

   return(len);
}

