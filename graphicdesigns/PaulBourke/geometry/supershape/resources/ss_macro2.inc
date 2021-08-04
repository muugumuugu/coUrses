// by Mike Williams

#include "param.inc"

#macro SuperShape(SS1m,SS1a,SS1b,SS1n1,SS1n2,SS1n3,SS2m,SS2a,SS2b,SS2n1,SS2n2,SS2n3,resol) 
  #declare SS1 = function(T) { 1/
      pow( pow(abs(cos(SS1m*T/4))/SS1a,SS1n2) 
    + pow(abs(sin(SS1m*T/4))/SS1b,SS1n3), 1/SS1n1)
  }
  #declare SS2 = function(T) { 1/
      pow( pow(abs(cos(SS2m*T/4))/SS2a,SS2n2) 
     + pow(abs(sin(SS2m*T/4))/SS2b,SS2n3), 1/SS2n1)
  }

  #declare Fx=function(u,v) { SS1(u) *cos(u) *SS2(v) *cos(v) }
  #declare Fy=function(u,v) { SS1(u) *sin(u) *SS2(v) *cos(v) }
  #declare Fz=function(u,v) { SS2(v) *sin(v) }

  Parametric(Fx,Fy,Fz,<-pi/2,-pi>,<pi/2,pi>,resol,resol,"")

#end

