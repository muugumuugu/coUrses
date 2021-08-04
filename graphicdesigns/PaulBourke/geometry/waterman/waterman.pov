/*
   PovRay scene that creates Waterman sphere based polyhedra.
   Written and tested using PovRay 3.5
*/

/* Change this at will */
#declare ROOT = 10;

/* This varies the colour ramp, should be between 0 and 1 */
#declare CUTOFF = 0.5;

#declare RADIUS2 = 2 * ROOT;
#declare RADIUS = sqrt(RADIUS2);
#declare SRADIUS = 1/sqrt(2.0);

#declare vp = 0.7*<3*(RADIUS+0.5),(RADIUS+0.5),(RADIUS+0.5)>;
camera {
   location vp
   up y
   right -x*image_width/image_height
   angle 60
   sky <0,0,1>
   look_at <0,0,0>
}

global_settings {
  assumed_gamma 1.0
}

light_source {
   <3*RADIUS,RADIUS,2*RADIUS>
   color rgb <1,1,1>
}

#declare IR = int(RADIUS2+1);
#declare ix = -IR;
#while (ix <= IR) 
   #declare iy = -IR;
   #declare R = ix*ix + iy*iy;
   #while (iy <= IR)
      #declare iz = -IR;
      #while (iz <= IR)
         #if (mod(ix+iy+iz,2) = 0)
            #declare R = ix*ix + iy*iy + iz*iz;
            #if (R <= RADIUS2)
               #debug "o"
               sphere {
                  <ix,iy,iz>, SRADIUS
                  #declare RAMP = (R-CUTOFF*RADIUS2)/(RADIUS2-CUTOFF*RADIUS2);
                  #if (RAMP > 1)
                     #declare RAMP = 1;
                  #end
                  #if (RAMP < 0)
                     #declare RAMP = 0;
                  #end
                  texture {
                     pigment { color rgb <RAMP,0,1-RAMP> }
                     finish { specular 0.3 }
                  }
               }
            #end
         #end
         #declare iz = iz + 1;
      #end
      #declare iy = iy + 1;
   #end
   #declare ix = ix + 1;
#end

