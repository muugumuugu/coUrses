/*-------------------------------------------------------------------------
   Create a contour slice through a 3 vertex facet "p"
   Given the normal of the cutting plane "n" and a point on the plane "p0"
   Return
       0 if the contour plane doesn't cut the facet
       2 if it does cut the facet, the contour line segment is p1->p2
      -1 for an unexpected occurence
   If a vertex touches the contour plane nothing need to be drawn!?
   Note: the following has been written as a "stand along" piece of
   code that will work but is far from efficient....
*/
int ContourFacet(XYZ *p,XYZ n,XYZ p0,XYZ *p1,XYZ *p2)
{
   double A,B,C,D;
   double l;
   double side[3];

   /*
      Determine the equation of the plane as
      Ax + By + Cz + D = 0
   */
   l = sqrt(n.x*n.x + n.y*n.y + n.z*n.z);
   A = n.x / l;
   B = n.y / l;
   C = n.z / l;
   D = -(n.x*p0.x + n.y*p0.y + n.z*p0.z);

   /*
      Evaluate the equation of the plane for each vertex
      If side < 0 then it is on the side to be retained
      else it is to be clipped
   */
   side[0] = A*p[0].x + B*p[0].y + C*p[0].z + D;
   side[1] = A*p[1].x + B*p[1].y + C*p[1].z + D;
   side[2] = A*p[2].x + B*p[2].y + C*p[2].z + D;

   /* Are all the vertices on the same side */
   if (side[0] >= 0 && side[1] >= 0 && side[2] >= 0)
      return(0);
   if (side[0] <= 0 && side[1] <= 0 && side[2] <= 0)
      return(0);

   /* Is p0 the only point on a side by itself */
   if ((SIGN(side[0]) != SIGN(side[1])) && (SIGN(side[0]) != SIGN(side[2]))) {
      p1->x = p[0].x - side[0] * (p[2].x - p[0].x) / (side[2] - side[0]);
      p1->y = p[0].y - side[0] * (p[2].y - p[0].y) / (side[2] - side[0]);
      p1->z = p[0].z - side[0] * (p[2].z - p[0].z) / (side[2] - side[0]);
      p2->x = p[0].x - side[0] * (p[1].x - p[0].x) / (side[1] - side[0]);
      p2->y = p[0].y - side[0] * (p[1].y - p[0].y) / (side[1] - side[0]);
      p2->z = p[0].z - side[0] * (p[1].z - p[0].z) / (side[1] - side[0]);
      return(2);
   }

   /* Is p1 the only point on a side by itself */
   if ((SIGN(side[1]) != SIGN(side[0])) && (SIGN(side[1]) != SIGN(side[2]))) {
      p1->x = p[1].x - side[1] * (p[2].x - p[1].x) / (side[2] - side[1]);
      p1->y = p[1].y - side[1] * (p[2].y - p[1].y) / (side[2] - side[1]);
      p1->z = p[1].z - side[1] * (p[2].z - p[1].z) / (side[2] - side[1]);
      p2->x = p[1].x - side[1] * (p[0].x - p[1].x) / (side[0] - side[1]);
      p2->y = p[1].y - side[1] * (p[0].y - p[1].y) / (side[0] - side[1]);
      p2->z = p[1].z - side[1] * (p[0].z - p[1].z) / (side[0] - side[1]);
      return(2);
   }

   /* Is p2 the only point on a side by itself */
   if ((SIGN(side[2]) != SIGN(side[0])) && (SIGN(side[2]) != SIGN(side[1]))) {
      p1->x = p[2].x - side[2] * (p[0].x - p[2].x) / (side[0] - side[2]);
      p1->y = p[2].y - side[2] * (p[0].y - p[2].y) / (side[0] - side[2]);
      p1->z = p[2].z - side[2] * (p[0].z - p[2].z) / (side[0] - side[2]);
      p2->x = p[2].x - side[2] * (p[1].x - p[2].x) / (side[1] - side[2]);
      p2->y = p[2].y - side[2] * (p[1].y - p[2].y) / (side[1] - side[2]);
      p2->z = p[2].z - side[2] * (p[1].z - p[2].z) / (side[1] - side[2]);
      return(2);
   }

   /* Shouldn't get here */
   return(-1);
}

