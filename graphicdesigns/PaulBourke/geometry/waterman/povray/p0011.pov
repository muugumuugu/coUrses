#declare RADIUS = sqrt(20);
#declare ptexture = texture {
   pigment { color rgb <1.0,0.5,0.5> }
}
union {
polygon {
   4,
   <-3,-3,2>,
   <-2,-4,0>,
   <-3,-3,-2>,
   <-4,-2,0>
   texture { ptexture }
}
polygon {
   4,
   <-2,-4,0>,
   <0,-4,-2>,
   <-2,-3,-3>,
   <-3,-3,-2>
   texture { ptexture }
}
polygon {
   4,
   <0,-4,2>,
   <2,-4,0>,
   <0,-4,-2>,
   <-2,-4,0>
   texture { ptexture }
}
polygon {
   4,
   <3,-3,-2>,
   <2,-4,0>,
   <3,-3,2>,
   <4,-2,0>
   texture { ptexture }
}
polygon {
   4,
   <2,-4,0>,
   <0,-4,2>,
   <2,-3,3>,
   <3,-3,2>
   texture { ptexture }
}
polygon {
   4,
   <3,-2,-3>,
   <3,-3,-2>,
   <4,-2,0>,
   <4,0,-2>
   texture { ptexture }
}
polygon {
   4,
   <2,0,-4>,
   <3,-2,-3>,
   <4,0,-2>,
   <3,2,-3>
   texture { ptexture }
}
polygon {
   3,
   <-2,-3,-3>,
   <-3,-2,-3>,
   <-3,-3,-2>
   texture { ptexture }
}
polygon {
   4,
   <-3,-2,-3>,
   <-4,0,-2>,
   <-4,-2,0>,
   <-3,-3,-2>
   texture { ptexture }
}
polygon {
   3,
   <-3,-2,3>,
   <-2,-3,3>,
   <-3,-3,2>
   texture { ptexture }
}
polygon {
   4,
   <-3,-3,2>,
   <-2,-3,3>,
   <0,-4,2>,
   <-2,-4,0>
   texture { ptexture }
}
polygon {
   4,
   <-2,-3,3>,
   <0,-2,4>,
   <2,-3,3>,
   <0,-4,2>
   texture { ptexture }
}
polygon {
   4,
   <-2,-3,3>,
   <-3,-2,3>,
   <-2,0,4>,
   <0,-2,4>
   texture { ptexture }
}
polygon {
   4,
   <-4,2,0>,
   <-3,3,-2>,
   <-2,4,0>,
   <-3,3,2>
   texture { ptexture }
}
polygon {
   3,
   <3,-2,-3>,
   <2,-3,-3>,
   <3,-3,-2>
   texture { ptexture }
}
polygon {
   4,
   <2,-3,-3>,
   <0,-2,-4>,
   <-2,-3,-3>,
   <0,-4,-2>
   texture { ptexture }
}
polygon {
   4,
   <3,-3,-2>,
   <2,-3,-3>,
   <0,-4,-2>,
   <2,-4,0>
   texture { ptexture }
}
polygon {
   4,
   <0,-2,-4>,
   <2,-3,-3>,
   <3,-2,-3>,
   <2,0,-4>
   texture { ptexture }
}
polygon {
   4,
   <-3,3,-2>,
   <-2,3,-3>,
   <0,4,-2>,
   <-2,4,0>
   texture { ptexture }
}
polygon {
   4,
   <0,2,-4>,
   <2,3,-3>,
   <0,4,-2>,
   <-2,3,-3>
   texture { ptexture }
}
polygon {
   4,
   <2,3,-3>,
   <0,2,-4>,
   <2,0,-4>,
   <3,2,-3>
   texture { ptexture }
}
polygon {
   4,
   <-4,-2,0>,
   <-4,0,2>,
   <-3,-2,3>,
   <-3,-3,2>
   texture { ptexture }
}
polygon {
   4,
   <-4,0,-2>,
   <-4,2,0>,
   <-4,0,2>,
   <-4,-2,0>
   texture { ptexture }
}
polygon {
   4,
   <-3,3,2>,
   <-3,2,3>,
   <-4,0,2>,
   <-4,2,0>
   texture { ptexture }
}
polygon {
   4,
   <-4,0,2>,
   <-3,2,3>,
   <-2,0,4>,
   <-3,-2,3>
   texture { ptexture }
}
polygon {
   4,
   <-2,0,-4>,
   <0,-2,-4>,
   <2,0,-4>,
   <0,2,-4>
   texture { ptexture }
}
polygon {
   4,
   <-2,0,-4>,
   <-3,-2,-3>,
   <-2,-3,-3>,
   <0,-2,-4>
   texture { ptexture }
}
polygon {
   3,
   <3,3,-2>,
   <2,3,-3>,
   <3,2,-3>
   texture { ptexture }
}
polygon {
   3,
   <-3,2,-3>,
   <-2,3,-3>,
   <-3,3,-2>
   texture { ptexture }
}
polygon {
   4,
   <-3,2,-3>,
   <-3,3,-2>,
   <-4,2,0>,
   <-4,0,-2>
   texture { ptexture }
}
polygon {
   4,
   <-3,2,-3>,
   <-4,0,-2>,
   <-3,-2,-3>,
   <-2,0,-4>
   texture { ptexture }
}
polygon {
   4,
   <-3,2,-3>,
   <-2,0,-4>,
   <0,2,-4>,
   <-2,3,-3>
   texture { ptexture }
}
polygon {
   3,
   <2,-3,3>,
   <3,-2,3>,
   <3,-3,2>
   texture { ptexture }
}
polygon {
   3,
   <-2,3,3>,
   <-3,2,3>,
   <-3,3,2>
   texture { ptexture }
}
polygon {
   4,
   <-2,3,3>,
   <0,2,4>,
   <-2,0,4>,
   <-3,2,3>
   texture { ptexture }
}
polygon {
   4,
   <3,3,-2>,
   <2,4,0>,
   <0,4,-2>,
   <2,3,-3>
   texture { ptexture }
}
polygon {
   4,
   <0,2,4>,
   <2,0,4>,
   <0,-2,4>,
   <-2,0,4>
   texture { ptexture }
}
polygon {
   4,
   <2,0,4>,
   <3,-2,3>,
   <2,-3,3>,
   <0,-2,4>
   texture { ptexture }
}
polygon {
   3,
   <3,2,3>,
   <2,3,3>,
   <3,3,2>
   texture { ptexture }
}
polygon {
   4,
   <2,3,3>,
   <3,2,3>,
   <2,0,4>,
   <0,2,4>
   texture { ptexture }
}
polygon {
   4,
   <4,2,0>,
   <3,3,-2>,
   <3,2,-3>,
   <4,0,-2>
   texture { ptexture }
}
polygon {
   4,
   <4,2,0>,
   <3,3,2>,
   <2,4,0>,
   <3,3,-2>
   texture { ptexture }
}
polygon {
   4,
   <2,4,0>,
   <0,4,2>,
   <-2,4,0>,
   <0,4,-2>
   texture { ptexture }
}
polygon {
   4,
   <0,4,2>,
   <-2,3,3>,
   <-3,3,2>,
   <-2,4,0>
   texture { ptexture }
}
polygon {
   4,
   <0,4,2>,
   <2,3,3>,
   <0,2,4>,
   <-2,3,3>
   texture { ptexture }
}
polygon {
   4,
   <2,3,3>,
   <0,4,2>,
   <2,4,0>,
   <3,3,2>
   texture { ptexture }
}
polygon {
   4,
   <3,2,3>,
   <3,3,2>,
   <4,2,0>,
   <4,0,2>
   texture { ptexture }
}
polygon {
   4,
   <3,2,3>,
   <4,0,2>,
   <3,-2,3>,
   <2,0,4>
   texture { ptexture }
}
polygon {
   4,
   <4,0,2>,
   <4,2,0>,
   <4,0,-2>,
   <4,-2,0>
   texture { ptexture }
}
polygon {
   4,
   <3,-2,3>,
   <4,0,2>,
   <4,-2,0>,
   <3,-3,2>
   texture { ptexture }
}
}
