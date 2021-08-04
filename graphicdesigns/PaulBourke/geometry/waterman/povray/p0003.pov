#declare RADIUS = sqrt(6);
#declare ptexture = texture {
   pigment { color rgb <1.0,0.5,0.5> }
}
union {
polygon {
   4,
   <-2,1,-1>,
   <-2,1,1>,
   <-2,-1,1>,
   <-2,-1,-1>
   texture { ptexture }
}
polygon {
   4,
   <-2,1,1>,
   <-1,1,2>,
   <-1,-1,2>,
   <-2,-1,1>
   texture { ptexture }
}
polygon {
   4,
   <2,1,1>,
   <2,1,-1>,
   <2,-1,-1>,
   <2,-1,1>
   texture { ptexture }
}
polygon {
   3,
   <-1,-2,-1>,
   <-1,-1,-2>,
   <-2,-1,-1>
   texture { ptexture }
}
polygon {
   4,
   <1,2,1>,
   <1,2,-1>,
   <2,1,-1>,
   <2,1,1>
   texture { ptexture }
}
polygon {
   3,
   <-1,-2,1>,
   <-2,-1,1>,
   <-1,-1,2>
   texture { ptexture }
}
polygon {
   4,
   <-1,-2,1>,
   <-1,-2,-1>,
   <-2,-1,-1>,
   <-2,-1,1>
   texture { ptexture }
}
polygon {
   3,
   <-1,2,1>,
   <-1,1,2>,
   <-2,1,1>
   texture { ptexture }
}
polygon {
   4,
   <-1,2,-1>,
   <-1,2,1>,
   <-2,1,1>,
   <-2,1,-1>
   texture { ptexture }
}
polygon {
   4,
   <-1,2,1>,
   <-1,2,-1>,
   <1,2,-1>,
   <1,2,1>
   texture { ptexture }
}
polygon {
   3,
   <1,1,2>,
   <1,2,1>,
   <2,1,1>
   texture { ptexture }
}
polygon {
   4,
   <1,1,2>,
   <-1,1,2>,
   <-1,2,1>,
   <1,2,1>
   texture { ptexture }
}
polygon {
   4,
   <1,-1,2>,
   <1,1,2>,
   <2,1,1>,
   <2,-1,1>
   texture { ptexture }
}
polygon {
   4,
   <1,1,2>,
   <1,-1,2>,
   <-1,-1,2>,
   <-1,1,2>
   texture { ptexture }
}
polygon {
   3,
   <1,1,-2>,
   <2,1,-1>,
   <1,2,-1>
   texture { ptexture }
}
polygon {
   4,
   <1,1,-2>,
   <1,-1,-2>,
   <2,-1,-1>,
   <2,1,-1>
   texture { ptexture }
}
polygon {
   3,
   <1,-2,1>,
   <1,-1,2>,
   <2,-1,1>
   texture { ptexture }
}
polygon {
   4,
   <1,-2,1>,
   <-1,-2,1>,
   <-1,-1,2>,
   <1,-1,2>
   texture { ptexture }
}
polygon {
   3,
   <-2,1,-1>,
   <-1,1,-2>,
   <-1,2,-1>
   texture { ptexture }
}
polygon {
   4,
   <-1,-1,-2>,
   <-1,1,-2>,
   <-2,1,-1>,
   <-2,-1,-1>
   texture { ptexture }
}
polygon {
   4,
   <-1,1,-2>,
   <1,1,-2>,
   <1,2,-1>,
   <-1,2,-1>
   texture { ptexture }
}
polygon {
   4,
   <-1,1,-2>,
   <-1,-1,-2>,
   <1,-1,-2>,
   <1,1,-2>
   texture { ptexture }
}
polygon {
   3,
   <1,-1,-2>,
   <1,-2,-1>,
   <2,-1,-1>
   texture { ptexture }
}
polygon {
   4,
   <-1,-2,-1>,
   <1,-2,-1>,
   <1,-1,-2>,
   <-1,-1,-2>
   texture { ptexture }
}
polygon {
   4,
   <1,-2,-1>,
   <1,-2,1>,
   <2,-1,1>,
   <2,-1,-1>
   texture { ptexture }
}
polygon {
   4,
   <1,-2,1>,
   <1,-2,-1>,
   <-1,-2,-1>,
   <-1,-2,1>
   texture { ptexture }
}
}
