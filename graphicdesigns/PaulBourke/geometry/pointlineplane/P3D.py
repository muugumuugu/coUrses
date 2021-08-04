## P3D.py (module 'P3D') Version 1.03
## Copyright (c) 2006 Bruce Vaughan, BV Detailing & Design, Inc.
## All rights reserved.
## NOT FOR SALE. The software is provided "as is" without any warranty.
#############################################################################
"""
/// Define a plane in 3D space from three non-collinear points.
/// Determine if another point lies on the defined plane.
/// Define two additional planes and calculate the radius and center point of a circle connecting the points.
/// Rotate a point about an axis perpendicular to the defined plane (axis is defined by p1 and p1 + N_uv).
/// 
/// Developed by Bruce Vaughan, BV Detailing & Design, Inc. (September 2006)
/// URL: www.bvdetailing.com
/// 
/// 
///
/// Revision History:
///     Version 1.01 (10/18/06) -   Removed method 'pr_init()'
///                                 Add optional argument to '__init__()'
///     Version 1.02 (11/11/06) -   Rewrite class method PointRotate3D
///     Version 1.03 (11/15/06) -   Rewrite Plane3D
///                                 Removed lie_check2 since it was redundant
///
///
/// References 'Equation of a plane', 'Intersection of three planes', 'Rotate A Point About An Arbitrary Axis (3D)' - Paul Bourke
"""
###########################################
from math import pi, sqrt, acos, cos, sin
from point import Point

