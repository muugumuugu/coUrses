/*
	POV-Ray geometry file created by Paul Bourke
	Model information
	Number of objects = 36
		x bounds of model = -1.72747 -> 1.72814
		y bounds of model = -0.314397 -> 0.33794
		z bounds of model = -1.42827 -> 1.87329
		Centroid (0.000334978,0.0117715,0.22251)
*/

#include "colors.inc"
#include "shapes.inc"

#version 2.0

#declare WireFrameRadius = 0.0246984
#declare LineEndCapShape = sphere {<0,0,0>,0.0246984}

background {
	color rgb <0.1,0.3,0.8>
}

/* Viewing information */
camera {
	location <-3.19397,9.2689,1.97131>
	up <0,1,0>
	right <1,0,0>
	look_at <0.000334978,0.0117715,0.22251>
}

/* Lighting info */
light_source {
	<0.000334978,0.0117715,5.39736>
	color White
}
light_source {
	<5.18409,1.00205,5.39736>
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
	<-0.862901,0.232677,-0.518015>,
	<0.000813082,0.333768,-0.0242754>,
	<-0.000141623,-0.204855,-0.888624>
	texture {Texture1}
}
triangle {
	<-0.862901,0.232677,-0.518015>,
	<-0.000141623,-0.204855,-0.888624>,
	<-0.863536,-0.18138,-1.42827>
	texture {Texture1}
}
triangle {
	<-0.862901,0.232677,-0.518015>,
	<-0.863536,-0.18138,-1.42827>,
	<-1.72747,-0.200683,-0.889316>
	texture {Texture1}
}
triangle {
	<-0.862901,0.232677,-0.518015>,
	<-1.72747,-0.200683,-0.889316>,
	<-1.72651,0.33794,-0.0249671>
	texture {Texture1}
}
triangle {
	<-0.862901,0.232677,-0.518015>,
	<-1.72651,0.33794,-0.0249671>,
	<-0.863117,0.314465,0.514675>
	texture {Texture1}
}
triangle {
	<-0.862901,0.232677,-0.518015>,
	<-0.863117,0.314465,0.514675>,
	<0.000813082,0.333768,-0.0242754>
	texture {Texture1}
}
triangle {
	<9.03026e-06,0.17045,0.998693>,
	<0.000813082,0.333768,-0.0242754>,
	<-0.863117,0.314465,0.514675>
	texture {Texture1}
}
triangle {
	<9.03026e-06,0.17045,0.998693>,
	<-0.863117,0.314465,0.514675>,
	<-0.864907,-0.290921,1.33365>
	texture {Texture1}
}
triangle {
	<9.03026e-06,0.17045,0.998693>,
	<-0.864907,-0.290921,1.33365>,
	<-0.00151213,-0.314397,1.87329>
	texture {Texture1}
}
triangle {
	<9.03026e-06,0.17045,0.998693>,
	<-0.00151213,-0.314397,1.87329>,
	<0.862418,-0.295093,1.33434>
	texture {Texture1}
}
triangle {
	<9.03026e-06,0.17045,0.998693>,
	<0.862418,-0.295093,1.33434>,
	<0.864208,0.310293,0.515367>
	texture {Texture1}
}
triangle {
	<9.03026e-06,0.17045,0.998693>,
	<0.864208,0.310293,0.515367>,
	<0.000813082,0.333768,-0.0242754>
	texture {Texture1}
}
triangle {
	<0.864424,0.228506,-0.517324>,
	<0.000813082,0.333768,-0.0242754>,
	<0.864208,0.310293,0.515367>
	texture {Texture1}
}
triangle {
	<0.864424,0.228506,-0.517324>,
	<0.864208,0.310293,0.515367>,
	<1.72814,0.329596,-0.0235837>
	texture {Texture1}
}
triangle {
	<0.864424,0.228506,-0.517324>,
	<1.72814,0.329596,-0.0235837>,
	<1.72718,-0.209027,-0.887932>
	texture {Texture1}
}
triangle {
	<0.864424,0.228506,-0.517324>,
	<1.72718,-0.209027,-0.887932>,
	<0.863788,-0.185552,-1.42757>
	texture {Texture1}
}
triangle {
	<0.864424,0.228506,-0.517324>,
	<0.863788,-0.185552,-1.42757>,
	<-0.000141623,-0.204855,-0.888624>
	texture {Texture1}
}
triangle {
	<0.864424,0.228506,-0.517324>,
	<-0.000141623,-0.204855,-0.888624>,
	<0.000813082,0.333768,-0.0242754>
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
	<-0.863752,-0.0995927,-0.395576>,
	<-0.000141623,-0.204855,-0.888624>,
	<0.000813082,0.333768,-0.0242754>
	texture {Texture2}
}
triangle {
	<-0.863752,-0.0995927,-0.395576>,
	<-0.863536,-0.18138,-1.42827>,
	<-0.000141623,-0.204855,-0.888624>
	texture {Texture2}
}
triangle {
	<-0.863752,-0.0995927,-0.395576>,
	<-1.72747,-0.200683,-0.889316>,
	<-0.863536,-0.18138,-1.42827>
	texture {Texture2}
}
triangle {
	<-0.863752,-0.0995927,-0.395576>,
	<-1.72651,0.33794,-0.0249671>,
	<-1.72747,-0.200683,-0.889316>
	texture {Texture2}
}
triangle {
	<-0.863752,-0.0995927,-0.395576>,
	<-0.863117,0.314465,0.514675>,
	<-1.72651,0.33794,-0.0249671>
	texture {Texture2}
}
triangle {
	<-0.863752,-0.0995927,-0.395576>,
	<0.000813082,0.333768,-0.0242754>,
	<-0.863117,0.314465,0.514675>
	texture {Texture2}
}
triangle {
	<-0.000708076,-0.151079,0.850322>,
	<-0.863117,0.314465,0.514675>,
	<0.000813082,0.333768,-0.0242754>
	texture {Texture2}
}
triangle {
	<-0.000708076,-0.151079,0.850322>,
	<-0.864907,-0.290921,1.33365>,
	<-0.863117,0.314465,0.514675>
	texture {Texture2}
}
triangle {
	<-0.000708076,-0.151079,0.850322>,
	<-0.00151213,-0.314397,1.87329>,
	<-0.864907,-0.290921,1.33365>
	texture {Texture2}
}
triangle {
	<-0.000708076,-0.151079,0.850322>,
	<0.862418,-0.295093,1.33434>,
	<-0.00151213,-0.314397,1.87329>
	texture {Texture2}
}
triangle {
	<-0.000708076,-0.151079,0.850322>,
	<0.864208,0.310293,0.515367>,
	<0.862418,-0.295093,1.33434>
	texture {Texture2}
}
triangle {
	<-0.000708076,-0.151079,0.850322>,
	<0.000813082,0.333768,-0.0242754>,
	<0.864208,0.310293,0.515367>
	texture {Texture2}
}
triangle {
	<0.863572,-0.103764,-0.394884>,
	<0.864208,0.310293,0.515367>,
	<0.000813082,0.333768,-0.0242754>
	texture {Texture2}
}
triangle {
	<0.863572,-0.103764,-0.394884>,
	<1.72814,0.329596,-0.0235837>,
	<0.864208,0.310293,0.515367>
	texture {Texture2}
}
triangle {
	<0.863572,-0.103764,-0.394884>,
	<1.72718,-0.209027,-0.887932>,
	<1.72814,0.329596,-0.0235837>
	texture {Texture2}
}
triangle {
	<0.863572,-0.103764,-0.394884>,
	<0.863788,-0.185552,-1.42757>,
	<1.72718,-0.209027,-0.887932>
	texture {Texture2}
}
triangle {
	<0.863572,-0.103764,-0.394884>,
	<-0.000141623,-0.204855,-0.888624>,
	<0.863788,-0.185552,-1.42757>
	texture {Texture2}
}
triangle {
	<0.863572,-0.103764,-0.394884>,
	<0.000813082,0.333768,-0.0242754>,
	<-0.000141623,-0.204855,-0.888624>
	texture {Texture2}
}
