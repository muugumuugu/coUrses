#version 3.7;

/*
	Scene file for pointboxcount outputs
	Change #include for the file you want
*/

#declare thefinish = finish { ambient 0.2 diffuse 0.7 specular 0.3 }
#declare boxtexture = texture {
	pigment { colour rgbt <0.5,0.5,0.5,0.75> }
	finish { thefinish }
}
#declare XAXISTEXTURE = texture {
   pigment { colour rgb <0.8,0.2,0.2> }
   finish { thefinish }
}
#declare YAXISTEXTURE = texture {
   pigment { colour rgb <0.1,0.6,0.1> }
   finish { thefinish }
}
#declare ZAXISTEXTURE = texture {
   pigment { colour rgb <0.2,0.2,0.8> }
   finish { thefinish }
}
#declare BBOXTEXTURE = texture {
   pigment { colour rgb <0.5,0.5,0.5> }
   finish { thefinish }
}
#declare SCALE = 0.75; // Use this to change size of points
#declare AXESSCALE = 1; // Use this to change size of axes
#declare BBOXSCALE = 1; // Use this to change size of bounding box
#declare SHOWPOINTS = 0; // 0 for on, 1 for off
#declare SHOWBOXES = 1; // 0 for on, 1 for off
#declare SHOWCURVE = 1; // 0 for on, 1 for off

union {
	#include "data.inc"
	translate -CENTROID
	rotate <0,0,clock*360> // Simple rotation about z axis
}

#declare VP = 0.8*RANGE * vnormalize(<0,-1,0>);
camera {
   perspective
   location VP
   up y
   right -image_width*x/image_height
   angle 80
   sky <0,0,1>
   look_at <0,0,0>
}

global_settings {
   ambient_light rgb <1,1,1>
   assumed_gamma 1.8
	max_trace_level 5
}
background {
   color rgb <1,1,1>
}

light_source {
	VP
   color rgb <1,1,1>
}

