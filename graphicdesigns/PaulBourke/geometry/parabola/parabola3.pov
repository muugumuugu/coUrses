#declare RR = 4;
#switch (clock) 
#case (0)
   #declare VP = <RR,0,0>;
   #break
#case (1)
   #declare VP = <0,0,RR>;
   #break
#case (2)
   #declare VP = <0.7*RR,0,0.7*RR>;
   #break
#case (3)
   #declare VP = <0.7*RR,0.7*RR,0.7*RR>;
   #break
#end

camera {
   location VP
   up y
   right x
   angle 60
   sky <0,0,1>
   look_at <0,0,0.5>
}

light_source {
  <15,0,0>
  color rgb <1,0.5,0.5>
}
light_source {
  <0,15,0>
  color rgb <0.5,1.0,0.5>
}
light_source {
  <0,0,15>
  color rgb <0.5,0.5,1.0>
}

#declare C = 1;

#declare dz = 0.01;
#declare dtheta = radians(2);

union {
	#declare z1 = 0;
	#while (z1 < 1.5) 
		#declare theta = 0;
		#while (theta < 2*pi)
			#declare r1 = sqrt(C*z1);
			#declare r2 = sqrt(C*(z1+dz));
			#if (z1 > 0)
			triangle {
				<r1*cos(theta),r1*sin(theta),z1>,
            <r1*cos(theta+dtheta),r1*sin(theta+dtheta),z1>,
            <r2*cos(theta+dtheta),r2*sin(theta+dtheta),z1+dz>
			}
			#end
			triangle {
				<r1*cos(theta),r1*sin(theta),z1>,
				<r2*cos(theta+dtheta),r2*sin(theta+dtheta),z1+dz>,
            <r2*cos(theta),r2*sin(theta),z1+dz>
			}
			#declare theta = theta + dtheta;
		#end // theta
		#declare z1 = z1 + dz;
	#end // z1
   texture {
      pigment { color rgb <1,1,1> }
      finish { ambient 0.2 diffuse 0.6 specular 0.3 }
   }
}

