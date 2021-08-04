#declare RADIUS = sqrt(40);
#declare ptexture = texture {
   pigment { color rgb <1.0,0.5,0.5> }
}
union {
polygon {
   4,
   <-6,-2,0>,
   <-6,0,2>,
   <-5,-1,4>,
   <-5,-4,1>
   texture { ptexture }
}
polygon {
   4,
   <5,-1,4>,
   <6,0,2>,
   <6,-2,0>,
   <5,-4,1>
   texture { ptexture }
}
polygon {
   3,
   <-2,-6,0>,
   <-4,-5,-1>,
   <-4,-5,1>
   texture { ptexture }
}
polygon {
   3,
   <1,-5,4>,
   <0,-6,2>,
   <-1,-5,4>
   texture { ptexture }
}
polygon {
   4,
   <0,-6,2>,
   <-2,-6,0>,
   <-4,-5,1>,
   <-1,-5,4>
   texture { ptexture }
}
polygon {
   3,
   <-2,6,0>,
   <-4,5,1>,
   <-4,5,-1>
   texture { ptexture }
}
polygon {
   3,
   <-4,-1,-5>,
   <-2,0,-6>,
   <-4,1,-5>
   texture { ptexture }
}
polygon {
   4,
   <-2,0,-6>,
   <-4,-1,-5>,
   <-1,-4,-5>,
   <0,-2,-6>
   texture { ptexture }
}
polygon {
   3,
   <-5,-1,-4>,
   <-5,1,-4>,
   <-6,0,-2>
   texture { ptexture }
}
polygon {
   4,
   <-5,-1,-4>,
   <-4,-1,-5>,
   <-4,1,-5>,
   <-5,1,-4>
   texture { ptexture }
}
polygon {
   4,
   <-5,4,-1>,
   <-4,5,-1>,
   <-4,5,1>,
   <-5,4,1>
   texture { ptexture }
}
polygon {
   6,
   <5,1,-4>,
   <5,4,-1>,
   <4,5,-1>,
   <1,5,-4>,
   <1,4,-5>,
   <4,1,-5>
   texture { ptexture }
}
polygon {
   3,
   <-6,0,2>,
   <-5,1,4>,
   <-5,-1,4>
   texture { ptexture }
}
polygon {
   6,
   <-4,-1,5>,
   <-1,-4,5>,
   <-1,-5,4>,
   <-4,-5,1>,
   <-5,-4,1>,
   <-5,-1,4>
   texture { ptexture }
}
polygon {
   4,
   <-1,-4,5>,
   <-4,-1,5>,
   <-2,0,6>,
   <0,-2,6>
   texture { ptexture }
}
polygon {
   3,
   <1,-4,5>,
   <-1,-4,5>,
   <0,-2,6>
   texture { ptexture }
}
polygon {
   4,
   <1,-4,5>,
   <1,-5,4>,
   <-1,-5,4>,
   <-1,-4,5>
   texture { ptexture }
}
polygon {
   6,
   <1,-4,5>,
   <4,-1,5>,
   <5,-1,4>,
   <5,-4,1>,
   <4,-5,1>,
   <1,-5,4>
   texture { ptexture }
}
polygon {
   3,
   <-1,-4,-5>,
   <1,-4,-5>,
   <0,-2,-6>
   texture { ptexture }
}
polygon {
   3,
   <5,1,4>,
   <6,0,2>,
   <5,-1,4>
   texture { ptexture }
}
polygon {
   4,
   <4,5,1>,
   <4,5,-1>,
   <5,4,-1>,
   <5,4,1>
   texture { ptexture }
}
polygon {
   4,
   <-2,-6,0>,
   <0,-6,-2>,
   <-1,-5,-4>,
   <-4,-5,-1>
   texture { ptexture }
}
polygon {
   3,
   <-5,-4,1>,
   <-5,-4,-1>,
   <-6,-2,0>
   texture { ptexture }
}
polygon {
   4,
   <-4,-5,-1>,
   <-5,-4,-1>,
   <-5,-4,1>,
   <-4,-5,1>
   texture { ptexture }
}
polygon {
   6,
   <-5,-1,-4>,
   <-5,-4,-1>,
   <-4,-5,-1>,
   <-1,-5,-4>,
   <-1,-4,-5>,
   <-4,-1,-5>
   texture { ptexture }
}
polygon {
   4,
   <-6,0,-2>,
   <-6,-2,0>,
   <-5,-4,-1>,
   <-5,-1,-4>
   texture { ptexture }
}
polygon {
   4,
   <2,-6,0>,
   <0,-6,-2>,
   <-2,-6,0>,
   <0,-6,2>
   texture { ptexture }
}
polygon {
   4,
   <2,-6,0>,
   <0,-6,2>,
   <1,-5,4>,
   <4,-5,1>
   texture { ptexture }
}
polygon {
   3,
   <-6,2,0>,
   <-5,4,-1>,
   <-5,4,1>
   texture { ptexture }
}
polygon {
   4,
   <-6,0,2>,
   <-6,2,0>,
   <-5,4,1>,
   <-5,1,4>
   texture { ptexture }
}
polygon {
   4,
   <-6,0,-2>,
   <-6,2,0>,
   <-6,0,2>,
   <-6,-2,0>
   texture { ptexture }
}
polygon {
   4,
   <-6,2,0>,
   <-6,0,-2>,
   <-5,1,-4>,
   <-5,4,-1>
   texture { ptexture }
}
polygon {
   3,
   <5,4,-1>,
   <6,2,0>,
   <5,4,1>
   texture { ptexture }
}
polygon {
   4,
   <6,2,0>,
   <6,0,2>,
   <5,1,4>,
   <5,4,1>
   texture { ptexture }
}
polygon {
   4,
   <6,2,0>,
   <6,0,-2>,
   <6,-2,0>,
   <6,0,2>
   texture { ptexture }
}
polygon {
   4,
   <6,0,-2>,
   <6,2,0>,
   <5,4,-1>,
   <5,1,-4>
   texture { ptexture }
}
polygon {
   3,
   <-1,5,-4>,
   <1,5,-4>,
   <0,6,-2>
   texture { ptexture }
}
polygon {
   4,
   <-4,5,-1>,
   <-1,5,-4>,
   <0,6,-2>,
   <-2,6,0>
   texture { ptexture }
}
polygon {
   3,
   <-4,-1,5>,
   <-4,1,5>,
   <-2,0,6>
   texture { ptexture }
}
polygon {
   6,
   <-1,4,5>,
   <-4,1,5>,
   <-5,1,4>,
   <-5,4,1>,
   <-4,5,1>,
   <-1,5,4>
   texture { ptexture }
}
polygon {
   4,
   <-5,1,4>,
   <-4,1,5>,
   <-4,-1,5>,
   <-5,-1,4>
   texture { ptexture }
}
polygon {
   3,
   <5,-4,-1>,
   <5,-4,1>,
   <6,-2,0>
   texture { ptexture }
}
polygon {
   3,
   <4,5,1>,
   <2,6,0>,
   <4,5,-1>
   texture { ptexture }
}
polygon {
   4,
   <2,6,0>,
   <0,6,-2>,
   <1,5,-4>,
   <4,5,-1>
   texture { ptexture }
}
polygon {
   4,
   <0,2,-6>,
   <2,0,-6>,
   <4,1,-5>,
   <1,4,-5>
   texture { ptexture }
}
polygon {
   4,
   <2,0,-6>,
   <0,2,-6>,
   <-2,0,-6>,
   <0,-2,-6>
   texture { ptexture }
}
polygon {
   3,
   <5,1,-4>,
   <5,-1,-4>,
   <6,0,-2>
   texture { ptexture }
}
polygon {
   4,
   <5,-1,-4>,
   <5,-4,-1>,
   <6,-2,0>,
   <6,0,-2>
   texture { ptexture }
}
polygon {
   3,
   <4,-5,-1>,
   <2,-6,0>,
   <4,-5,1>
   texture { ptexture }
}
polygon {
   4,
   <5,-4,-1>,
   <4,-5,-1>,
   <4,-5,1>,
   <5,-4,1>
   texture { ptexture }
}
polygon {
   4,
   <0,-2,6>,
   <2,0,6>,
   <4,-1,5>,
   <1,-4,5>
   texture { ptexture }
}
polygon {
   3,
   <0,6,2>,
   <1,5,4>,
   <-1,5,4>
   texture { ptexture }
}
polygon {
   4,
   <2,6,0>,
   <0,6,2>,
   <-2,6,0>,
   <0,6,-2>
   texture { ptexture }
}
polygon {
   4,
   <0,6,2>,
   <2,6,0>,
   <4,5,1>,
   <1,5,4>
   texture { ptexture }
}
polygon {
   4,
   <-2,6,0>,
   <0,6,2>,
   <-1,5,4>,
   <-4,5,1>
   texture { ptexture }
}
polygon {
   3,
   <-1,4,-5>,
   <0,2,-6>,
   <1,4,-5>
   texture { ptexture }
}
polygon {
   6,
   <-1,5,-4>,
   <-4,5,-1>,
   <-5,4,-1>,
   <-5,1,-4>,
   <-4,1,-5>,
   <-1,4,-5>
   texture { ptexture }
}
polygon {
   4,
   <-1,5,-4>,
   <-1,4,-5>,
   <1,4,-5>,
   <1,5,-4>
   texture { ptexture }
}
polygon {
   4,
   <-2,0,-6>,
   <0,2,-6>,
   <-1,4,-5>,
   <-4,1,-5>
   texture { ptexture }
}
polygon {
   3,
   <2,0,-6>,
   <4,-1,-5>,
   <4,1,-5>
   texture { ptexture }
}
polygon {
   4,
   <4,-1,-5>,
   <5,-1,-4>,
   <5,1,-4>,
   <4,1,-5>
   texture { ptexture }
}
polygon {
   4,
   <1,-4,-5>,
   <4,-1,-5>,
   <2,0,-6>,
   <0,-2,-6>
   texture { ptexture }
}
polygon {
   3,
   <1,-5,-4>,
   <-1,-5,-4>,
   <0,-6,-2>
   texture { ptexture }
}
polygon {
   6,
   <4,-1,-5>,
   <1,-4,-5>,
   <1,-5,-4>,
   <4,-5,-1>,
   <5,-4,-1>,
   <5,-1,-4>
   texture { ptexture }
}
polygon {
   4,
   <4,-5,-1>,
   <1,-5,-4>,
   <0,-6,-2>,
   <2,-6,0>
   texture { ptexture }
}
polygon {
   4,
   <1,-5,-4>,
   <1,-4,-5>,
   <-1,-4,-5>,
   <-1,-5,-4>
   texture { ptexture }
}
polygon {
   3,
   <2,0,6>,
   <4,1,5>,
   <4,-1,5>
   texture { ptexture }
}
polygon {
   4,
   <4,1,5>,
   <5,1,4>,
   <5,-1,4>,
   <4,-1,5>
   texture { ptexture }
}
polygon {
   6,
   <5,4,1>,
   <5,1,4>,
   <4,1,5>,
   <1,4,5>,
   <1,5,4>,
   <4,5,1>
   texture { ptexture }
}
polygon {
   4,
   <1,5,4>,
   <1,4,5>,
   <-1,4,5>,
   <-1,5,4>
   texture { ptexture }
}
polygon {
   3,
   <1,4,5>,
   <0,2,6>,
   <-1,4,5>
   texture { ptexture }
}
polygon {
   4,
   <0,2,6>,
   <-2,0,6>,
   <-4,1,5>,
   <-1,4,5>
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
   <2,0,6>,
   <0,2,6>,
   <1,4,5>,
   <4,1,5>
   texture { ptexture }
}
}
