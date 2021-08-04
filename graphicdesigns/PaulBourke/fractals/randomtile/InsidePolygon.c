int InsidePolygon(XY *polygon,int n,XY p)
{
   int i;
   double angle=0;
   XY p1,p2;

   for (i=0;i<n;i++) {
      p1.x = polygon[i].x - p.x;
      p1.y = polygon[i].y - p.y;
      p2.x = polygon[(i+1)%n].x - p.x;
      p2.y = polygon[(i+1)%n].y - p.y;
      angle += Angle2D(p1.x,p1.y,p2.x,p2.y);
   }

   if (ABS(angle) < PI)
      return(FALSE);
   else
      return(TRUE);
}

/*
   Return the angle between two vectors on a plane
   The angle is from vector 1 to vector 2, positive anticlockwise
*/
double Angle2D(double x1,double y1,double x2,double y2)
{
   double dtheta,theta1,theta2;

   theta1 = atan2(y1,x1);
   theta2 = atan2(y2,x2);
   dtheta = theta2 - theta1;
   while (dtheta > PI)
      dtheta -= TWOPI;
   while (dtheta < -PI)
      dtheta += TWOPI;

   return(dtheta);
}

