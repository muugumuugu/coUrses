
intersectionLinePlane <- function(LM, PM) {
	
	# Bryan Hanson, DePauw University, June 2013
	# Use as you see fit.
	
	# Function to find the intersection of a line with a plane
	# LM is a 2 x 3 matrix with columns x, y, z giving 2 pts on the line
	# PM is a similar 3 x 3 matrix, giving 3 points on the plane

	### Helper function from RSEIS (3D vector cross product)
	xprod <- function(A1, A2) {
	    x = A1[2] * A2[3] - A1[3] * A2[2]
	    y = A1[3] * A2[1] - A1[1] * A2[3]
	    z = A1[1] * A2[2] - A2[1] * A1[2]
	    return(c(x, y, z))
		}

	# Based upon the method described
	# paulbourke.net/geometry/pointlineplane/
	La <- LM[1,]
	Lb <- LM[2,]
	P0 <- PM[1,]
	P1 <- PM[2,]
	P2 <- PM[3,]
	N <- xprod(P2-P0, P1-P0) # correct based upon graphical testing
	n <- sum(N[1]*(P2 - La)[1], N[2]*(P2 - La)[2], N[3]*(P2 - La)[3])
	d <- sum(N[1]*(Lb - La)[1], N[2]*(Lb - La)[2], N[3]*(Lb - La)[3])
	if (isTRUE(all.equal(d, 0.0))) stop("Line is parallel to or in the plane")
	u <- n/d
	if ((u >= 0.0) && (u <= 1.0)) message("Plane is between the two points")
	P <- La + u*(Lb-La)
	P # correct based upon graphical testing
	}

# Some test runs

ML <- matrix(rnorm(6), nrow = 2)
MP <- matrix(rnorm(9), nrow = 3)
chk <- intersectionLinePlane(ML, MP)

ML <- matrix(rnorm(6), nrow = 2)
MP <- matrix(rnorm(9), nrow = 3)
chk <- intersectionLinePlane(ML, rbind(ML, MP[3,])) # check for d = 0

ML <- matrix(c(0,0,0,1,1,1), nrow = 2, byrow = TRUE)
MP <- diag(nrow = 3)
chk <- intersectionLinePlane(ML, MP) # check for betweenness

# graphical checks
library("rgl")
open3d()
segments3d(ML, col = "red", lwd = 3)
segments3d(rbind(MP[1:2,], MP[2:3,], MP[c(3,1),]), col = "blue", lwd = 3)
axes3d(box = TRUE)
title3d(xlab = "x", ylab = "y", zlab = "z")
points3d(chk[1], chk[2], chk[3], col = "green", size = 10)
