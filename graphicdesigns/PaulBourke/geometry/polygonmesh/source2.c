/*
   Return whether a polygon in 2D is concave or convex
   return 0 for incomputables eg: colinear points
          CONVEX == 1
          CONCAVE == -1
   It is assumed that the polygon is simple
   (does not intersect itself or have holes)
*/
int Convex(XY *p,int n)
{
   int i,j,k;
   int flag = 0;
   double z;

   if (n < 3)
      return(0);

   for (i=0;i<n;i++) {
      j = (i + 1) % n;
      k = (i + 2) % n;
      z  = (p[j].x - p[i].x) * (p[k].y - p[j].y);
      z -= (p[j].y - p[i].y) * (p[k].x - p[j].x);
      if (z < 0)
         flag |= 1;
      else if (z > 0)
         flag |= 2;
      if (flag == 3)
         return(CONCAVE);
   }
   if (flag != 0)
      return(CONVEX);
   else
      return(0);
}
