#include "common.inc"

#declare SHOWAXES = 0; // 0 to turn on

background { color rgb <1,1,1> }

// Camera
#declare VP = 20*vnormalize(<cos(clock*2*pi),sin(clock*2*pi),2*(1-cos(clock*2*pi))>);
#declare VD = -VP;
#declare VU = <0,0,1>;
/*
camera {
   perspective
   location VP
	angle 60
   up y
   right -image_width*x/image_height
   sky VU
	look_at VP+VD
}
*/
camera {
   orthographic
   location <0,10,0>
   up 12*y
   right -12*x
   sky <0,0,1>
   look_at <0,0,0>
}

// Lights, good to have one at the view position
light_source {
   VP
   color rgb 0.5*<1,1,1>
}
light_source {
   <0,0,100>
   color rgb <1,1,1>
}

#declare xymaterial = texture { pigment { colour rgb <0.1,0.5,0.9> } finish { metalfinish } }
#declare xzmaterial = texture { pigment { colour rgb <0.5,0.8,0.1> } finish { metalfinish } }
#declare yzmaterial = texture { pigment { colour rgb <0.8,0.1,0.2> } finish { metalfinish } }

// Axes
#if (SHOWAXES = 0)
#declare RR = 0.04;
#declare AXISLENGTH = 1;
union {
	union {
		cylinder { <0,0,0>, <AXISLENGTH,0,0>, RR }
		cone { <AXISLENGTH,0,0>, 2*RR, <AXISLENGTH+9*RR,0,0>, 0 }
		texture { redtexture }
	}
	union {
	   cylinder { <0,0,0>, <0,AXISLENGTH,0>, RR }
	   cone { <0,AXISLENGTH,0>, 2*RR, <0,AXISLENGTH+9*RR,0>, 0 }
	   texture { dkgreentexture }
	}
	union {
	   cylinder { <0,0,0>, <0,0,AXISLENGTH>, RR }
	   cone { <0,0,AXISLENGTH>, 2*RR, <0,0,AXISLENGTH+9*RR>, 0 }
	   texture { bluetexture }
	}
	no_shadow
	translate <4,4,0>
}
#end

#declare minor = 0.275;
#declare major = 1.0; //minor*(2+sqrt(2));
#declare dxy = 2*(minor+major) + minor; //minor*(4+4*sqrt(2)); 
#declare N = 1;

#declare xytorus = torus {
   major,minor
   rotate <90,0,0>
   texture { xymaterial }
}
#declare xztorus = torus {
   major,minor
   texture { xzmaterial }
}
#declare yztorus = torus {
   major,minor
   rotate <0,0,90>
   texture { yzmaterial }
}

#declare k = -N;
#while (k <= N)

// Blue
#declare i = -N;
#while (i <= N)  
	#declare j = -N;
	#while (j <= N)
		object { xytorus translate <i*dxy,j*dxy,k*dxy> }
		object { xytorus translate <dx+dxy/2,dy+dxy/2,dz+dxy/2> }
		#declare j = j + 1;
	#end
	#declare i = i + 1;
#end

// Green
#declare i = -N;
#while (i <= N) 
   #declare j = -2*N;
   #while (j <= 2*N)
      #if (mod(j+4*N,2) = 1)
         #declare dx = i*dxy;
         #declare dy = j*dxy/2;
         #declare dz = k*dxy+dxy/2;
      #else
         #declare dx = i*dxy+dxy/2;
         #declare dy = j*dxy/2;
         #declare dz = k*dxy;
      #end
      object { xztorus translate <dx,dy,dz> }
      #declare j = j + 1;
   #end
   #declare i = i + 1;
#end

// Red
#declare i = -2*N; 
#while (i <= 2*N)
   #declare j = -N;
   #while (j <= N)
		#if (mod(i+4*N,2) = 0)
			#declare dx = i*dxy/2;
			#declare dy = j*dxy+dxy/2;
			#declare dz = k*dxy;
		#else
			#declare dx = i*dxy/2;
			#declare dy = j*dxy;
			#declare dz = k*dxy+dxy/2;
		#end
      object { yztorus translate <dx,dy,dz> }
      #declare j = j + 1;
   #end
   #declare i = i + 1;
#end

#declare k = k + 1;
#end



