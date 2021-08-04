
#declare DRAWMODE = clock; // 0 for 2d tile, >1 for 3D

#if (DRAWMODE = 2)
	#declare VP = 7*<1,-0.5,1>;
#else
	#declare VP = 6*<1,-1,1>;
#end

camera {
	#if (DRAWMODE = 0)
		orthographic
	#else
		perspective
	#end
   location VP
   up y
   right -image_width*x/image_height
   angle 60
   sky <0,0,1>
   look_at <0,0,0>
}

global_settings {
   ambient_light <1,1,1>
}

// Lights
#if (DRAWMODE = 2)
   light_source {
      <0,0,100>
      color rgb <1,1,1>
   }
   light_source {
      VP
      color rgb 0.5*<1,1,1>
   }
#else
	light_source {
	   <0,0,100>
	   color rgb <1,1,1>
	}
	light_source {
	   <0,100,0>
	   color rgb 0.8*<1,1,1>
	}
	light_source {
	   <100,0,0>
	   color rgb 0.6*<1,1,1>
	}
#end

#if (DRAWMODE = 2)
   #declare thetexture = texture {
		pigment {
			color rgb <1,1,1>
		}
   	finish {
      	ambient 0.1
      	diffuse 0.6
      	specular 0.4
   	}
		normal {
		   granite 0.4
		   scale 0.2
		}
	}
#else
   #declare thetexture = texture {
      pigment {
         color rgb <1,1,1>
      }
      finish {
         ambient 0.2
         diffuse 0.8
         specular 0
      }
   }
#end

#declare stage0 = union {
	box { <0,0,0>, <1,1,1> }
	box { <0,0,0>, <1,1,1> scale 1/3 translate <0,-1/3,2/3> }
   box { <0,0,0>, <1,1,1> scale 1/3 translate <1,0,0> }
   box { <0,0,0>, <1,1,1> scale 1/3 translate <2/3,2/3,1> }
	translate <-0.5,-0.5,-0.5>
}

#declare N = 10;
#declare stage1 = union {
	#declare i = -N;
	#while (i < N)
   	object { stage0 translate i*<-1,-2/3, 1/3> }
		#declare i = i + 1;
	#end
}

#declare stage2 = union {
   #declare i = -N;
   #while (i < N)
   	object { stage1 translate i*<1/3,1,2/3> }
      #declare i = i + 1;
   #end
}

object {
	stage2
   texture { thetexture }
}

