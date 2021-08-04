/// <summary>
/// Calculates the intersection line segment between 2 lines (not segments).
/// Returns false if no solution can be found.
/// </summary>
/// <returns></returns>
public static bool CalculateLineLineIntersection(Vector3 line1Point1, Vector3 line1Point2, 
	Vector3 line2Point1, Vector3 line2Point2, out Vector3 resultSegmentPoint1, out Vector3 resultSegmentPoint2)
{
   // Algorithm is ported from the C algorithm of 
   // Paul Bourke at http://local.wasp.uwa.edu.au/~pbourke/geometry/lineline3d/
   resultSegmentPoint1 = Vector3.Empty;
   resultSegmentPoint2 = Vector3.Empty;
 
   Vector3 p1 = line1Point1;
   Vector3 p2 = line1Point2;
   Vector3 p3 = line2Point1;
   Vector3 p4 = line2Point2;
   Vector3 p13 = p1 - p3;
   Vector3 p43 = p4 - p3;
 
   if (p43.LengthSq() < Math.Epsilon) {
      return false;
   }
   Vector3 p21 = p2 - p1;
   if (p21.LengthSq() < Math.Epsilon) {
      return false;
   }
 
   double d1343 = p13.X * (double)p43.X + (double)p13.Y * p43.Y + (double)p13.Z * p43.Z;
   double d4321 = p43.X * (double)p21.X + (double)p43.Y * p21.Y + (double)p43.Z * p21.Z;
   double d1321 = p13.X * (double)p21.X + (double)p13.Y * p21.Y + (double)p13.Z * p21.Z;
   double d4343 = p43.X * (double)p43.X + (double)p43.Y * p43.Y + (double)p43.Z * p43.Z;
   double d2121 = p21.X * (double)p21.X + (double)p21.Y * p21.Y + (double)p21.Z * p21.Z;
 
   double denom = d2121 * d4343 - d4321 * d4321;
   if (Math.Abs(denom) < Math.Epsilon) {
      return false;
   }
   double numer = d1343 * d4321 - d1321 * d4343;
 
   double mua = numer / denom;
   double mub = (d1343 + d4321 * (mua)) / d4343;
 
   resultSegmentPoint1.X = (float)(p1.X + mua * p21.X);
   resultSegmentPoint1.Y = (float)(p1.Y + mua * p21.Y);
   resultSegmentPoint1.Z = (float)(p1.Z + mua * p21.Z);
   resultSegmentPoint2.X = (float)(p3.X + mub * p43.X);
   resultSegmentPoint2.Y = (float)(p3.Y + mub * p43.Y);
   resultSegmentPoint2.Z = (float)(p3.Z + mub * p43.Z);

   return true;
}

