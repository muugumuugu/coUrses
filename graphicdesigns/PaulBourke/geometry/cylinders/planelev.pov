#declare theta = 25;
#declare VP = <2.5*cos(radians(theta)),2.5*sin(radians(theta)*pi/2),1>;
camera {
   location VP
   up y
   right x
   angle 60
   sky <0,0,1>
   look_at <0,0,0>
}

global_settings { ambient_light <1,1,1> }
background { color rgb <1,1,1> }

light_source {
  VP + <0,0,5>
  color rgb <1,1,1>
}

#declare R = 0.5;
#declare L = 1.2;

#declare c1 = cylinder { 
	<-L,0,0>, <L,0,0>, R 
	texture { 
		pigment { color rgb <1,0,0> }
	}
}
#declare c2 = cylinder { 
	<0,-L,0>, <0,L,0>, R 
	texture { 
      pigment { color rgb <0,1,0> }
   }
}
#declare c3 = cylinder { 
	<0,0,-L>, <0,0,L>, R 
	texture { 
      pigment { color rgb <0,0,1> }
   }
}

#if (clock = 0)
union {
	object { c1 }
   object { c2 }
   object { c3 }
}
#end

#if (clock = 1)
intersection {
   object { c1 }
   object { c2 }
   object { c3 }
}
#end

