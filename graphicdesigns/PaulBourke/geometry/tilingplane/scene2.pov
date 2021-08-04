
#declare VP = <0.5,1,2>;

global_settings {
   ambient_light rgb <1,1,1>
   assumed_gamma 1.8
   max_trace_level 5
}

background { color rgb <1,1,1> }

// Light at the camera
light_source {
   VP
   color rgb <1,1,1>
}

camera {
   perspective
   location VP
   up y
   right image_width*x/image_height
   angle 60
   sky <0,1,0>
   look_at <0.5,1,0>
}

#declare RADIUS = 0.05;

/* Origin
sphere {
	<0,0,0>, RADIUS*2
	pigment { color rgb <1,0,0> }
}
*/

#declare thefinish = finish {
   ambient 0.2 
   diffuse 0.4
   specular 0.5 
}
#declare texture1 = texture {
	pigment { color rgb <1,0,0> }
	finish { thefinish }
}
#declare texture2 = texture {
   pigment { color rgb <0,1,0> }
   finish { thefinish }
}
#declare texture3 = texture {
   pigment { color rgb <0,0,1> }
   finish { thefinish }
}
#declare texture4 = texture {
   pigment { color rgb <1,1,0> }
   finish { thefinish }
}
#declare texture5 = texture {
   pigment { color rgb <0,1,1> }
   finish { thefinish }
}

// Interior angles
#declare THETA1 = degrees(atan(0.5));
#declare THETA2 = degrees(atan(2.0));

// Various lengths
#declare LENGTH1 = sqrt(5);
#declare LENGTH2 = sin(atan(2));
#declare LENGTH3 = cos(atan(2));

// Base tile: 1,2,sqrt(5) sided triangle
#declare pinwheel0 = union {
	polygon { 4, <0,0,0>, <1,0,0>, <0,2,0>, <0,0,0> }
}

// pinwheel 1
#declare pinwheel1 = union  {
	object { pinwheel0 rotate <0,0,-THETA1> texture {texture1} }
	object { pinwheel0 rotate <0,0,-THETA1> translate <0,-LENGTH1,0> texture {texture2} }
   object { pinwheel0 rotate <0,0,-THETA1> rotate <0,0,-90> translate <-LENGTH2,-LENGTH1+LENGTH3,0> texture {texture3} }
   object { pinwheel0 scale <-1,1,1> rotate <0,0,-THETA1> translate <0,-LENGTH1,0> texture {texture4} }
	object { pinwheel0 scale <1,-1,1> rotate <0,0,-THETA1> texture {texture5} }
	scale <-1,1,1>
	translate <LENGTH2,LENGTH1+LENGTH3,0>
	scale 1/LENGTH1
}

// pinwheel 2
#declare pinwheel2 = union  {
   object { pinwheel1 rotate <0,0,-THETA1> }
   object { pinwheel1 rotate <0,0,-THETA1> translate <0,-LENGTH1,0> }
   object { pinwheel1 rotate <0,0,-THETA1> rotate <0,0,-90> translate <-LENGTH2,-LENGTH1+LENGTH3,0> }
   object { pinwheel1 scale <-1,1,1> rotate <0,0,-THETA1> translate <0,-LENGTH1,0> }
   object { pinwheel1 scale <1,-1,1> rotate <0,0,-THETA1> }
	scale <-1,1,1>
   translate <LENGTH2,LENGTH1+LENGTH3,0>
   scale 1/LENGTH1
}

// pinwheel 3
#declare pinwheel3 = union  {
   object { pinwheel2 rotate <0,0,-THETA1> }
   object { pinwheel2 rotate <0,0,-THETA1> translate <0,-LENGTH1,0> }
   object { pinwheel2 rotate <0,0,-THETA1> rotate <0,0,-90> translate <-LENGTH2,-LENGTH1+LENGTH3,0> }
   object { pinwheel2 scale <-1,1,1> rotate <0,0,-THETA1> translate <0,-LENGTH1,0> }
   object { pinwheel2 scale <1,-1,1> rotate <0,0,-THETA1> }
   scale <-1,1,1>
   translate <LENGTH2,LENGTH1+LENGTH3,0>
   scale 1/LENGTH1
}

// pinwheel 4
#declare pinwheel4 = union  {
   object { pinwheel3 rotate <0,0,-THETA1> }
   object { pinwheel3 rotate <0,0,-THETA1> translate <0,-LENGTH1,0> }
   object { pinwheel3 rotate <0,0,-THETA1> rotate <0,0,-90> translate <-LENGTH2,-LENGTH1+LENGTH3,0> }
   object { pinwheel3 scale <-1,1,1> rotate <0,0,-THETA1> translate <0,-LENGTH1,0> }
   object { pinwheel3 scale <1,-1,1> rotate <0,0,-THETA1> }
   scale <-1,1,1>
   translate <LENGTH2,LENGTH1+LENGTH3,0>
   scale 1/LENGTH1
}

union {
	object { pinwheel4 }
	object { pinwheel4 scale <-1,-1,1> translate <1,2,0> } // Forms a rectangle
}

