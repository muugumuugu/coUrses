/*
   Create a unit sphere centered at the origin
   This code illustrates the concept rather than implements it efficiently
   It is called with two arguments, the theta and phi angle increments in degrees
   Note that at the poles only 3 vertex facet result
        while the rest of the sphere has 4 point facets
*/
void CreateUnitSphere(int dtheta,int dphi)
{
   int n;
   int theta,phi;
   XYZ p[4];

   for (theta=-90;theta<=90-dtheta;theta+=dtheta) {
      for (phi=0;phi<=360-dphi;phi+=dphi) {
         n = 0;
         p[n].x = cos(theta*DTOR) * cos(phi*DTOR);
         p[n].y = cos(theta*DTOR) * sin(phi*DTOR);
         p[n].z = sin(theta*DTOR);
         n++;
         p[n].x = cos((theta+dtheta)*DTOR) * cos(phi*DTOR);
         p[n].y = cos((theta+dtheta)*DTOR) * sin(phi*DTOR);
         p[n].z = sin((theta+dtheta)*DTOR);
         n++;
         p[n].x = cos((theta+dtheta)*DTOR) * cos((phi+dphi)*DTOR);
         p[n].y = cos((theta+dtheta)*DTOR) * sin((phi+dphi)*DTOR);
         p[n].z = sin((theta+dtheta)*DTOR);
         n++;
         if (theta > -90 && theta < 90) {
            p[n].x = cos(theta*DTOR) * cos((phi+dphi)*DTOR);
            p[n].y = cos(theta*DTOR) * sin((phi+dphi)*DTOR);
            p[n].z = sin(theta*DTOR);
            n++;
         }

         /* Do something with the n vertex facet p */

      }
   }
}
