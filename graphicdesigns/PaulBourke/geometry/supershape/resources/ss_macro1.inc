#version 3.5;
#include "param.inc"

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7
// by Tor Olav Kristensen

#macro SuperFunction(M, A, B, N1, N2, N3)

  #local Nil = 1E-12;
  #local MM = M/4;
  #local NN = -1/N1;

  function(T) {
    pow(
      Nil +
      pow(abs(cos(T*MM)/A), N2) +
      pow(abs(sin(T*MM)/B), N3),
      NN
    )
  }

#end // macro SuperFunction

#macro SuperShapeMesh(
         M1, A1, B1, N11, N12, N13,
         M2, A2, B2, N21, N22, N23,
         ResTh, ResPh)

  #local SuperFn1 = SuperFunction(M1, A1, B1, N11, N12, N13)
  #local SuperFn2 = SuperFunction(M2, A2, B2, N21, N22, N23)

  Parametric(
    function(Th, Ph) { cos(Th)*SuperFn1(Th)*cos(Ph)*SuperFn2(Ph) },
    function(Th, Ph) { sin(Ph)*SuperFn2(Ph) },
    function(Th, Ph) { sin(Th)*SuperFn1(Th)*cos(Ph)*SuperFn2(Ph) },
    <-pi, -pi/2>, <pi, pi/2>,
    ResTh, ResPh, ""
  )

#end // macro SuperShapeMesh
// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7

