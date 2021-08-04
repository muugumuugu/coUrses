#declare RADIUS = sqrt(2);
#declare ptexture = texture {
   pigment { color rgb <1.0,0.5,0.5> }
}
union {
polygon {
   3,
   <0,1,-1>,
   <-1,1,0>,
   <-1,0,-1>
   texture { ptexture }
}
polygon {
   4,
   <-1,0,-1>,
   <0,-1,-1>,
   <1,0,-1>,
   <0,1,-1>
   texture { ptexture }
}
polygon {
   3,
   <0,-1,-1>,
   <1,-1,0>,
   <1,0,-1>
   texture { ptexture }
}
polygon {
   3,
   <-1,-1,0>,
   <0,-1,-1>,
   <-1,0,-1>
   texture { ptexture }
}
polygon {
   3,
   <-1,-1,0>,
   <-1,0,1>,
   <0,-1,1>
   texture { ptexture }
}
polygon {
   4,
   <0,-1,-1>,
   <-1,-1,0>,
   <0,-1,1>,
   <1,-1,0>
   texture { ptexture }
}
polygon {
   4,
   <-1,-1,0>,
   <-1,0,-1>,
   <-1,1,0>,
   <-1,0,1>
   texture { ptexture }
}
polygon {
   3,
   <1,1,0>,
   <0,1,-1>,
   <1,0,-1>
   texture { ptexture }
}
polygon {
   3,
   <0,1,1>,
   <-1,0,1>,
   <-1,1,0>
   texture { ptexture }
}
polygon {
   4,
   <-1,1,0>,
   <0,1,-1>,
   <1,1,0>,
   <0,1,1>
   texture { ptexture }
}
polygon {
   3,
   <1,0,1>,
   <1,-1,0>,
   <0,-1,1>
   texture { ptexture }
}
polygon {
   3,
   <1,0,1>,
   <0,1,1>,
   <1,1,0>
   texture { ptexture }
}
polygon {
   4,
   <1,-1,0>,
   <1,0,1>,
   <1,1,0>,
   <1,0,-1>
   texture { ptexture }
}
polygon {
   4,
   <1,0,1>,
   <0,-1,1>,
   <-1,0,1>,
   <0,1,1>
   texture { ptexture }
}
}
