/*
   Sponge.inc by Piotr Rashidow
    piotrrashidow@hotmail.com
*/
#version unofficial MegaPov 0.5;

#ifndef(Debug) #declare Debug=false; #end
#declare spc1="   " #declare spc2="      "
#ifndef(Render_X_Wall_Only) #declare Render_X_Wall_Only=false; #end
#ifndef(Hollow) #declare Hollow=false; #end
#ifndef(Dust) #declare Dust=true; #end
#ifndef(tc) #declare tc=0; #end //triangle counter

#declare RW=Render_X_Wall_Only;
#if(!RW) #declare ZA=3; #declare ZB=5; #declare ZC=9;
#else    #declare ZA=1; #declare ZB=1; #declare ZC=1;
#end

#declare c1 = camera {location <-3,12,-7>  look_at <4.5,3,4.5>}
#declare c2 = camera {location <1.5,3.2,3.2> angle 90 look_at <4.5,4.5,6> }
#declare c3 = camera {location <3,4.5,-0.5> look_at 4.5 }
#declare c4 = camera {location <0,9.5,9.5> look_at <4.5,6.1,4.5> }
#declare X_Wall_Cam = camera {orthographic location <4.5,4.5,-10> right <9,0,0> up <0,9,0> look_at 4.5}

#declare light_group1 = union {
   light_source { <-9,4.5,-4.5>*9 rgb 1 }
   light_source { <-9.5,4.55,-4.55>*9.1 rgb <.25,.28,.42> shadowless }
}

#declare test_light = union {
   light_source { <4.5,4.5,18> rgb <1,0,0> shadowless }
   light_source { <4.5,4.5,-9> rgb <1,0,0> shadowless }
   light_source { <18,4.5,4.5> rgb <0,1,0> shadowless }
   light_source { <-9,4.5,4.5> rgb <0,1,0> shadowless }  
   light_source { <4.5,18,4.5> rgb <0,0,1> shadowless }
   light_source { <4.5,-9,4.5> rgb <0,0,1> shadowless }
}   
   
#declare center_light = object { light_source { 4.5 rgb 0.7 } }

#declare l1_s =
 array[3][3]
 {
  {1,1,1},
  {1,0,1},
  {1,1,1}
 }

#declare l2_s =
 array[3][3]
 {
  {1,0,1},
  {0,0,0},
  {1,0,1}
 }

#declare l1 =
 array[9][9]
 {
  {1,1,1,1,1,1,1,1,1},
  {1,0,1,1,0,1,1,0,1},
  {1,1,1,1,1,1,1,1,1},
  {1,1,1,0,0,0,1,1,1},
  {1,0,1,0,0,0,1,0,1},
  {1,1,1,0,0,0,1,1,1},
  {1,1,1,1,1,1,1,1,1},
  {1,0,1,1,0,1,1,0,1},
  {1,1,1,1,1,1,1,1,1}
 }

#declare l2 =
 array[9][9]
 {
  {1,0,1,1,0,1,1,0,1},
  {0,0,0,0,0,0,0,0,0},
  {1,0,1,1,0,1,1,0,1},
  {1,0,1,0,0,0,1,0,1},
  {0,0,0,0,0,0,0,0,0},
  {1,0,1,0,0,0,1,0,1},
  {1,0,1,1,0,1,1,0,1},
  {0,0,0,0,0,0,0,0,0},
  {1,0,1,1,0,1,1,0,1}
 }

#declare l4 =
 array[9][9]
 {
  {1,1,1,0,0,0,1,1,1},
  {1,0,1,0,0,0,1,0,1},
  {1,1,1,0,0,0,1,1,1},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {1,1,1,0,0,0,1,1,1},
  {1,0,1,0,0,0,1,0,1},
  {1,1,1,0,0,0,1,1,1}
 }
 
#declare l5 =
 array[9][9]
 {
  {1,0,1,0,0,0,1,0,1},
  {0,0,0,0,0,0,0,0,0},
  {1,0,1,0,0,0,1,0,1},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {1,0,1,0,0,0,1,0,1},
  {0,0,0,0,0,0,0,0,0},
  {1,0,1,0,0,0,1,0,1}
 }
 
