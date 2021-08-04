#declare RADIUS = sqrt(38);
#declare ptexture = texture {
   pigment { color rgb <1.0,0.5,0.5> }
}
union {
polygon {
   4,
   <-5,3,-2>,
   <-3,5,-2>,
   <-3,5,2>,
   <-5,3,2>
   texture { ptexture }
}
polygon {
   3,
   <-5,2,3>,
   <-6,1,1>,
   <-5,3,2>
   texture { ptexture }
}
polygon {
   4,
   <-6,1,1>,
   <-6,1,-1>,
   <-5,3,-2>,
   <-5,3,2>
   texture { ptexture }
}
polygon {
   4,
   <-6,-1,1>,
   <-6,-1,-1>,
   <-6,1,-1>,
   <-6,1,1>
   texture { ptexture }
}
polygon {
   3,
   <6,1,1>,
   <5,2,3>,
   <5,3,2>
   texture { ptexture }
}
polygon {
   3,
   <-1,1,-6>,
   <-2,3,-5>,
   <-3,2,-5>
   texture { ptexture }
}
polygon {
   3,
   <-3,5,2>,
   <-1,6,1>,
   <-2,5,3>
   texture { ptexture }
}
polygon {
   4,
   <-1,6,-1>,
   <-1,6,1>,
   <-3,5,2>,
   <-3,5,-2>
   texture { ptexture }
}
polygon {
   4,
   <1,6,-1>,
   <1,6,1>,
   <-1,6,1>,
   <-1,6,-1>
   texture { ptexture }
}
polygon {
   4,
   <2,5,3>,
   <-2,5,3>,
   <-1,6,1>,
   <1,6,1>
   texture { ptexture }
}
polygon {
   4,
   <3,2,-5>,
   <1,1,-6>,
   <1,-1,-6>,
   <3,-2,-5>
   texture { ptexture }
}
polygon {
   4,
   <1,-1,-6>,
   <1,1,-6>,
   <-1,1,-6>,
   <-1,-1,-6>
   texture { ptexture }
}
polygon {
   3,
   <1,-1,-6>,
   <2,-3,-5>,
   <3,-2,-5>
   texture { ptexture }
}
polygon {
   4,
   <-2,-3,-5>,
   <2,-3,-5>,
   <1,-1,-6>,
   <-1,-1,-6>
   texture { ptexture }
}
polygon {
   4,
   <-6,-1,1>,
   <-6,1,1>,
   <-5,2,3>,
   <-5,-2,3>
   texture { ptexture }
}
polygon {
   6,
   <-5,3,2>,
   <-3,5,2>,
   <-2,5,3>,
   <-2,3,5>,
   <-3,2,5>,
   <-5,2,3>
   texture { ptexture }
}
polygon {
   4,
   <6,1,-1>,
   <6,-1,-1>,
   <6,-1,1>,
   <6,1,1>
   texture { ptexture }
}
polygon {
   4,
   <6,1,-1>,
   <6,1,1>,
   <5,3,2>,
   <5,3,-2>
   texture { ptexture }
}
polygon {
   3,
   <-6,1,-1>,
   <-5,2,-3>,
   <-5,3,-2>
   texture { ptexture }
}
polygon {
   3,
   <-3,5,-2>,
   <-2,5,-3>,
   <-1,6,-1>
   texture { ptexture }
}
polygon {
   6,
   <-3,2,-5>,
   <-2,3,-5>,
   <-2,5,-3>,
   <-3,5,-2>,
   <-5,3,-2>,
   <-5,2,-3>
   texture { ptexture }
}
polygon {
   3,
   <-5,-2,3>,
   <-5,-3,2>,
   <-6,-1,1>
   texture { ptexture }
}
polygon {
   4,
   <-5,-3,2>,
   <-3,-5,2>,
   <-3,-5,-2>,
   <-5,-3,-2>
   texture { ptexture }
}
polygon {
   4,
   <-5,-3,2>,
   <-5,-3,-2>,
   <-6,-1,-1>,
   <-6,-1,1>
   texture { ptexture }
}
polygon {
   4,
   <-3,-2,5>,
   <-5,-2,3>,
   <-5,2,3>,
   <-3,2,5>
   texture { ptexture }
}
polygon {
   4,
   <1,-1,6>,
   <1,1,6>,
   <3,2,5>,
   <3,-2,5>
   texture { ptexture }
}
polygon {
   3,
   <1,-6,1>,
   <2,-5,3>,
   <3,-5,2>
   texture { ptexture }
}
polygon {
   3,
   <-2,3,5>,
   <-1,1,6>,
   <-3,2,5>
   texture { ptexture }
}
polygon {
   4,
   <-1,1,6>,
   <-1,-1,6>,
   <-3,-2,5>,
   <-3,2,5>
   texture { ptexture }
}
polygon {
   4,
   <-1,1,6>,
   <1,1,6>,
   <1,-1,6>,
   <-1,-1,6>
   texture { ptexture }
}
polygon {
   3,
   <1,1,6>,
   <2,3,5>,
   <3,2,5>
   texture { ptexture }
}
polygon {
   4,
   <-2,3,5>,
   <2,3,5>,
   <1,1,6>,
   <-1,1,6>
   texture { ptexture }
}
polygon {
   4,
   <2,3,5>,
   <-2,3,5>,
   <-2,5,3>,
   <2,5,3>
   texture { ptexture }
}
polygon {
   3,
   <5,2,-3>,
   <6,1,-1>,
   <5,3,-2>
   texture { ptexture }
}
polygon {
   4,
   <5,-2,-3>,
   <5,2,-3>,
   <3,2,-5>,
   <3,-2,-5>
   texture { ptexture }
}
polygon {
   4,
   <5,2,-3>,
   <5,-2,-3>,
   <6,-1,-1>,
   <6,1,-1>
   texture { ptexture }
}
polygon {
   4,
   <1,-6,-1>,
   <1,-6,1>,
   <3,-5,2>,
   <3,-5,-2>
   texture { ptexture }
}
polygon {
   3,
   <-1,-6,1>,
   <-3,-5,2>,
   <-2,-5,3>
   texture { ptexture }
}
polygon {
   4,
   <-1,-6,-1>,
   <-1,-6,1>,
   <1,-6,1>,
   <1,-6,-1>
   texture { ptexture }
}
polygon {
   4,
   <1,-6,1>,
   <-1,-6,1>,
   <-2,-5,3>,
   <2,-5,3>
   texture { ptexture }
}
polygon {
   4,
   <-1,-6,1>,
   <-1,-6,-1>,
   <-3,-5,-2>,
   <-3,-5,2>
   texture { ptexture }
}
polygon {
   3,
   <1,6,-1>,
   <2,5,-3>,
   <3,5,-2>
   texture { ptexture }
}
polygon {
   4,
   <-2,5,-3>,
   <2,5,-3>,
   <1,6,-1>,
   <-1,6,-1>
   texture { ptexture }
}
polygon {
   3,
   <3,5,2>,
   <2,5,3>,
   <1,6,1>
   texture { ptexture }
}
polygon {
   6,
   <5,2,3>,
   <3,2,5>,
   <2,3,5>,
   <2,5,3>,
   <3,5,2>,
   <5,3,2>
   texture { ptexture }
}
polygon {
   4,
   <3,5,-2>,
   <3,5,2>,
   <1,6,1>,
   <1,6,-1>
   texture { ptexture }
}
polygon {
   4,
   <5,3,2>,
   <3,5,2>,
   <3,5,-2>,
   <5,3,-2>
   texture { ptexture }
}
polygon {
   3,
   <-2,-5,-3>,
   <-3,-5,-2>,
   <-1,-6,-1>
   texture { ptexture }
}
polygon {
   3,
   <2,-5,-3>,
   <1,-6,-1>,
   <3,-5,-2>
   texture { ptexture }
}
polygon {
   4,
   <-2,-5,-3>,
   <2,-5,-3>,
   <2,-3,-5>,
   <-2,-3,-5>
   texture { ptexture }
}
polygon {
   4,
   <2,-5,-3>,
   <-2,-5,-3>,
   <-1,-6,-1>,
   <1,-6,-1>
   texture { ptexture }
}
polygon {
   3,
   <-3,-2,-5>,
   <-2,-3,-5>,
   <-1,-1,-6>
   texture { ptexture }
}
polygon {
   4,
   <-3,2,-5>,
   <-3,-2,-5>,
   <-1,-1,-6>,
   <-1,1,-6>
   texture { ptexture }
}
polygon {
   3,
   <-5,-3,-2>,
   <-5,-2,-3>,
   <-6,-1,-1>
   texture { ptexture }
}
polygon {
   4,
   <-5,-2,-3>,
   <-5,2,-3>,
   <-6,1,-1>,
   <-6,-1,-1>
   texture { ptexture }
}
polygon {
   6,
   <-2,-5,-3>,
   <-2,-3,-5>,
   <-3,-2,-5>,
   <-5,-2,-3>,
   <-5,-3,-2>,
   <-3,-5,-2>
   texture { ptexture }
}
polygon {
   4,
   <-5,2,-3>,
   <-5,-2,-3>,
   <-3,-2,-5>,
   <-3,2,-5>
   texture { ptexture }
}
polygon {
   3,
   <5,-3,2>,
   <5,-2,3>,
   <6,-1,1>
   texture { ptexture }
}
polygon {
   4,
   <6,-1,1>,
   <5,-2,3>,
   <5,2,3>,
   <6,1,1>
   texture { ptexture }
}
polygon {
   4,
   <3,-2,5>,
   <3,2,5>,
   <5,2,3>,
   <5,-2,3>
   texture { ptexture }
}
polygon {
   3,
   <-2,-3,5>,
   <-3,-2,5>,
   <-1,-1,6>
   texture { ptexture }
}
polygon {
   6,
   <-3,-2,5>,
   <-2,-3,5>,
   <-2,-5,3>,
   <-3,-5,2>,
   <-5,-3,2>,
   <-5,-2,3>
   texture { ptexture }
}
polygon {
   3,
   <5,-2,-3>,
   <5,-3,-2>,
   <6,-1,-1>
   texture { ptexture }
}
polygon {
   4,
   <5,-3,-2>,
   <5,-3,2>,
   <6,-1,1>,
   <6,-1,-1>
   texture { ptexture }
}
polygon {
   4,
   <3,-5,-2>,
   <3,-5,2>,
   <5,-3,2>,
   <5,-3,-2>
   texture { ptexture }
}
polygon {
   6,
   <3,-5,-2>,
   <5,-3,-2>,
   <5,-2,-3>,
   <3,-2,-5>,
   <2,-3,-5>,
   <2,-5,-3>
   texture { ptexture }
}
polygon {
   3,
   <2,3,-5>,
   <1,1,-6>,
   <3,2,-5>
   texture { ptexture }
}
polygon {
   6,
   <2,5,-3>,
   <2,3,-5>,
   <3,2,-5>,
   <5,2,-3>,
   <5,3,-2>,
   <3,5,-2>
   texture { ptexture }
}
polygon {
   4,
   <2,3,-5>,
   <-2,3,-5>,
   <-1,1,-6>,
   <1,1,-6>
   texture { ptexture }
}
polygon {
   4,
   <2,3,-5>,
   <2,5,-3>,
   <-2,5,-3>,
   <-2,3,-5>
   texture { ptexture }
}
polygon {
   3,
   <2,-3,5>,
   <1,-1,6>,
   <3,-2,5>
   texture { ptexture }
}
polygon {
   6,
   <2,-5,3>,
   <2,-3,5>,
   <3,-2,5>,
   <5,-2,3>,
   <5,-3,2>,
   <3,-5,2>
   texture { ptexture }
}
polygon {
   4,
   <2,-3,5>,
   <-2,-3,5>,
   <-1,-1,6>,
   <1,-1,6>
   texture { ptexture }
}
polygon {
   4,
   <-2,-3,5>,
   <2,-3,5>,
   <2,-5,3>,
   <-2,-5,3>
   texture { ptexture }
}
}
