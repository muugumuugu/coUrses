#declare RADIUS = sqrt(26);
#declare ptexture = texture {
   pigment { color rgb <1.0,0.5,0.5> }
}
union {
polygon {
   3,
   <-1,5,0>,
   <-3,4,1>,
   <-3,4,-1>
   texture { ptexture }
}
polygon {
   4,
   <1,5,0>,
   <0,5,-1>,
   <1,4,-3>,
   <3,4,-1>
   texture { ptexture }
}
polygon {
   4,
   <0,-5,1>,
   <-1,-5,0>,
   <-3,-4,1>,
   <-1,-4,3>
   texture { ptexture }
}
polygon {
   3,
   <1,-3,4>,
   <-1,-3,4>,
   <0,-1,5>
   texture { ptexture }
}
polygon {
   3,
   <-1,-5,0>,
   <-3,-4,-1>,
   <-3,-4,1>
   texture { ptexture }
}
polygon {
   3,
   <-5,0,1>,
   <-4,1,3>,
   <-4,-1,3>
   texture { ptexture }
}
polygon {
   4,
   <-4,1,3>,
   <-3,1,4>,
   <-3,-1,4>,
   <-4,-1,3>
   texture { ptexture }
}
polygon {
   4,
   <-4,1,3>,
   <-5,0,1>,
   <-5,1,0>,
   <-4,3,1>
   texture { ptexture }
}
polygon {
   6,
   <-4,-3,1>,
   <-4,-1,3>,
   <-3,-1,4>,
   <-1,-3,4>,
   <-1,-4,3>,
   <-3,-4,1>
   texture { ptexture }
}
polygon {
   4,
   <-4,-3,1>,
   <-3,-4,1>,
   <-3,-4,-1>,
   <-4,-3,-1>
   texture { ptexture }
}
polygon {
   3,
   <4,-3,1>,
   <5,-1,0>,
   <4,-3,-1>
   texture { ptexture }
}
polygon {
   3,
   <1,0,-5>,
   <3,-1,-4>,
   <3,1,-4>
   texture { ptexture }
}
polygon {
   3,
   <-1,-3,-4>,
   <1,-3,-4>,
   <0,-1,-5>
   texture { ptexture }
}
polygon {
   4,
   <0,-1,-5>,
   <1,-3,-4>,
   <3,-1,-4>,
   <1,0,-5>
   texture { ptexture }
}
polygon {
   4,
   <4,-3,-1>,
   <5,-1,0>,
   <5,0,-1>,
   <4,-1,-3>
   texture { ptexture }
}
polygon {
   3,
   <-4,-1,-3>,
   <-4,1,-3>,
   <-5,0,-1>
   texture { ptexture }
}
polygon {
   4,
   <-3,1,-4>,
   <-4,1,-3>,
   <-4,-1,-3>,
   <-3,-1,-4>
   texture { ptexture }
}
polygon {
   3,
   <-5,1,0>,
   <-4,3,-1>,
   <-4,3,1>
   texture { ptexture }
}
polygon {
   4,
   <-4,3,-1>,
   <-3,4,-1>,
   <-3,4,1>,
   <-4,3,1>
   texture { ptexture }
}
polygon {
   4,
   <-5,1,0>,
   <-5,0,-1>,
   <-4,1,-3>,
   <-4,3,-1>
   texture { ptexture }
}
polygon {
   3,
   <4,3,-1>,
   <5,1,0>,
   <4,3,1>
   texture { ptexture }
}
polygon {
   3,
   <0,1,5>,
   <-1,3,4>,
   <1,3,4>
   texture { ptexture }
}
polygon {
   6,
   <-3,4,1>,
   <-1,4,3>,
   <-1,3,4>,
   <-3,1,4>,
   <-4,1,3>,
   <-4,3,1>
   texture { ptexture }
}
polygon {
   3,
   <3,4,1>,
   <1,5,0>,
   <3,4,-1>
   texture { ptexture }
}
polygon {
   4,
   <4,3,1>,
   <3,4,1>,
   <3,4,-1>,
   <4,3,-1>
   texture { ptexture }
}
polygon {
   3,
   <-1,0,5>,
   <-3,-1,4>,
   <-3,1,4>
   texture { ptexture }
}
polygon {
   4,
   <0,1,5>,
   <-1,0,5>,
   <-3,1,4>,
   <-1,3,4>
   texture { ptexture }
}
polygon {
   4,
   <-3,-1,4>,
   <-1,0,5>,
   <0,-1,5>,
   <-1,-3,4>
   texture { ptexture }
}
polygon {
   3,
   <1,-4,3>,
   <0,-5,1>,
   <-1,-4,3>
   texture { ptexture }
}
polygon {
   6,
   <3,-4,1>,
   <1,-4,3>,
   <1,-3,4>,
   <3,-1,4>,
   <4,-1,3>,
   <4,-3,1>
   texture { ptexture }
}
polygon {
   4,
   <1,-3,4>,
   <1,-4,3>,
   <-1,-4,3>,
   <-1,-3,4>
   texture { ptexture }
}
polygon {
   4,
   <1,-5,0>,
   <0,-5,-1>,
   <-1,-5,0>,
   <0,-5,1>
   texture { ptexture }
}
polygon {
   4,
   <1,-5,0>,
   <0,-5,1>,
   <1,-4,3>,
   <3,-4,1>
   texture { ptexture }
}
polygon {
   4,
   <3,1,4>,
   <4,1,3>,
   <4,-1,3>,
   <3,-1,4>
   texture { ptexture }
}
polygon {
   6,
   <-4,-3,-1>,
   <-3,-4,-1>,
   <-1,-4,-3>,
   <-1,-3,-4>,
   <-3,-1,-4>,
   <-4,-1,-3>
   texture { ptexture }
}
polygon {
   4,
   <-1,-4,-3>,
   <-3,-4,-1>,
   <-1,-5,0>,
   <0,-5,-1>
   texture { ptexture }
}
polygon {
   3,
   <-5,-1,0>,
   <-4,-3,1>,
   <-4,-3,-1>
   texture { ptexture }
}
polygon {
   4,
   <-5,0,-1>,
   <-5,-1,0>,
   <-4,-3,-1>,
   <-4,-1,-3>
   texture { ptexture }
}
polygon {
   4,
   <-5,-1,0>,
   <-5,0,-1>,
   <-5,1,0>,
   <-5,0,1>
   texture { ptexture }
}
polygon {
   4,
   <-5,-1,0>,
   <-5,0,1>,
   <-4,-1,3>,
   <-4,-3,1>
   texture { ptexture }
}
polygon {
   3,
   <4,1,3>,
   <5,0,1>,
   <4,-1,3>
   texture { ptexture }
}
polygon {
   4,
   <5,1,0>,
   <5,0,1>,
   <4,1,3>,
   <4,3,1>
   texture { ptexture }
}
polygon {
   4,
   <5,0,1>,
   <5,-1,0>,
   <4,-3,1>,
   <4,-1,3>
   texture { ptexture }
}
polygon {
   4,
   <5,-1,0>,
   <5,0,1>,
   <5,1,0>,
   <5,0,-1>
   texture { ptexture }
}
polygon {
   3,
   <-3,-1,-4>,
   <-1,0,-5>,
   <-3,1,-4>
   texture { ptexture }
}
polygon {
   4,
   <0,-1,-5>,
   <-1,0,-5>,
   <-3,-1,-4>,
   <-1,-3,-4>
   texture { ptexture }
}
polygon {
   3,
   <4,1,-3>,
   <4,-1,-3>,
   <5,0,-1>
   texture { ptexture }
}
polygon {
   6,
   <3,4,-1>,
   <1,4,-3>,
   <1,3,-4>,
   <3,1,-4>,
   <4,1,-3>,
   <4,3,-1>
   texture { ptexture }
}
polygon {
   4,
   <4,1,-3>,
   <5,0,-1>,
   <5,1,0>,
   <4,3,-1>
   texture { ptexture }
}
polygon {
   4,
   <4,1,-3>,
   <3,1,-4>,
   <3,-1,-4>,
   <4,-1,-3>
   texture { ptexture }
}
polygon {
   3,
   <-1,4,-3>,
   <1,4,-3>,
   <0,5,-1>
   texture { ptexture }
}
polygon {
   4,
   <0,5,-1>,
   <-1,5,0>,
   <-3,4,-1>,
   <-1,4,-3>
   texture { ptexture }
}
polygon {
   6,
   <1,3,4>,
   <1,4,3>,
   <3,4,1>,
   <4,3,1>,
   <4,1,3>,
   <3,1,4>
   texture { ptexture }
}
polygon {
   4,
   <1,4,3>,
   <1,3,4>,
   <-1,3,4>,
   <-1,4,3>
   texture { ptexture }
}
polygon {
   3,
   <1,0,5>,
   <3,1,4>,
   <3,-1,4>
   texture { ptexture }
}
polygon {
   4,
   <1,0,5>,
   <0,-1,5>,
   <-1,0,5>,
   <0,1,5>
   texture { ptexture }
}
polygon {
   4,
   <0,-1,5>,
   <1,0,5>,
   <3,-1,4>,
   <1,-3,4>
   texture { ptexture }
}
polygon {
   4,
   <1,0,5>,
   <0,1,5>,
   <1,3,4>,
   <3,1,4>
   texture { ptexture }
}
polygon {
   4,
   <0,1,-5>,
   <-1,0,-5>,
   <0,-1,-5>,
   <1,0,-5>
   texture { ptexture }
}
polygon {
   4,
   <0,1,-5>,
   <1,0,-5>,
   <3,1,-4>,
   <1,3,-4>
   texture { ptexture }
}
polygon {
   3,
   <0,5,1>,
   <1,4,3>,
   <-1,4,3>
   texture { ptexture }
}
polygon {
   4,
   <-1,5,0>,
   <0,5,1>,
   <-1,4,3>,
   <-3,4,1>
   texture { ptexture }
}
polygon {
   4,
   <0,5,1>,
   <-1,5,0>,
   <0,5,-1>,
   <1,5,0>
   texture { ptexture }
}
polygon {
   4,
   <0,5,1>,
   <1,5,0>,
   <3,4,1>,
   <1,4,3>
   texture { ptexture }
}
polygon {
   3,
   <1,-4,-3>,
   <-1,-4,-3>,
   <0,-5,-1>
   texture { ptexture }
}
polygon {
   4,
   <1,-4,-3>,
   <1,-3,-4>,
   <-1,-3,-4>,
   <-1,-4,-3>
   texture { ptexture }
}
polygon {
   3,
   <3,-4,-1>,
   <1,-5,0>,
   <3,-4,1>
   texture { ptexture }
}
polygon {
   6,
   <1,-4,-3>,
   <3,-4,-1>,
   <4,-3,-1>,
   <4,-1,-3>,
   <3,-1,-4>,
   <1,-3,-4>
   texture { ptexture }
}
polygon {
   4,
   <4,-3,-1>,
   <3,-4,-1>,
   <3,-4,1>,
   <4,-3,1>
   texture { ptexture }
}
polygon {
   4,
   <3,-4,-1>,
   <1,-4,-3>,
   <0,-5,-1>,
   <1,-5,0>
   texture { ptexture }
}
polygon {
   3,
   <-1,3,-4>,
   <0,1,-5>,
   <1,3,-4>
   texture { ptexture }
}
polygon {
   4,
   <-1,3,-4>,
   <-3,1,-4>,
   <-1,0,-5>,
   <0,1,-5>
   texture { ptexture }
}
polygon {
   4,
   <-1,4,-3>,
   <-1,3,-4>,
   <1,3,-4>,
   <1,4,-3>
   texture { ptexture }
}
polygon {
   6,
   <-4,3,-1>,
   <-4,1,-3>,
   <-3,1,-4>,
   <-1,3,-4>,
   <-1,4,-3>,
   <-3,4,-1>
   texture { ptexture }
}
}