#declare dst =
 array[9][9]
 {
  {9,1,9,0,1,0,9,1,9},
  {1,0,1,1,0,1,1,0,1},
  {9,1,9,0,1,0,9,1,9},
  {0,1,0,0,0,0,0,1,0},
  {1,0,1,0,0,0,1,0,1},
  {0,1,0,0,0,0,0,1,0},
  {9,1,9,0,1,0,9,1,9},
  {1,0,1,1,0,1,1,0,1},
  {9,1,9,0,1,0,9,1,9}
 }

#declare dst2=
 array[9][9]
 {
  {1,0,1,1,0,1,1,0,1},
  {0,0,0,0,0,0,0,0,0},
  {1,0,1,1,0,1,1,0,1},
  {1,0,1,0,0,0,1,0,1},
  {0,0,0,0,0,0,0,0,0},
  {1,0,1,0,0,0,1,0,1},
  {1,0,1,1,0,1,1,0,1},
  {0,0,0,0,0,0,0,0,0},
  {1,0,1,1,0,1,1,0,1}
 }

#macro BOX(X,Y,Z,X_LEN,Y_LEN,Z_LEN,BT,LR,BF)
   
   /*        x_len
           __________
          /|        /|
         / |       / | y_len
        /__|______/  |
        |  |______|__|
        |  /      |  /
        | /       | /z_len
        |/        |/
      x,y,z_______|           */

   #local x_l=X+X_LEN; #local y_l=Y+Y_LEN; #local z_l=Z+Z_LEN;
   #if(BT)
      triangle {<X,Y,Z><X,Y,z_l><x_l,Y,z_l>}
      triangle {<X,Y,Z><x_l,Y,Z><x_l,Y,z_l>}
      triangle {<X,y_l,Z><X,y_l,z_l><x_l,y_l,z_l>}
      triangle {<X,y_l,Z><x_l,y_l,Z><x_l,y_l,z_l>}
      #declare tc=tc+4;
   #end 
   #if(LR)
      triangle {<X,Y,Z><X,y_l,z_l><X,Y,z_l>}
      triangle {<X,Y,Z><X,y_l,Z><X,y_l,z_l>}
      triangle {<x_l,Y,Z><x_l,y_l,z_l><x_l,Y,z_l>}
      triangle {<x_l,Y,Z><x_l,y_l,Z><x_l,y_l,z_l>}
      #declare tc=tc+4;
   #end
   #if(BF)
      triangle {<X,y_l,z_l><x_l,y_l,z_l><x_l,Y,z_l>}
      triangle {<X,Y,z_l><X,y_l,z_l><x_l,Y,z_l>}
      triangle {<X,Y,Z><x_l,y_l,Z><x_l,Y,Z>}
      triangle {<X,Y,Z><X,y_l,Z><x_l,y_l,Z>}
      #declare tc=tc+4;
   #end
#end

#macro ROTATE(v1,v2,v3,vrot,tr,tr_v,DN)
   ((vrotate(v1,vrot)+tr)*(1/DN))+tr_v
   ((vrotate(v2,vrot)+tr)*(1/DN))+tr_v
   ((vrotate(v3,vrot)+tr)*(1/DN))+tr_v
#end

