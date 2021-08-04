
background { color rgb <1,1,1> }

#declare thefinish = finish { ambient 0.2 diffuse 0.6 specular 0.2 };
#declare thetexture = texture { 
	pigment { colour rgb <122,208,187>/255 } 
	finish { thefinish }
};

// Camera
#declare RANGE = 1.1;
#declare VP = RANGE*<1,1,0.75>;
camera {
   perspective
	location VP
   up y
   right -image_width*x/image_height
	angle 60
   sky <0,0,1>
  	look_at <0,0,0>
}

#declare LR = 10;
light_source { LR*<1,0,0> color rgb <1,1,1> }
light_source { LR*<0,1,0> color rgb <1,1,1> }
light_source { LR*<0,0,1> color rgb <1,1,1> }
light_source { LR*<-1,0,0> color rgb <1,1,1> }
light_source { LR*<0,-1,0> color rgb <1,1,1> }
light_source { LR*<0,0,-1> color rgb <1,1,1> }
light_source { <0,0,0> color rgb <1,1,1> }

#declare SCALE1 = sqrt(2.0) - 1;
#declare SCALE2 = SCALE1 * SCALE1;
#declare TRANS1 = (SCALE1 + SCALE2) / 2;
#declare TRANS2 = SCALE1;

#declare s0 = box { 
	<-0.5,-0.5,-0.5>, <0.5,0.5,0.5> 
}

#declare s1 = union {
	object { s0 scale SCALE1*<1,1,1> translate <-TRANS1,-TRANS1,-TRANS1> }
   object { s0 scale SCALE1*<1,1,1> translate <-TRANS1, TRANS1,-TRANS1> }
   object { s0 scale SCALE1*<1,1,1> translate < TRANS1, TRANS1,-TRANS1> }
   object { s0 scale SCALE1*<1,1,1> translate < TRANS1,-TRANS1,-TRANS1> }
   object { s0 scale SCALE1*<1,1,1> translate <-TRANS1,-TRANS1, TRANS1> }
   object { s0 scale SCALE1*<1,1,1> translate <-TRANS1, TRANS1, TRANS1> }
   object { s0 scale SCALE1*<1,1,1> translate < TRANS1, TRANS1, TRANS1> }
   object { s0 scale SCALE1*<1,1,1> translate < TRANS1,-TRANS1, TRANS1> }

   object { s0 scale SCALE2*<1,1,1> translate <0,-TRANS2, TRANS2> }
   object { s0 scale SCALE2*<1,1,1> translate <0, TRANS2, TRANS2> }
   object { s0 scale SCALE2*<1,1,1> translate < TRANS2,0, TRANS2> }
   object { s0 scale SCALE2*<1,1,1> translate <-TRANS2,0, TRANS2> }

   object { s0 scale SCALE2*<1,1,1> translate <0,-TRANS2,-TRANS2> }
   object { s0 scale SCALE2*<1,1,1> translate <0, TRANS2,-TRANS2> }
   object { s0 scale SCALE2*<1,1,1> translate < TRANS2,0,-TRANS2> }
   object { s0 scale SCALE2*<1,1,1> translate <-TRANS2,0,-TRANS2> }

   object { s0 scale SCALE2*<1,1,1> translate <-TRANS2,-TRANS2,0> }
   object { s0 scale SCALE2*<1,1,1> translate < TRANS2, TRANS2,0> }
   object { s0 scale SCALE2*<1,1,1> translate < TRANS2,-TRANS2,0> }
   object { s0 scale SCALE2*<1,1,1> translate <-TRANS2, TRANS2,0> }
}

#declare s2 = union {
   object { s1 scale SCALE1*<1,1,1> translate <-TRANS1,-TRANS1,-TRANS1> }
   object { s1 scale SCALE1*<1,1,1> translate <-TRANS1, TRANS1,-TRANS1> }
   object { s1 scale SCALE1*<1,1,1> translate < TRANS1, TRANS1,-TRANS1> }
   object { s1 scale SCALE1*<1,1,1> translate < TRANS1,-TRANS1,-TRANS1> }
   object { s1 scale SCALE1*<1,1,1> translate <-TRANS1,-TRANS1, TRANS1> }
   object { s1 scale SCALE1*<1,1,1> translate <-TRANS1, TRANS1, TRANS1> }
   object { s1 scale SCALE1*<1,1,1> translate < TRANS1, TRANS1, TRANS1> }
   object { s1 scale SCALE1*<1,1,1> translate < TRANS1,-TRANS1, TRANS1> }

   object { s0 scale SCALE2*<1,1,1> translate <0,-TRANS2, TRANS2> }
   object { s0 scale SCALE2*<1,1,1> translate <0, TRANS2, TRANS2> }
   object { s0 scale SCALE2*<1,1,1> translate < TRANS2,0, TRANS2> }
   object { s0 scale SCALE2*<1,1,1> translate <-TRANS2,0, TRANS2> }

   object { s0 scale SCALE2*<1,1,1> translate <0,-TRANS2,-TRANS2> }
   object { s0 scale SCALE2*<1,1,1> translate <0, TRANS2,-TRANS2> }
   object { s0 scale SCALE2*<1,1,1> translate < TRANS2,0,-TRANS2> }
   object { s0 scale SCALE2*<1,1,1> translate <-TRANS2,0,-TRANS2> }

   object { s0 scale SCALE2*<1,1,1> translate <-TRANS2,-TRANS2,0> }
   object { s0 scale SCALE2*<1,1,1> translate < TRANS2, TRANS2,0> }
   object { s0 scale SCALE2*<1,1,1> translate < TRANS2,-TRANS2,0> }
   object { s0 scale SCALE2*<1,1,1> translate <-TRANS2, TRANS2,0> }
}


