// Based upon source by Louis Bellotto

#include "colors.inc"

#declare index = 0;

global_settings {
	assumed_gamma 1.80
	max_trace_level 10
}

#declare VP = 2*<cos(clock*2*pi),sin(clock*2*pi),0.5>;

camera {
   perspective
	location VP
   up y
   right image_width*x/image_height
   angle 60
   sky <0,0,1>
  	look_at <0,0,0>
}

light_source {
	VP
	color White
}

background {
	color <0,0,0>
}

//		Create a triangular facet approximation to a sphere
//		Return the number of facets created.
//		The number of facets will be (4^iterations) * 8
#macro CreateNSphere (iterationNumber)
	#local i = 0;
	#local it = 0;
	#local pointA = <0,0,0>;
	#local pointB = <0,0,0>;
	#local pointC = <0,0,0>;
	
	#local p = array[6];
	#local p[0] = < 0, 0, 1>;
	#local p[1] = < 0, 0,-1>;
	#local p[2] = <-1/sqrt(2.0),-1/sqrt(2.0), 0>;
	#local p[3] = < 1/sqrt(2.0),-1/sqrt(2.0), 0>;
	#local p[4] = < 1/sqrt(2.0), 1/sqrt(2.0), 0>;
	#local p[5] = <-1/sqrt(2.0), 1/sqrt(2.0), 0>;

	// --- Create the level 0 object
	#declare facettes[0][0]=p[0];#declare facettes[0][1]=p[3];#declare facettes[0][2]=p[4];
	#declare facettes[1][0]=p[0];#declare facettes[1][1]=p[4];#declare facettes[1][2]=p[5];
	#declare facettes[2][0]=p[0];#declare facettes[2][1]=p[5];#declare facettes[2][2]=p[2];
	#declare facettes[3][0]=p[0];#declare facettes[3][1]=p[2];#declare facettes[3][2]=p[3];
	#declare facettes[4][0]=p[1];#declare facettes[4][1]=p[4];#declare facettes[4][2]=p[3];
	#declare facettes[5][0]=p[1];#declare facettes[5][1]=p[5];#declare facettes[5][2]=p[4];
	#declare facettes[6][0]=p[1];#declare facettes[6][1]=p[2];#declare facettes[6][2]=p[5];
	#declare facettes[7][0]=p[1];#declare facettes[7][1]=p[3];#declare facettes[7][2]=p[2];
	#local nt=8;
	
	#if (iterationNumber > 0)
		// -- Bisect each edge and move to the surface of a unit sphere
		#declare it=0;
		#while (it<iterationNumber)
			#local ntOld=nt;
			#declare i=0;
			#while(i<ntOld)
				// --- build mid points
				#declare pointA = (facettes[i][0]+facettes[i][1])/2;
				#declare pointB = (facettes[i][1]+facettes[i][2])/2;
				#declare pointC = (facettes[i][2]+facettes[i][0])/2;
				
				// --- unit length vector that is the same direction as original vector
				#declare pointA = vnormalize(pointA);
				#declare pointB = vnormalize(pointB);
				#declare pointC = vnormalize(pointC);
			
				#declare facettes[nt][0]=facettes[i][0];
				#declare facettes[nt][1]=pointA;
				#declare facettes[nt][2]=pointC;
				#declare nt=nt+1;
				
				#declare facettes[nt][0]=pointA;
				#declare facettes[nt][1]=facettes[i][1];
				#declare facettes[nt][2]=pointB;
				#declare nt=nt+1;
				
				#declare facettes[nt][0]=pointB;
				#declare facettes[nt][1]=facettes[i][2];
				#declare facettes[nt][2]=pointC;
				#declare nt=nt+1;
				
				#declare facettes[i][0]=pointA;
				#declare facettes[i][1]=pointB;
				#declare facettes[i][2]=pointC;
			
				#declare i=i+1;
			#end
			#declare it=it+1;
		#end
	#end
	nt
#end

#macro samePoint (v1,v2)
	((v1.x = v2.x) & (v1.y = v2.y) & (v1.z = v2.z))
#end

#declare iteration = 5;
#declare nfacettes = pow(4,iteration)*8;

#debug concat(str(nfacettes,0,0)," faces to compute...\n")
#declare facettes = array [nfacettes][3];

#declare fCreated = CreateNSphere(iteration);
#debug concat("Created ",str(fCreated,0,0)," faces\n")

// Draw framing
#declare rSphere = 0.005;
#declare rTube = 0.0025;
#declare index=0;
#while (index < fCreated)
	union {
		sphere { facettes[index][0], rSphere }
		sphere { facettes[index][1], rSphere }
		sphere { facettes[index][2], rSphere }
		pigment { color OrangeRed }
		finish { ambient 0.2 diffuse 0.6 specular 0.5 }
	}
	union {
		cylinder { facettes[index][0], facettes[index][1], rTube }
		cylinder { facettes[index][1], facettes[index][2], rTube }
		cylinder { facettes[index][2], facettes[index][0], rTube }
		pigment { color MediumGoldenrod }
		finish { ambient 0.2 diffuse 0.6 specular 0.5 }
	}
	#declare index = index+1;
#end

/* Enclosing sphere
sphere {
	<0,0,0>, 1
	pigment { color MediumWood transmit 0.90 }
	finish { ambient 0.40 diffuse 0.60 }
}
*/