#declare vr=array[6] {<0,0,0>,<0,0,0>,<0,0,90>,<0,90,90>,<-90,0,0>,<-90,0,0>}
#declare tr=array[6] {<0,0,0>,<0,9,0>,<0,0,0>,<9,0,9>,<0,0,0>,<0,0,9>}
#macro HOLLOW_SPONGE(vect,D)
   #local i=0; #while(i<6)
      triangle {ROTATE(<0,0,0>,<9,0,0>,<9,0,1>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<0,0,0>,<0,0,1>,<9,0,1>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<0,0,2>,<9,0,2>,<9,0,3>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<0,0,2>,<0,0,3>,<9,0,3>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<0,0,6>,<9,0,6>,<9,0,7>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<0,0,6>,<0,0,7>,<9,0,7>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<0,0,8>,<9,0,8>,<9,0,9>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<0,0,8>,<0,0,9>,<9,0,9>,vr[i],tr[i],vect,D)}
      //
      triangle {ROTATE(<0,0,0>,<0,0,9>,<1,0,9>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<0,0,0>,<1,0,0>,<1,0,9>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<2,0,0>,<2,0,9>,<3,0,9>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<2,0,0>,<3,0,0>,<3,0,9>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<6,0,0>,<6,0,9>,<7,0,9>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<6,0,0>,<7,0,0>,<7,0,9>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<8,0,0>,<8,0,9>,<9,0,9>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<8,0,0>,<9,0,0>,<9,0,9>,vr[i],tr[i],vect,D)}
      //
      triangle {ROTATE(<1,0,3>,<2,0,3>,<2,0,4>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<1,0,3>,<1,0,4>,<2,0,4>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<1,0,5>,<2,0,5>,<2,0,6>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<1,0,5>,<1,0,6>,<2,0,6>,vr[i],tr[i],vect,D)}
      //
      triangle {ROTATE(<7,0,3>,<8,0,3>,<8,0,4>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<7,0,3>,<7,0,4>,<8,0,4>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<7,0,5>,<8,0,5>,<8,0,6>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<7,0,5>,<7,0,6>,<8,0,6>,vr[i],tr[i],vect,D)}
      //
      triangle {ROTATE(<3,0,1>,<3,0,2>,<4,0,2>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<3,0,1>,<4,0,1>,<4,0,2>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<5,0,1>,<5,0,2>,<6,0,2>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<5,0,1>,<6,0,1>,<6,0,2>,vr[i],tr[i],vect,D)}
      //
      triangle {ROTATE(<3,0,7>,<3,0,8>,<4,0,8>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<3,0,7>,<4,0,7>,<4,0,8>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<5,0,7>,<5,0,8>,<6,0,8>,vr[i],tr[i],vect,D)}
      triangle {ROTATE(<5,0,7>,<6,0,7>,<6,0,8>,vr[i],tr[i],vect,D)}
      #declare tc=tc+48;
      //
   #local i=i+1; #end
#end

/*
   Usage:
   mesh {
      SPONGE2(
              translate X,
              translate Y,
              translate Z,
              Denominator  // Used for
                           // calculating the
                           // width, height and depth
                           // of each box.
              )
   }
*/

#macro SPONGE2(X,Y,Z,D)
   #if(Hollow)
      HOLLOW_SPONGE(<X,Y,Z>,D)
   #else
      #local points=array[4] {0,2/D,6/D,8/D}
      #local F1=1/D; #local F3=3/D; #local F5=5/D; #local F7=7/D; #local F9=9/D;
      
      #if(Dust)
         #local i=0; #while (i<4)
         #local j=0; #while (j<4)
            BOX(X,points[i]+Y,points[j]+Z,F9,F1,F1,1,0,1)
            BOX(points[i]+X,Y,points[j]+Z,F1,F9,F1,0,1,1)
            BOX(points[j]+X,points[i]+Y,Z,F1,F1,F9,1,1,0)
         #local j=j+1; #end
         #local i=i+1; #end
      #end
         #local i=0; #while (i<4)
            
            #local co1=array[4] {F1,F7,F1,F7}
            #local co2=array[4] {F3,F3,F5,F5}
            
            #local p_x=points[i]+X; #local p_y=points[i]+Y; #local p_z=points[i]+Z;
            
            #local j=0; #while(j<4)
               BOX(co1[j]+X,p_y,co2[j]+Z,F1,F1,F1,1,0,1)
               BOX(co1[j]+X,co2[j]+Y,p_z,F1,F1,F1,1,0,1)
               BOX(p_x,co1[j]+Y,co2[j]+Z,F1,F1,F1,0,1,1)
               BOX(co2[j]+X,co1[j]+Y,p_z,F1,F1,F1,0,1,1)
               BOX(p_x,co2[j]+Y,co1[j]+Z,F1,F1,F1,1,1,0)
               BOX(co2[j]+X,p_y,co1[j]+Z,F1,F1,F1,1,1,0)
            #local j=j+1; #end
            
         #local i=i+1; #end
   #end
