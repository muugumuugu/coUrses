#include "rand.inc"
#include "colors.inc"
#include "metals.inc"
#include "rad_def.inc"
#include "functions.inc"

background { 
   color rgb <0,0,0> 
}

global_settings {
   ambient_light rgb <1,1,1>
   assumed_gamma 2
   max_trace_level 8
}

#declare H = sqrt(3);
#declare RANGE = 2.5;
#declare VU = <0,0,1>;

#switch (frame_number)
#case (0)
	#declare VP = <-0.9*RANGE,0,H/2>;
	#declare VD = <1,0,0>;
	#declare SCALE = 1;
   #break
#case (1)
   #declare VP = <0,-0.9*RANGE,H/2>;
   #declare VD = <0,1,0>;
	#declare SCALE = 0.95;
   #break
#case (2)
   #declare VP = <-0.6*RANGE,-0.6*RANGE,H/3>;
   #declare VD = <1,1,0>;
	#declare SCALE = 0.95;
   #break
#case (3)
   #declare VP = 0.75*<-0.75*RANGE,-0.75*RANGE,-0.5>;
   #declare VU = <0,0,1>;
   #declare VD = -VP + <0,0,H/2>;
	#declare SCALE = 0.95;
   #break
#end

camera {
   perspective
   location VP
   up y
   right -image_width*x/image_height
   angle 80
   sky VU
   look_at VP + VD
}

#declare thetexture = texture {
   pigment {
      rgb <0.8,0.8,0.5>
   }
   finish {
      ambient 0.1
      diffuse 0.6
      specular 0.3
   }
}

// Lights
light_source {
  <-10,-5,5>
  color <1,1,1>
}
light_source {
  <0,0,10>
  color <1,1,1>
}
light_source {
  <0,0,H/2>
  color <1,1,1>
}
light_source {
  <0,0,-10>
  color <1,1,1>
}

#declare stage1 = union {
	polygon { 5, <-1,-1,0>, <-1,1,0>, <1,1,0>, <1,-1,0>, <-1,-1,0> }
	polygon { 5, <-1,-1,0>, <-1,0,H>, <1,0,H>, <1,-1,0>, <-1,-1,0> }
   polygon { 5, <-1, 1,0>, <-1,0,H>, <1,0,H>, <1, 1,0>, <-1, 1,0> }
	triangle { <1,1,0>, <1,-1,0>, <1,0,H> }
   triangle { <-1,1,0>, <-1,-1,0>, <-1,0,H> }
	scale SCALE
}

#declare stage2 = union {
   object { stage1 } // Ground floor
	object { stage1 translate <2,0,0> }
   object { stage1 translate <4,0,0> }
   object { stage1 translate <0,2,0> }
   object { stage1 translate <4,2,0> }
   object { stage1 translate <0,4,0> }
   object { stage1 translate <2,4,0> }
   object { stage1 translate <4,4,0> }
	object { stage1 translate <0,1,H> } // Second storey
   object { stage1 translate <0,3,H> }
   object { stage1 translate <4,1,H> }
   object { stage1 translate <4,3,H> }
   object { stage1 translate <0,2,2*H> } // Top row
   object { stage1 translate <2,2,2*H> }
   object { stage1 translate <4,2,2*H> }
	translate <-2,-2,0>
   scale 1/3
}

#declare stage3 = union {
   object { stage2 } // Ground floor
   object { stage2 translate <2,0,0> }
   object { stage2 translate <4,0,0> }
   object { stage2 translate <0,2,0> }
   object { stage2 translate <4,2,0> }
   object { stage2 translate <0,4,0> }
   object { stage2 translate <2,4,0> }
   object { stage2 translate <4,4,0> }
   object { stage2 translate <0,1,H> } // Second storey
   object { stage2 translate <0,3,H> }
   object { stage2 translate <4,1,H> }
   object { stage2 translate <4,3,H> }
   object { stage2 translate <0,2,2*H> } // Top row
   object { stage2 translate <2,2,2*H> }
   object { stage2 translate <4,2,2*H> }
   translate <-2,-2,0>
   scale 1/3
}

