#declare RADIUS = sqrt(10);
#declare ptexture = texture {
   pigment { color rgb <1.0,0.5,0.5> }
}
union {
polygon {
   4,
   <0,-3,1>,
   <1,-3,0>,
   <0,-3,-1>,
   <-1,-3,0>
   texture { ptexture }
}
polygon {
   6,
   <1,-3,0>,
   <3,-1,0>,
   <3,0,-1>,
   <1,0,-3>,
   <0,-1,-3>,
   <0,-3,-1>
   texture { ptexture }
}
polygon {
   4,
   <1,3,0>,
   <0,3,1>,
   <-1,3,0>,
   <0,3,-1>
   texture { ptexture }
}
polygon {
   6,
   <0,-1,-3>,
   <-1,0,-3>,
   <-3,0,-1>,
   <-3,-1,0>,
   <-1,-3,0>,
   <0,-3,-1>
   texture { ptexture }
}
polygon {
   4,
   <-3,1,0>,
   <-3,0,1>,
   <-3,-1,0>,
   <-3,0,-1>
   texture { ptexture }
}
polygon {
   4,
   <3,0,1>,
   <3,1,0>,
   <3,0,-1>,
   <3,-1,0>
   texture { ptexture }
}
polygon {
   6,
   <3,1,0>,
   <1,3,0>,
   <0,3,-1>,
   <0,1,-3>,
   <1,0,-3>,
   <3,0,-1>
   texture { ptexture }
}
polygon {
   6,
   <-3,0,-1>,
   <-1,0,-3>,
   <0,1,-3>,
   <0,3,-1>,
   <-1,3,0>,
   <-3,1,0>
   texture { ptexture }
}
polygon {
   4,
   <0,1,-3>,
   <-1,0,-3>,
   <0,-1,-3>,
   <1,0,-3>
   texture { ptexture }
}
polygon {
   6,
   <0,3,1>,
   <0,1,3>,
   <-1,0,3>,
   <-3,0,1>,
   <-3,1,0>,
   <-1,3,0>
   texture { ptexture }
}
polygon {
   6,
   <-3,0,1>,
   <-1,0,3>,
   <0,-1,3>,
   <0,-3,1>,
   <-1,-3,0>,
   <-3,-1,0>
   texture { ptexture }
}
polygon {
   6,
   <0,-3,1>,
   <0,-1,3>,
   <1,0,3>,
   <3,0,1>,
   <3,-1,0>,
   <1,-3,0>
   texture { ptexture }
}
polygon {
   6,
   <1,3,0>,
   <3,1,0>,
   <3,0,1>,
   <1,0,3>,
   <0,1,3>,
   <0,3,1>
   texture { ptexture }
}
polygon {
   4,
   <1,0,3>,
   <0,-1,3>,
   <-1,0,3>,
   <0,1,3>
   texture { ptexture }
}
}
