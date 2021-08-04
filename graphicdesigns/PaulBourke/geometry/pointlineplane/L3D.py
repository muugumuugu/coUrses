## L3D.py (module 'L3D') Version 1.05
## Copyright (c) 2006 Bruce Vaughan, BV Detailing & Design, Inc.
## All rights reserved.
## NOT FOR SALE. The software is provided "as is" without any warranty.
################################################################################
from math import sqrt
from point import Point
################################################################################
"""
    LineLineIntersect3D (class) - Determine information about the intersection of two line segments in 3D space
    DistancePointLine3D (class) - Determine information about the relationship between a line segment and a point in 3D space
    ret_WP (class) - Return the WP on member 1 and which end of member 2 coincides

    Revision History:
        Version 1.02 - Add attributes obj.Pa and obj.Pb to a DistancePointLine3D instance
        Version 1.03 (10/30/06) - Rework calculation of self.position
                                  Consolidate comments
                                  add function ret_WP
        Version 1.04 (11/16/06) - Rework LineLineIntersect3D - solve using like triangles
        Version 1.05 (11/17/06) - Rework LineLineIntersect3D - solve for unknowns by substitution

    Reference 'The Shortest Line Between Two Lines in 3D' - Paul Bourke   
"""
class LineLineIntersect3D:        
    def __init__(self, p1, p2, p3, p4):
        from param import Warning
        """                                                                                                                       <-->     <-->
            Calculate the points in 3D space Pa and Pb that define the line segment which is the shortest route between two lines p1p2 and p3p4.
            Each point occurs at the apparent intersection of the 3D lines.
            The apparent intersection is defined here as the location where the two lines 'appear' to intersect when viewed along the line segment PaPb.
            Equation for each line:
            Pa = p1 + ma(p2-p1)
            Pb = p3 + mb(p4-p3)
            
            Pa lies on the line connecting p1p2.
            Pb lies on the line connecting p3p4.

            The shortest line segment is perpendicular to both lines. Therefore:
            (Pa-Pb).(p2-p1) = 0
            (Pa-Pb).(p4-p3) = 0

            Where:            
            '.' indicates the dot product            

            A = p1-p3
            B = p2-p1
            C = p4-p3

            Substituting:
            (A + ma(B) - mb(C)).B = 0       &       (A + ma(B) - mb(C)).C = 0
            -----------------------------------------------------------------
            A.B + ma(B.B) - mb(C.B) = 0
            A.B + ma(B.B) - (ma(C.B)-A.C)/C.C)(C.B) = 0
            ma(B.B)(C.C) - ma(C.B)(C.B) = (A.C)(C.B)-(A.B)(C.C)
            ma = ((A.C)(C.B)-(A.B)(C.C))/((B.B)(C.C) - (C.B)(C.B))
            mb = (A.B + ma(B.B))/(C.B)

            If the cross product magnitude of the two lines is equal to 0.0, the lines are parallel.          
                                                                                                                                                 <-->
            A line extends forever in both directions. The name of a line passing through two different points p1 and p2 would be "line p1p2" or p1p2.                                           
            The two-headed arrow over p1p2 signifies a line passing through points p1 and p2.

            Two lines which have no actual intersection but are not parallel are called 'skew' or 'agonic' lines. Skew lines can only exist in
            three or more dimensions.

            Determine whether the apparent intersection point lies between the line segment end points or beyond one of the line segment end points.
            This information is to be used to evaluate the framing condition of mem1 (p1p2).
            Convention for members:
                p1p2 - mem1.left.location, mem1.right.location
                p3p4 - mem2.left.location, mem2.right.location
                
            Set a keyword indicating the apparent intersection point position with respect to the line segment end points p1 and p2 as follows:
                'LE' indicates the apparent intersection point occurs at p1 (within fudge_factor distance)
                'RE' indicates the apparent intersection point occurs at p2 (within fudge_factor distance)
                'Beyond LE' indicates the apparent intersection point occurs beyond p1
                'Beyond RE' indicates the apparent intersection point occurs beyond p2
                'Not Beyond LE' indicates the apparent intersection point occurs in between p1 and p2 and is closer to p1
                'Not Beyond RE' indicates the apparent intersection point occurs in between p1 and p2 and is closer to p2
            Calculate the magnitude and direction (beam member 'X' distance) the apparent intersection point occurs from line segment p1p2 end points.
        """
        def cross_product(p1, p2):
            return Point(p1.y*p2.z - p1.z*p2.y, p1.z*p2.x - p1.x*p2.z, p1.x*p2.y - p1.y*p2.x)

        def dot_product(p1, p2):
            return (p1.x*p2.x + p1.y*p2.y + p1.z*p2.z)

        def mag(p):
            return sqrt(p.x**2 + p.y**2 + p.z**2)        

        def normalise(p1, p2):
            p = p2 - p1
            m = mag(p)
            if m == 0:
                return Point(0.0, 0.0, 0.0)
            else:
                return Point(p.x/m, p.y/m, p.z/m)

        def ptFactor(p, f):
            return Point(p.x*f, p.y*f, p.z*f)

        A = p1-p3
        B = p2-p1
        C = p4-p3

        # Line p1p2 and p3p4 unit vectors
        self.uv1 = normalise(p1, p2)
        self.uv2 = normalise(p3, p4)        

        # Check for parallel lines
        self.cp12 = cross_product(self.uv1, self.uv2)
        self._cp12_ = mag(self.cp12)

        if round(self._cp12_, 6) != 0.0:         
            ma = ((dot_product(A, C)*dot_product(C, B)) - (dot_product(A, B)*dot_product(C, C)))/ \
                 ((dot_product(B, B)*dot_product(C, C)) - (dot_product(C, B)*dot_product(C, B)))
            mb = (ma*dot_product(C, B) + dot_product(A, C))/ dot_product(C, C)
            
            # Calculate the point on line 1 that is the closest point to line 2
            Pa = p1 + ptFactor(B, ma)
            self.Pmem1 = Pa
            
            # Calculate the point on line 2 that is the closest point to line 1
            Pb = p3 + ptFactor(C, mb)
            self.Pmem2 = Pb
            
            # Distance between lines            
            self.inters_dist = Pa.dist(Pb)
            
            if round(ma, 3) >= 0.0 and round(ma, 3) <= 1.0:
                self.on_segment1 = 1
                xl_dir = 1
                xr_dir = -1
                if round(ma, 2) == 0.0:
                    self.position = "LE" # apparent intersection is at p1
                elif round(ma, 2) == 1.0:
                    self.position = "RE" # apparent intersection is at p2
                    xr_dir = 1
                    xl_dir = 1
                elif ma <= 0.5:
                    self.position = "Not Beyond LE" # apparent intersection is closer to p1
                elif ma > 0.5:
                    self.position = "Not Beyond RE" # apparent intersection is closer to p2
                else:
                    Warning('self.position calculation error, self.on_segment = 1')
                    raise ValueError
            else:
                self.on_segment1 = 0
                if ma < 0.0:
                    self.position = "Beyond LE" # apparent intersection is beyond p1
                    xl_dir = -1
                    xr_dir = -1
                elif ma > 0.0:
                    self.position = "Beyond RE" # apparent intersection is beyond p2
                    xl_dir = 1
                    xr_dir = 1
                else:
                    Warning('self.position calculation error, self.on_segment = 0')
                    raise ValueError

            # Set the member 'X' direction with respect to p1 and p2 - either '+' or '-'
            self.left_dist = round(Pa.dist(p1)*xl_dir, 8)
            self.right_dist = round(Pa.dist(p2)*xr_dir, 8)                

            if round(mb, 3) >= 0.0 and round(mb, 3) <= 1.0:
                self.on_segment2 = 1
            else:
                self.on_segment2 = 0
            
            # Calculate the unit vector of PaPb
            if round(self.inters_dist, 4) > 0.0:
                self.uv = normalise(Pb, Pa)
            else:
                self.uv = Point(0.0, 0.0, 0.0)
                
        # Lines are parallel
        else:
            self.Pmem1 = None
            self.Pmem2 = None
            self.inters_dist = None
            self.left_dist = None
            self.right_dist = None
            self.uv = None

    # Return False if lines are parallel, and return True if lines are not parallel        
    def not_parallel(self):
        if round(self._cp12_, 5) != 0.0:
            return True
        else:
            return False 
