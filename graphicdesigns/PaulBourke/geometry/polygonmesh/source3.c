/*-------------------------------------------------------------------------
   Clip a 3 vertex facet in place
   The 3 point facet is defined by vertices p[0],p[1],p[2], "p[3]"
      There must be a fourth point as a 4 point facet may result
   The normal to the plane is n
   A point on the plane is p0
   The side of the plane containing the normal is clipped away
   Return the number of vertices in the clipped polygon
*/
int ClipFacet(XYZ *p,XYZ n,XYZ p0)
{
   double A,B,C,D;
   double l;
   double side[3];
   XYZ q;

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
      else it is to be clippped
   */
   side[0] = A*p[0].x + B*p[0].y + C*p[0].z + D;
   side[1] = A*p[1].x + B*p[1].y + C*p[1].z + D;
   side[2] = A*p[2].x + B*p[2].y + C*p[2].z + D;

   /* Are all the vertices are on the clipped side */
   if (side[0] >= 0 && side[1] >= 0 && side[2] >= 0)
      return(0);

   /* Are all the vertices on the not-clipped side */
   if (side[0] <= 0 && side[1] <= 0 && side[2] <= 0)
      return(3);

   /* Is p0 the only point on the clipped side */
   if (side[0] > 0 && side[1] < 0 && side[2] < 0) {
      q.x = p[0].x - side[0] * (p[2].x - p[0].x) / (side[2] - side[0]);
      q.y = p[0].y - side[0] * (p[2].y - p[0].y) / (side[2] - side[0]);
      q.z = p[0].z - side[0] * (p[2].z - p[0].z) / (side[2] - side[0]);
      p[3] = q;
      q.x = p[0].x - side[0] * (p[1].x - p[0].x) / (side[1] - side[0]);
      q.y = p[0].y - side[0] * (p[1].y - p[0].y) / (side[1] - side[0]);
      q.z = p[0].z - side[0] * (p[1].z - p[0].z) / (side[1] - side[0]);
      p[0] = q;
      return(4);
   }

   /* Is p1 the only point on the clipped side */
   if (side[1] > 0 && side[0] < 0 && side[2] < 0) {
      p[3] = p[2];
      q.x = p[1].x - side[1] * (p[2].x - p[1].x) / (side[2] - side[1]);
      q.y = p[1].y - side[1] * (p[2].y - p[1].y) / (side[2] - side[1]);
      q.z = p[1].z - side[1] * (p[2].z - p[1].z) / (side[2] - side[1]);
      p[2] = q;
      q.x = p[1].x - side[1] * (p[0].x - p[1].x) / (side[0] - side[1]);
      q.y = p[1].y - side[1] * (p[0].y - p[1].y) / (side[0] - side[1]);
      q.z = p[1].z - side[1] * (p[0].z - p[1].z) / (side[0] - side[1]);
      p[1] = q;
      return(4);
   }

   /* Is p2 the only point on the clipped side */
   if (side[2] > 0 && side[0] < 0 && side[1] < 0) {
      q.x = p[2].x - side[2] * (p[0].x - p[2].x) / (side[0] - side[2]);
      q.y = p[2].y - side[2] * (p[0].y - p[2].y) / (side[0] - side[2]);
      q.z = p[2].z - side[2] * (p[0].z - p[2].z) / (side[0] - side[2]);
      p[3] = q;
      q.x = p[2].x - side[2] * (p[1].x - p[2].x) / (side[1] - side[2]);
      q.y = p[2].y - side[2] * (p[1].y - p[2].y) / (side[1] - side[2]);
      q.z = p[2].z - side[2] * (p[1].z - p[2].z) / (side[1] - side[2]);
      p[2] = q;
      return(4);
   }

   /* Is p0 the only point on the not-clipped side */
   if (side[0] < 0 && side[1] > 0 && side[2] > 0) {
      q.x = p[0].x - side[0] * (p[1].x - p[0].x) / (side[1] - side[0]);
      q.y = p[0].y - side[0] * (p[1].y - p[0].y) / (side[1] - side[0]);
      q.z = p[0].z - side[0] * (p[1].z - p[0].z) / (side[1] - side[0]);
      p[1] = q;
      q.x = p[0].x - side[0] * (p[2].x - p[0].x) / (side[2] - side[0]);
      q.y = p[0].y - side[0] * (p[2].y - p[0].y) / (side[2] - side[0]);
      q.z = p[0].z - side[0] * (p[2].z - p[0].z) / (side[2] - side[0]);
      p[2] = q;
      return(3);
   }

   /* Is p1 the only point on the not-clipped side */
   if (side[1] < 0 && side[0] > 0 && side[2] > 0) {
      q.x = p[1].x - side[1] * (p[0].x - p[1].x) / (side[0] - side[1]);
      q.y = p[1].y - side[1] * (p[0].y - p[1].y) / (side[0] - side[1]);
      q.z = p[1].z - side[1] * (p[0].z - p[1].z) / (side[0] - side[1]);
      p[0] = q;
      q.x = p[1].x - side[1] * (p[2].x - p[1].x) / (side[2] - side[1]);
      q.y = p[1].y - side[1] * (p[2].y - p[1].y) / (side[2] - side[1]);
      q.z = p[1].z - side[1] * (p[2].z - p[1].z) / (side[2] - side[1]);
      p[2] = q;
      return(3);
   }

   /* Is p2 the only point on the not-clipped side */
   if (side[2] < 0 && side[0] > 0 && side[1] > 0) {
      q.x = p[2].x - side[2] * (p[1].x - p[2].x) / (side[1] - side[2]);
      q.y = p[2].y - side[2] * (p[1].y - p[2].y) / (side[1] - side[2]);
      q.z = p[2].z - side[2] * (p[1].z - p[2].z) / (side[1] - side[2]);
      p[1] = q;
      q.x = p[2].x - side[2] * (p[0].x - p[2].x) / (side[0] - side[2]);
      q.y = p[2].y - side[2] * (p[0].y - p[2].y) / (side[0] - side[2]);
      q.z = p[2].z - side[2] * (p[0].z - p[2].z) / (side[0] - side[2]);
      p[0] = q;
      return(3);
   }

   /* Shouldn't get here */
   return(-1);
}

