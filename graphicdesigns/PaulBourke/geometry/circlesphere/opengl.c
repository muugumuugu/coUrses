/*
   Create a cone/cylinder uncapped between end points p1, p2
   radius r1, r2, and precision m
   Create the cylinder between theta1 and theta2 in radians
*/
void CreateCone(XYZ p1,XYZ p2,double r1,double r2,int m,
   double theta1,double theta2)
{
   int i,j;
   double theta;
   XYZ n,p,q,perp;

   /* Normal pointing from p1 to p2 */
   n.x = p1.x - p2.x;
   n.y = p1.y - p2.y;
   n.z = p1.z - p2.z;

   /*
      Create two perpendicular vectors perp and q
      on the plane of the disk
   */
   perp = n;
   if (n.x == 0 && n.z == 0)
      perp.x += 1;
   else
      perp.y += 1;
   CROSSPROD(perp,n,q);
   CROSSPROD(n,q,perp);
   Normalise(&perp);
   Normalise(&q);

   glBegin(GL_QUAD_STRIP);
   for (i=0;i<=m;i++) {
      theta = theta1 + i * (theta2 - theta1) / m;

      n.x = cos(theta) * perp.x + sin(theta) * q.x;
      n.y = cos(theta) * perp.y + sin(theta) * q.y;
      n.z = cos(theta) * perp.z + sin(theta) * q.z;
      Normalise(&n);

      p.x = p2.x + r2 * n.x;
      p.y = p2.y + r2 * n.y;
      p.z = p2.z + r2 * n.z;
      glNormal3f(n.x,n.y,n.z);
      glTexCoord2f(i/(double)m,1.0);
      glVertex3f(p.x,p.y,p.z);

      p.x = p1.x + r1 * n.x;
      p.y = p1.y + r1 * n.y;
      p.z = p1.z + r1 * n.z;
      glNormal3f(n.x,n.y,n.z);
      glTexCoord2f(i/(double)m,0.0);
      glVertex3f(p.x,p.y,p.z);
   }
   glEnd();
}

