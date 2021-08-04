#declare RADIUS = sqrt(16);
#declare ptexture = texture {
   pigment { color rgb <1.0,0.5,0.5> }
}
union {
polygon {
   3,
   <-3,2,1>,
   <-3,1,2>,
   <-4,0,0>
   texture { ptexture }
}
polygon {
   3,
   <3,1,2>,
   <3,2,1>,
   <4,0,0>
   texture { ptexture }
}
polygon {
   3,
   <-2,1,-3>,
   <-2,-1,-3>,
   <0,0,-4>
   texture { ptexture }
}
polygon {
   3,
   <-2,3,1>,
   <-2,3,-1>,
   <0,4,0>
   texture { ptexture }
}
polygon {
   3,
   <-1,3,2>,
   <-2,3,1>,
   <0,4,0>
   texture { ptexture }
}
polygon {
   3,
   <2,-1,-3>,
   <2,1,-3>,
   <0,0,-4>
   texture { ptexture }
}
polygon {
   3,
   <-1,2,-3>,
   <-2,1,-3>,
   <0,0,-4>
   texture { ptexture }
}
polygon {
   3,
   <-2,-3,-1>,
   <-2,-3,1>,
   <0,-4,0>
   texture { ptexture }
}
polygon {
   3,
   <-2,-1,3>,
   <-2,1,3>,
   <0,0,4>
   texture { ptexture }
}
polygon {
   3,
   <-2,1,3>,
   <-1,2,3>,
   <0,0,4>
   texture { ptexture }
}
polygon {
   6,
   <-2,1,3>,
   <-3,1,2>,
   <-3,2,1>,
   <-2,3,1>,
   <-1,3,2>,
   <-1,2,3>
   texture { ptexture }
}
polygon {
   3,
   <-1,2,3>,
   <1,2,3>,
   <0,0,4>
   texture { ptexture }
}
polygon {
   3,
   <-3,2,-1>,
   <-3,2,1>,
   <-4,0,0>
   texture { ptexture }
}
polygon {
   3,
   <-3,1,-2>,
   <-3,2,-1>,
   <-4,0,0>
   texture { ptexture }
}
polygon {
   4,
   <-3,2,-1>,
   <-2,3,-1>,
   <-2,3,1>,
   <-3,2,1>
   texture { ptexture }
}
polygon {
   3,
   <-2,-3,1>,
   <-1,-3,2>,
   <0,-4,0>
   texture { ptexture }
}
polygon {
   3,
   <3,2,1>,
   <3,2,-1>,
   <4,0,0>
   texture { ptexture }
}
polygon {
   3,
   <3,2,-1>,
   <3,1,-2>,
   <4,0,0>
   texture { ptexture }
}
polygon {
   3,
   <-2,3,-1>,
   <-1,3,-2>,
   <0,4,0>
   texture { ptexture }
}
polygon {
   6,
   <-2,1,-3>,
   <-1,2,-3>,
   <-1,3,-2>,
   <-2,3,-1>,
   <-3,2,-1>,
   <-3,1,-2>
   texture { ptexture }
}
polygon {
   3,
   <-3,1,2>,
   <-3,-1,2>,
   <-4,0,0>
   texture { ptexture }
}
polygon {
   3,
   <-3,-1,2>,
   <-3,-2,1>,
   <-4,0,0>
   texture { ptexture }
}
polygon {
   4,
   <-2,-1,3>,
   <-3,-1,2>,
   <-3,1,2>,
   <-2,1,3>
   texture { ptexture }
}
polygon {
   3,
   <-3,-2,1>,
   <-3,-2,-1>,
   <-4,0,0>
   texture { ptexture }
}
polygon {
   4,
   <-2,-3,-1>,
   <-3,-2,-1>,
   <-3,-2,1>,
   <-2,-3,1>
   texture { ptexture }
}
polygon {
   3,
   <1,-2,-3>,
   <2,-1,-3>,
   <0,0,-4>
   texture { ptexture }
}
polygon {
   3,
   <2,3,-1>,
   <2,3,1>,
   <0,4,0>
   texture { ptexture }
}
polygon {
   4,
   <3,2,1>,
   <2,3,1>,
   <2,3,-1>,
   <3,2,-1>
   texture { ptexture }
}
polygon {
   3,
   <2,1,3>,
   <2,-1,3>,
   <0,0,4>
   texture { ptexture }
}
polygon {
   3,
   <1,2,3>,
   <2,1,3>,
   <0,0,4>
   texture { ptexture }
}
polygon {
   3,
   <3,-2,-1>,
   <3,-2,1>,
   <4,0,0>
   texture { ptexture }
}
polygon {
   3,
   <3,-1,2>,
   <3,1,2>,
   <4,0,0>
   texture { ptexture }
}
polygon {
   3,
   <3,-2,1>,
   <3,-1,2>,
   <4,0,0>
   texture { ptexture }
}
polygon {
   4,
   <3,-1,2>,
   <2,-1,3>,
   <2,1,3>,
   <3,1,2>
   texture { ptexture }
}
polygon {
   3,
   <-1,-2,3>,
   <-2,-1,3>,
   <0,0,4>
   texture { ptexture }
}
polygon {
   6,
   <-2,-1,3>,
   <-1,-2,3>,
   <-1,-3,2>,
   <-2,-3,1>,
   <-3,-2,1>,
   <-3,-1,2>
   texture { ptexture }
}
polygon {
   3,
   <2,1,-3>,
   <1,2,-3>,
   <0,0,-4>
   texture { ptexture }
}
polygon {
   3,
   <1,2,-3>,
   <-1,2,-3>,
   <0,0,-4>
   texture { ptexture }
}
polygon {
   3,
   <-3,-1,-2>,
   <-3,1,-2>,
   <-4,0,0>
   texture { ptexture }
}
polygon {
   3,
   <-3,-2,-1>,
   <-3,-1,-2>,
   <-4,0,0>
   texture { ptexture }
}
polygon {
   4,
   <-3,-1,-2>,
   <-2,-1,-3>,
   <-2,1,-3>,
   <-3,1,-2>
   texture { ptexture }
}
polygon {
   3,
   <-2,-1,-3>,
   <-1,-2,-3>,
   <0,0,-4>
   texture { ptexture }
}
polygon {
   3,
   <-1,-2,-3>,
   <1,-2,-3>,
   <0,0,-4>
   texture { ptexture }
}
polygon {
   3,
   <1,3,2>,
   <-1,3,2>,
   <0,4,0>
   texture { ptexture }
}
polygon {
   3,
   <2,3,1>,
   <1,3,2>,
   <0,4,0>
   texture { ptexture }
}
polygon {
   4,
   <1,3,2>,
   <1,2,3>,
   <-1,2,3>,
   <-1,3,2>
   texture { ptexture }
}
polygon {
   6,
   <3,1,2>,
   <2,1,3>,
   <1,2,3>,
   <1,3,2>,
   <2,3,1>,
   <3,2,1>
   texture { ptexture }
}
polygon {
   3,
   <2,-3,1>,
   <2,-3,-1>,
   <0,-4,0>
   texture { ptexture }
}
polygon {
   4,
   <3,-2,-1>,
   <2,-3,-1>,
   <2,-3,1>,
   <3,-2,1>
   texture { ptexture }
}
polygon {
   3,
   <3,1,-2>,
   <3,-1,-2>,
   <4,0,0>
   texture { ptexture }
}
polygon {
   3,
   <3,-1,-2>,
   <3,-2,-1>,
   <4,0,0>
   texture { ptexture }
}
polygon {
   4,
   <2,-1,-3>,
   <3,-1,-2>,
   <3,1,-2>,
   <2,1,-3>
   texture { ptexture }
}
polygon {
   3,
   <1,-3,2>,
   <2,-3,1>,
   <0,-4,0>
   texture { ptexture }
}
polygon {
   3,
   <-1,-3,2>,
   <1,-3,2>,
   <0,-4,0>
   texture { ptexture }
}
polygon {
   3,
   <1,3,-2>,
   <2,3,-1>,
   <0,4,0>
   texture { ptexture }
}
polygon {
   3,
   <-1,3,-2>,
   <1,3,-2>,
   <0,4,0>
   texture { ptexture }
}
polygon {
   6,
   <3,2,-1>,
   <2,3,-1>,
   <1,3,-2>,
   <1,2,-3>,
   <2,1,-3>,
   <3,1,-2>
   texture { ptexture }
}
polygon {
   4,
   <1,2,-3>,
   <1,3,-2>,
   <-1,3,-2>,
   <-1,2,-3>
   texture { ptexture }
}
polygon {
   3,
   <-1,-3,-2>,
   <-2,-3,-1>,
   <0,-4,0>
   texture { ptexture }
}
polygon {
   6,
   <-1,-3,-2>,
   <-1,-2,-3>,
   <-2,-1,-3>,
   <-3,-1,-2>,
   <-3,-2,-1>,
   <-2,-3,-1>
   texture { ptexture }
}
polygon {
   3,
   <2,-1,3>,
   <1,-2,3>,
   <0,0,4>
   texture { ptexture }
}
polygon {
   3,
   <1,-2,3>,
   <-1,-2,3>,
   <0,0,4>
   texture { ptexture }
}
polygon {
   6,
   <3,-2,1>,
   <2,-3,1>,
   <1,-3,2>,
   <1,-2,3>,
   <2,-1,3>,
   <3,-1,2>
   texture { ptexture }
}
polygon {
   4,
   <1,-2,3>,
   <1,-3,2>,
   <-1,-3,2>,
   <-1,-2,3>
   texture { ptexture }
}
polygon {
   3,
   <2,-3,-1>,
   <1,-3,-2>,
   <0,-4,0>
   texture { ptexture }
}
polygon {
   3,
   <1,-3,-2>,
   <-1,-3,-2>,
   <0,-4,0>
   texture { ptexture }
}
polygon {
   6,
   <2,-1,-3>,
   <1,-2,-3>,
   <1,-3,-2>,
   <2,-3,-1>,
   <3,-2,-1>,
   <3,-1,-2>
   texture { ptexture }
}
polygon {
   4,
   <1,-3,-2>,
   <1,-2,-3>,
   <-1,-2,-3>,
   <-1,-3,-2>
   texture { ptexture }
}
}
