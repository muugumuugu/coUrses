using System;
using System.Windows;
using System.Windows.Shapes;

namespace AnimatingObjectsAlongAPath
{
   public static class Helpers
   {

      /// <summary>
      /// This is based off an explanation and expanded math presented by Paul Bourke:
      /// 
      /// It takes two lines as inputs and returns true if they intersect, false if they 
      /// don't.
      /// If they do, ptIntersection returns the point where the two lines intersect.  
      /// </summary>
      /// <param name="L1">The first line</param>
      /// <param name="L2">The second line</param>
      /// <param name="ptIntersection">The point where both lines intersect (if they do).</param>
      /// <returns></returns>
      /// <remarks>See http://local.wasp.uwa.edu.au/~pbourke/geometry/lineline2d/</remarks>
      public static bool DoLinesIntersect(Line L1, Line L2, ref Point ptIntersection)
      {
         // Denominator for ua and ub are the same, so store this calculation
         double d =
            (L2.Y2 - L2.Y1) * (L1.X2 - L1.X1)
            -
            (L2.X2 - L2.X1) * (L1.Y2 - L1.Y1);

         //n_a and n_b are calculated as seperate values for readability
         double n_a =
            (L2.X2 - L2.X1) * (L1.Y1 - L2.Y1)
            -
            (L2.Y2 - L2.Y1) * (L1.X1 - L2.X1);

         double n_b =
            (L1.X2 - L1.X1) * (L1.Y1 - L2.Y1)
            -
            (L1.Y2 - L1.Y1) * (L1.X1 - L2.X1);

         // Make sure there is not a division by zero - this also indicates that
         // the lines are parallel.  
         // If n_a and n_b were both equal to zero the lines would be on top of each 
         // other (coincidental).  This check is not done because it is not 
         // necessary for this implementation (the parallel check accounts for this).
         if (d == 0)
            return false;

         // Calculate the intermediate fractional point that the lines potentially intersect.
         double ua = n_a / d;
         double ub = n_b / d;

         // The fractional point will be between 0 and 1 inclusive if the lines
         // intersect.  If the fractional calculation is larger than 1 or smaller
         // than 0 the lines would need to be longer to intersect.
         if (ua >= 0d && ua <= 1d && ub >= 0d && ub <= 1d)
         {
            ptIntersection.X = L1.X1 + (ua * (L1.X2 - L1.X1));
            ptIntersection.Y = L1.Y1 + (ua * (L1.Y2 - L1.Y1));
            return true;
         }
         return false;
      }
   }
}
