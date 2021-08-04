#declare RADIUS = sqrt(10);
#declare ptexture = texture {
   pigment { color rgb <1.0,0.5,0.5> }
}
union {
polygon {
   3,
   <-2,-2,2>,
   <-1,0,3>,
   <0,-1,3>
   texture { ptexture }
}
polygon {
   4,
   <0,-3,1>,
   <-2,-2,2>,
   <0,-1,3>,
   <2,-2,2>
   texture { ptexture }
}
polygon {
   3,
   <-2,2,-2>,
   <-3,1,0>,
   <-3,0,-1>
   texture { ptexture }
}
polygon {
   3,
   <0,-3,1>,
   <-1,-3,0>,
   <-2,-2,2>
   texture { ptexture }
}
polygon {
   3,
   <-3,0,1>,
   <-3,1,0>,
   <-2,2,2>
   texture { ptexture }
}
polygon {
   3,
   <-3,-1,0>,
   <-3,0,1>,
   <-2,-2,2>
   texture { ptexture }
}
polygon {
   4,
   <-2,-2,2>,
   <-3,0,1>,
   <-2,2,2>,
   <-1,0,3>
   texture { ptexture }
}
polygon {
   4,
   <-3,1,0>,
   <-3,0,1>,
   <-3,-1,0>,
   <-3,0,-1>
   texture { ptexture }
}
polygon {
   3,
   <1,-3,0>,
   <0,-3,1>,
   <2,-2,2>
   texture { ptexture }
}
polygon {
   4,
   <0,-3,1>,
   <1,-3,0>,
   <0,-3,-1>,
   <-1,-3,0>
   texture { ptexture }
}
polygon {
   3,
   <-1,3,0>,
   <-2,2,-2>,
   <0,3,-1>
   texture { ptexture }
}
polygon {
   4,
   <-1,3,0>,
   <-2,2,2>,
   <-3,1,0>,
   <-2,2,-2>
   texture { ptexture }
}
polygon {
   3,
   <2,-2,-2>,
   <3,-1,0>,
   <3,0,-1>
   texture { ptexture }
}
polygon {
   3,
   <1,-3,0>,
   <2,-2,-2>,
   <0,-3,-1>
   texture { ptexture }
}
polygon {
   3,
   <2,-2,-2>,
   <1,0,-3>,
   <0,-1,-3>
   texture { ptexture }
}
polygon {
   4,
   <3,-1,0>,
   <2,-2,-2>,
   <1,-3,0>,
   <2,-2,2>
   texture { ptexture }
}
polygon {
   4,
   <2,-2,-2>,
   <3,0,-1>,
   <2,2,-2>,
   <1,0,-3>
   texture { ptexture }
}
polygon {
   3,
   <1,0,3>,
   <2,-2,2>,
   <0,-1,3>
   texture { ptexture }
}
polygon {
   3,
   <3,0,1>,
   <3,-1,0>,
   <2,-2,2>
   texture { ptexture }
}
polygon {
   4,
   <3,0,1>,
   <2,-2,2>,
   <1,0,3>,
   <2,2,2>
   texture { ptexture }
}
polygon {
   3,
   <2,2,-2>,
   <1,3,0>,
   <0,3,-1>
   texture { ptexture }
}
polygon {
   3,
   <-3,-1,0>,
   <-2,-2,-2>,
   <-3,0,-1>
   texture { ptexture }
}
polygon {
   3,
   <-2,-2,-2>,
   <-1,-3,0>,
   <0,-3,-1>
   texture { ptexture }
}
polygon {
   3,
   <-1,0,-3>,
   <-2,-2,-2>,
   <0,-1,-3>
   texture { ptexture }
}
polygon {
   4,
   <-2,-2,-2>,
   <0,-3,-1>,
   <2,-2,-2>,
   <0,-1,-3>
   texture { ptexture }
}
polygon {
   4,
   <-2,-2,-2>,
   <-3,-1,0>,
   <-2,-2,2>,
   <-1,-3,0>
   texture { ptexture }
}
polygon {
   4,
   <-3,0,-1>,
   <-2,-2,-2>,
   <-1,0,-3>,
   <-2,2,-2>
   texture { ptexture }
}
polygon {
   3,
   <0,1,-3>,
   <1,0,-3>,
   <2,2,-2>
   texture { ptexture }
}
polygon {
   3,
   <-1,0,-3>,
   <0,1,-3>,
   <-2,2,-2>
   texture { ptexture }
}
polygon {
   4,
   <0,1,-3>,
   <2,2,-2>,
   <0,3,-1>,
   <-2,2,-2>
   texture { ptexture }
}
polygon {
   4,
   <1,0,-3>,
   <0,1,-3>,
   <-1,0,-3>,
   <0,-1,-3>
   texture { ptexture }
}
polygon {
   3,
   <0,1,3>,
   <-1,0,3>,
   <-2,2,2>
   texture { ptexture }
}
polygon {
   3,
   <1,0,3>,
   <0,1,3>,
   <2,2,2>
   texture { ptexture }
}
polygon {
   4,
   <-1,0,3>,
   <0,1,3>,
   <1,0,3>,
   <0,-1,3>
   texture { ptexture }
}
polygon {
   3,
   <3,1,0>,
   <2,2,-2>,
   <3,0,-1>
   texture { ptexture }
}
polygon {
   3,
   <3,1,0>,
   <3,0,1>,
   <2,2,2>
   texture { ptexture }
}
polygon {
   4,
   <2,2,-2>,
   <3,1,0>,
   <2,2,2>,
   <1,3,0>
   texture { ptexture }
}
polygon {
   4,
   <3,1,0>,
   <3,0,-1>,
   <3,-1,0>,
   <3,0,1>
   texture { ptexture }
}
polygon {
   3,
   <-1,3,0>,
   <0,3,1>,
   <-2,2,2>
   texture { ptexture }
}
polygon {
   3,
   <0,3,1>,
   <1,3,0>,
   <2,2,2>
   texture { ptexture }
}
polygon {
   4,
   <-2,2,2>,
   <0,3,1>,
   <2,2,2>,
   <0,1,3>
   texture { ptexture }
}
polygon {
   4,
   <0,3,1>,
   <-1,3,0>,
   <0,3,-1>,
   <1,3,0>
   texture { ptexture }
}
}
