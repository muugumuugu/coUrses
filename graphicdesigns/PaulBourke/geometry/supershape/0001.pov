/* --------------------------
Entry: 0001
Artist: SpB
Title: Flying wing
---------------------------*/

#include "colors.inc"
#include "textures.inc"
#include "skies.inc"
#declare        C_RADIUS        =  0.05;
#declare        C_N1            =  0.17; 
#declare        C_N2            = -0.61; 
#declare        C_N3            = -0.66; 
#declare        C_A             =  0.10; 
#declare        C_B             =  0.24; 
#declare        C_M             =  5.00; 
#declare        C_WINKELDIFF    =  0.01;
sky_sphere { S_Cloud1 }
plane { y, -10.5
    texture {
        pigment { CadetBlue }
        finish { reflection .5 specular 0.75 }
        normal { ripples .55 turbulence .75 scale 4.5 }
    }      
}
light_source {
        <0, 100, -150> 
        White 
}
light_source {
        <50, 3, 50>
        White 
}
camera {
	location 5*<1, 1, -2>
	look_at 0
	angle 50
}
                         
#macro KUGEL(mitte)
        sphere { mitte, C_RADIUS                        
                texture { Cork }
        }
#end
#declare a_hoch_x = function(a, xx) {
        exp (ln (a) * xx)
}
#declare R_von_phi = function(phi) {
         a_hoch_x(  a_hoch_x(abs( cos(phi * C_M/4) / C_A ), C_N2)
                  + a_hoch_x(abs( sin(phi * C_M/4) / C_B ), C_N3), -1/C_N1)
        
}
#declare phi    =  -pi / 2;
#while(phi <= pi/2)
        #declare theta  =  -pi;
        #while(theta <= pi)
                #local aktRadiusPhi   = R_von_phi(phi);
                #local aktRadiusTheta = R_von_phi(theta);      
                #local cosPhi         = cos(phi);
                #local xx = aktRadiusTheta*cos(theta) * aktRadiusPhi*cosPhi;
                #local yy = aktRadiusTheta*sin(theta) * aktRadiusPhi*cosPhi;
                #local zz = aktRadiusPhi  *sin(phi);
                KUGEL(<xx, yy, zz>)
                #declare theta = theta + C_WINKELDIFF;
        #end // theta
        #declare phi = phi + C_WINKELDIFF;
#end // phi
