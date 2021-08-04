#version 3.6;

// Superfície de Scherk
// Jorge J. Delgado (2006)
// IM-UFF

background{color rgb 1}
global_settings {ambient_light rgb 1}

#declare text1=texture{
  pigment{bozo
    color_map{
      [0 rgbft<1,.8,.4,0,0>]
      [.4 rgbft<.8,.7,.4,0,0>]
      [.6 rgbft<.7,.8,.4,0,0>]
      [1 rgbft<.8,1,.4,0,0>]
    }
    scale .5
  }
    finish{
      metallic
      phong .5
      ambient .8
    }
}

#declare text1bis=texture{
  pigment{bozo
    color_map{
      [0 rgbft<1,.8,.4,.1,.1>]
      [.4 rgbft<.8,.7,.4,.1,.1>]
      [.6 rgbft<.7,.8,.4,.1,.1>]
      [1 rgbft<.8,1,.4,.1,.1>]
    }
    scale .3
  }
    finish{
      metallic
      phong .6
      ambient .7
    }
}



#declare mpi=pi/2;
#declare pi2=1.570796;
#declare duv=pi2/70;

#macro F(U,V) 
  < V , log(cos(a*U)/cos(a*V))/a , -U > 
#end

#macro curvas(a)
union{
  #declare U=-pi2;
  #while (U<pi2)
    cylinder{F(U,0),F(U+duv,0),.03 no_shadow
      clipped_by{box{<-pi2,-5,-pi2>,<pi2,5,pi2>}}}
    cylinder{F(0,U),F(0,U+duv),.03 no_shadow
      clipped_by{box{<-pi2,-5,-pi2>,<pi2,5,pi2>}}}    
    #declare U=U+duv;
  #end  
}
#end


#macro Sup(a)
union{
  #declare U=-pi2;
  #while (U<pi2)
    #declare V=-pi2;
    #while (V<pi2)
      triangle{F(U,V),F(U+duv,V),F(U,V+duv)
	no_shadow
	clipped_by{box{<-pi2,-5,-pi2>,<pi2,5,pi2>}}
      }
      triangle{F(U,V+duv),F(U+duv,V+duv),F(U+duv,V)
	no_shadow
	clipped_by{box{<-pi2,-5,-pi2>,<pi2,5,pi2>}}
      }
      #declare V=V+duv;
    #end
    #declare U=U+duv;
  #end
}
#end


#declare p1=<-mpi,-5,-mpi>;
#declare p2=<mpi,-5,-mpi>;
#declare p3=<mpi,5,-mpi>;
#declare p4=<-mpi,5,-mpi>;
#declare p5=<-mpi,5,mpi>;
#declare p6=<mpi,5,mpi>;
#declare p7=<mpi,-5,mpi>;
#declare p8=<-mpi,-5,mpi>;

#declare r=0.03;

#declare lados=union{
  cylinder{p1,p2,r no_shadow}
  cylinder{p2,p3,r no_shadow}
  cylinder{p4,p1,r no_shadow}
  cylinder{p6,p7,r no_shadow}
  cylinder{p7,p8,r no_shadow}
  cylinder{p8,p5,r no_shadow}
  cylinder{p4,p5,r no_shadow}
  cylinder{p3,p6,r no_shadow}
}

#declare r1=.025;
union{
  cylinder{<-mpi,0,-mpi>,<mpi,0,-mpi>,r1}
  cylinder{<mpi,0,-mpi>,<mpi,0,mpi>,r1}
  cylinder{<mpi,0,mpi>,<-mpi,0,mpi>,r1}
  cylinder{<-mpi,0,mpi>,<-mpi,0,-mpi>,r1}
  pigment{rgb<.2,.5,.9>}
  finish{ambient .7 phong .5}
  no_shadow
}

union{
  object{Sup(1) texture{text1bis}}
  object{curvas(1) pigment{rgb<.9,.5,.2>} finish{ambient .7 phong .6} no_shadow}
  object{lados texture{text1} }
  object{Eixos(-3,3,-3,3,-5,5,.03)
    pigment{rgb .5}
    finish{ambient .7}
    no_shadow
  }
}



light_source{<10,20,-20>, rgb 1}

camera{
  orthographic
  location <6,3,-8.7>
  look_at 0
}

