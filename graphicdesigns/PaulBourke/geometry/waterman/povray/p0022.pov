#declare RADIUS = sqrt(44);
#declare ptexture = texture {
   pigment { color rgb <1.0,0.5,0.5> }
}
union {
polygon {
   4,
   <-6,-2,-2>,
   <-6,2,-2>,
   <-6,2,2>,
   <-6,-2,2>
   texture { ptexture }
}
polygon {
   4,
   <-2,2,-6>,
   <-4,1,-5>,
   <-4,-1,-5>,
   <-2,-2,-6>
   texture { ptexture }
}
polygon {
   4,
   <-2,-2,6>,
   <-2,2,6>,
   <2,2,6>,
   <2,-2,6>
   texture { ptexture }
}
polygon {
   4,
   <-5,1,-4>,
   <-5,-1,-4>,
   <-4,-1,-5>,
   <-4,1,-5>
   texture { ptexture }
}
polygon {
   4,
   <-5,-1,-4>,
   <-5,1,-4>,
   <-6,2,-2>,
   <-6,-2,-2>
   texture { ptexture }
}
polygon {
   9,
   <-6,-2,-2>,
   <-5,-4,-1>,
   <-4,-5,-1>,
   <-2,-6,-2>,
   <-1,-5,-4>,
   <-1,-4,-5>,
   <-2,-2,-6>,
   <-4,-1,-5>,
   <-5,-1,-4>
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
   <4,5,1>,
   <2,6,2>,
   <2,6,-2>,
   <4,5,-1>
   texture { ptexture }
}
polygon {
   4,
   <2,6,2>,
   <-2,6,2>,
   <-2,6,-2>,
   <2,6,-2>
   texture { ptexture }
}
polygon {
   4,
   <-2,6,2>,
   <-4,5,1>,
   <-4,5,-1>,
   <-2,6,-2>
   texture { ptexture }
}
polygon {
   4,
   <5,4,1>,
   <5,4,-1>,
   <6,2,-2>,
   <6,2,2>
   texture { ptexture }
}
polygon {
   4,
   <5,1,-4>,
   <5,-1,-4>,
   <6,-2,-2>,
   <6,2,-2>
   texture { ptexture }
}
polygon {
   4,
   <5,1,-4>,
   <4,1,-5>,
   <4,-1,-5>,
   <5,-1,-4>
   texture { ptexture }
}
polygon {
   4,
   <2,-2,-6>,
   <2,2,-6>,
   <-2,2,-6>,
   <-2,-2,-6>
   texture { ptexture }
}
polygon {
   4,
   <2,-2,-6>,
   <4,-1,-5>,
   <4,1,-5>,
   <2,2,-6>
   texture { ptexture }
}
polygon {
   4,
   <1,-4,-5>,
   <2,-2,-6>,
   <-2,-2,-6>,
   <-1,-4,-5>
   texture { ptexture }
}
polygon {
   4,
   <-1,5,-4>,
   <1,5,-4>,
   <2,6,-2>,
   <-2,6,-2>
   texture { ptexture }
}
polygon {
   4,
   <-5,1,4>,
   <-5,-1,4>,
   <-6,-2,2>,
   <-6,2,2>
   texture { ptexture }
}
polygon {
   4,
   <-1,4,5>,
   <1,4,5>,
   <2,2,6>,
   <-2,2,6>
   texture { ptexture }
}
polygon {
   4,
   <-5,-4,1>,
   <-5,-4,-1>,
   <-6,-2,-2>,
   <-6,-2,2>
   texture { ptexture }
}
polygon {
   4,
   <-5,4,-1>,
   <-5,4,1>,
   <-6,2,2>,
   <-6,2,-2>
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
   4,
   <6,2,2>,
   <6,2,-2>,
   <6,-2,-2>,
   <6,-2,2>
   texture { ptexture }
}
polygon {
   4,
   <6,-2,2>,
   <5,-1,4>,
   <5,1,4>,
   <6,2,2>
   texture { ptexture }
}
polygon {
   4,
   <2,-6,-2>,
   <-2,-6,-2>,
   <-2,-6,2>,
   <2,-6,2>
   texture { ptexture }
}
polygon {
   4,
   <4,1,5>,
   <4,-1,5>,
   <2,-2,6>,
   <2,2,6>
   texture { ptexture }
}
polygon {
   4,
   <4,-1,5>,
   <4,1,5>,
   <5,1,4>,
   <5,-1,4>
   texture { ptexture }
}
polygon {
   9,
   <1,5,-4>,
   <1,4,-5>,
   <2,2,-6>,
   <4,1,-5>,
   <5,1,-4>,
   <6,2,-2>,
   <5,4,-1>,
   <4,5,-1>,
   <2,6,-2>
   texture { ptexture }
}
polygon {
   9,
   <-4,1,5>,
   <-5,1,4>,
   <-6,2,2>,
   <-5,4,1>,
   <-4,5,1>,
   <-2,6,2>,
   <-1,5,4>,
   <-1,4,5>,
   <-2,2,6>
   texture { ptexture }
}
polygon {
   4,
   <-4,-1,5>,
   <-4,1,5>,
   <-2,2,6>,
   <-2,-2,6>
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
   9,
   <5,4,1>,
   <6,2,2>,
   <5,1,4>,
   <4,1,5>,
   <2,2,6>,
   <1,4,5>,
   <1,5,4>,
   <2,6,2>,
   <4,5,1>
   texture { ptexture }
}
polygon {
   4,
   <2,6,2>,
   <1,5,4>,
   <-1,5,4>,
   <-2,6,2>
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
   9,
   <-4,-1,5>,
   <-2,-2,6>,
   <-1,-4,5>,
   <-1,-5,4>,
   <-2,-6,2>,
   <-4,-5,1>,
   <-5,-4,1>,
   <-6,-2,2>,
   <-5,-1,4>
   texture { ptexture }
}
polygon {
   4,
   <-4,-5,1>,
   <-2,-6,2>,
   <-2,-6,-2>,
   <-4,-5,-1>
   texture { ptexture }
}
polygon {
   4,
   <-5,-4,1>,
   <-4,-5,1>,
   <-4,-5,-1>,
   <-5,-4,-1>
   texture { ptexture }
}
polygon {
   4,
   <1,-5,4>,
   <2,-6,2>,
   <-2,-6,2>,
   <-1,-5,4>
   texture { ptexture }
}
polygon {
   4,
   <-1,-5,-4>,
   <1,-5,-4>,
   <1,-4,-5>,
   <-1,-4,-5>
   texture { ptexture }
}
polygon {
   4,
   <2,-6,-2>,
   <1,-5,-4>,
   <-1,-5,-4>,
   <-2,-6,-2>
   texture { ptexture }
}
polygon {
   4,
   <5,-4,-1>,
   <5,-4,1>,
   <6,-2,2>,
   <6,-2,-2>
   texture { ptexture }
}
polygon {
   9,
   <-6,2,-2>,
   <-5,1,-4>,
   <-4,1,-5>,
   <-2,2,-6>,
   <-1,4,-5>,
   <-1,5,-4>,
   <-2,6,-2>,
   <-4,5,-1>,
   <-5,4,-1>
   texture { ptexture }
}
polygon {
   4,
   <1,4,-5>,
   <-1,4,-5>,
   <-2,2,-6>,
   <2,2,-6>
   texture { ptexture }
}
polygon {
   4,
   <-1,4,-5>,
   <1,4,-5>,
   <1,5,-4>,
   <-1,5,-4>
   texture { ptexture }
}
polygon {
   9,
   <4,-5,1>,
   <2,-6,2>,
   <1,-5,4>,
   <1,-4,5>,
   <2,-2,6>,
   <4,-1,5>,
   <5,-1,4>,
   <6,-2,2>,
   <5,-4,1>
   texture { ptexture }
}
polygon {
   4,
   <1,-4,5>,
   <-1,-4,5>,
   <-2,-2,6>,
   <2,-2,6>
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
   9,
   <1,-5,-4>,
   <2,-6,-2>,
   <4,-5,-1>,
   <5,-4,-1>,
   <6,-2,-2>,
   <5,-1,-4>,
   <4,-1,-5>,
   <2,-2,-6>,
   <1,-4,-5>
   texture { ptexture }
}
polygon {
   4,
   <4,-5,-1>,
   <2,-6,-2>,
   <2,-6,2>,
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
}
