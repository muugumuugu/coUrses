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

#declare dz = 0.001;
#declare dtheta = radians(2);

#declare N = 20;

lathe {
	//linear_spline
	//quadratic_spline
	cubic_spline
	N+1,
	<-0.01,0>
	#declare i = 0;
	#while (i < N) 
		#declare x1 = 1.4*i/N;
		<x1,x1*x1/C>
		#if (i < N-1)
		,
		#end
		#declare i = i + 1;
	#end // i
	rotate <90,0,0>
   texture {
      pigment { color rgb <1,1,1> }
      finish { ambient 0.2 diffuse 0.6 specular 0.3 }
   }
}