class Plane3D:
    
    def cross_product(self, p1, p2):
        return Point(p1.y*p2.z - p1.z*p2.y, p1.z*p2.x - p1.x*p2.z, p1.x*p2.y - p1.y*p2.x)

    def dot_product(self, p1, p2):
        return (p1.x*p2.x + p1.y*p2.y + p1.z*p2.z)    
    
    def plane_def(self, p1, p2, p3):
        N = self.cross_product(p2-p1, p3-p1)
        A = N.x
        B = N.y
        C = N.z
        D = self.dot_product(-N, p1)
        return N, A, B, C, D
        
    def __init__(self, p1, p2, p3, theta1 = 0):
        
        def chk_type(p_list):
            ret_list = []
            for p in p_list:
                if type(p) == type(Point(0,0,0)):
                    ret_list.append(True)
                else:
                    ret_list.append(None)
            return ret_list
        
        if None not in chk_type([p1, p2, p3]):
            """
            /// Define a plane from 3 non-collinear points
            /// Ax + By + Cz + D = 0
            /// The normal 'N' to the plane is the vector (A, B, C)
            """
            self.N, A, B, C, self.D = self.plane_def(p1, p2, p3)
            self.N_len = round(sqrt(A*A + B*B + C*C), 6)
            if self.N_len > 0.0:
                self.N_uv = Point(self.N.x/self.N_len, self.N.y/self.N_len, self.N.z/self.N_len)
            else:
                self.N_uv = Point(0.0, 0.0, 0.0)
            # make p1 global to class namespace
            self.p1 = p1
            """
            /// If vector N is the normal to the plane then all points 'p' on the plane satisfy the following:
            /// N dot p = k where 'dot' is the dot product
            /// N dot p = N.x*p.x + N.y*p.y + N.z*p.z
            """
            self.k = round(self.dot_product(self.N, p1), 6)             # calculation of plane constant 'k'
            self.k0 = round(self.dot_product(self.N_uv, p1), 6)         # displacement of the plane from the origin
            """
            /// Determine vector e and unit vector e0 (p1 to p3)
            /// Determine vector d and unit vector d0 (p1 to p2)
            /// Determine location of point F, midpoint on vector d
            /// Determine location of point G, midpoint on vector e
            """
            e = p3 - p1
            e_len = (sqrt(e.x**2 + e.y**2 + e.z**2))
            if e_len > 0.0:
                self.e0 = Point(e.x/e_len, e.y/e_len, e.z/e_len)
            else:
                self.e0 = Point(0.0, 0.0, 0.0)
            d = p2 - p1
            d_len = (sqrt(d.x**2 + d.y**2 + d.z**2))
            if d_len > 0.0:
                self.d0 = Point(d.x/d_len, d.y/d_len, d.z/d_len)
            else:
                self.d0 = Point(0.0, 0.0, 0.0) 
            self.F = Point(p1.x + (d.x/2), p1.y + (d.y/2), p1.z + (d.z/2))
            self.G = Point(p1.x + (e.x/2), p1.y + (e.y/2), p1.z + (e.z/2))
            # Make variables 'e' and 'd' available as attributes
            self.e = e
            self.d = d
            
            # Calculate distance between points p1 and p2
            self.Ra = p2.dist(p1)

            """
            /// Calculate net angle between vectors d0 and e0 (Q)
            /// Radius = self.Ra
            /// Calculate point to point distance (pp)
            """
            if abs(theta1) == pi:
                self.Q = theta1
            else:
                self.Q = acos(self.dot_product(self.d0, self.e0))   # radians
            self.pp = abs(self.Q * self.Ra)            

        else:
            raise TypeError, 'The arguments passed to Plane3D must be a POINT'
        
    # Calculate points to define plane #2 and calculate N2 and d2
    def plane_2(self):
        p1 = self.G
        p2 = self.G + self.N_uv
        p3 = self.G + self.cross_product(self.e0, self.N_uv)
        N, A, B, C, D = self.plane_def(p1, p2, p3)
        d = round(sqrt(A*A + B*B + C*C), 6) 
        self.N2 = Point(A/d, B/d, C/d)
        self.d2 = round(self.N2.x*p1.x + self.N2.y*p1.y + self.N2.z*p1.z, 6)
        
    # Calculate points to define plane #3 and calculate N3 and d3
    def plane_3(self):
        p1 = self.F
        p2 = self.F + self.N_uv
        p3 = self.F + self.cross_product(self.d0, self.N_uv)
        N, A, B, C, D = self.plane_def(p1, p2, p3)
        d = round(sqrt(A*A + B*B + C*C), 6)
        self.N3 = Point(A/d, B/d, C/d)
        self.d3 = round(self.N3.x*p1.x + self.N3.y*p1.y + self.N3.z*p1.z, 6)

    def three_pt_circle (self):     
        """
        /// The intersection of three planes is either a point, a line, or there is no intersection.
        /// Three planes can be written as:
        /// N1 dot p = d1
        /// N2 dot p = d2
        /// N3 dot p = d3
        /// 'Nx' is the normal vector
        /// 'p' is a point on the plane
        /// 'dot' signifies the dot product of 'Nx' and 'p'
        /// 'dx' = plane constant (displacement of the plane from the origin if Nx is a unit vector)
        /// The intersection point of the three planes "M" is given by:
        /// M = (d1*(N2 cross N3) + d2(N3 cross N1) + d3*(N1 cross N2)) / (N1 dot (N2 cross N3))
        /// 'cross' indicates the cross product and 'dot' indicates the dot product
        /// Calculate the center point of the circle (intersection point of three planes) and the radius.
        /// Plane 1 is defined in __init__ method.
        """
        # Define Plane 2
        self.plane_2()
        # Define Plane 3
        self.plane_3()
        
        N23 = self.cross_product(self.N2, self.N3)
        N31 = self.cross_product(self.N3, self.N)
        N12 = self.cross_product(self.N, self.N2)
        NdN23 = round(self.dot_product(self.N, N23), 6)

        numer = Point(self.k*N23.x, self.k*N23.y, self.k*N23.z) + (self.d2*N31.x, self.d2*N31.y, self.d2*N31.z) + \
                     (self.d3*N12.x, self.d3*N12.y, self.d3*N12.z)
        if NdN23 != 0.0:
            self.M = Point(numer.x/NdN23, numer.y/NdN23, numer.z/NdN23)
            self.R = self.M.dist(self.p1)
        else:
            self.M = Point(0.0, 0.0, 0.0)
            self.R = 0.0

    """
    /// Rotate point p about a line passing through self.p1 and normal to the current plane by the angle 'theta' in radians
    /// Return the new point
    """    
    def PointRotate3D(self, p, theta):
        # Initialize point q
        q = Point(0.0,0.0,0.0)
        # Rotation axis unit vector
        n = self.N_uv
        # Translate so axis is at origin
        p = p - self.p1

        # Matrix common factors     
        c = cos(theta)
        t = (1 - cos(theta))
        s = sin(theta)
        X = n.x
        Y = n.y
        Z = n.z

        # Matrix 'M'
        d11 = t*X**2 + c
        d12 = t*X*Y - s*Z
        d13 = t*X*Z + s*Y
        d21 = t*X*Y + s*Z
        d22 = t*Y**2 + c
        d23 = t*Y*Z - s*X
        d31 = t*X*Z - s*Y
        d32 = t*Y*Z + s*X
        d33 = t*Z**2 + c

        #            |p.x|
        # Matrix 'M'*|p.y|
        #            |p.z|
        q.x = d11*p.x + d12*p.y + d13*p.z
        q.y = d21*p.x + d22*p.y + d23*p.z
        q.z = d31*p.x + d32*p.y + d33*p.z
        
        # Translate axis and rotated point back to original location
        return q + self.p1

    def lie_check(self, p):
        """
        /// Given any point 'a' on a plane: N dot (a-p) = 0
        """
        return round(self.dot_product(self.N, (p - self.p1)))

