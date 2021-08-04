c
c========================================================================
c========================================================================
c
c     Triangulation subroutine
c     
c     Takes as input NVERT vertices in arrays X() and Y()
c
c     Returned is a list of NTRI triangular faces in the arrays 
c     V1(), V2(), V3(). These triangles are arranged in clockwise order.
c
      subroutine triangulate(nvert,x,y,v1,v2,v3,ntri)
c     -----------------------------------------------
      implicit none
      integer*4 nmax,vmax
      parameter (nmax = 6000,vmax = 12000)
      integer*4 edgemax
      parameter (edgemax = 100)
c
      integer*4 nvert,ntri
      integer*4 v1(vmax),v2(vmax),v3(vmax)
      real*4 x(nmax),y(nmax)
      logical*1 complete(vmax)
c
c     External function declarations
c
      logical incircum
c
c     Declarations
c
      logical inc
      integer*4 edges(1:2,1:edgemax),nedge
      integer*4 i,j,k,p1,p2,p3
      real*4 xp,yp,x1,y1,x2,y2,x3,y3,xc,yc,r
      real*4 xmin,xmax,ymin,ymax,xmid,ymid,dx,dy,dmax
c
c     Find the maximum and minimum vertex bounds.
c     This is to allow calculation of the bounding triangle
c
      xmin = x(1)
      ymin = y(1)
      xmax = xmin
      ymax = ymin
      do 100 i=2,nvert
         x1 = x(i)
         y1 = y(i)
         xmin = min(x1,xmin)
         xmax = max(x1,xmax)
         ymin = min(y1,ymin)
         ymax = max(y1,ymax)
100   continue
      dx = xmax - xmin
      dy = ymax - ymin
      dmax = max(dx,dy)
      xmid = (xmax+xmin) / 2.0
      ymid = (ymax+ymin) / 2.0
c
c     Set up the supertriangle
c     This is a triangle which encompasses all the sample points.
c     The supertriangle coordinates are added to the end of the 
c     vertex list. The supertriangle is the first triangle in
c     the triangle list.
c
      p1 = nvert+1
      p2 = nvert+2
      p3 = nvert+3
      x(p1) = xmid - 20 * dmax
      y(p1) = ymid - dmax
      x(p2) = xmid
      y(p2) = ymid + 20 * dmax
      x(p3) = xmid + 20 * dmax
      y(p3) = ymid - dmax
      v1(1) = p1
      v2(1) = p2
      v3(1) = p3
      complete(1) = .FALSE.
      ntri = 1
c
c     Include each point one at a time into the existing mesh
c
      do 1000 i=1,nvert
         write(9,*) 'TRIANGULATE - I - point #',i
         xp = x(i)
         yp = y(i)
         nedge = 0
c
c        Set up the edge buffer. 
c        If the point (xp,yp) lies inside the circumcircle then the
c        three edges of that triangle are added to the edge buffer.
c
         j = 0
600      continue
            j = j + 1
            if (complete(j)) goto 500
            p1 = v1(j)
            p2 = v2(j)
            p3 = v3(j)
            x1 = x(p1)
            y1 = y(p1)
            x2 = x(p2)
            y2 = y(p2)
            x3 = x(p3)
            y3 = y(p3)
            inc = incircum(xp,yp,x1,y1,x2,y2,x3,y3,xc,yc,r)
            if (xc+r.lt.xp) then
               complete(j) = .TRUE.
               goto 500
            endif
            if (inc) then
               if (nedge+3.gt.edgemax) then
                  call cls
                  write(9,*) 'TRIANGULATE - F - edge buffer full'
                  pause
                  stop
               endif
               edges(1,nedge+1) = p1
               edges(2,nedge+1) = p2
               edges(1,nedge+2) = p2
               edges(2,nedge+2) = p3
               edges(1,nedge+3) = p3
               edges(2,nedge+3) = p1
               nedge = nedge + 3
               v1(j) = v1(ntri)
               v2(j) = v2(ntri)
               v3(j) = v3(ntri)
               complete(j) = complete(ntri)
               j = j - 1
               ntri = ntri - 1
            endif
500      if (j.lt.ntri) goto 600
c
c        Tag multiple edges
c        Note: if all triangles are specified anticlockwise then all
c              interior edges are opposite pointing in direction.
c
         do 700 j=1,nedge-1
            if (edges(1,j).eq.0 .and. edges(2,j).eq.0) goto 700
            do 650 k=j+1,nedge
               if (edges(1,k).eq.0 .and. edges(2,k).eq.0) goto 650
               if (edges(1,j).eq.edges(2,k)) then
                  if (edges(2,j).eq.edges(1,k)) then
                     edges(1,j) = 0
                     edges(2,j) = 0
                     edges(1,k) = 0
                     edges(2,k) = 0
                  endif
               endif
650         continue
700      continue
c
c        Form new triangles for the current point
c        Skipping over any tagged edges. 
c        All edges are arranged in clockwise order.
c
         do 900 j=1,nedge
            if (edges(1,j).eq.0 .and. edges(2,j).eq.0) goto 900
            ntri = ntri + 1
            v1(ntri) = edges(1,j)
            v2(ntri) = edges(2,j)
            v3(ntri) = i
            complete(ntri) = .FALSE.
900      continue
1000  continue
c
c     Remove triangles with supertriangle vertices
c     These are triangles which have a vertex number greater than NVERT
c
      i = 0
