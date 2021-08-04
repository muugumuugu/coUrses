## PointRotate.py Version 1.02
## Copyright (c) 2006 Bruce Vaughan, BV Detailing & Design, Inc.
## All rights reserved.
## NOT FOR SALE. The software is provided "as is" without any warranty.
#############################################################################
"""
    Return a point rotated about an arbitrary axis in 3D.
    Positive angles are counter-clockwise looking down the axis toward the origin.
    The coordinate system is assumed to be right-hand.
    Arguments: 'axis point 1', 'axis point 2', 'point to be rotated', 'angle of rotation (in radians)' >> 'new point'
    Revision History:
        Version 1.01 (11/11/06) - Revised function code
        Version 1.02 (11/16/06) - Rewrote PointRotate3D function

    Reference 'Rotate A Point About An Arbitrary Axis (3D)' - Paul Bourke        
"""
def PointRotate3D(p1, p2, p0, theta):
    from point import Point
    from math import cos, sin, sqrt

    # Translate so axis is at origin    
    p = p0 - p1
    # Initialize point q
    q = Point(0.0,0.0,0.0)
    N = (p2-p1)
    Nm = sqrt(N.x**2 + N.y**2 + N.z**2)
    
    # Rotation axis unit vector
    n = Point(N.x/Nm, N.y/Nm, N.z/Nm)

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
    return q + p1
    
## END PointRotate3D() ##########################
def test_PointRotate3D():
    from point import Point, PointLocate
    from member import Member, MemberLocate
    from param import dim_print, Prompt, yes_or_no, Warning, ClearSelection
    from macrolib.angle import dtor
    from macrolib.ExceptWarn import formatExceptionInfo
    from macrolib.PrintPtList import formatPtList
    a1 = 45.0
    while 1:
        ClearSelection()
        try:
            Warning("Rotate a Point About a Member Line - The rotation is REVERSED if the view " +\
                    "along the rotation axis is from the member LEFT end toward the member RIGHT end. " + \
                    "A right hand coordinate system is assumed. Positive angles are counter-clockwise " +\
                    "when looking down the axis toward the origin. The member LEFT end is the origin.")
            mem1 = MemberLocate("Select member to rotate about")
            pt1 = PointLocate("Pick point to rotate")
            a1 = Prompt(a1, "Rotation angle")
            pt2 = PointRotate3D(mem1.left.location, mem1.right.location, pt1, dtor(a1))
            Warning("The selected point is %s, %s, %s \nThe new point is %s, %s, %s" % \
                    (dim_print(pt1.x), dim_print(pt1.y), dim_print(pt1.z), dim_print(pt2.x), dim_print(pt2.y), dim_print(pt2.z)))
            print formatPtList("Original Point and Rotated Point Coordinates:", [pt1, pt2])
        except:
            Warning(formatExceptionInfo())
        if not yes_or_no("Continue?"):
                break
## END test_PointRotate3D() #####################
if __name__ == '__main__':
    try:
        test_PointRotate3D()
    finally:
        del test_PointRotate3D