#declare RADIUS = sqrt(40);
#declare ptexture = texture {
   pigment { color rgb <1.0,0.5,0.5> }
}
union {
polygon {
   4,
   <0,-6,2>,
   <2,-6,0>,
   <0,-6,-2>,
   <-2,-6,0>
   texture { ptexture }
}
polygon {
   4,
   <2,-5,3>,
   <3,-5,2>,
   <2,-6,0>,
   <0,-6,2>
   texture { ptexture }
}
polygon {
   4,
   <0,6,-2>,
   <2,6,0>,
   <0,6,2>,
   <-2,6,0>
   texture { ptexture }
}
polygon {
   4,
   <-6,2,0>,
   <-6,0,2>,
   <-6,-2,0>,
   <-6,0,-2>
   texture { ptexture }
}
polygon {
   4,
   <-5,2,3>,
   <-6,0,2>,
   <-6,2,0>,
   <-5,3,2>
   texture { ptexture }
}
polygon {
   4,
   <0,6,2>,
   <-2,5,3>,
   <-3,5,2>,
   <-2,6,0>
   texture { ptexture }
}
polygon {
   4,
   <6,0,2>,
   <6,2,0>,
   <6,0,-2>,
   <6,-2,0>
   texture { ptexture }
}
polygon {
   4,
   <6,0,2>,
   <5,2,3>,
   <5,3,2>,
   <6,2,0>
   texture { ptexture }
}
polygon {
   4,
   <2,5,3>,
   <0,6,2>,
   <2,6,0>,
   <3,5,2>
   texture { ptexture }
}
polygon {
   4,
   <-2,-5,3>,
   <0,-6,2>,
   <-2,-6,0>,
   <-3,-5,2>
   texture { ptexture }
}
polygon {
   4,
   <-6,0,-2>,
   <-5,2,-3>,
   <-5,3,-2>,
   <-6,2,0>
   texture { ptexture }
}
polygon {
   6,
   <5,3,2>,
   <3,5,2>,
   <2,6,0>,
   <3,5,-2>,
   <5,3,-2>,
   <6,2,0>
   texture { ptexture }
}
polygon {
   4,
   <-2,-5,-3>,
   <-3,-5,-2>,
   <-2,-6,0>,
   <0,-6,-2>
   texture { ptexture }
}
polygon {
   4,
   <-6,0,2>,
   <-5,-2,3>,
   <-5,-3,2>,
   <-6,-2,0>
   texture { ptexture }
}
polygon {
   6,
   <-5,-2,3>,
   <-3,-2,5>,
   <-2,-3,5>,
   <-2,-5,3>,
   <-3,-5,2>,
   <-5,-3,2>
   texture { ptexture }
}
polygon {
   6,
   <-3,2,5>,
   <-2,0,6>,
   <-3,-2,5>,
   <-5,-2,3>,
   <-6,0,2>,
   <-5,2,3>
   texture { ptexture }
}
polygon {
   4,
   <-3,-2,5>,
   <-2,0,6>,
   <0,-2,6>,
   <-2,-3,5>
   texture { ptexture }
}
polygon {
   6,
   <0,-6,-2>,
   <2,-5,-3>,
   <2,-3,-5>,
   <0,-2,-6>,
   <-2,-3,-5>,
   <-2,-5,-3>
   texture { ptexture }
}
polygon {
   4,
   <3,-5,-2>,
   <2,-5,-3>,
   <0,-6,-2>,
   <2,-6,0>
   texture { ptexture }
}
polygon {
   6,
   <-2,-5,3>,
   <-2,-3,5>,
   <0,-2,6>,
   <2,-3,5>,
   <2,-5,3>,
   <0,-6,2>
   texture { ptexture }
}
polygon {
   6,
   <-2,5,3>,
   <-2,3,5>,
   <-3,2,5>,
   <-5,2,3>,
   <-5,3,2>,
   <-3,5,2>
   texture { ptexture }
}
polygon {
   6,
   <-3,5,-2>,
   <-2,6,0>,
   <-3,5,2>,
   <-5,3,2>,
   <-6,2,0>,
   <-5,3,-2>
   texture { ptexture }
}
polygon {
   4,
   <-3,5,-2>,
   <-2,5,-3>,
   <0,6,-2>,
   <-2,6,0>
   texture { ptexture }
}
polygon {
   6,
   <-5,-3,-2>,
   <-6,-2,0>,
   <-5,-3,2>,
   <-3,-5,2>,
   <-2,-6,0>,
   <-3,-5,-2>
   texture { ptexture }
}
polygon {
   4,
   <-5,-3,-2>,
   <-5,-2,-3>,
   <-6,0,-2>,
   <-6,-2,0>
   texture { ptexture }
}
polygon {
   6,
   <3,-5,2>,
   <5,-3,2>,
   <6,-2,0>,
   <5,-3,-2>,
   <3,-5,-2>,
   <2,-6,0>
   texture { ptexture }
}
polygon {
   4,
   <5,-2,-3>,
   <5,-3,-2>,
   <6,-2,0>,
   <6,0,-2>
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
   <2,5,-3>,
   <3,5,-2>,
   <2,6,0>,
   <0,6,-2>
   texture { ptexture }
}
polygon {
   4,
   <5,2,-3>,
   <6,0,-2>,
   <6,2,0>,
   <5,3,-2>
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
   6,
   <-6,0,-2>,
   <-5,-2,-3>,
   <-3,-2,-5>,
   <-2,0,-6>,
   <-3,2,-5>,
   <-5,2,-3>
   texture { ptexture }
}
polygon {
   4,
   <-2,0,-6>,
   <-3,-2,-5>,
   <-2,-3,-5>,
   <0,-2,-6>
   texture { ptexture }
}
polygon {
   4,
   <5,-2,3>,
   <6,0,2>,
   <6,-2,0>,
   <5,-3,2>
   texture { ptexture }
}
polygon {
   6,
   <5,-2,3>,
   <3,-2,5>,
   <2,0,6>,
   <3,2,5>,
   <5,2,3>,
   <6,0,2>
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
   <2,0,6>,
   <3,-2,5>,
   <2,-3,5>,
   <0,-2,6>
   texture { ptexture }
}
polygon {
   6,
   <2,5,3>,
   <2,3,5>,
   <0,2,6>,
   <-2,3,5>,
   <-2,5,3>,
   <0,6,2>
   texture { ptexture }
}
polygon {
   4,
   <0,2,6>,
   <2,0,6>,
   <0,-2,6>,
   <-2,0,6>
   texture { ptexture }
}
polygon {
   4,
   <-2,3,5>,
   <0,2,6>,
   <-2,0,6>,
   <-3,2,5>
   texture { ptexture }
}
polygon {
   4,
   <0,2,6>,
   <2,3,5>,
   <3,2,5>,
   <2,0,6>
   texture { ptexture }
}
polygon {
   6,
   <-5,2,-3>,
   <-3,2,-5>,
   <-2,3,-5>,
   <-2,5,-3>,
   <-3,5,-2>,
   <-5,3,-2>
   texture { ptexture }
}
polygon {
   6,
   <0,2,-6>,
   <2,3,-5>,
   <2,5,-3>,
   <0,6,-2>,
   <-2,5,-3>,
   <-2,3,-5>
   texture { ptexture }
}
polygon {
   4,
   <0,2,-6>,
   <-2,3,-5>,
   <-3,2,-5>,
   <-2,0,-6>
   texture { ptexture }
}
polygon {
   4,
   <0,-2,-6>,
   <2,0,-6>,
   <0,2,-6>,
   <-2,0,-6>
   texture { ptexture }
}
polygon {
   6,
   <5,-2,-3>,
   <3,-2,-5>,
   <2,-3,-5>,
   <2,-5,-3>,
   <3,-5,-2>,
   <5,-3,-2>
   texture { ptexture }
}
polygon {
   4,
   <3,-2,-5>,
   <2,0,-6>,
   <0,-2,-6>,
   <2,-3,-5>
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
   6,
   <5,-2,-3>,
   <6,0,-2>,
   <5,2,-3>,
   <3,2,-5>,
   <2,0,-6>,
   <3,-2,-5>
   texture { ptexture }
}
polygon {
   4,
   <2,0,-6>,
   <3,2,-5>,
   <2,3,-5>,
   <0,2,-6>
   texture { ptexture }
}
}