#end

#if(RW) #declare LIM3=1; #else #declare LIM3=2; #end
#macro SPONGE3(Xt,Yt,Zt,DN)
   #local DN3=DN*3;
   #local X=0; #while (X<2)
   #local Y=0; #while (Y<2)
   #local Z=0; #while (Z<LIM3)
      #switch (Y)
         #case(0) #local CA=l1_s #break
         #case(1) #local CA=l2_s #break
      #end 
      #if(CA[X][Z])
         #local xt=(X/3)+Xt;
         #local x2=(X/3+2/3)+Xt;
         #local yt=(Y/3)+Yt;
         #local y2=(Y/3+2/3)+Yt;
         #local zt=(Z/3)+Zt;
         #local z2=(Z/3+2/3)+Zt;
                           SPONGE2(xt,yt,zt,DN3)
         #if(X=0)          SPONGE2(x2,yt,zt,DN3) #end
         #if(!RW) #if(Z=0) SPONGE2(xt,yt,z2,DN3) #end
            #if(X=0 & Z=0) SPONGE2(x2,yt,z2,DN3) #end
         #end
         #if(Y=0)          SPONGE2(xt,y2,zt,DN3)
         #if(X=0)          SPONGE2(x2,y2,zt,DN3) #end
         #if(!RW) #if(Z=0) SPONGE2(xt,y2,z2,DN3) #end
            #if(X=0 & Z=0) SPONGE2(x2,y2,z2,DN3) #end
         #end
         #end
      #end
   #local Z=Z+1; #end
   #local Y=Y+1; #end
   #local X=X+1; #end
#end

#macro DUST_S(xt,yt,zt)
   #local d =1/9;    #local d2=d+d;
   #local d3=1-d2-d; #local d4=1-d;
   #local x_points=array[4] {xt,xt+d2,xt+d3,xt+d4}
   #local y_points=array[4] {yt,yt+d2,yt+d3,yt+d4}
   #local z_points=array[4] {zt,zt+d2,zt+d3,zt+d4}
   #local i=0; #while(i<4)
   #local j=0; #while(j<4)
      #if(x_dust) BOX(xt,y_points[i],z_points[j],1,d,d,1,0,1) #end
      #if(y_dust) BOX(x_points[i],yt,z_points[j],d,1,d,0,1,1) #end 
      #if(z_dust) BOX(x_points[i],y_points[j],zt,d,d,1,1,1,0) #end
   #local j=j+1; #end
   #local i=i+1; #end
#end

