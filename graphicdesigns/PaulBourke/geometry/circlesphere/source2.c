{
   XYZ origin={0.0,0.0,0.0},p1={0.0,1.0,1.0},p2={1.0,2.0,3.0};
   XYZ plane[3];
   XYZ n,p,r,s,p1p2;
   double theta,dtheta;

   p1p2 = VectorSub(p1,p2);
   p.x = rand(); /* Create a random vector */
   p.y = rand();
   p.z = rand();
   CROSSPROD(p1p2,p,r);
   CROSSPROD(p1p2,r,s);
   Normalise(&r);
   Normalise(&s);
   dtheta = TWOPI / 36;
   for (theta=0;theta&lt;TWOPI;theta+=dtheta) {
      n.x = r.x * cos(theta) + s.x * sin(theta);
      n.y = r.y * cos(theta) + s.y * sin(theta);
      n.z = r.z * cos(theta) + s.z * sin(theta);
      Normalise(&n);
      plane[0].x = p1.x + r.x * cos(theta) + s.x * sin(theta);
      plane[0].y = p1.y + r.y * cos(theta) + s.y * sin(theta);
      plane[0].z = p1.z + r.z * cos(theta) + s.z * sin(theta);
      plane[1]   = p1;
      plane[2].x = p1.x + r.x * cos(theta+dtheta) + s.x * sin(theta+dtheta);
      plane[2].y = p1.y + r.y * cos(theta+dtheta) + s.y * sin(theta+dtheta);
      plane[2].z = p1.z + r.z * cos(theta+dtheta) + s.z * sin(theta+dtheta);
      WRITE THE FACET "PLANE" IN WHATEVER FORMAT YOU LIKE
    }
}
