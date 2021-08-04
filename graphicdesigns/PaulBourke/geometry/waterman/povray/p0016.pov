#declare RADIUS = sqrt(30);
#declare ptexture = texture {
   pigment { color rgb <1.0,0.5,0.5> }
}
union {
polygon {
   3,
   <-4,0,-4>,
   <-5,1,-2>,
   <-5,-1,-2>
   texture { ptexture }
}
polygon {
   3,
   <-5,-2,-1>,
   <-5,-2,1>,
   <-4,-4,0>
   texture { ptexture }
}
polygon {
   3,
   <1,-5,-2>,
   <0,-4,-4>,
   <-1,-5,-2>
   texture { ptexture }
}
polygon {
   3,
   <-5,2,-1>,
   <-4,4,0>,
   <-5,2,1>
   texture { ptexture }
}
polygon {
   3,
   <2,5,1>,
   <2,5,-1>,
   <4,4,0>
   texture { ptexture }
}
polygon {
   3,
   <4,-4,0>,
   <2,-5,-1>,
   <2,-5,1>
   texture { ptexture }
}
polygon {
   3,
   <0,-4,4>,
   <1,-5,2>,
   <-1,-5,2>
   texture { ptexture }
}
polygon {
   3,
   <-2,-5,1>,
   <-2,-5,-1>,
   <-4,-4,0>
   texture { ptexture }
}
polygon {
   9,
   <-5,-1,-2>,
   <-5,-2,-1>,
   <-4,-4,0>,
   <-2,-5,-1>,
   <-1,-5,-2>,
   <0,-4,-4>,
   <-1,-2,-5>,
   <-2,-1,-5>,
   <-4,0,-4>
   texture { ptexture }
}
polygon {
   8,
   <2,-5,1>,
   <2,-5,-1>,
   <1,-5,-2>,
   <-1,-5,-2>,
   <-2,-5,-1>,
   <-2,-5,1>,
   <-1,-5,2>,
   <1,-5,2>
   texture { ptexture }
}
polygon {
   3,
   <-2,5,-1>,
   <-2,5,1>,
   <-4,4,0>
   texture { ptexture }
}
polygon {
   3,
   <2,-1,5>,
   <2,1,5>,
   <4,0,4>
   texture { ptexture }
}
polygon {
   3,
   <0,-4,-4>,
   <1,-2,-5>,
   <-1,-2,-5>
   texture { ptexture }
}
polygon {
   9,
   <-1,5,2>,
   <0,4,4>,
   <-1,2,5>,
   <-2,1,5>,
   <-4,0,4>,
   <-5,1,2>,
   <-5,2,1>,
   <-4,4,0>,
   <-2,5,1>
   texture { ptexture }
}
polygon {
   3,
   <5,1,2>,
   <5,-1,2>,
   <4,0,4>
   texture { ptexture }
}
polygon {
   3,
   <-2,-1,5>,
   <-4,0,4>,
   <-2,1,5>
   texture { ptexture }
}
polygon {
   3,
   <-4,0,4>,
   <-5,-1,2>,
   <-5,1,2>
   texture { ptexture }
}
polygon {
   8,
   <-5,-1,-2>,
   <-5,1,-2>,
   <-5,2,-1>,
   <-5,2,1>,
   <-5,1,2>,
   <-5,-1,2>,
   <-5,-2,1>,
   <-5,-2,-1>
   texture { ptexture }
}
polygon {
   9,
   <-5,-1,2>,
   <-4,0,4>,
   <-2,-1,5>,
   <-1,-2,5>,
   <0,-4,4>,
   <-1,-5,2>,
   <-2,-5,1>,
   <-4,-4,0>,
   <-5,-2,1>
   texture { ptexture }
}
polygon {
   3,
   <1,2,5>,
   <-1,2,5>,
   <0,4,4>
   texture { ptexture }
}
polygon {
   3,
   <1,-2,5>,
   <0,-4,4>,
   <-1,-2,5>
   texture { ptexture }
}
polygon {
   8,
   <-1,2,5>,
   <1,2,5>,
   <2,1,5>,
   <2,-1,5>,
   <1,-2,5>,
   <-1,-2,5>,
   <-2,-1,5>,
   <-2,1,5>
   texture { ptexture }
}
polygon {
   3,
   <5,1,-2>,
   <4,0,-4>,
   <5,-1,-2>
   texture { ptexture }
}
polygon {
   9,
   <5,-2,-1>,
   <5,-1,-2>,
   <4,0,-4>,
   <2,-1,-5>,
   <1,-2,-5>,
   <0,-4,-4>,
   <1,-5,-2>,
   <2,-5,-1>,
   <4,-4,0>
   texture { ptexture }
}
polygon {
   3,
   <-1,5,2>,
   <1,5,2>,
   <0,4,4>
   texture { ptexture }
}
polygon {
   8,
   <1,5,-2>,
   <2,5,-1>,
   <2,5,1>,
   <1,5,2>,
   <-1,5,2>,
   <-2,5,1>,
   <-2,5,-1>,
   <-1,5,-2>
   texture { ptexture }
}
polygon {
   3,
   <5,-2,1>,
   <5,-2,-1>,
   <4,-4,0>
   texture { ptexture }
}
polygon {
   9,
   <1,-2,5>,
   <2,-1,5>,
   <4,0,4>,
   <5,-1,2>,
   <5,-2,1>,
   <4,-4,0>,
   <2,-5,1>,
   <1,-5,2>,
   <0,-4,4>
   texture { ptexture }
}
polygon {
   3,
   <5,2,-1>,
   <5,2,1>,
   <4,4,0>
   texture { ptexture }
}
polygon {
   8,
   <5,-2,-1>,
   <5,-2,1>,
   <5,-1,2>,
   <5,1,2>,
   <5,2,1>,
   <5,2,-1>,
   <5,1,-2>,
   <5,-1,-2>
   texture { ptexture }
}
polygon {
   9,
   <2,1,5>,
   <1,2,5>,
   <0,4,4>,
   <1,5,2>,
   <2,5,1>,
   <4,4,0>,
   <5,2,1>,
   <5,1,2>,
   <4,0,4>
   texture { ptexture }
}
polygon {
   3,
   <0,4,-4>,
   <1,5,-2>,
   <-1,5,-2>
   texture { ptexture }
}
polygon {
   3,
   <-2,-1,-5>,
   <-2,1,-5>,
   <-4,0,-4>
   texture { ptexture }
}
polygon {
   9,
   <-2,1,-5>,
   <-1,2,-5>,
   <0,4,-4>,
   <-1,5,-2>,
   <-2,5,-1>,
   <-4,4,0>,
   <-5,2,-1>,
   <-5,1,-2>,
   <-4,0,-4>
   texture { ptexture }
}
polygon {
   3,
   <4,0,-4>,
   <2,1,-5>,
   <2,-1,-5>
   texture { ptexture }
}
polygon {
   3,
   <1,2,-5>,
   <0,4,-4>,
   <-1,2,-5>
   texture { ptexture }
}
polygon {
   9,
   <1,2,-5>,
   <2,1,-5>,
   <4,0,-4>,
   <5,1,-2>,
   <5,2,-1>,
   <4,4,0>,
   <2,5,-1>,
   <1,5,-2>,
   <0,4,-4>
   texture { ptexture }
}
polygon {
   8,
   <1,-2,-5>,
   <2,-1,-5>,
   <2,1,-5>,
   <1,2,-5>,
   <-1,2,-5>,
   <-2,1,-5>,
   <-2,-1,-5>,
   <-1,-2,-5>
   texture { ptexture }
}
}
