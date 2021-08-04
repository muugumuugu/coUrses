//Description:
//  Supershapes contest entry
//  butterflies find cactus flowers in a desert
//

//Author: Ben Scheele
//Date: 5-18-2004. 5-23-2004, and 5-30-2004

#version 3.5;
#include "param.inc"
#include "ss_macro1.inc"  

global_settings{
  
  radiosity{
    pretrace_start 0.08
    pretrace_end .01
    count 100

    nearest_count 6
    error_bound 1.55
    recursion_limit 1

    low_error_factor 0.55
    gray_threshold 0.0
    minimum_reuse 0.015
    brightness .1

    adc_bailout 0.01/2
  }
  max_trace_level 6
  //ambient_light off

} 
  
camera{
  location <0,260,-345>
  up y
  right x
  look_at <28,70,0> 
  angle 50
}  


//sun
light_source {         
  0*x                 // light's position (translated below)
  rgb .9*<.9,.9,.35>      // light's color
  area_light
  90*x 90*z // lights spread out across this distance (x * z)
  3, 3                // total number of lights in grid (4x*4z = 16 lights)
  adaptive 1          // 0,1,2,3...
  jitter              // adds random softening of light
  circular            // make the shape of the light circular
  orient              // orient light
  translate <8000,5000,-500>   // <x y z> position of light
} 
  
light_source{ <0,260,-345> rgb .275*(x+y) shadowless }  //flashlight

//light_source{ <8000,5000,-500> rgb <1,1,.2> }    //non area-light sun

background{ rgb <.5,.9,1.1> }

#declare B_Glass = 

  finish{
    specular 0.7
    roughness 0.00125
    brilliance .005
    phong .3
    diffuse .8
    reflection{
      0.15, 0.65   
      falloff .7
      metallic .1   
    }
    conserve_energy
  } 


// Butterfly creation macro, 2d supershape ---------------------------------------------

#declare m  =  4.6;    // symmetry
#declare n1 =  2.9;    // xy profile
#declare n2 =  16.5;   // xy profile
#declare n3 =  5;      // xy profile
#declare a  =  0.8;    // x scale
#declare b  =  1.05;   // z scale

#declare But_fin = finish{ brilliance .3 phong .8 diffuse .95 metallic .15 reflection{ .15 .275 } }

#declare Butterfly = 

isosurface{ 
 
   function{ pow(
     pow(abs(cos(0.25*m*acos(y/sqrt(x*x+y*y))*abs(y)/y)/a),n2)  +
     pow(abs(sin(0.25*m*acos(y/sqrt(x*x+y*y))*abs(y)/y)/b),n3),1/n1) * sqrt(x*x+y*y) - 1 }
   contained_by{ box{ 1.5*<-2,-2,-2>, 1.5*<2,2,2> }}
   scale <1,1,0.003>                        
}

#declare R_wing =

intersection{
object{ Butterfly }
box{ <0.1,1.3,1.1>, <-0.1,-0.1,-1.3> rotate <83,90,0> translate .18*x pigment{ rgb <1.2,.4,0> }}  
}

#declare L_wing =

intersection{
object{ Butterfly }
box{ <0.1,1.3,1.3>, <-0.1,-0.1,-1.1> rotate <-83,90,0> translate -.18*x pigment{ rgb <1.2,.4,0> }} 
}

#declare Body = 
difference{
  object{ Butterfly }
  box{ <0.1,1.3,1.1>, <-0.1,-0.1,-1.3> rotate <83,90,0> translate .18*x pigment{ rgb <1.2,.4,0> }}    
  box{ <0.1,1.3,1.3>, <-0.1,-0.1,-1.1> rotate <-83,90,0> translate -.18*x pigment{ rgb <1.2,.4,0> }} 
}

#macro Butterfly2(rot)  //limit on wing rotation is 10 - 87 degrees 

