/*
	Model information
	Number of objects = 12
		x bounds of model = -0.835782 -> 0.835782
		y bounds of model = -0.268972 -> 1.26897
		z bounds of model = -0.973075 -> 0.973075
		Centroid (0,0.499999,0)
*/

#include "colors.inc"
#include "shapes.inc"

#version 2.0

#declare WireFrameRadius = 0.0171855
#declare LineEndCapShape = sphere {<0,0,0>,0.0171855}

background {
	color rgb <0.1,0.3,0.8>
}

/* Viewing information */
camera {
	location <2.96198,5,-8.13798>
	up <0,1,0>
	right <1,0,0>
	look_at <0,0.499999,0>
}

/* Lighting info */
light_source {
	<0,0.499999,2.91922>
	color White
}
light_source {
	<2.50735,3.30691,2.91922>
	color White
}

/* The model geometry follows */

#declare Texture1 = texture {
	pigment {
		color rgb <0,1,0>
	}
	finish {
		ambient 0.2
		diffuse 0.8
		specular 0.6
		roughness 0.01
	}
}

triangle {
	<4.46411e-16,0.00841499,0.973075>,
	<0.835782,1.01477,0.474356>,
	<-3.72235e-16,1.26897,-0.0123167>
	texture {Texture1}
}
triangle {
	<0.835782,1.01477,0.474356>,
	<0.835782,-0.0147687,-0.474356>,
	<-3.72235e-16,1.26897,-0.0123167>
	texture {Texture1}
}
triangle {
	<0.835782,-0.0147687,-0.474356>,
	<-3.38964e-17,0.991585,-0.973075>,
	<-3.72235e-16,1.26897,-0.0123167>
	texture {Texture1}
}
triangle {
	<-3.38964e-17,0.991585,-0.973075>,
	<-0.835782,-0.0147687,-0.474356>,
	<-3.72235e-16,1.26897,-0.0123167>
	texture {Texture1}
}
triangle {
	<-0.835782,-0.0147687,-0.474356>,
	<-0.835782,1.01477,0.474356>,
	<-3.72235e-16,1.26897,-0.0123167>
	texture {Texture1}
}
triangle {
	<-0.835782,1.01477,0.474356>,
	<4.46411e-16,0.00841499,0.973075>,
	<-3.72235e-16,1.26897,-0.0123167>
	texture {Texture1}
}

#declare Texture2 = texture {
	pigment {
		color rgb <0,0,1>
	}
	finish {
		ambient 0.2
		diffuse 0.8
		specular 0.6
		roughness 0.01
	}
}

triangle {
	<4.46411e-16,0.00841499,0.973075>,
	<6.45885e-16,-0.268972,0.0123167>,
	<0.835782,1.01477,0.474356>
	texture {Texture2}
}
triangle {
	<0.835782,1.01477,0.474356>,
	<6.45885e-16,-0.268972,0.0123167>,
	<0.835782,-0.0147687,-0.474356>
	texture {Texture2}
}
triangle {
	<0.835782,-0.0147687,-0.474356>,
	<6.45885e-16,-0.268972,0.0123167>,
	<-3.38964e-17,0.991585,-0.973075>
	texture {Texture2}
}
triangle {
	<-3.38964e-17,0.991585,-0.973075>,
	<6.45885e-16,-0.268972,0.0123167>,
	<-0.835782,-0.0147687,-0.474356>
	texture {Texture2}
}
triangle {
	<-0.835782,-0.0147687,-0.474356>,
	<6.45885e-16,-0.268972,0.0123167>,
	<-0.835782,1.01477,0.474356>
	texture {Texture2}
}
triangle {
	<-0.835782,1.01477,0.474356>,
	<6.45885e-16,-0.268972,0.0123167>,
	<4.46411e-16,0.00841499,0.973075>
	texture {Texture2}
}
