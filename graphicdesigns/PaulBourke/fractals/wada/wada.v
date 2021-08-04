//  Wada fractals with reflective spheres and colored transparent foils.
//  By Rasta Robert

#include "color.vc"

studio {
	from 2 -2 2
	at 0 0 0
	up 1 1 1
   angle 11
	aspect 1/1
	resolution 1200 1200
	antialias adaptive
	threshold 0
	jitter
	bkg black
}

//  light
light { center  2 -2 2 color yellow * .9 }

// reflective spheres
surf 
		{	spec    1 1 1
			ambient 0.1 0.1 0.2
			diff .08 .08 .1
			shine 500
			brilliance 20
		}

sphere { center -0.5 -0.5 0.5  radius sqrt(.5) }
sphere { center 0.5 0.5 0.5  radius sqrt(.5) }
sphere { center -0.5 0.5 -0.5  radius sqrt(.5) }
sphere { center 0.5 -0.5 -0.5  radius sqrt(.5) }

// red foil triangle patch
surf
{	ambient .1 0 0
	diff    1 0 0
	spec    1 0 0
	trans   1 0 0
	shine 500
	brilliance 20
}

polygon {
	points 3
	vertex -1.414214 1.414214 -1.414214
	vertex -1.414214 -1.414214 1.414214 
	vertex 1.414214 1.414214 1.414214
}

// green foil triangle patch
surf
{	ambient 0 .1 0
	diff    0 1 0
	spec    0 1 0
	trans   0 1 0
	shine 500
	brilliance 20
}
polygon {
	points 3
	vertex -1.414214 1.414214 -1.414214
	vertex 1.414214 1.414214 1.414214  
	vertex 1.414214 -1.414214 -1.414214
}

// blue foil triangle patch
surf
{	ambient 0 0 .1
	diff    0 0 1
	spec    0 0 1
	trans   0 0 1
	shine 500
	brilliance 20
}
polygon {
	points 3
	vertex -1.414214 1.414214 -1.414214
	vertex  1.414214 -1.414214 -1.414214 
	vertex -1.414214 -1.414214 1.414214
}

