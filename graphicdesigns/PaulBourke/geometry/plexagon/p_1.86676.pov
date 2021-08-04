/*
	Model information
	Number of objects = 12
		x bounds of model = -0.826734 -> 0.826734
		y bounds of model = -0.450853 -> 1.45085
		z bounds of model = -0.965924 -> 0.965924
		Centroid (0,0.499999,0)
*/

#include "colors.inc"
#include "shapes.inc"

#version 2.0

#declare WireFrameRadius = 0.0182901
#declare LineEndCapShape = sphere {<0,0,0>,0.0182901}

background {
	color rgb <0.1,0.3,0.8>
}

/* Viewing information */
camera {
	location <8.13798,3.4202,-4.69846>
	up <0,1,0>
	right <1,0,0>
	look_at <0,0.499999,0>
}

/* Lighting info */
light_source {
	<0,0.499999,2.89777>
	color White
}
light_source {
	<2.4802,3.85255,2.89777>
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
	<1.40144e-15,-0.136388,0.965924>,
	<0.826734,1.16147,0.465803>,
	<3.64053e-16,1.45085,-0.0166546>
	texture {Texture1}
}
triangle {
	<0.826734,1.16147,0.465803>,
	<0.826734,-0.161465,-0.465803>,
	<3.64053e-16,1.45085,-0.0166546>
	texture {Texture1}
}
triangle {
	<0.826734,-0.161465,-0.465803>,
	<5.43463e-16,1.13639,-0.965924>,
	<3.64053e-16,1.45085,-0.0166546>
	texture {Texture1}
}
triangle {
	<5.43463e-16,1.13639,-0.965924>,
	<-0.826734,-0.161465,-0.465803>,
	<3.64053e-16,1.45085,-0.0166546>
	texture {Texture1}
}
triangle {
	<-0.826734,-0.161465,-0.465803>,
	<-0.826734,1.16147,0.465803>,
	<3.64053e-16,1.45085,-0.0166546>
	texture {Texture1}
}
triangle {
	<-0.826734,1.16147,0.465803>,
	<1.40144e-15,-0.136388,0.965924>,
	<3.64053e-16,1.45085,-0.0166546>
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
	<1.40144e-15,-0.136388,0.965924>,
	<1.72438e-15,-0.450853,0.0166546>,
	<0.826734,1.16147,0.465803>
	texture {Texture2}
}
triangle {
	<0.826734,1.16147,0.465803>,
	<1.72438e-15,-0.450853,0.0166546>,
	<0.826734,-0.161465,-0.465803>
	texture {Texture2}
}
triangle {
	<0.826734,-0.161465,-0.465803>,
	<1.72438e-15,-0.450853,0.0166546>,
	<5.43463e-16,1.13639,-0.965924>
	texture {Texture2}
}
triangle {
	<5.43463e-16,1.13639,-0.965924>,
	<1.72438e-15,-0.450853,0.0166546>,
	<-0.826734,-0.161465,-0.465803>
	texture {Texture2}
}
triangle {
	<-0.826734,-0.161465,-0.465803>,
	<1.72438e-15,-0.450853,0.0166546>,
	<-0.826734,1.16147,0.465803>
	texture {Texture2}
}
triangle {
	<-0.826734,1.16147,0.465803>,
	<1.72438e-15,-0.450853,0.0166546>,
	<1.40144e-15,-0.136388,0.965924>
	texture {Texture2}
}
