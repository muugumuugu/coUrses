#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "paulslib.h"

XYZ Eval(double,double,double);

#define Nx 400
#define Ny 400

int main(int argc,char **argv)
{
   int i,j,k,icolour = 9;
   double s,t,p,dt,dp;
   XYZ q[4],q1,q2,n[4];
   COLOUR colour,black = {0.0,0.0,0.0};
   
   if (argc > 1)
      icolour = atoi(argv[1]);

   dt = 0.5 / (double)Nx;
   dp = 1 / (double)Ny;

   for (i=0;i<Nx;i++) {
      t = i * dt;
      s = 1;
      for (j=0;j<Ny;j++) {
         p = j * dp;
         s = s + p - s * p;
         q[0] = Eval(t,p,s);
         n[0] = CalcNormal(q[0],Eval(t+dt/10,p,s),Eval(t,p+dp/10,s));
         q[1] = Eval(t+dt,p,s);
         n[1] = CalcNormal(q[1],Eval(t+dt+dt/10,p,s),Eval(t+dt,p+dp/10,s));
         q[2] = Eval(t+dt,p+dp,s);
         n[2] = CalcNormal(q[2],Eval(t+dt+dt/10,p+dp,s),Eval(t+dt,p+dp+dp/10,s));
         q[3] = Eval(t,p+dp,s);
         n[3] = CalcNormal(q[3],Eval(t+dt/10,p+dp,s),Eval(t,p+dp+dp/10,s));
         colour = GetColour((double)i,0.0,(double)Nx,icolour);
         if (i % 10 == 0 || j % 10 == 0)
            colour = black;
         printf("f4n ");
         for (k=0;k<4;k++)
            printf("%g %g %g ",q[k].x,q[k].y,q[k].z);
         for (k=0;k<4;k++)
            printf("%g %g %g ",n[k].x,n[k].y,n[k].z);
         printf("%g %g %g\n",colour.r,colour.g,colour.b);
      }
   }
}

XYZ Eval(double t,double p,double s)
{
   XYZ q;

   q.x = cos(TWOPI*t-s*PID2)*cos(TWOPI*(-t+p)+s*PID2);
   q.y = cos(TWOPI*p-s*PID2)*cos(TWOPI*(-t+p)+s*PID2);
   q.z = cos(TWOPI*p-s*PID2)*cos(TWOPI*t-s*PID2);

   return(q);
}



