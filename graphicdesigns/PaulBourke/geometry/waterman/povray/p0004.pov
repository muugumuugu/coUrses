#declare RADIUS = sqrt(8);
#declare ptexture = texture {
   pigment { color rgb <1.0,0.5,0.5> }
}
union {
polygon {
   3,
   <0,2,-2>,
   <-2,2,0>,
   <-2,0,-2>
   texture { ptexture }
}
polygon {
   4,
   <-2,0,-2>,
   <0,-2,-2>,
   <2,0,-2>,
   <0,2,-2>
   texture { ptexture }
}
polygon {
   3,
   <2,2,0>,
   <0,2,-2>,
   <2,0,-2>
   texture { ptexture }
}
polygon {
   3,
   <0,-2,-2>,
   <2,-2,0>,
   <2,0,-2>
   texture { ptexture }
}
polygon {
   3,
   <-2,-2,0>,
   <0,-2,-2>,
   <-2,0,-2>
   texture { ptexture }
}
polygon {
   4,
   <-2,0,-2>,
   <-2,2,0>,
   <-2,0,2>,
   <-2,-2,0>
   texture { ptexture }
}
polygon {
   4,
   <-2,-2,0>,
   <0,-2,2>,
   <2,-2,0>,
   <0,-2,-2>
   texture { ptexture }
}
polygon {
   3,
   <0,-2,2>,
   <-2,-2,0>,
   <-2,0,2>
   texture { ptexture }
}
polygon {
   3,
   <0,2,2>,
   <-2,0,2>,
   <-2,2,0>
   texture { ptexture }
}
polygon {
   4,
   <0,2,2>,
   <-2,2,0>,
   <0,2,-2>,
   <2,2,0>
   texture { ptexture }
}
polygon {
   4,
   <0,2,2>,
   <2,0,2>,
   <0,-2,2>,
   <-2,0,2>
   texture { ptexture }
}
polygon {
   3,
   <2,0,2>,
   <2,-2,0>,
   <0,-2,2>
   texture { ptexture }
}
polygon {
   4,
   <2,2,0>,
   <2,0,-2>,
   <2,-2,0>,
   <2,0,2>
   texture { ptexture }
}
polygon {
   3,
   <2,0,2>,
   <0,2,2>,
   <2,2,0>
   texture { ptexture }
}
}