# end class definition
##############################################################################################
## Determine information about the relationship between a line segment and a point in 3D space
class DistancePointLine3D:
    def __init__(self, p1, p2, Pb):
        """
            Points p1 and p2 are the end points of member #1.
            Point Pb is a point that lies on member #2.
            Calculate the minimum distance in 3D space between point Pb and line p1p2.
            Point Pb is closest to line p1p2 at an intersecting perpendicular line PaPb. Pa lies on line p1p2.
            The dot product of two vectors, A and B, will equal the cosine of the angle between the vectors, times the length of each vector.
            A dot B = A.x * B.x + A.y * B.y + A.z * B.z
            If the vectors are unit vectors, the dot product is equal to the cosine of the angle between the vectors.
            Since the angle between lines p1p2 and PaPb is 90 degrees, the dot product of vector p1p2 and vector PaPb is 0 (cos(90 deg)=0).
            Determine location of point Pa and the scalar distance from point Pb.

            If the calculation result for 'u' is between 0 and 1, Pa lies on line segment p1p2.

            Determine whether point Pa lies between the line segment end points or beyond one of the line segment end points.
            Set a keyword indicating point Pa position with respect to the line segment end points as follows:
                'LE' indicates Pa occurs at p1 (within fudge_factor distance)
                'RE' indicates Pa occurs at p2 (within fudge_factor distance)
                'Beyond LE' indicates Pa occurs beyond p1
                'Beyond RE' indicates Pa occurs beyond p2
                'Not Beyond LE' indicates Pa occurs in between p1 and p2 and is closer to p1
                'Not Beyond RE' indicates Pa occurs in between p1 and p2 and is closer to p2
            Calculate the scalar distance and direction (beam member 'X' distance) Pa occurs from each line segment end point.                
        """
        
        Pa = Point(0.0, 0.0, 0.0)
        u = (((Pb.x-p1.x)*(p2.x-p1.x))+((Pb.y-p1.y)*(p2.y-p1.y))+((Pb.z-p1.z)*(p2.z-p1.z)))/(((p2.x-p1.x)**2)+((p2.y-p1.y)**2)+((p2.z-p1.z)**2))
        Pa.x = p1.x + u*(p2.x-p1.x)
        Pa.y = p1.y + u*(p2.y-p1.y)
        Pa.z = p1.z + u*(p2.z-p1.z)
        self.Pmem1 = Pa
        self.Pa = Pa
        self.Pb = Pb
        self.dist = round(Pa.dist(Pb),8)
        
        if round(u, 3) >= 0.0 and round(u, 3) <= 1.0:
            self.on_segment = 1
            xl_dir = 1
            xr_dir = -1
            if round(u, 3) == 0.0:
                self.position = "LE" # apparent intersection is at p1
            elif round(u, 3) == 1.0:
                self.position = "RE" # apparent intersection is at p2
                xr_dir = 1
                xl_dir = 1
            elif u <= 0.5:
                self.position = "Not Beyond LE" # apparent intersection is closer to p1
            elif u > 0.5:
                self.position = "Not Beyond RE" # apparent intersection is closer to p2
            else:
                Warning('self.position calculation error, self.on_segment = 1')
                raise ValueError
        else:
            self.on_segment = 0
            if u < 0.0:
                self.position = "Beyond LE" # apparent intersection is beyond p1
                xl_dir = -1
                xr_dir = -1
            elif u > 1.0:
                self.position = "Beyond RE" # apparent intersection is beyond p2
                xl_dir = 1
                xr_dir = 1
            else:
                Warning('self.position calculation error, self.on_segment = 0')
                raise ValueError

        # Set the member 'X' direction with respect to p1 and p2 - either '+' or '-'
        self.left_dist = round(Pa.dist(p1)*xl_dir, 8)
        self.right_dist = round(Pa.dist(p2)*xr_dir, 8)            
        
        # Calculate the unit vector of PaPb
        if self.dist > 0.0:
            self.uv = Point((Pa.x-Pb.x)/self.dist, (Pa.y-Pb.y)/self.dist, (Pa.z-Pb.z)/self.dist)
        else:
            self.uv = Point(0.0, 0.0, 0.0)
