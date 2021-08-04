#declare RADIUS = sqrt(24);
#declare ptexture = texture {
   pigment { color rgb <1.0,0.5,0.5> }
}
union {
polygon {
   4,
   <-4,2,-2>,
   <-4,2,2>,
   <-4,-2,2>,
   <-4,-2,-2>
   texture { ptexture }
}
polygon {
   4,
   <-2,4,-2>,
   <-2,4,2>,
   <-4,2,2>,
   <-4,2,-2>
   texture { ptexture }
}
polygon {
   4,
   <-2,2,-4>,
   <-4,2,-2>,
   <-4,-2,-2>,
   <-2,-2,-4>
   texture { ptexture }
}
polygon {
   4,
   <2,2,-4>,
   <-2,2,-4>,
   <-2,-2,-4>,
   <2,-2,-4>
   texture { ptexture }
}
polygon {
   3,
   <-2,4,-2>,
   <-4,2,-2>,
   <-2,2,-4>
   texture { ptexture }
}
polygon {
   4,
   <4,-2,-2>,
   <4,2,-2>,
   <2,2,-4>,
   <2,-2,-4>
   texture { ptexture }
}
polygon {
   4,
   <4,2,2>,
   <4,2,-2>,
   <4,-2,-2>,
   <4,-2,2>
   texture { ptexture }
}
polygon {
   3,
   <-2,-4,-2>,
   <-2,-2,-4>,
   <-4,-2,-2>
   texture { ptexture }
}
polygon {
   4,
   <2,4,2>,
   <2,4,-2>,
   <4,2,-2>,
   <4,2,2>
   texture { ptexture }
}
polygon {
   3,
   <4,2,-2>,
   <2,4,-2>,
   <2,2,-4>
   texture { ptexture }
}
polygon {
   4,
   <2,4,-2>,
   <-2,4,-2>,
   <-2,2,-4>,
   <2,2,-4>
   texture { ptexture }
}
polygon {
   4,
   <2,4,-2>,
   <2,4,2>,
   <-2,4,2>,
   <-2,4,-2>
   texture { ptexture }
}
polygon {
   3,
   <-2,4,2>,
   <-2,2,4>,
   <-4,2,2>
   texture { ptexture }
}
polygon {
   4,
   <-4,2,2>,
   <-2,2,4>,
   <-2,-2,4>,
   <-4,-2,2>
   texture { ptexture }
}
polygon {
   3,
   <2,-4,2>,
   <2,-2,4>,
   <4,-2,2>
   texture { ptexture }
}
polygon {
   3,
   <2,2,4>,
   <2,4,2>,
   <4,2,2>
   texture { ptexture }
}
polygon {
   4,
   <2,-2,4>,
   <2,2,4>,
   <4,2,2>,
   <4,-2,2>
   texture { ptexture }
}
polygon {
   4,
   <-2,2,4>,
   <2,2,4>,
   <2,-2,4>,
   <-2,-2,4>
   texture { ptexture }
}
polygon {
   4,
   <2,2,4>,
   <-2,2,4>,
   <-2,4,2>,
   <2,4,2>
   texture { ptexture }
}
polygon {
   3,
   <2,-2,-4>,
   <2,-4,-2>,
   <4,-2,-2>
   texture { ptexture }
}
polygon {
   4,
   <-2,-4,-2>,
   <2,-4,-2>,
   <2,-2,-4>,
   <-2,-2,-4>
   texture { ptexture }
}
polygon {
   4,
   <2,-4,-2>,
   <2,-4,2>,
   <4,-2,2>,
   <4,-2,-2>
   texture { ptexture }
}
polygon {
   3,
   <-2,-4,2>,
   <-4,-2,2>,
   <-2,-2,4>
   texture { ptexture }
}
polygon {
   4,
   <-2,-4,-2>,
   <-2,-4,2>,
   <2,-4,2>,
   <2,-4,-2>
   texture { ptexture }
}
polygon {
   4,
   <-2,-4,2>,
   <-2,-4,-2>,
   <-4,-2,-2>,
   <-4,-2,2>
   texture { ptexture }
}
polygon {
   4,
   <2,-4,2>,
   <-2,-4,2>,
   <-2,-2,4>,
   <2,-2,4>
   texture { ptexture }
}
}
