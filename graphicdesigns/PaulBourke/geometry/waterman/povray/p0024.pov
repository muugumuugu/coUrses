#declare RADIUS = sqrt(46);
#declare ptexture = texture {
   pigment { color rgb <1.0,0.5,0.5> }
}
union {
polygon {
   3,
   <-3,6,-1>,
   <-4,4,-4>,
   <-1,6,-3>
   texture { ptexture }
}
polygon {
   3,
   <1,6,-3>,
   <4,4,-4>,
   <3,6,-1>
   texture { ptexture }
}
polygon {
   3,
   <4,4,-4>,
   <6,3,-1>,
   <3,6,-1>
   texture { ptexture }
}
polygon {
   3,
   <-3,6,-1>,
   <-6,3,-1>,
   <-4,4,-4>
   texture { ptexture }
}
polygon {
   3,
   <-4,4,-4>,
   <-6,3,-1>,
   <-6,1,-3>
   texture { ptexture }
}
polygon {
   3,
   <4,4,-4>,
   <6,1,-3>,
   <6,3,-1>
   texture { ptexture }
}
polygon {
   3,
   <3,1,-6>,
   <6,1,-3>,
   <4,4,-4>
   texture { ptexture }
}
polygon {
   4,
   <6,1,-3>,
   <3,1,-6>,
   <3,-1,-6>,
   <6,-1,-3>
   texture { ptexture }
}
polygon {
   3,
   <1,3,-6>,
   <4,4,-4>,
   <1,6,-3>
   texture { ptexture }
}
polygon {
   3,
   <4,4,-4>,
   <1,3,-6>,
   <3,1,-6>
   texture { ptexture }
}
polygon {
   3,
   <-1,-6,3>,
   <-4,-4,4>,
   <-1,-3,6>
   texture { ptexture }
}
polygon {
   3,
   <4,-4,4>,
   <3,-1,6>,
   <6,-1,3>
   texture { ptexture }
}
polygon {
   3,
   <6,-3,1>,
   <4,-4,4>,
   <6,-1,3>
   texture { ptexture }
}
polygon {
   3,
   <-4,4,-4>,
   <-1,3,-6>,
   <-1,6,-3>
   texture { ptexture }
}
polygon {
   4,
   <-1,3,-6>,
   <1,3,-6>,
   <1,6,-3>,
   <-1,6,-3>
   texture { ptexture }
}
polygon {
   3,
   <-3,-1,-6>,
   <-4,-4,-4>,
   <-1,-3,-6>
   texture { ptexture }
}
polygon {
   3,
   <-4,-4,-4>,
   <-3,-1,-6>,
   <-6,-1,-3>
   texture { ptexture }
}
polygon {
   3,
   <1,6,3>,
   <3,6,1>,
   <4,4,4>
   texture { ptexture }
}
polygon {
   3,
   <4,4,4>,
   <3,1,6>,
   <1,3,6>
   texture { ptexture }
}
polygon {
   3,
   <4,4,4>,
   <1,3,6>,
   <1,6,3>
   texture { ptexture }
}
polygon {
   4,
   <-1,3,6>,
   <-1,6,3>,
   <1,6,3>,
   <1,3,6>
   texture { ptexture }
}
polygon {
   3,
   <-4,4,4>,
   <-1,6,3>,
   <-1,3,6>
   texture { ptexture }
}
polygon {
   4,
   <6,3,-1>,
   <6,3,1>,
   <3,6,1>,
   <3,6,-1>
   texture { ptexture }
}
polygon {
   3,
   <4,4,4>,
   <3,6,1>,
   <6,3,1>
   texture { ptexture }
}
polygon {
   8,
   <6,-1,-3>,
   <6,-3,-1>,
   <6,-3,1>,
   <6,-1,3>,
   <6,1,3>,
   <6,3,1>,
   <6,3,-1>,
   <6,1,-3>
   texture { ptexture }
}
polygon {
   4,
   <3,1,6>,
   <6,1,3>,
   <6,-1,3>,
   <3,-1,6>
   texture { ptexture }
}
polygon {
   3,
   <4,4,4>,
   <6,1,3>,
   <3,1,6>
   texture { ptexture }
}
polygon {
   3,
   <4,4,4>,
   <6,3,1>,
   <6,1,3>
   texture { ptexture }
}
polygon {
   3,
   <4,-4,4>,
   <1,-3,6>,
   <3,-1,6>
   texture { ptexture }
}
polygon {
   3,
   <3,-6,1>,
   <4,-4,4>,
   <6,-3,1>
   texture { ptexture }
}
polygon {
   4,
   <3,-6,1>,
   <6,-3,1>,
   <6,-3,-1>,
   <3,-6,-1>
   texture { ptexture }
}
polygon {
   3,
   <4,-4,-4>,
   <6,-3,-1>,
   <6,-1,-3>
   texture { ptexture }
}
polygon {
   3,
   <3,-1,-6>,
   <4,-4,-4>,
   <6,-1,-3>
   texture { ptexture }
}
polygon {
   3,
   <6,-3,-1>,
   <4,-4,-4>,
   <3,-6,-1>
   texture { ptexture }
}
polygon {
   3,
   <4,-4,-4>,
   <1,-6,-3>,
   <3,-6,-1>
   texture { ptexture }
}
polygon {
   3,
   <1,-3,-6>,
   <4,-4,-4>,
   <3,-1,-6>
   texture { ptexture }
}
polygon {
   3,
   <4,-4,-4>,
   <1,-3,-6>,
   <1,-6,-3>
   texture { ptexture }
}
polygon {
   8,
   <3,6,1>,
   <1,6,3>,
   <-1,6,3>,
   <-3,6,1>,
   <-3,6,-1>,
   <-1,6,-3>,
   <1,6,-3>,
   <3,6,-1>
   texture { ptexture }
}
polygon {
   3,
   <-4,4,4>,
   <-3,6,1>,
   <-1,6,3>
   texture { ptexture }
}
polygon {
   8,
   <-3,-1,-6>,
   <-1,-3,-6>,
   <1,-3,-6>,
   <3,-1,-6>,
   <3,1,-6>,
   <1,3,-6>,
   <-1,3,-6>,
   <-3,1,-6>
   texture { ptexture }
}
polygon {
   4,
   <-6,-1,-3>,
   <-3,-1,-6>,
   <-3,1,-6>,
   <-6,1,-3>
   texture { ptexture }
}
polygon {
   3,
   <-4,4,-4>,
   <-6,1,-3>,
   <-3,1,-6>
   texture { ptexture }
}
polygon {
   3,
   <-3,1,-6>,
   <-1,3,-6>,
   <-4,4,-4>
   texture { ptexture }
}
polygon {
   3,
   <-6,-3,-1>,
   <-4,-4,-4>,
   <-6,-1,-3>
   texture { ptexture }
}
polygon {
   3,
   <-4,-4,-4>,
   <-6,-3,-1>,
   <-3,-6,-1>
   texture { ptexture }
}
polygon {
   3,
   <-4,4,4>,
   <-1,3,6>,
   <-3,1,6>
   texture { ptexture }
}
polygon {
   3,
   <1,-6,3>,
   <1,-3,6>,
   <4,-4,4>
   texture { ptexture }
}
polygon {
   4,
   <1,-6,3>,
   <-1,-6,3>,
   <-1,-3,6>,
   <1,-3,6>
   texture { ptexture }
}
polygon {
   3,
   <4,-4,4>,
   <3,-6,1>,
   <1,-6,3>
   texture { ptexture }
}
polygon {
   3,
   <-3,-6,-1>,
   <-1,-6,-3>,
   <-4,-4,-4>
   texture { ptexture }
}
polygon {
   4,
   <-1,-3,-6>,
   <-1,-6,-3>,
   <1,-6,-3>,
   <1,-3,-6>
   texture { ptexture }
}
polygon {
   3,
   <-4,-4,-4>,
   <-1,-6,-3>,
   <-1,-3,-6>
   texture { ptexture }
}
polygon {
   3,
   <-3,-6,1>,
   <-4,-4,4>,
   <-1,-6,3>
   texture { ptexture }
}
polygon {
   8,
   <-1,-6,-3>,
   <-3,-6,-1>,
   <-3,-6,1>,
   <-1,-6,3>,
   <1,-6,3>,
   <3,-6,1>,
   <3,-6,-1>,
   <1,-6,-3>
   texture { ptexture }
}
polygon {
   8,
   <3,-1,6>,
   <1,-3,6>,
   <-1,-3,6>,
   <-3,-1,6>,
   <-3,1,6>,
   <-1,3,6>,
   <1,3,6>,
   <3,1,6>
   texture { ptexture }
}
polygon {
   3,
   <-4,-4,4>,
   <-3,-1,6>,
   <-1,-3,6>
   texture { ptexture }
}
polygon {
   3,
   <-6,1,3>,
   <-4,4,4>,
   <-3,1,6>
   texture { ptexture }
}
polygon {
   3,
   <-6,1,3>,
   <-6,3,1>,
   <-4,4,4>
   texture { ptexture }
}
polygon {
   4,
   <-6,3,-1>,
   <-3,6,-1>,
   <-3,6,1>,
   <-6,3,1>
   texture { ptexture }
}
polygon {
   3,
   <-4,4,4>,
   <-6,3,1>,
   <-3,6,1>
   texture { ptexture }
}
polygon {
   4,
   <-3,-6,-1>,
   <-6,-3,-1>,
   <-6,-3,1>,
   <-3,-6,1>
   texture { ptexture }
}
polygon {
   3,
   <-4,-4,4>,
   <-3,-6,1>,
   <-6,-3,1>
   texture { ptexture }
}
polygon {
   3,
   <-6,-3,1>,
   <-6,-1,3>,
   <-4,-4,4>
   texture { ptexture }
}
polygon {
   4,
   <-6,1,3>,
   <-3,1,6>,
   <-3,-1,6>,
   <-6,-1,3>
   texture { ptexture }
}
polygon {
   8,
   <-6,3,-1>,
   <-6,3,1>,
   <-6,1,3>,
   <-6,-1,3>,
   <-6,-3,1>,
   <-6,-3,-1>,
   <-6,-1,-3>,
   <-6,1,-3>
   texture { ptexture }
}
polygon {
   3,
   <-4,-4,4>,
   <-6,-1,3>,
   <-3,-1,6>
   texture { ptexture }
}
}