#macro SPONGE4()
/* It only removes the most obvious redundancies.
   Building a level 4 sponge with SPONGE3() 
   results in 460800 triangles. 393600 triangles is 
   created using this method. The boxes with length 2
   is not removed.                                    */
   #if(Debug) #debug concat(spc1,"SPONGE4()\n") #end
   
   #declare Dust=false;
   
   #if(!Hollow)
      
      #local D=1/9;
      
      #local X=0; #while (X<9)//Length: 9 &
      #local Z=0; #while (Z<9)//Length: 3
         /**/
         #local XD=X*D; #local XD9=(9-XD)-D;
         #local ZD=Z*D; #local ZD9=(9-ZD)-D;
         
         #if(dst[X][Z]=9)
         
            #local XP=array[5] {0,XD,2+XD,XD9,XD9-2}
            #local ZP=array[5] {0,ZD,2+ZD,ZD9,ZD9-2}
            
            #local i=0; #while(i<5)
            #local j=0; #while(j<5)
               //Length:9
               BOX(0,ZP[j],XP[i],9,D,D,1,0,1)
               BOX(XP[i],0,ZP[j],D,9,D,0,1,1)
               BOX(XP[i],ZP[j],0,D,D,9,1,1,0)

               #if(i=1 | i=2)
                  #local coords_x=array[4] {0,6,0,6}
                  #local coords_y=array[4] {3+XP[i],3+XP[i],ZP[j],ZP[j]}
                  #local coords_z=array[4] {ZP[j],ZP[j],3+XP[i],3+XP[i]}
                  #local k=0; #while(k<4)
                     //Length:3
                     BOX(coords_x[k],coords_y[k],coords_z[k],3,D,D,1,0,1)
                     BOX(coords_y[k],coords_x[k],coords_z[k],D,3,D,0,1,1)
                     BOX(coords_y[k],coords_z[k],coords_x[k],D,D,3,1,1,0)
                  #local k=k+1; #end
               #end
               
            #local j=j+1; #end
            #local i=i+1; #end
            
         #end//if 9

      #local Z=Z+1; #end
      #local X=X+1; #end
      
   #end//hollow
   
   #local X=0; #while (X<5)
   #local Y=0; #while (Y<5)
   #local Z=0; #while (Z<ZB)
      
      #switch(Y)
         #case(0) #local CA=l1 #break
         #case(1) #local CA=l2 #break
         #case(2) #local CA=l1 #break
         #case(3) #local CA=l4 #break
         #case(4) #local CA=l5 #break
      #end
      
      #if(CA[X][Z])

          #local X8=8-X; #local Y8=8-Y; #local Z8=8-Z;

          #if(!Hollow)

            #declare x_dust=1; #declare z_dust=1;
            
            #if(Y=1 | Y=4) #local CD=dst2 #declare y_dust=0;
            #else          #local CD=dst  #declare y_dust=1;
               #if( (X=1 | X=4 | X=7) & (Z!=X) ) #declare x_dust=0; #declare z_dust=1; #end
               #if( (Z=1 | Z=4 | Z=7) & (X!=Z) ) #declare x_dust=1; #declare z_dust=0; #end
            #end
            
            #if(CD[X][Z]=1)      //Length: 1
                                 DUST_S(X,Y,Z) 
               #if(X!=4)         DUST_S(X8,Y,Z)  #end
               #if(Z!=4)         DUST_S(X,Y,Z8)  #end
               #if(X!=4 & Z!=4)  DUST_S(X8,Y,Z8) #end
               #if(Y!=4)         
                                 DUST_S(X,Y8,Z)
               #if(X!=4)         DUST_S(X8,Y8,Z) #end
               #if(Z!=4)         DUST_S(X,Y8,Z8) #end
               #if(X!=4 & Z!=4)  DUST_S(X8,Y8,Z8)#end
               #end//Y!=4
            #end

         #end//hollow
                                 //Length: 1/9 
                                 //but if Hollow is true the whole sponge is created here
                                 SPONGE2(X,Y,Z,9)
               #if(X!=4)         SPONGE2(X8,Y,Z,9)   #end
               #if(Z!=4)         SPONGE2(X,Y,Z8,9)   #end
               #if(X!=4 & Z!=4)  SPONGE2(X8,Y,Z8,9)  #end
               #if(Y!=4)         
                                 SPONGE2(X,Y8,Z,9)
               #if(X!=4)         SPONGE2(X8,Y8,Z,9)  #end
               #if(Z!=4)         SPONGE2(X,Y8,Z8,9)  #end
               #if(X!=4 & Z!=4)  SPONGE2(X8,Y8,Z8,9) #end
               #end//Y!=4
               
      #end                
      
   #local Z=Z+1; #end
   #local Y=Y+1; #end
   #if(Debug) #debug concat(spc2,str(X+1,1,0),"/5\n") #end
   #local X=X+1; #end
   
   #if(Debug) #debug concat(spc1,"Done\n") #end
   
#end

#macro Build_Mesh(Type) #switch(Type)
   #case(1) SPONGE2(0,0,0,9) #break
   #case(2) SPONGE3(0,0,0,9) #break
   #case(3) SPONGE4()        #break
#end #end

#macro Build_Sponge(base_obj,Lvl)

