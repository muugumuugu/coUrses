#declare RADIUS = sqrt(4);
#declare ptexture = texture {
   pigment { color rgb <1.0,0.5,0.5> }
}
union {
polygon {
   3,
   <0,2,0>,
   <0,0,2>,
   <-2,0,0>
   texture { ptexture }
}
polygon {
   3,
   <0,0,2>,
   <0,2,0>,
   <2,0,0>
   texture { ptexture }
}
polygon {
   3,
   <0,0,-2>,
   <0,2,0>,
   <-2,0,0>
   texture { ptexture }
}
polygon {
   3,
   <0,2,0>,
   <0,0,-2>,
   <2,0,0>
   texture { ptexture }
}
polygon {
   3,
   <0,-2,0>,
   <0,0,2>,
   <2,0,0>
   texture { ptexture }
}
polygon {
   3,
   <0,0,2>,
   <0,-2,0>,
   <-2,0,0>
   texture { ptexture }
}
polygon {
   3,
   <0,-2,0>,
   <0,0,-2>,
   <-2,0,0>
   texture { ptexture }
}
polygon {
   3,
   <0,0,-2>,
   <0,-2,0>,
   <2,0,0>
   texture { ptexture }
}
}