union{
  object{ R_wing     
    pigment{ onion scale 1.3 translate <.7,.05> turbulence -.05
      color_map{ [ 0 rgb <1,.89,0> ]
                 [ .15 rgb  <.5,.4,.3> ]
                 [ .25 rgb <1.2,.4,0> ]
                 [ 1 rgb  <1,.89,0> ]
                              
      }
    }     
    finish{ But_fin }
    normal{ dents .5 scale .02 }
  
  rotate -7*z translate -.075*x rotate -rot*y translate .075*x rotate 7*z 
  }
  
  object{ L_wing 
    pigment { onion scale 1.3 translate <-.7,.05> turbulence .05
      color_map{ [ 0 rgb <1,.89,0> ]
                 [ .15 rgb  <.5,.4,.3> ]
                 [ .25 rgb <1.2,.4,0> ]
                 [ 1 rgb  <1,.89,0> ]
                              
      }
    }     
    finish{ But_fin }
    normal{ dents .5 scale .02 }
  
  rotate 7*z translate .075*x rotate rot*y translate -.075*x rotate -7*z
  }
  
  object{ Body 
    pigment{ rgb <1.1,.55,.15> } 
    finish{ brilliance .9 phong .4 diffuse .7 metallic .05 reflection{ .05 .1 }} 
    normal{ dents .5 scale .03 }
  }
} 

#end

// end of butterfly macro ----------------------------------------------

// definition of 3d supershapes ----------------------------------------

#declare cactus =

object{
  SuperShapeMesh(
    26,   //#sides, xy spline shape
    100,  //#sides, xy spline shape
    8,    //higher = spikes more irregular, larger
    55,   //key shape modifier, odd behavior, larger = more sphere-like
    5,    //#sides, xy spline shape
    5,    //#sides, xy spline shape
    50,   //xy spline + vertical portion angle
    50,   //scale to some degree
    10,   //lower = spikier    
    7.5,  // inverse overall scale
    10,   //overall scale
    100,  //lower = spikier, less sides    //10
    120,  //more divisions, more triangles xy dir.  
    120   //more layers, more triangles, y dir.     
  )
  pigment{ rgb .75*<.2,.9,.45> transmit 0.55 }
  finish{ B_Glass }   
  
    interior{
    ior 1.33  
    caustics .6
    fade_distance 8
    fade_power 6
    fade_color rgb <.2,.9,.45>*.5
  } 
  
}

#declare flower =

object{
  SuperShapeMesh(
    26*2,   //#sides, xy spline shape
    10.0, //#sides, xy spline shape
    2*8.0,//higher = spikes more irregular, larger
    15,   //key shape modifier, odd behavior, larger = more sphere-like 
    50,   //#sides, xy spline shape
    5,    //#sides, xy spline shape
    50,   //xy spline + vertical portion angle
    50,   //scale to some degree
    10,   //lower = spikier    
    7.5,  // inverse overall scale
    10,   //overall scale
    10.0, //lower = spikier, less sides    
    150,  //more divisions, more triangles xy dir.  
    150   //more layers, more triangles, y dir.      
  )
  pigment{ gradient y triangle_wave frequency .15 scale 5 phase 1.7 turbulence .2 color_map{ [0 rgbt <1.2,.8,.8,.5>][1 rgbt <1.3,.95,.4,.5>] }}
  finish{ B_Glass ambient .15 }   
  
    interior{
      ior 1.4  
      caustics .45
      fade_distance 7
      fade_power 4
    } 
  
  normal{ bumps .3 scale .25 }
} 
            


//Placement of objects ----------------------------------------


//test spheres
//sphere{ 0, 90 scale <1.33,.88,1.33> pigment{ rgbt <.2,.9,.4,.5> } finish{ B_Glass } scale <.85,1,.85>}
//sphere{ 0, 50 scale <1.33,.665,1.33> pigment{ rgbt <.85,.5,.6,.5> } finish{ B_Glass } scale <.75,.9,.75> translate 100*y }

#macro spike(xr,yr,lng)

cone{ 0, 1, -1.2*lng*z, .1 pigment{ rgb 1.9*<.8,.9,1> }

   rotate <xr,yr>
}
#end

#declare spikes = 

