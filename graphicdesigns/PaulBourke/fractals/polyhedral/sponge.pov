// Megapov version by Angelo "KeN" Pesce 2001
#version unofficial MegaPov 0.5;

// Global settings
global_settings
{ assumed_gamma 2
  radiosity
  { pretrace_start 0.01
    pretrace_end   0.01
    count 128
    nearest_count 8
    error_bound 1
    recursion_limit 4
    low_error_factor .5
    gray_threshold 0.0
    minimum_reuse 0.015
    brightness 1
    adc_bailout 0.01/2
  }
  reflection_samples 16
}

// Setup background
default { pigment { rgb 1 } }
background { rgb 1 }
   
// Some optional parameters 
#declare Hollow=false;    
/* If true all level 2 sponges will be hollow. */
#declare Debug=true;
/* Debug short messages when macroes are invoked */
#declare Render_X_Wall_Only=0;
/* Creates a wall (or carpet) instead of a sponge. */
#declare s1=" " #declare s2="  " 
#include "sponge.inc"

/*
// Standard setup  
camera { c1 }
object { light_group1 }
object { center_light }
*/
    
// Weird setup
camera
{ location <4.5,4.5,4.5>
  look_at <1,0,0>
  spherical_camera
  normal { bumps 0.5 } // weird
}
light_source
{ <4.5,3,4.5> color red 0.9 green 0.5 blue 0.3 }
light_source
{ <4, 5, -4> color red 0.2 green 0.6 blue 0.8
  circular
  orient
  area_light <0.8,0,0>,<0,0.8,0>,3,3
  adaptive 1
  jitter
}
light_source
{ <3.5, 8.5, 4> color red 0.1 green 0.5 blue 0.6
  circular
  orient
  area_light <0.8,0,0>,<0,0.8,0>,3,3
  adaptive 1
  jitter
}   
      
// Sponge material
#declare Sponge_Txtr = 
texture
{ pigment { color rgb <0.4,0.4,0.4> }
  finish
  { ambient 0
    diffuse 0.7
    brilliance 2
    phong 0.3
    phong_size 200
    crand 0.03
    metallic
    reflect_metallic
    reflection 0.4
    reflection_blur 0.1
  }
}


// Sponge complexity
                                //Number of objects
#declare Render_Level_1 = no;   //20
#declare Render_Level_2 = no;   //1
#declare Render_Level_3 = no;   //1
#declare Render_Level_4 = no;   //20
#declare Render_Level_5 = no;   //400
#declare Render_Level_6 = no;   //8000
#declare Render_Level_7 = no;   //8000
#declare Render_Level_8 = yes;  //160000 (393600 triangles)







//--------------------------------------------//
//                -Level 1-                   //  
//--------------------------------------------//
  
#if(Render_Level_1)
  
  #declare Level0 = 
      mesh { 
         BOX(0,0,0,1,1,1,true,true,true)
      }
  
  #declare Recursion_Level=1;
  
  object {
      Build_Sponge(Level0, Recursion_Level)
      scale 9
      texture { Sponge_Txtr }
  }
  
#end
           
//--------------------------------------------//
//                 -Level 2-                  //
//--------------------------------------------//
   
#if(Render_Level_2)
   
   mesh { 
      Build_Mesh(1)
      texture { Sponge_Txtr }
      scale 9
   }
   
#end

//--------------------------------------------//
//                 -Level3-                   //  
//--------------------------------------------//
   
#if(Render_Level_3)
   
   mesh {
      Build_Mesh(2)
      texture { Sponge_Txtr }
      scale 9
   }
   
#end
   
//--------------------------------------------//
//                 -Level4-                   //  
//--------------------------------------------//

#if(Render_Level_4)
   
   object {
      Build_Sponge(mesh { Build_Mesh(2) },1)
      texture { Sponge_Txtr }
      scale 9
   }
         
#end
   
//--------------------------------------------//
//                 -Level5-                   //  
//--------------------------------------------//
   
#if(Render_Level_5)
   
   object {
      Build_Sponge(mesh {Build_Mesh(2)},2)
      texture { Sponge_Txtr }
      scale 9
   }
   
#end

//--------------------------------------------//
//                 -Level6-                   //  
//--------------------------------------------//

#if(Render_Level_6)
  
   #declare Level3 = mesh { Build_Mesh(2) }
   
   #declare Level5 = union { 
      Build_Sponge2(Level3)
      scale 1/9
   }
   
   #undef Level3
   object {
      Build_Sponge(Level5,1)
      texture { Sponge_Txtr }
      scale 9
   }
   
#end
   
//--------------------------------------------//
//                 -Level7-                   //  
//--------------------------------------------//
// On a AMD-K6 350 MHz with 96 MB RAM
// this level renders in ~ 5 minutes
// ( QUICKRES.INI [640x480, No AA] )


#if(Render_Level_7)
   
   #declare Level4 = mesh { Build_Mesh(3) scale 1/9 }
   
   object {
      Build_Sponge(Level4,3)
      texture { Sponge_Txtr }
      scale 9
   }
   
#end

//--------------------------------------------//
//                 -Level8-                   //  
//--------------------------------------------//

#if(Render_Level_8)
   
   //#declare Hollow=true;
   #declare Level4 = mesh { Build_Mesh(3) scale 1/9 }
   
   #declare Level6 =
      union { Build_Sponge2(Level4) scale 1/9 }
   
   #undef Level4
   union {
      //Build_Sponge2(Level6)
      Build_Sponge2_Color(Level6)
      texture { Sponge_Txtr }
   }
  
#end

#if(Debug)
   #debug concat(spc1,"\nSPONGE.INC returned ",str(tc,1,0)," triangles")
#end
