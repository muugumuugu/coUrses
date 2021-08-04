//////////////////////////////////////////////////////////////////////////
// F L O W E R S
//
// 2004
//
// By Stefano Tessarin
// s.tessarin--at--tin.it
// 
// Submitted to: May 2004 Supershape Contest
// http://astronomy.swin.edu.au/~pbourke/povray/
//
//////////////////////////////////////////////////////////////////////////
#version 3.5;


#declare Radiosity=on;
//#declare Radiosity=off;

#declare VERBOSE = true;
//#declare VERBOSE = false;

global_settings {
  assumed_gamma 1.0
  max_trace_level 25
  #if (Radiosity)
    radiosity {
      pretrace_start 0.08         
      pretrace_end   0.04
      count 50
      nearest_count 6
      error_bound 1.5
      recursion_limit 5
      low_error_factor .5
      gray_threshold 0.0
      minimum_reuse 0.015
      brightness 1
      adc_bailout 0.01/2
    }
  #end
}

#default {
  texture {
    pigment {rgb 1}
    #if (Radiosity)
      finish {
        ambient 0.0
        diffuse 0.6
        specular 0.3
      }
    #else
      finish {
        ambient 0.1
        diffuse 0.6
        specular 0.3
      }
    #end
  }
}



//-----------------------------------------
// T E X T U R E S 
//-----------------------------------------
#declare T_petal = texture {
                pigment {
                            gradient y                           
                            color_map {
                                       
                                       [0.15 rgb <156,123,78>/255]
                                       [0.25 rgb <255,230,217>/255]
                                       [0.5 rgb <255,134,121>/255]
                                       [1.0  rgb <250,176,0>/255]
                                       }                                   
                        }
                 finish{
                        diffuse 0.5
                        ambient 0.04
                        crand 0.001
                       }
                }


#declare T_petal2 = texture {
                pigment {
                            gradient y                           
                            color_map {
                                       
                                       [0.15 rgb <176,113,178>/255]
                                       [0.25 rgb <125,30,217>/255]
                                       [0.5 rgb <55,14,121>/255]
                                       [1.0  rgb <250,176,0>/255]
                                       }                                   
                        }
                 finish{
                        diffuse 0.5
                        ambient 0.04
                        crand 0.001
                       }
                }
                
#declare T_tile = texture {
                           pigment {
                                    //rgb 1
                                    rgb <249,233,248>/255
                                   }
                           finish {
                                   ambient .1
                                   diffuse .8
                                   brilliance 1
                                   reflection{0.025 .5 fresnel on}
                                   specular .3
                                   roughness 0.01
                                  }
                          }                


#declare T_mortar = texture {
                        pigment {
                                 rgb <32,32,32>/255
                                }
                        normal {
                                bumps .2
                                scale .001
                               }
                        }

#declare T_wall = texture {
                         pigment {
                                  rgb <166,57,36>/255
                                 }
                         normal {
                                granite .05
                                }
                         finish {
                                ambient .08
                                diffuse  .4
                                }
                          }                        



#declare C_Base = <166,218,218>/255;
#declare C_Ring = <155,134,19>/255;

#declare T_vase = texture {
                          pigment {
                                   gradient y
                                   color_map {[0.0 rgb C_Ring]
                                              [0.20 rgb C_Base]
                                              [0.20 rgb C_Ring]
                                              [0.21 rgb C_Ring]
                                              [0.21 rgb C_Base]                                              
                                              [0.40 rgb C_Base]
                                              [0.40 rgb C_Ring]
                                              [0.41 rgb C_Ring]
                                              [0.41 rgb C_Base]                                              
                                              [0.60 rgb C_Ring]
                                              [0.60 rgb C_Base]
                                              [0.61 rgb C_Ring]
                                              [0.61 rgb C_Base]                                              
                                              [1 rgb C_Base]
                                             }
                                   }
                                finish
                                {             
                                    conserve_energy
                                    diffuse 0.55
                                    ambient .05
                                    reflection{0.025 .5 fresnel on}
                                    specular .45
                                    roughness .005
                                }
                          }                          


//-----------------------------------------
// M E S H    M A C R O S
//-----------------------------------------
 