# end class definition
###############################################################################
# Return the WP on member 1 and which end of member 2 is closer
def ret_WP(mem1, mem2):
    a = LineLineIntersect3D(mem1.left.location, mem1.right.location, mem2.left.location, mem2.right.location)
    b = LineLineIntersect3D(mem2.left.location, mem2.right.location, mem1.left.location, mem1.right.location)
    # if intersection point is closer to left end, set which_end to 'left_end'
    # if intersection point is closer to right end, set which_end to 'right_end'
    if abs(b.left_dist) < abs(b.right_dist):
        which_end = "left end"
    else:
        which_end = "right end"
    return (a.Pmem1, which_end)
# end function definition
###############################################################################
def test_scriptLL():
    from member import Member, MemberLocate
    from param import dim_print
    from point import Point, PointLocate
    from macrolib.PrintDict import formatDict
    mem1 = MemberLocate("Select a MEMBER 1")
    mem2 = MemberLocate("Select a MEMBER 2")
    a = LineLineIntersect3D(mem1.left.location, mem1.right.location, mem2.left.location, mem2.right.location)
    print "Statement - Member 1 and Member 2 are not parallel - True or False? %s\n" % (a.not_parallel())
    if a.not_parallel():
        print "Member 1 apparent intersection point = ", a.Pmem1
        print "Member 2 apparent intersection point = ", a.Pmem2
        print "Unit vector length of segment connecting apparent intersection points = ", a.uv
        print "Absolute distance between apparent intersection points = ", a.inters_dist
        print "Member 1 Left End 'X' distance to apparent intersection point = ", a.left_dist
        print "Member 1 Right End 'X' distance to apparent intersection point = ", a.right_dist
        print "Apparent intersection point position with respect to Member 1 = ", a.position
        if a.on_segment1 == 1:
            print "Point Pa lies on Member 1"
        else:
            print "Point Pa does not lie on Member 1"
        if a.on_segment2 == 1:
            print "Point Pb lies on Member 2"
        else:
            print "Point Pb does not lie on Member 2"
    else:
        Warning("The members are parallel and do not intersect")
    print "\nObject:"
    print a
    print formatDict("\nObject Attributes:", a.__dict__)