################################################################################
def test_Rotate3D():
    from point import Point, PointLocate
    from param import Prompt, Warning, dim_print, yes_or_no
    from macrolib.angle import dtor, rtod
    A = 45.0
    pt1 = PointLocate("Pick center point of rotation")
    pt2 = PointLocate("Pick point to rotate")
    pt3 = PointLocate("Pick a counter-clockwise reference point to define the current plane")
    print "Selected point: %s, %s, %s" % (dim_print(pt2.x), dim_print(pt2.y), dim_print(pt2.z))
    while 1:        
        A = Prompt(A, "Enter rotation angle")
        a = Plane3D(pt1, pt2, pt3, dtor(A))
        pt = a.PointRotate3D(pt2, dtor(A))
        Warning("\nSelected point: %s, %s, %s\nRotated point: %s, %s, %s" % \
                (dim_print(pt2.x), dim_print(pt2.y), dim_print(pt2.z), dim_print(pt.x), dim_print(pt.y), dim_print(pt.z)))
        print "Rotated point: %s, %s, %s" % (dim_print(pt.x), dim_print(pt.y), dim_print(pt.z))
        if not yes_or_no("Rotate the point again?"):
            break
        
## END test_P3D() #############################################################
def test_Plane3D():
    from point import Point, PointLocate
    from param import Warning
    pt1 = PointLocate("Pick point 1")
    pt2 = PointLocate("Pick point 2")
    pt3 = PointLocate("Pick point 3")
    if None not in [pt1, pt2, pt3]:
        a = Plane3D(pt1, pt2, pt3)
        if a.N_len > 0.0:
            Warning('%s\n%s\n%s\n%s' % ('Normal unit vector to the plane defined by the picked points:',\
                                        'x = ' + str(round(a.N_uv.x, 4)),\
                                        'y = ' + str(round(a.N_uv.y, 4)),\
                                        'z = ' + str(round(a.N_uv.z, 4))
                                        )
                    )
            print "Normal unit vector to the plane defined by the picked points ('N'):"
            print 'x = ' + str(round(a.N_uv.x, 4))
            print 'y = ' + str(round(a.N_uv.y, 4))
            print 'z = ' + str(round(a.N_uv.z, 4)), '\n'
            print "Plane constant 'k' = N dot product p:", a.k
            print "Plane displacement from the origin (0,0,0) = N_uv dot product p:", a.k0, '\n'
            print "a.D = %s" % (a.D)
            pt4 = PointLocate("Pick a point to test lie_check")
            if a.lie_check(pt4) == 0.0:
                print "Selected point lies on current plane."
            elif a.lie_check(pt4) < 0.0:
                print "Selected point lies on OPPOSITE side of current plane as normal N."
            else:
                print "Selected point lies on SAME side of current plane as normal N."
## END test_Plane3D() ########################################################
            
if __name__ == '__main__':
    try:
        test_Rotate3D()
        #test_Plane3D()
    finally:
        del test_Rotate3D
        del test_Plane3D
        del Plane3D