union{
  spike(0,0,25)
  spike(0,-30,25)
  spike(0,-60,25) 
  spike(0,30,25) 
  spike(0,60,25) 
  
  spike(40,-45,15)
  spike(40,0,15)
  spike(40,45,15)
  
  spike(-40,-45,15)
  spike(-40,0,15)
  spike(-40,45,15) 
  
  rotate -90*y
} 
             
#macro spike_row(ot,rt) 
union{
#declare T = -35-ot;
#while(T < 60)
  
  union{
    sphere{ 0, 5 pigment{ rgb 1.5 }} 
    object{ spikes scale 1.3 } 
      scale .1+.8*cos(T/60-.15)     
      translate (sqrt(10353-T*T)-5*cos(T/60-.15))*x 
      rotate 55*z*T/60
  }
#declare T = T + 20;
#end

rotate rt*360/13*y
}

#end

#declare spike_set =

union{
#declare T2 = 0;
#declare EndT2 = 6;
#while(T2 <= EndT2)
  
  spike_row(0,T2*2)
  spike_row(10,1+T2*2) 
     
#declare T2 = T2 + 1;
#end
}

#declare cactus2 = 
union{
object{ cactus scale 2 scale <.85,1.05,.85> translate -5*y } 
object{ spike_set finish{ B_Glass }}
}   

//Near cactus and flower

object{ cactus2 }   
object{ flower scale <.27,.77,.27> scale <.75,.9,.75> translate 100*y } 

//Butterflies

object{ Butterfly2(45) scale 30 rotate <-130,-110> translate <23,127,0> finish{ B_Glass }}  //on the close cactus
object{ Butterfly2(70) scale 30 rotate <-160,-110> translate <47.5,105,0> rotate 180*y }

object{ Butterfly2(25) scale 30 rotate <-120,10> translate <-65,170,80> }    //flying towards the near cactus
object{ Butterfly2(35) scale 30 rotate <-100,0> translate <95,150,190>  no_shadow } 
  
object{ Butterfly2(55) scale 30 rotate <-155,200> translate <250,-5,360>  }  //flying towards the far cactus
object{ Butterfly2(25) scale 30 rotate <-120,300> translate <525,0,800>  } 

//Sand dunes ------------------------------------------------

#macro Ring(maj,minor) 
 torus{ maj minor pigment{ rgb .8*<1,.95> }  
 
 finish {
    specular 0.7
    roughness 0.001
    brilliance .005
    phong .3
    diffuse .8
    reflection {
      0.15, 0.85   
      falloff .65
      metallic .1   
    }
    conserve_energy
  }}
  
#end 


#declare T = 0;
#declare EndT = 100;
#while(T < EndT + 1)
  
  #declare c = T/EndT; 
   
  object{ Ring(50+2000*c-80*sin(20*c),13.5*1.35)        
    translate -55*y-.1*pow(c*150,1.5)*y
  }
#declare T = T + 1;
#end   


//second dune, translated into distance along with other cactus, flower, and a butterfly

union{
  #declare T = 0;
  #declare EndT = 100;
  #while(T < EndT + 1)
  
    #declare c = T/EndT; 
    
    object{ Ring(50+2000*c-80*sin(20*c),13.5)        
      translate -75*y-.1*pow(c*150,1.5)*y
    }
  #declare T = T + 1;
  #end 

  union{

  //test spheres
  //sphere{ 0, 90 scale <1.33,.88,1.33> pigment{ rgbt <.2,.9,.4,.5> } finish{ B_Glass } scale <.85,1,.85>}
  //sphere{ 0, 50 scale <1.33,.665,1.33> pigment{ rgbt <.85,.5,.6,.5> } finish{ B_Glass } scale <.75,.9,.75> translate 100*y }

    object{ cactus2 }
    object{ flower scale <.27,.77,.27> scale <.75,.9,.75> translate 100*y }

   scale .85 
  }

  object{ Butterfly2(30) scale 30 rotate <-160,-110> translate <37.5,95,15> rotate 90*y }

 translate <450,-50,950>

}

//----------------------------------------------------------