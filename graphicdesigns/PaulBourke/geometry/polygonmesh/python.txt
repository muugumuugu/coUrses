class Point:

   def __init__(self, x,y):
       self.x = x
       self.y = y

class Contour:

   def __init__(self, a):
       self.pts = a

   def area(self):
       area=0
       pts = self.pts;
       nPts = len(pts)
       j=nPts-1
       i = 0
       for point in pts:
           p1=pts[i]
           p2=pts[j]
           area+= (p1.x*p2.y)
           area-=p1.y*p2.x
           j=i
           i+=1

       area/=2;
       return area;

   def centroid(self):
     pts = self.pts;
     nPts = len(pts)
     x=0
     y=0
     j=nPts-1;
     i = 0

     for point in pts:
         p1=pts[i]
         p2=pts[j]
         f=p1.x*p2.y-p2.x*p1.y
         x+=(p1.x+p2.x)*f
         y+=(p1.y+p2.y)*f
         j=i
         i+=1


     f=self.area()*6
     return Point(x/f,y/f)

