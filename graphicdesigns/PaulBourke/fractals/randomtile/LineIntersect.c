/*
   Return FALSE if the lines don't intersect
*/
int LineIntersect(double x1,double y1,double x2,double y2,double x3,double y3,double x4,double y4)
{
   double mua,mub;
   double denom,numera,numerb;

   denom  = (y4-y3) * (x2-x1) - (x4-x3) * (y2-y1);
   numera = (x4-x3) * (y1-y3) - (y4-y3) * (x1-x3);
   numerb = (x2-x1) * (y1-y3) - (y2-y1) * (x1-x3);

   // Are the line coincident?
   if (ABS(numera) < EPS && ABS(numerb) < EPS && ABS(denom) < EPS)
      return(TRUE);

   // Are the line parallel
   if (ABS(denom) < EPS)
      return(FALSE);

   // Is the intersection along the the segments
   mua = numera / denom;
   mub = numerb / denom;
   if (mua < 0 || mua > 1 || mub < 0 || mub > 1)
      return(FALSE);
  
   return(TRUE);
}