#declare stage4 = union {
   object { stage3 } // Ground floor
   object { stage3 translate <2,0,0> }
   object { stage3 translate <4,0,0> }
   object { stage3 translate <0,2,0> }
   object { stage3 translate <4,2,0> }
   object { stage3 translate <0,4,0> }
   object { stage3 translate <2,4,0> }
   object { stage3 translate <4,4,0> }
   object { stage3 translate <0,1,H> } // Second storey
   object { stage3 translate <0,3,H> }
   object { stage3 translate <4,1,H> }
   object { stage3 translate <4,3,H> }
   object { stage3 translate <0,2,2*H> } // Top row
   object { stage3 translate <2,2,2*H> }
   object { stage3 translate <4,2,2*H> }
   translate <-2,-2,0>
   scale 1/3
}  

#declare stage5 = union {
   object { stage4 } // Ground floor
   object { stage4 translate <2,0,0> }
   object { stage4 translate <4,0,0> }
   object { stage4 translate <0,2,0> }
   object { stage4 translate <4,2,0> }
   object { stage4 translate <0,4,0> }
   object { stage4 translate <2,4,0> }
   object { stage4 translate <4,4,0> }
   object { stage4 translate <0,1,H> } // Second storey
   object { stage4 translate <0,3,H> }
   object { stage4 translate <4,1,H> }
   object { stage4 translate <4,3,H> } 
   object { stage4 translate <0,2,2*H> } // Top row
   object { stage4 translate <2,2,2*H> }
   object { stage4 translate <4,2,2*H> }
   translate <-2,-2,0>
   scale 1/3
}

union {
   stage5
   texture { thetexture }
}

/*
fog {
   distance 200
   color rgb 0.8*<0.9,0.3,0.1>
   turbulence 0.6
   turb_depth 0.5
   fog_type 2
   fog_offset 20
   fog_alt 4
   rotate <90,0,0>
}

#local SCALESKY = 0.75;

sky_sphere { 
   pigment { 
      function { max(min(y,1),0) }
      color_map {
                        [  0/269 color rgb <120/255, 79/255, 51/255>*SCALESKY]
                        [  1/269 color rgb <141/255, 83/255, 46/255>*SCALESKY]
                        [  2/269 color rgb <177/255, 86/255, 41/255>*SCALESKY]
                        [  3/269 color rgb <235/255,128/255, 72/255>*SCALESKY]
                        [  5/269 color rgb <255/255,159/255, 72/255>*SCALESKY]
                        [  8/269 color rgb <255/255,203/255, 94/255>*SCALESKY]
                        [ 10/269 color rgb <255/255,218/255,112/255>*SCALESKY]
                        [ 13/269 color rgb <255/255,233/255,148/255>*SCALESKY]
                        [ 15/269 color rgb <251/255,241/255,172/255>*SCALESKY]
                        [ 20/269 color rgb <255/255,246/255,203/255>*SCALESKY]
                        [ 30/269 color rgb <255/255,240/255,219/255>*SCALESKY]
                        [ 40/269 color rgb <236/255,223/255,214/255>*SCALESKY]
                        [ 50/269 color rgb <205/255,204/255,212/255>*SCALESKY]
                        [ 55/269 color rgb <185/255,190/255,209/255>*SCALESKY]
                        [ 60/269 color rgb <166/255,176/255,201/255>*SCALESKY]
                        [ 65/269 color rgb <149/255,163/255,190/255>*SCALESKY]
                        [ 70/269 color rgb <129/255,149/255,182/255>*SCALESKY]
                        [ 80/269 color rgb <103/255,127/255,171/255>*SCALESKY]
                        [ 90/269 color rgb < 79/255,110/255,154/255>*SCALESKY]
                        [100/269 color rgb < 66/255, 97/255,143/255>*SCALESKY]
                        [110/269 color rgb < 52/255, 84/255,131/255>*SCALESKY]
                        [120/269 color rgb < 47/255, 75/255,122/255>*SCALESKY]
                        [140/269 color rgb < 37/255, 60/255,102/255>*SCALESKY]
                        [160/269 color rgb < 32/255, 51/255, 84/255>*SCALESKY]
                        [180/269 color rgb < 27/255, 42/255, 71/255>*SCALESKY]
                        [200/269 color rgb < 25/255, 36/255, 58/255>*SCALESKY]
                        [220/269 color rgb < 22/255, 31/255, 48/255>*SCALESKY]
                        [240/269 color rgb < 18/255, 27/255, 42/255>*SCALESKY]
                        [260/269 color rgb < 15/255, 21/255, 33/255>*SCALESKY]
                        [269/269 color rgb < 15/255, 21/255, 33/255>*SCALESKY]
        }
   }
   rotate <90,0,0>
}
*/

