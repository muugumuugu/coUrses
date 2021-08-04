#declare RADIUS = sqrt(18);
#declare ptexture = texture {
   pigment { color rgb <1.0,0.5,0.5> }
}
union {
polygon {
   3,
   <-3,0,-3>,
   <-4,1,-1>,
   <-4,-1,-1>
   texture { ptexture }
}
polygon {
   4,
   <-4,-1,-1>,
   <-4,1,-1>,
   <-4,1,1>,
   <-4,-1,1>
   texture { ptexture }
}
polygon {
   3,
   <-3,0,3>,
   <-4,-1,1>,
   <-4,1,1>
   texture { ptexture }
}
polygon {
   3,
   <-4,-1,1>,
   <-3,-3,0>,
   <-4,-1,-1>
   texture { ptexture }
}
polygon {
   6,
   <-4,-1,-1>,
   <-3,-3,0>,
   <-1,-4,-1>,
   <0,-3,-3>,
   <-1,-1,-4>,
   <-3,0,-3>
   texture { ptexture }
}
polygon {
   3,
   <1,-4,-1>,
   <0,-3,-3>,
   <-1,-4,-1>
   texture { ptexture }
}
polygon {
   3,
   <-3,0,3>,
   <-1,1,4>,
   <-1,-1,4>
   texture { ptexture }
}
polygon {
   3,
   <-4,1,-1>,
   <-3,3,0>,
   <-4,1,1>
   texture { ptexture }
}
polygon {
   3,
   <0,-3,-3>,
   <1,-1,-4>,
   <-1,-1,-4>
   texture { ptexture }
}
polygon {
   3,
   <1,-1,-4>,
   <3,0,-3>,
   <1,1,-4>
   texture { ptexture }
}
polygon {
   3,
   <1,4,1>,
   <1,4,-1>,
   <3,3,0>
   texture { ptexture }
}
polygon {
   3,
   <0,3,-3>,
   <1,4,-1>,
   <-1,4,-1>
   texture { ptexture }
}
polygon {
   3,
   <-1,1,-4>,
   <-3,0,-3>,
   <-1,-1,-4>
   texture { ptexture }
}
polygon {
   3,
   <0,3,-3>,
   <-1,1,-4>,
   <1,1,-4>
   texture { ptexture }
}
polygon {
   4,
   <-1,1,-4>,
   <-1,-1,-4>,
   <1,-1,-4>,
   <1,1,-4>
   texture { ptexture }
}
polygon {
   6,
   <-3,0,-3>,
   <-1,1,-4>,
   <0,3,-3>,
   <-1,4,-1>,
   <-3,3,0>,
   <-4,1,-1>
   texture { ptexture }
}
polygon {
   3,
   <1,1,4>,
   <-1,1,4>,
   <0,3,3>
   texture { ptexture }
}
polygon {
   6,
   <3,3,0>,
   <4,1,1>,
   <3,0,3>,
   <1,1,4>,
   <0,3,3>,
   <1,4,1>
   texture { ptexture }
}
polygon {
   3,
   <-1,4,1>,
   <1,4,1>,
   <0,3,3>
   texture { ptexture }
}
polygon {
   3,
   <-1,4,1>,
   <-3,3,0>,
   <-1,4,-1>
   texture { ptexture }
}
polygon {
   6,
   <-4,1,1>,
   <-3,3,0>,
   <-1,4,1>,
   <0,3,3>,
   <-1,1,4>,
   <-3,0,3>
   texture { ptexture }
}
polygon {
   4,
   <-1,4,1>,
   <-1,4,-1>,
   <1,4,-1>,
   <1,4,1>
   texture { ptexture }
}
polygon {
   3,
   <4,1,-1>,
   <3,0,-3>,
   <4,-1,-1>
   texture { ptexture }
}
polygon {
   3,
   <4,1,-1>,
   <4,1,1>,
   <3,3,0>
   texture { ptexture }
}
polygon {
   6,
   <4,1,-1>,
   <3,3,0>,
   <1,4,-1>,
   <0,3,-3>,
   <1,1,-4>,
   <3,0,-3>
   texture { ptexture }
}
polygon {
   3,
   <3,-3,0>,
   <1,-4,-1>,
   <1,-4,1>
   texture { ptexture }
}
polygon {
   6,
   <3,-3,0>,
   <4,-1,-1>,
   <3,0,-3>,
   <1,-1,-4>,
   <0,-3,-3>,
   <1,-4,-1>
   texture { ptexture }
}
polygon {
   3,
   <-3,-3,0>,
   <-1,-4,1>,
   <-1,-4,-1>
   texture { ptexture }
}
polygon {
   3,
   <-1,-4,1>,
   <0,-3,3>,
   <1,-4,1>
   texture { ptexture }
}
polygon {
   6,
   <-1,-1,4>,
   <0,-3,3>,
   <-1,-4,1>,
   <-3,-3,0>,
   <-4,-1,1>,
   <-3,0,3>
   texture { ptexture }
}
polygon {
   4,
   <-1,-4,-1>,
   <-1,-4,1>,
   <1,-4,1>,
   <1,-4,-1>
   texture { ptexture }
}
polygon {
   3,
   <1,-1,4>,
   <0,-3,3>,
   <-1,-1,4>
   texture { ptexture }
}
polygon {
   3,
   <1,-1,4>,
   <1,1,4>,
   <3,0,3>
   texture { ptexture }
}
polygon {
   4,
   <1,-1,4>,
   <-1,-1,4>,
   <-1,1,4>,
   <1,1,4>
   texture { ptexture }
}
polygon {
   3,
   <4,1,1>,
   <4,-1,1>,
   <3,0,3>
   texture { ptexture }
}
polygon {
   3,
   <3,-3,0>,
   <4,-1,1>,
   <4,-1,-1>
   texture { ptexture }
}
polygon {
   4,
   <4,-1,-1>,
   <4,-1,1>,
   <4,1,1>,
   <4,1,-1>
   texture { ptexture }
}
polygon {
   6,
   <0,-3,3>,
   <1,-1,4>,
   <3,0,3>,
   <4,-1,1>,
   <3,-3,0>,
   <1,-4,1>
   texture { ptexture }
}
}