//supershape formula
#macro r(a,b,m,n1,n2,n3,theta) 
     pow(
          (
           pow(abs(cos(m*theta/4)/a),n2)
           +pow(abs(sin(m*theta/4)/b),n3)   
          )
        ,(-1/n1))   
#end        


//-------------------------------------------
//Define the coordinates of a point using the
//spherical product
#macro make_point_spherical(point,a1,b1,a2,b2,m1,n11,n12,n13,m2,n21,n22,n23,theta,phi)
                
        #declare point = <r(a1,b1,m1,n11,n12,n13,theta)*cos(theta)*r(a2,b2,m2,n21,n22,n23,phi)*cos(phi),
                          r(a1,b1,m1,n11,n12,n13,theta)*sin(theta)*r(a2,b2,m2,n21,n22,n23,phi)*cos(phi),
                          r(a2,b2,m2,n21,n22,n23,phi)*sin(phi)>
                          
#end

// ----------------------------------------
//Make SuperShape  
#macro MakeMesh(a1,b1,a2,b2,m1,n11,n12,n13,m2,n21,n22,n23,inc)
        
        #local THETA_MIN = -pi;
        #local THETA_MAX = pi;
        #local PHI_MIN = -pi/2;
        #local PHI_MAX = pi/2;
      
        #local INCREMENT = pi/inc;        
        
        #local phi = PHI_MIN;
        #local theta = THETA_MIN;
        
        #local p0 = <0,0,0>;
        #local p1 = <0,0,0>;
        #local p2 = <0,0,0>;
        #local p3 = <0,0,0>;
        
        #while (theta < THETA_MAX)
                #while (phi < PHI_MAX)                
                        make_point_spherical(p0,a1,b1,a2,b2,m1,n11,n12,n13,m2,n21,n22,n23,theta,phi);
                        make_point_spherical(p1,a1,b1,a2,b2,m1,n11,n12,n13,m2,n21,n22,n23,theta+INCREMENT,phi);
                        make_point_spherical(p2,a1,b1,a2,b2,m1,n11,n12,n13,m2,n21,n22,n23,theta+INCREMENT,phi+INCREMENT);
                        make_point_spherical(p3,a1,b1,a2,b2,m1,n11,n12,n13,m2,n21,n22,n23,theta,phi+INCREMENT); 
                        triangle {p0,p1,p3}
                        triangle {p3,p2,p1}                        

                        #declare phi = phi + INCREMENT;
                        
                #end //phi
                #declare phi = PHI_MIN;
                #declare theta = theta + INCREMENT;
                #if (VERBOSE) #debug concat("Step # ",str(theta/pi,0,5),"\r") #end
        #end //theta 
        #if (VERBOSE) #warning concat("Mesh complete","\n") #end
#end


//-----------------------------------------
// F L O W E R S    S T E M S
// Draw a sweep following a spline defined 
// by two points.
//-----------------------------------------
#macro make_stem(startP,endP,delta)
        
        
        #local INCREMENT = 0.001;
        
        #declare MySpline = spline{
                                quadratic_spline
                                
                                0, startP
                                .5, (endP+startP)*.5+delta
                                1, endP
                                }

        #local i = 0;
        #while (i<=1)
                  sphere {
                    MySpline(i),.005
                    pigment { rgb <21+i*(55-21),55,21>/255 }
                  }
                  #declare i = i + INCREMENT;
        #end
#end

//-----------------------------------------
// T I L E S    F L O O R 
// Make a tile floor using a generic object (MyTile)
// and add random normal to each tile
//-----------------------------------------
#macro make_floor(startX,endX,startZ,endZ,MyTile,MyTexture,Increment)

        
              
        #local H = max_extent(MyTile);
        #local Lx = H.x-min_extent(MyTile).x+Increment;
        #local Lz = H.z-min_extent(MyTile).z+Increment;

        
        #local R1 = seed(374);
        
        #declare MyTexture = texture {MyTexture
                                      normal {
                                                bozo 
                                                warp {turbulence .05}
                                                scale Lx/5
                                              }
                                      }
        
        #local i = startX;
        #local j = startZ;
        #while (i <= endX)
                #while (j <= endZ)
                        
                        object {
                                tile 
                                        texture {MyTexture 
                                                 translate <Lx*rand(R1),1,Lz*rand(R1)> 
                                                 rotate y*360*rand(R1)} 
                                translate <i,-H.y,j>
                                }
                        
                        #declare j = j + Lz;
                #end
                #declare j = startZ;
                #declare i = i + Lx;                
        #end
        
        plane {y,-0.012 texture {T_mortar}}   