## end test_scriptLL() ########################################################
        
def test_scriptLP():
    from member import Member, MemberLocate
    from point import Point, PointLocate
    from param import dim_print
    mem1 = MemberLocate("Select a MEMBER 1")
    pt1 = PointLocate("Pick point")
    a = DistancePointLine3D(mem1.left.location, mem1.right.location, pt1)
    print "Object: %s/n" % (a)
    print "Closest point on Member 1 (Pa) from selected point = %s, %s, %s" % (dim_print(a.Pmem1.x), dim_print(a.Pmem1.y), dim_print(a.Pmem1.z))
    print "Unit vector of segment connecting Pb and Pa = ", a.uv
    print "Scalar distance between points Pb and Pa = ", a.dist
    if a.on_segment == 1:
        print "Point Pa lies on Member 1"
    else:
        print "Point Pa does not lie on Member 1"
    print "Left end 'X' distance to Pa = ", a.left_dist
    print "Right end 'X' distance to Pa = ", a.right_dist
    print "Point Pa position = ", a.position, "\n"
    listCopy = list(a.__dict__.keys())
    listCopy.sort()
    for i in listCopy:
        print i, "=", a.__dict__[i]
## end test_scriptLP() ########################################################

def test_ret_WP():
    from member import Member, MemberLocate
    from param import dim_print
    from point import Point, PointLocate
    mem1 = MemberLocate("Select a MEMBER 1")
    mem2 = MemberLocate("Select a MEMBER 2")
    a, b = ret_WP(mem1, mem2)
    print('Work point at member 1 = %s, %s, %s at the %s of member 2' % (dim_print(a.x), dim_print(a.y), dim_print(a.z), b))
## end test_ret_WP ############################################################

if __name__ == '__main__':
    try:
        test_scriptLL()
    finally:
        del test_scriptLL
        del test_scriptLP
        del test_ret_WP
        del LineLineIntersect3D
        del DistancePointLine3D