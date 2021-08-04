int main(int argc,char **argv)
{
   int i,j,n=200;
   double u,v;
   XYZ p;
   COLOUR colour;
   COLOUR black = {0.0,0.0,0.0};

   printf("CMESH\n%d %d\n",n+1,n+1);
   for (i=0;i<=n;i++) {
      for (j=0;j<=n;j++) {

         u = i * TWOPI / n;
         v = j * 0.5 * PI / n;

         p.x = cos(u) * sin(2*v);
         p.y = sin(u) * sin(2*v);
         p.z = cos(v) * cos(v) - cos(u) * cos(u) * sin(v) * sin(v);

         colour = GetColour(u,0.0,2*PI,4);
         printf("%g %g %g %g %g %g 0.5\n",p.x,p.y,p.z,
            colour.r,colour.g,colour.b);
      }
   }
}
