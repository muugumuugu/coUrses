/* --------------------------
Entry: 0007
Artist: Emanuele Munarini
Title: 
---------------------------*/

#include "colors.inc"
#declare RR = 3; // camera range
/* Render different views */
#switch (clock) 
#case (0)
   #declare VP = <-RR,0,0>;
   #break
#case (1)
   #declare VP = <0,-RR,0>;
   #break
#case (2)
   #declare VP = <0,0,-RR>;
   #break
#case (3)
   #declare VP = <-0.7*RR,-0.7*RR,0>;
   #break
#case (4)
   #declare VP = <0,-0.7*RR,-0.7*RR>;
   #break
#case (5)
   #declare VP = <-0.7*RR,0,-0.7*RR>;
   #break
#case (6)
   #declare VP = <-0.7*RR,-0.7*RR,-0.7*RR>;
   #break
#end
/* Perspective camera */
camera {
   location VP
   up y
   right x // square image
   angle 60
   sky <0,0,1>
   look_at <0,0,0>
}
/* Coloured lights o each axis */
light_source{ <-2*RR,0,0> White }
light_source{ <0,-2*RR,0> White }
light_source{ <0,0,2*RR> White }
//background{Gray}
/* 
   The following is a "simple" implementation of a supershape.
   The parameters for the two shapes are given by SS1 and SS2 variables 
   below, namely m,a,b,n1,n2,n3 as per the formulation given here
      http://astronomy.swin.edu.au/~pbourke/surfaces/supershape3d/
   It will left up the reader to improve this, for example, it is
   useful to be able to vary the range of the longitude and latitude,
   namely the range over which variables t1,t2,p1, and p2 vary. This
   formulation doesn't create normals, sorry, you'll need to use high
   resolutions for smooth surfaces.
*/
#macro SuperShape(SS1m,SS1a,SS1b,SS1n1,SS1n2,SS1n3,SS2m,SS2a,SS2b,SS2n1,SS2n2,SS2n3,resol) 
#declare SS1 = function(T) {
   pow( pow(abs(cos(SS1m*T/4))/SS1a,SS1n2) + pow(abs(sin(SS1m*T/4))/SS1b,SS1n3), 1/SS1n1)
}
#declare SS2 = function(T) {
   pow( pow(abs(cos(SS2m*T/4))/SS2a,SS2n2) + pow(abs(sin(SS2m*T/4))/SS2b,SS2n3), 1/SS2n1)
}
#declare i = 0;
#while (i < resol) // longitude -pi to pi
   #declare j = 0;
   #while (j < resol/2) // latitude -pi/2 to pi/2
      #declare t1 = -pi + i*2*pi/resol;
      #declare t2 = -pi + (i+1)*2*pi/resol;
      #declare p1 = -pi/2 + j*2*pi/resol;
      #declare p2 = -pi/2 + (j+1)*2*pi/resol;
      #declare zeros = 0;
      #declare r0 = SS1(t1);
      #if (r0 = 0) #declare zeros = zeros+1; #end
      #declare r1 = SS2(p1);
      #if (r1 = 0) #declare zeros = zeros+1; #end
      #declare r2 = SS1(t2);
      #if (r2 = 0) #declare zeros = zeros+1; #end
      #declare r3 = SS2(p2);
      #if (r3 = 0) #declare zeros = zeros+1; #end
      #if (zeros = 0)
         #declare r0 = 1 / r0;
         #declare r1 = 1 / r1;
         #declare r2 = 1 / r2;
         #declare r3 = 1 / r3;
         #declare pa = <r0*cos(t1)*r1*cos(p1),r0*sin(t1)*r1*cos(p1),r1*sin(p1)>;
         #declare pb = <r2*cos(t2)*r1*cos(p1),r2*sin(t2)*r1*cos(p1),r1*sin(p1)>;
         #declare pc = <r2*cos(t2)*r3*cos(p2),r2*sin(t2)*r3*cos(p2),r3*sin(p2)>;
         #declare pd = <r0*cos(t1)*r3*cos(p2),r0*sin(t1)*r3*cos(p2),r3*sin(p2)>;
         #if (vlength(pa - pb) > 0) 
            #if (vlength(pa - pc) > 0)
               triangle { pa, pb, pc }
            #end 
         #end
         #if (vlength(pc - pd) > 0) 
            #if (vlength(pc - pa) > 0)
               triangle { pc, pd, pa }
            #end 
         #end
      #end // if
      #declare j = j + 1;
   #end // j
   #declare i = i + 1;
#end // i
#end // macro
/* Lets use it */
union{
 
mesh {
 SuperShape(8, 0.536393322550127, 0.287026581621754, 100, 38.1786553544725, -34, 
            9, 1.42240668965728, 1.12839136936552, 100, 300, 12, 300)             
 pigment{ 
  onion 
  color_map{ 
   [0.1 0.4 color White color PaleGreen]
   [0.4 0.6 color PaleGreen color MediumSeaGreen]
   [0.6 0.8 color MediumSeaGreen color ForestGreen] 
   [0.8 1   color ForestGreen color DarkGreen] 
  }
  scale 0.1 //05
 } 
 finish{ 
   ambient 0.5
   diffuse 0.4
   specular 0.4
   roughness 0.001
   phong 1
 }
 rotate 60*z //rotate -60*y
 //translate 0.5*x 
}
plane{ z, -1
 pigment{ NavyBlue }  
 finish{
   ambient 0.5
   diffuse 0.7
   specular 0.4
   roughness 0.001
   phong 1
 }
 normal{ granite }
} 
rotate -60*y
}
