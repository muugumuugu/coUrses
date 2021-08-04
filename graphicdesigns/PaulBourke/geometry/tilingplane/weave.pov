
#declare DRAWMODE = clock; // 0 for 2d tile, >1 for 3D

#if (DRAWMODE = 2)
   #declare VP = 3*vnormalize(<0,1,1>);
#end
#if (DRAWMODE = 1)
	#declare VP = 3*vnormalize(<1,0,1>);
#end
#if (DRAWMODE = 0)
	#declare VP = 3*<0,0,1>;
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

background {
   color rgb <1,1,1>
}

global_settings {
   ambient_light <1,1,1>
}

// Lights
   light_source {
      <0,0,100>
      color rgb <1,1,1>
   }

#if (DRAWMODE = 0)
   #declare thetexture = texture {
      pigment {
         color rgb <1,1,1>
      }
      finish {
         ambient 0.1
         diffuse 0.7
         specular 0
      }
   }
#else
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
#end

#declare RADIUS = 0.1;

#declare tileunit1 = union { // cross bar 1
	sphere_sweep {
		b_spline
		11,
		<-0.6, 1.2, 0.0>, RADIUS,
		<-0.6, 1.0, 0.0>, RADIUS,
      <-0.6, 0.8, 0.0>, RADIUS,
      <-0.6, 0.6, 0.0>, RADIUS,
      <-0.2, 0.2, 0.0>, RADIUS,
      < 0.0, 0.0, 0.2>, RADIUS, // center
      < 0.2,-0.2, 0.0>, RADIUS,
      < 0.6,-0.6, 0.0>, RADIUS,
      < 0.6,-0.8, 0.0>, RADIUS,
      < 0.6,-1.0, 0.0>, RADIUS,
      < 0.6,-1.2, 0.0>, RADIUS
	}
}
#declare tileunit2 = union { // Curvey piece
   sphere_sweep {
      b_spline
      10,
      <-1.2, 0.6, 0.0>, RADIUS,
      <-1.0, 0.6, 0.0>, RADIUS,
      <-0.8, 0.6, 0.0>, RADIUS,
      <-0.3, 0.7,-0.5>, RADIUS,
      <-0.2, 0.5, 0.4>, RADIUS,
      <-0.6, 0.0, 0.1>, RADIUS,
      <-0.8,-0.3,-0.4>, RADIUS,
      <-0.6,-0.8, 0.0>, RADIUS,
      <-0.6,-1.0, 0.0>, RADIUS,
      <-0.6,-1.2, 0.0>, RADIUS
   }
}
#declare tileunit3 = union { // Cross bar 2
   sphere_sweep {
      b_spline
      11,
      <-0.6, 1.2, 0.00>, RADIUS,
      <-0.6, 1.0, 0.00>, RADIUS,
      <-0.6, 0.8, 0.00>, RADIUS,
      <-0.6, 0.6, 0.20>, RADIUS,
      <-0.3, 0.3, 0.00>, RADIUS,
      < 0.0, 0.0,-0.20>, RADIUS, // center
      < 0.3,-0.3, 0.00>, RADIUS,
      < 0.6,-0.6, 0.20>, RADIUS,
      < 0.6,-0.8, 0.00>, RADIUS,
      < 0.6,-1.0, 0.00>, RADIUS,
      < 0.6,-1.2, 0.00>, RADIUS
   }
	rotate <0,0,90>
}

//intersection {
	union {
		object { tileunit1 }
	   object { tileunit2 }
	   object { tileunit2 rotate <0,0,180> }
	   object { tileunit3 }
		texture { thetexture }
	}
   //box { <-1,-1,-1>, <1,1,1> }
	//texture { thetexture }
//}

union {
	cylinder { <-1,-1,0>, <-1, 1,0>, 0.01 }
	cylinder { <-1, 1,0>, < 1, 1,0>, 0.01 }
	cylinder { < 1, 1,0>, < 1,-1,0>, 0.01 }
	cylinder { < 1,-1,0>, <-1,-1,0>, 0.01 }
	pigment { color rgb <1,0,0> }
}

