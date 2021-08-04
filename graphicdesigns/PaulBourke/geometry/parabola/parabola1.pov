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

isosurface {
   function { 
		x*x + y*y - C*z 
	}
   contained_by { 
		sphere { <0,0,0>, 2 }
	}
	threshold 0
	accuracy 0.01
	max_gradient 100
	open
	texture { 
		pigment { color rgb <1,1,1> }
		finish { ambient 0.2 diffuse 0.6 specular 0.3 }
	}
}