#end



//----------------------------------------
//G e n e r i c     O b j e c t s
//----------------------------------------

camera {
  right x*image_width/image_height
  //location  <.5,3,5>
  location <.5,3,-5>
  look_at <0,.5,0>
  angle 18
}

light_source {
  <500,500,-500>       
  color rgb <1, 1, 1>*1.3
  area_light <50, 0, 0>, <0, 0, 50>, 10, 10
    adaptive 1
    jitter
}


//------------------------------------------



#declare vase = mesh {
                        #if (VERBOSE) #warning "Making vase...\n" #end
                        MakeMesh(1,1,1,1,4,-12,1,1,8.5,1,-1,-2,180) 
                      }
                      
                                       

#declare tile = mesh {
                       #if (VERBOSE) #warning "Making tile...\n" #end
                       MakeMesh(1,1,1,1,4,20,20,20,4,20,20,20,90)
                       scale .2
                     }
                                     
  
#declare petals1 = difference {
                        mesh {
                                #if (VERBOSE) #warning "Making flower 1...\n" #end
                                MakeMesh(1,2,1,1,12,-2.5,1,1,6,1,-2,-5,180)
                                rotate x*90
                             }
                        box {<-5,-5,-5>,<5,0,5>}        
            }

#declare flower1 = object {
                            petals1 
                            texture {T_petal scale .2}
                            rotate <-30,0,-20>
                            translate <0,(max_extent(vase).y*2+max_extent(petals1).y),-0.25>
                          }

    
#declare petals2 = difference {
                        mesh {
                                #if (VERBOSE) #warning "Making flower 2...\n" #end
                                MakeMesh(1,1,1,1,14,-2.5,1,1,6,1,-2,-3,180)
                                rotate x*90
                             }
                        box {<-5,-5,-5>,<5,0,5>}        
            }

#declare flower2 = object {
                        petals2 
                        texture {T_petal2 scale .2}
                        rotate <-20,18,15>
                        translate <-0.25,(max_extent(vase).y*2.6+max_extent(petals2).y),0>
        }
     


#declare petals3 = difference {
                        object {mesh {
                                #if (VERBOSE) #warning "Making flower 3...\n" #end
                                MakeMesh(1,2,1,1,13,-4,1,1,6,1,-2,-4,180)
                                rotate x*90
                             }}
                        box {<-5,-5,-5>,<5,0,5>}        
            }
                     
#declare flower3 = object {
                        petals3 
                        texture {T_petal scale .2} 
                        rotate <-25,-12,-27>
                        translate <.25,(max_extent(vase).y*2.2+max_extent(petals3).y),0>
        }        


            
//----------------------------------------------------------------------------
//      M A I N 
//----------------------------------------------------------------------------
      
object {flower1}
make_stem(0,((min_extent(flower1)+max_extent(flower1))/2),<.035,0,.1>)
        
object {flower2}
make_stem(0,(min_extent(flower2)+max_extent(flower2))/2,<.08,0,0>)        

object {flower3}
make_stem(0,(min_extent(flower3)+max_extent(flower3))/2,<-.15,0,0>)        
  
make_floor(-3,3,-3,3,tile,T_tile,-.015)
          

plane { //background wall
        z,2.2 
        texture {T_wall}
        }

object {vase 
        rotate x*90 
        translate y*(max_extent(vase).y-min_extent(vase).y)/2 
        texture {T_vase}
       } 

/*cylinder {<0,0,0>,<0,10,0>,.012 pigment {color rgb <1,0,0>}} //y axis
cylinder {<0,0,0>,<0,10,0>,.012 pigment {color rgb <0,1,0>} rotate z*-90} //x axis
cylinder {<0,0,0>,<0,10,0>,.012 pigment {color rgb <0,0,1>} rotate x*90} //z axis*/