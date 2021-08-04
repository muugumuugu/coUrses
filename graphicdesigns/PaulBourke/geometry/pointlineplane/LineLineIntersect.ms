/*
   Calculate the line segment PaPb that is the shortest route between
   two lines P1P2 and P3P4. Calculate also the values of mua and mub where
      Pa = P1 + mua (P2 - P1)
      Pb = P3 + mub (P4 - P3)
   Return FALSE if no solution exists.

   p1 thru p4 and pa and pb are of type Point3
*/
function LineLineIntersect p1 p2 p3 p4 &pa &pb = 
(
   local EPS = 2e-6;
   
   local p13 = Point3 0 0 0
   local p43 = Point3 0 0 0
   local p21 = Point3 0 0 0
   
   local d1343,d4321,d1321,d4343,d2121;
   local numer,denom;

   p13.x = p1.x - p3.x;
   p13.y = p1.y - p3.y;
   p13.z = p1.z - p3.z;
   p43.x = p4.x - p3.x;
   p43.y = p4.y - p3.y;
   p43.z = p4.z - p3.z;
   if ( (ABS(p43.x) < EPS) and \
   		(ABS(p43.y) < EPS) and \
   		(ABS(p43.z) < EPS) ) do (return false)
   p21.x = p2.x - p1.x;
   p21.y = p2.y - p1.y;
   p21.z = p2.z - p1.z;
   if (	(ABS(p21.x) < EPS) and \
   		(ABS(p21.y) < EPS) and \
   		(ABS(p21.z) < EPS) ) do (return false)

   d1343 = p13.x * p43.x + p13.y * p43.y + p13.z * p43.z;
   d4321 = p43.x * p21.x + p43.y * p21.y + p43.z * p21.z;
   d1321 = p13.x * p21.x + p13.y * p21.y + p13.z * p21.z;
   d4343 = p43.x * p43.x + p43.y * p43.y + p43.z * p43.z;
   d2121 = p21.x * p21.x + p21.y * p21.y + p21.z * p21.z;

   denom = d2121 * d4343 - d4321 * d4321;
   if (ABS(denom) < EPS) do (return false)
   numer = d1343 * d4321 - d1321 * d4343;

   local mua = numer / denom;
   local mub = (d1343 + d4321 * (mua)) / d4343;

   pa.x = p1.x + (mua * p21.x);
   pa.y = p1.y + (mua * p21.y);
   pa.z = p1.z + (mua * p21.z);
   pb.x = p3.x + (mub * p43.x);
   pb.y = p3.y + (mub * p43.y);
   pb.z = p3.z + (mub * p43.z);

   return true;
)
