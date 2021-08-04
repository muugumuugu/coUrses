##========================================================
##
##  Credits:
##  Theory by Paul Bourke http://local.wasp.uwa.edu.au/~pbourke/geometry/pointline/
##  Based in part on C code by Damian Coventry Tuesday, 16 July 2002
##  Based on VBA code by Brandon Crosby 9-6-05 (2 dimensions)
##  With grateful thanks for answering our needs!
##  This is an R (http://www.r-project.org) implementation by Gregoire Thomas 7/11/08
##
##========================================================

distancePointLine <- function(x, y, slope, intercept) {
 ## x, y is the point to test.
 ## slope, intercept is the line to check distance.
 ##
 ## Returns distance from the line.
 ##
 ## Returns 9999 on 0 denominator conditions.
 x1 <- x-10
 x2 <- x+10
 y1 <- x1*slope+intercept
 y2 <- x2*slope+intercept
 distancePointSegment(x,y, x1,y1, x2,y2)
}

distancePointSegment <- function(px, py, x1, y1, x2, y2) {
 ## px,py is the point to test.
 ## x1,y1,x2,y2 is the line to check distance.
 ##
 ## Returns distance from the line, or if the intersecting point on the line nearest
 ## the point tested is outside the endpoints of the line, the distance to the
 ## nearest endpoint.
 ##
 ## Returns 9999 on 0 denominator conditions.
 lineMagnitude <- function(x1, y1, x2, y2) sqrt((x2-x1)^2+(y2-y1)^2)
 ans <- NULL
 ix <- iy <- 0   # intersecting point
 lineMag <- lineMagnitude(x1, y1, x2, y2)
 if( lineMag < 0.00000001) {
   warning("short segment")
   return(9999)
 }
 u <- (((px - x1) * (x2 - x1)) + ((py - y1) * (y2 - y1)))
 u <- u / (lineMag * lineMag)
 if((u < 0.00001) || (u > 1)) {
   ## closest point does not fall within the line segment, take the shorter distance
   ## to an endpoint
   ix <- lineMagnitude(px, py, x1, y1)
   iy <- lineMagnitude(px, py, x2, y2)
   if(ix > iy)  ans <- iy
   else ans <- ix
 } else {
   ## Intersecting point is on the line, use the formula
   ix <- x1 + u * (x2 - x1)
   iy <- y1 + u * (y2 - y1)
   ans <- lineMagnitude(px, py, ix, iy)
 }
 ans
}

distancePointLineTest <- function() {
 if(abs(distancePointSegment(  5,   5,  10, 10, 20, 20) - 7.07106781186548)>.0001)
   stop("error 1")
 if(abs(distancePointSegment( 15,  15,  10, 10, 20, 20) - 0)>.0001)
   stop("error 2")
 if(abs(distancePointSegment( 15,  15,  20, 10, 20, 20) - 5)>.0001)
   stop("error 3")
 if(abs(distancePointSegment(  0,  15,  20, 10, 20, 20) - 20)>.0001)
   stop("error 4")
 if(abs(distancePointSegment(  0,  25,  20, 10, 20, 20) - 20.6155281280883)>.0001)
   stop("error 5")
 if(abs(distancePointSegment(-13, -25, -50, 10, 20, 20) - 39.8808224589213)>.0001)
   stop("error 6")
 if(abs(distancePointSegment(  0,   3,   0, -4,  5,  0) - 5.466082)>.0001)
   stop("error 7")
 if(abs(distancePointSegment(  0,   9,   0, -4,  0, 15) - 0)>.0001)
   stop("error 8")
 if(abs(distancePointSegment(  0,   0,   0, -2,  2,  0)^2 - 2)>.0001)
   stop("error 9")
 return(TRUE)
}

