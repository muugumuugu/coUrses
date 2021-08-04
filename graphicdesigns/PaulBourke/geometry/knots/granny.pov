#declare RR = 4;

#switch (clock) 
#case (0)
   #declare VP = <RR,0,0>;
   #break
#case (1)
   #declare VP = <0,RR,0>;
   #break
#case (2)
   #declare VP = <0,0,RR>;
   #break
#case (3)
   #declare VP = <0.7*RR,0.7*RR,0>;
   #break
#case (4)
   #declare VP = <0,0.7*RR,0.7*RR>;
   #break
#case (5)
   #declare VP = <0.7*RR,0,0.7*RR>;
   #break
#case (6)
   #declare VP = <0.7*RR,0.7*RR,0.7*RR>;
   #break
#end

camera {
   location VP
   up y
   right x
   angle 60
   sky <0,0,1>
   look_at <0,0,0>
}

light_source {
  <RR,0,0>
  color rgb <1,0.5,0.5>
}
light_source {
  <0,RR,0>
  color rgb <0.5,1.0,0.5>
}
light_source {
  <0,0,RR>
  color rgb <0.5,0.5,1.0>
}

#declare thefinish = finish {
   ambient 0.2
   diffuse 0.5
   specular 0.80
   roughness 1/100
}

#declare NN = 10000;
#declare RADIUS = 0.05;

#declare i = 0;
#while (i < NN)
	#declare uu = i * 2 * pi / NN;
	#declare xx = -22 * cos(uu) - 128 * sin(uu) - 44 * cos(3*uu) - 78 * sin(3*uu);
	#declare yy = -10 * cos(2*uu) - 27 * sin(2*uu) + 38 * cos(4*uu) + 46 * sin(4*uu);
	#declare zz = 70 * cos(3*uu) - 40 * sin(3*uu);
	sphere {
		0.01*<xx,yy,zz>, RADIUS
		texture {
			pigment { color rgb <0.5,0.5,0.5> }
			finish { thefinish }
		}
	}
	#declare i = i + 1;
#end

