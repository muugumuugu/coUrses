#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "paulslib.h"

XYZ Eval(double,double);

#define Nx 400
#define Ny 400

int main(int argc,char **argv)
{
   int i,j,k,icolour = 9;
   double t,p,dt,dp;
   XYZ q[4],q1,q2,n[4];
   COLOUR colour;
   
   if (argc > 1)
      icolour = atoi(argv[1]);

   dt = 1 / (double)Nx;
   dp = 2 / (double)Ny;

   for (i=0;i<Nx;i++) {
      t = i * dt;
      for (j=0;j<Ny;j++) {
         p = j * dp;
         q[0] = Eval(t,p);
         n[0] = CalcNormal(q[0],Eval(t+dt/10,p),Eval(t,p+dp/10));
         q[1] = Eval(t+dt,p);
         n[1] = CalcNormal(q[1],Eval(t+dt+dt/10,p),Eval(t+dt,p+dp/10));
         q[2] = Eval(t+dt,p+dp);
         n[2] = CalcNormal(q[2],Eval(t+dt+dt/10,p+dp),Eval(t+dt,p+dp+dp/10));
         q[3] = Eval(t,p+dp);
         n[3] = CalcNormal(q[3],Eval(t+dt/10,p+dp),Eval(t,p+dp+dp/10));
         colour = GetColour((double)i,0.0,(double)Nx,icolour);
         printf("f4n ");
         for (k=0;k<4;k++)
            printf("%g %g %g ",q[k].x,q[k].y,q[k].z);
         for (k=0;k<4;k++)
            printf("%g %g %g ",n[k].x,n[k].y,n[k].z);
         printf("%g %g %g\n",colour.r,colour.g,colour.b);
      }
   }
}

XYZ Eval(double t,double p)
{
   double a,b,c,d,tp;
   XYZ q;

   tp = TWOPI * 2 / 3.0;
   a = TWOPI * (t - p/3);
   b = TWOPI * (-t - p/3);
   c = TWOPI*(-t-p);
   d = TWOPI*(-t+p);
   q.x = cos(a) * cos(b) * cos(TWOPI*p) * cos(TWOPI*t);
   q.y = cos(a+tp)*cos(b+tp)*cos(c+tp)*cos(TWOPI*(t-1));
   q.z = cos(a-tp)*cos(b-tp)*cos(d+tp)*cos(TWOPI*(t-2));

   return(q);
}