/* This inc-file really only needed to contain
   this macro but since the number of objects
   grow so fast I wrote the mesh generators above.
       
   Usage: 
      object { Build_Sponge( box{0,1}, recursion_level )
         pigment { rgb 1 }
         }
         
   If your base object only contain one object the 
   number of objects returned is 20 ^ recursion_level. 
   
                                     Piotr Rashidow 2001  */

   #if(Debug) #debug concat(spc1,"Build_Sponge(",str(Lvl,1,0),")\n") #end
   #if(Lvl>4) 
      #local err_str=concat("Recursion level ",str(Lvl,1,0)," would result in ",str(pow(20,Lvl),1,0)," objects.\n" )
      #debug err_str #error "Remove this error to continue."
   #end
   //#if(Lvl>0)
      #declare MengerSponge = union {
         #local X=0; #while(X<3)
         #local Y=0; #while(Y<2)
         #local Z=0; #while(Z<ZA)
         #switch(Y)
            #case(0) #local CA=l1_s #break
            #case(1) #local CA=l2_s #break
         #end
         #if(CA[X][Z])
                     object {base_obj translate <X,Y,Z>}
            #if(Y=0) object {base_obj translate <X,2,Z>} #end
         #end
         #local Z=Z+1; #end
         #local Y=Y+1; #end
         #local X=X+1; #end
      scale 1/3
      }
   //#end
   #undef base_obj
   #if(Lvl>1) Build_Sponge(object { MengerSponge },Lvl-1)
   #else      object { MengerSponge }
   #end
   #if(Debug) #if(Lvl=1) #debug concat("\n",spc1,"Done\n") #end #end
#end

#macro Build_Sponge2(base_object)

   #if(Debug) #debug concat(spc1,"Build_Sponge2()\n") #end
   #local Y=0; #while (Y<5)
   #local X=0; #while (X<5)
   #local Z=0; #while (Z<ZB)
      #switch(Y)
         #case(0) #local CA=l1 #break #case(1) #local CA=l2 #break
         #case(2) #local CA=l1 #break #case(3) #local CA=l4 #break
         #case(4) #local CA=l5 #break
      #end                   
      
      #if(CA[X][Z])          #local X8=8-X; #local Y8=8-Y; #local Z8=8-Z;
                             object {base_object translate < X, Y, Z>}
            #if(X!=4)        object {base_object translate <X8, Y, Z>} #end
            #if(!RW)
            #if(Z!=4)        object {base_object translate < X, Y,Z8>} #end
            #if(X!=4 & Z!=4) object {base_object translate <X8, Y,Z8>} #end
            #end             
         #if(Y!=4)           object {base_object translate < X,Y8, Z>}
            #if(X!=4)        object {base_object translate <X8,Y8, Z>} #end
            #if(!RW)
            #if(Z!=4)        object {base_object translate < X,Y8,Z8>} #end
            #if(X!=4 & Z!=4) object {base_object translate <X8,Y8,Z8>} #end
            #end
         #end
         
      #end
      
   #local Z=Z+1; #end
   #local X=X+1; #end
   #local Y=Y+1; #end
   #if(Debug) #debug concat(spc1,"Done\n") #end
#end

#macro Build_Sponge2_Color(base_object)
   //Same as above but colors the sponge
   #if(Debug) #debug concat(spc1,"Build_Sponge2_Color()\n") #end
   #local X=0; #while (X<9)
   #local Y=0; #while (Y<5)
   #local Z=0; #while (Z<ZC)
      #switch (Y)
         #case(0) #local CA=l1 #break #case(1) #local CA=l2 #break
         #case(2) #local CA=l1 #break #case(3) #local CA=l4 #break
         #case(4) #local CA=l5 #break
      #end  
      #if(CA[X][Z])
            object {base_object translate <X,Y,Z> pigment {rgb <X,Y,Z>/8} }
         #if(Y!=4)
            object {base_object translate <X,8-Y,Z> pigment {rgb <X,8-Y,Z>/8} } 
         #end
      #end
   #local Z=Z+1; #end
   #local Y=Y+1; #end
   #local X=X+1; #end
   #if(Debug) #debug concat(spc1,"Done\n") #end
#end