#declare s3 = union {
   object { s2 scale SCALE1*<1,1,1> translate <-TRANS1,-TRANS1,-TRANS1> }
   object { s2 scale SCALE1*<1,1,1> translate <-TRANS1, TRANS1,-TRANS1> }
   object { s2 scale SCALE1*<1,1,1> translate < TRANS1, TRANS1,-TRANS1> }
   object { s2 scale SCALE1*<1,1,1> translate < TRANS1,-TRANS1,-TRANS1> }
   object { s2 scale SCALE1*<1,1,1> translate <-TRANS1,-TRANS1, TRANS1> }
   object { s2 scale SCALE1*<1,1,1> translate <-TRANS1, TRANS1, TRANS1> }
   object { s2 scale SCALE1*<1,1,1> translate < TRANS1, TRANS1, TRANS1> }
   object { s2 scale SCALE1*<1,1,1> translate < TRANS1,-TRANS1, TRANS1> }

   object { s1 scale SCALE2*<1,1,1> translate <0,-TRANS2, TRANS2> }
   object { s1 scale SCALE2*<1,1,1> translate <0, TRANS2, TRANS2> }
   object { s1 scale SCALE2*<1,1,1> translate < TRANS2,0, TRANS2> }
   object { s1 scale SCALE2*<1,1,1> translate <-TRANS2,0, TRANS2> }

   object { s1 scale SCALE2*<1,1,1> translate <0,-TRANS2,-TRANS2> }
   object { s1 scale SCALE2*<1,1,1> translate <0, TRANS2,-TRANS2> }
   object { s1 scale SCALE2*<1,1,1> translate < TRANS2,0,-TRANS2> }
   object { s1 scale SCALE2*<1,1,1> translate <-TRANS2,0,-TRANS2> }

   object { s1 scale SCALE2*<1,1,1> translate <-TRANS2,-TRANS2,0> }
   object { s1 scale SCALE2*<1,1,1> translate < TRANS2, TRANS2,0> }
   object { s1 scale SCALE2*<1,1,1> translate < TRANS2,-TRANS2,0> }
   object { s1 scale SCALE2*<1,1,1> translate <-TRANS2, TRANS2,0> }
}

#declare s4 = union {
   object { s3 scale SCALE1*<1,1,1> translate <-TRANS1,-TRANS1,-TRANS1> }
   object { s3 scale SCALE1*<1,1,1> translate <-TRANS1, TRANS1,-TRANS1> }
   object { s3 scale SCALE1*<1,1,1> translate < TRANS1, TRANS1,-TRANS1> }
   object { s3 scale SCALE1*<1,1,1> translate < TRANS1,-TRANS1,-TRANS1> }
   object { s3 scale SCALE1*<1,1,1> translate <-TRANS1,-TRANS1, TRANS1> }
   object { s3 scale SCALE1*<1,1,1> translate <-TRANS1, TRANS1, TRANS1> }
   object { s3 scale SCALE1*<1,1,1> translate < TRANS1, TRANS1, TRANS1> }
   object { s3 scale SCALE1*<1,1,1> translate < TRANS1,-TRANS1, TRANS1> }

   object { s2 scale SCALE2*<1,1,1> translate <0,-TRANS2, TRANS2> }
   object { s2 scale SCALE2*<1,1,1> translate <0, TRANS2, TRANS2> }
   object { s2 scale SCALE2*<1,1,1> translate < TRANS2,0, TRANS2> }
   object { s2 scale SCALE2*<1,1,1> translate <-TRANS2,0, TRANS2> }

   object { s2 scale SCALE2*<1,1,1> translate <0,-TRANS2,-TRANS2> }
   object { s2 scale SCALE2*<1,1,1> translate <0, TRANS2,-TRANS2> }
   object { s2 scale SCALE2*<1,1,1> translate < TRANS2,0,-TRANS2> }
   object { s2 scale SCALE2*<1,1,1> translate <-TRANS2,0,-TRANS2> }

   object { s2 scale SCALE2*<1,1,1> translate <-TRANS2,-TRANS2,0> }
   object { s2 scale SCALE2*<1,1,1> translate < TRANS2, TRANS2,0> }
   object { s2 scale SCALE2*<1,1,1> translate < TRANS2,-TRANS2,0> }
   object { s2 scale SCALE2*<1,1,1> translate <-TRANS2, TRANS2,0> }
}