2000  continue
         i = i + 1
         if ((v1(i).gt.nvert) .or.
     +       (v2(i).gt.nvert) .or.
     +       (v3(i).gt.nvert)) then
            v1(i) = v1(ntri)
            v2(i) = v2(ntri)
            v3(i) = v3(ntri)
            i = i - 1
            ntri = ntri - 1
         endif
      if (i.lt.ntri) goto 2000
c
      return
      end
c
c========================================================================
c
c     Returns the z coordinate of the point (xp,yp) on the plane
c     which passes though the vertices (x1,y1) (x2,y2) (x3,y3)
c
      real*4 function plane(xp,yp,x1,y1,z1,x2,y2,z2,x3,y3,z3)
c     -------------------------------------------------------
      implicit none
      real*4 x1,y1,z1,x2,y2,z2,x3,y3,z3,xp,yp
      real*4 a,b,c,d
c
      a = y1 * (z2-z3) + y2 * (z3-z1) + y3 * (z1-z2)
      b = z1 * (x2-x3) + z2 * (x3-x1) + z3 * (x1-x2)
      c = x1 * (y2-y3) + x2 * (y3-y1) + x3 * (y1-y2)
      d = -x1*(y2*z3-y3*z2) - x2*(y3*z1-y1*z3) - x3*(y1*z2-y2*z1)
      if (c.ne.0) then
         plane = - (a * xp + b * yp + d) / c
      else
         plane = 0.0
      endif
c
      return
      end
c
c========================================================================
c
c     Determines which side of a line the point (xp,yp) lies.
c     The line goes from (x1,y1) to (x2,y2)
c
c     Return codes are -1 for points to the left
c                       0 for points on the line
c                      +1 for points to the right
c
      integer*4 function whichside(xp,yp,x1,y1,x2,y2)
c     -----------------------------------------------
      implicit none
      real*4 x1,y1,x2,y2,xp,yp
      real*4 equation
c
      equation = (yp-y1)*(x2-x1) - (y2-y1)*(xp-x1)
      if (equation.gt.0) then
         whichside = -1
      else if (equation.eq.0) then
         whichside = 0
      else
         whichside = 1
      endif
c
      return
      end
c
c========================================================================
c
c     Returns TRUE if the point (xp,yp) lies inside the triangle
c     with the vertices (x1,y1) (x2,y2) (x3,y3)
c
c     NOTE: The vertices must be specified in a clockwise order
c           A point on the edge is inside the triangle
c
c     A point is in the centre if it is to the right of all the edges
c
      logical function intriang(xp,yp,x1,y1,x2,y2,x3,y3)
c     --------------------------------------------------
      implicit none
      real*4 x1,y1,x2,y2,x3,y3,xp,yp
      integer*4 whichside
c
      intriang = .FALSE.
      if (whichside(xp,yp,x1,y1,x2,y2).ne.1) return
      if (whichside(xp,yp,x2,y2,x3,y3).ne.1) return
      if (whichside(xp,yp,x3,y3,x1,y1).ne.1) return
c
      intriang = .TRUE.
      return
      end
c
c========================================================================
c
c     Return TRUE if the point (xp,yp) lies inside the circumcircle
c     made up by points (x1,y1) (x2,y2) (x3,y3)
c
c     The circumcircle centre is returned in (xc,yc) and the radius r
c
c     NOTE: A point on the edge is inside the circumcircle
c
      logical function incircum(xp,yp,x1,y1,x2,y2,x3,y3,xc,yc,r)
c     ----------------------------------------------------------
      implicit none
      real*4 xp,yp,x1,y1,x2,y2,x3,y3,xc,yc,r
      real*4 eps
      parameter (eps = 1.0e-6)
c
      real*4 m1,m2,mx1,mx2,my1,my2
      real*4 dx,dy,rsqr,drsqr
c
      incircum = .FALSE.
      if (abs(y1-y2).lt.eps .and. abs(y2-y3).lt.eps) then
         write(9,*) 'INCIRCUM - F - Points are coincident !!'
         pause
         stop
      endif
c
      if (abs(y2-y1).lt.eps) then
         m2 = - (x3-x2) / (y3-y2)
         mx2 = (x2 + x3) / 2.0
         my2 = (y2 + y3) / 2.0
         xc = (x2 + x1) / 2.0
         yc = m2 * (xc - mx2) + my2
      else if (abs(y3-y2).lt.eps) then
         m1 = - (x2-x1) / (y2-y1)
         mx1 = (x1 + x2) / 2.0
         my1 = (y1 + y2) / 2.0
         xc = (x3 + x2) / 2.0
         yc = m1 * (xc - mx1) + my1
      else
         m1 = - (x2-x1) / (y2-y1)
         m2 = - (x3-x2) / (y3-y2)
         mx1 = (x1 + x2) / 2.0
         mx2 = (x2 + x3) / 2.0
         my1 = (y1 + y2) / 2.0
         my2 = (y2 + y3) / 2.0
         xc = (m1*mx1 - m2*mx2 + my2 - my1) / (m1 - m2)
         yc = m1 * (xc - mx1) + my1
      endif
      dx = x2 - xc
      dy = y2 - yc
      rsqr = dx*dx + dy*dy
      r = sqrt(rsqr)
c
      dx = xp - xc
      dy = yp - yc
      drsqr = dx*dx + dy*dy
      if (drsqr.le.rsqr) incircum = .TRUE.
c
      return
      end
