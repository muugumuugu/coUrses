#declare RADIUS = sqrt(20);
#declare ptexture = texture {
   pigment { color rgb <1.0,0.5,0.5> }
}
union {
polygon {
   4,
   <0,-4,2>,
   <2,-4,0>,
   <0,-4,-2>,
   <-2,-4,0>
   texture { ptexture }
}
polygon {
   6,
   <0,-2,4>,
   <0,-4,2>,
   <-2,-4,0>,
   <-4,-2,0>,
   <-4,0,2>,
   <-2,0,4>
   texture { ptexture }
}
polygon {
   4,
   <-4,0,2>,
   <-4,-2,0>,
   <-4,0,-2>,
   <-4,2,0>
   texture { ptexture }
}
polygon {
   6,
   <2,-4,0>,
   <4,-2,0>,
   <4,0,-2>,
   <2,0,-4>,
   <0,-2,-4>,
   <0,-4,-2>
   texture { ptexture }
}
polygon {
   6,
   <2,0,4>,
   <4,0,2>,
   <4,-2,0>,
   <2,-4,0>,
   <0,-4,2>,
   <0,-2,4>
   texture { ptexture }
}
polygon {
   4,
   <4,-2,0>,
   <4,0,2>,
   <4,2,0>,
   <4,0,-2>
   texture { ptexture }
}
polygon {
   6,
   <0,-2,-4>,
   <-2,0,-4>,
   <-4,0,-2>,
   <-4,-2,0>,
   <-2,-4,0>,
   <0,-4,-2>
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
   6,
   <0,4,2>,
   <0,2,4>,
   <-2,0,4>,
   <-4,0,2>,
   <-4,2,0>,
   <-2,4,0>
   texture { ptexture }
}
polygon {
   6,
   <4,0,2>,
   <2,0,4>,
   <0,2,4>,
   <0,4,2>,
   <2,4,0>,
   <4,2,0>
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
   6,
   <4,2,0>,
   <2,4,0>,
   <0,4,-2>,
   <0,2,-4>,
   <2,0,-4>,
   <4,0,-2>
   texture { ptexture }
}
polygon {
   6,
   <-4,0,-2>,
   <-2,0,-4>,
   <0,2,-4>,
   <0,4,-2>,
   <-2,4,0>,
   <-4,2,0>
   texture { ptexture }
}
polygon {
   4,
   <0,2,-4>,
   <-2,0,-4>,
   <0,-2,-4>,
   <2,0,-4>
   texture { ptexture }
}
}