#declare s5 = union {
   object { s4 scale SCALE1*<1,1,1> translate <-TRANS1,-TRANS1,-TRANS1> }
   object { s4 scale SCALE1*<1,1,1> translate <-TRANS1, TRANS1,-TRANS1> }
   object { s4 scale SCALE1*<1,1,1> translate < TRANS1, TRANS1,-TRANS1> }
   object { s4 scale SCALE1*<1,1,1> translate < TRANS1,-TRANS1,-TRANS1> }
   object { s4 scale SCALE1*<1,1,1> translate <-TRANS1,-TRANS1, TRANS1> }
   object { s4 scale SCALE1*<1,1,1> translate <-TRANS1, TRANS1, TRANS1> }
   object { s4 scale SCALE1*<1,1,1> translate < TRANS1, TRANS1, TRANS1> }
   object { s4 scale SCALE1*<1,1,1> translate < TRANS1,-TRANS1, TRANS1> }

   object { s3 scale SCALE2*<1,1,1> translate <0,-TRANS2, TRANS2> }
   object { s3 scale SCALE2*<1,1,1> translate <0, TRANS2, TRANS2> }
   object { s3 scale SCALE2*<1,1,1> translate < TRANS2,0, TRANS2> }
   object { s3 scale SCALE2*<1,1,1> translate <-TRANS2,0, TRANS2> }

   object { s3 scale SCALE2*<1,1,1> translate <0,-TRANS2,-TRANS2> }
   object { s3 scale SCALE2*<1,1,1> translate <0, TRANS2,-TRANS2> }
   object { s3 scale SCALE2*<1,1,1> translate < TRANS2,0,-TRANS2> }
   object { s3 scale SCALE2*<1,1,1> translate <-TRANS2,0,-TRANS2> }

   object { s3 scale SCALE2*<1,1,1> translate <-TRANS2,-TRANS2,0> }
   object { s3 scale SCALE2*<1,1,1> translate < TRANS2, TRANS2,0> }
   object { s3 scale SCALE2*<1,1,1> translate < TRANS2,-TRANS2,0> }
   object { s3 scale SCALE2*<1,1,1> translate <-TRANS2, TRANS2,0> }
}

#declare s6 = union {
   object { s5 scale SCALE1*<1,1,1> translate <-TRANS1,-TRANS1,-TRANS1> }
   object { s5 scale SCALE1*<1,1,1> translate <-TRANS1, TRANS1,-TRANS1> }
   object { s5 scale SCALE1*<1,1,1> translate < TRANS1, TRANS1,-TRANS1> }
   object { s5 scale SCALE1*<1,1,1> translate < TRANS1,-TRANS1,-TRANS1> }
   object { s5 scale SCALE1*<1,1,1> translate <-TRANS1,-TRANS1, TRANS1> }
   object { s5 scale SCALE1*<1,1,1> translate <-TRANS1, TRANS1, TRANS1> }
   object { s5 scale SCALE1*<1,1,1> translate < TRANS1, TRANS1, TRANS1> }
   object { s5 scale SCALE1*<1,1,1> translate < TRANS1,-TRANS1, TRANS1> }

   object { s4 scale SCALE2*<1,1,1> translate <0,-TRANS2, TRANS2> }
   object { s4 scale SCALE2*<1,1,1> translate <0, TRANS2, TRANS2> }
   object { s4 scale SCALE2*<1,1,1> translate < TRANS2,0, TRANS2> }
   object { s4 scale SCALE2*<1,1,1> translate <-TRANS2,0, TRANS2> }

   object { s4 scale SCALE2*<1,1,1> translate <0,-TRANS2,-TRANS2> }
   object { s4 scale SCALE2*<1,1,1> translate <0, TRANS2,-TRANS2> }
   object { s4 scale SCALE2*<1,1,1> translate < TRANS2,0,-TRANS2> }
   object { s4 scale SCALE2*<1,1,1> translate <-TRANS2,0,-TRANS2> }

   object { s4 scale SCALE2*<1,1,1> translate <-TRANS2,-TRANS2,0> }
   object { s4 scale SCALE2*<1,1,1> translate < TRANS2, TRANS2,0> }
   object { s4 scale SCALE2*<1,1,1> translate < TRANS2,-TRANS2,0> }
   object { s4 scale SCALE2*<1,1,1> translate <-TRANS2, TRANS2,0> }
}

object {
	s6
	texture { thetexture }
	rotate <0,0,clock*360>
}

