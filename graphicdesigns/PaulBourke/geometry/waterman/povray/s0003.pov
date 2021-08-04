#declare RADIUS = sqrt(6);
#declare texture0 = texture {
   pigment { color rgb <0,0,1> }
   finish { specular 0.2 }
}
#declare texture1 = texture {
   pigment { color rgb <0,0.666667,1> }
   finish { specular 0.2 }
}
#declare texture2 = texture {
   pigment { color rgb <0,1,0.666667> }
   finish { specular 0.2 }
}
#declare texture3 = texture {
   pigment { color rgb <0,1,0> }
   finish { specular 0.2 }
}
#declare texture4 = texture {
   pigment { color rgb <0.666667,1,0> }
   finish { specular 0.2 }
}
#declare texture5 = texture {
   pigment { color rgb <1,0.666667,0> }
   finish { specular 0.2 }
}
#declare texture6 = texture {
   pigment { color rgb <1,0,0> }
   finish { specular 0.2 }
}
union {
sphere {
   <-1,-1,-2>, 0.707107
   texture { texture6 }
}
sphere {
   <1,-1,-2>, 0.707107
   texture { texture6 }
}
sphere {
   <0,0,-2>, 0.707107
   texture { texture4 }
}
sphere {
   <-1,1,-2>, 0.707107
   texture { texture6 }
}
sphere {
   <1,1,-2>, 0.707107
   texture { texture6 }
}
sphere {
   <-1,-2,-1>, 0.707107
   texture { texture6 }
}
sphere {
   <1,-2,-1>, 0.707107
   texture { texture6 }
}
sphere {
   <-2,-1,-1>, 0.707107
   texture { texture6 }
}
sphere {
   <0,-1,-1>, 0.707107
   texture { texture2 }
}
sphere {
   <2,-1,-1>, 0.707107
   texture { texture6 }
}
sphere {
   <-1,0,-1>, 0.707107
   texture { texture2 }
}
sphere {
   <1,0,-1>, 0.707107
   texture { texture2 }
}
sphere {
   <-2,1,-1>, 0.707107
   texture { texture6 }
}
sphere {
   <0,1,-1>, 0.707107
   texture { texture2 }
}
sphere {
   <2,1,-1>, 0.707107
   texture { texture6 }
}
sphere {
   <-1,2,-1>, 0.707107
   texture { texture6 }
}
sphere {
   <1,2,-1>, 0.707107
   texture { texture6 }
}
sphere {
   <0,-2,0>, 0.707107
   texture { texture4 }
}
sphere {
   <-1,-1,0>, 0.707107
   texture { texture2 }
}
sphere {
   <1,-1,0>, 0.707107
   texture { texture2 }
}
sphere {
   <-2,0,0>, 0.707107
   texture { texture4 }
}
sphere {
   <0,0,0>, 0.707107
   texture { texture0 }
}
sphere {
   <2,0,0>, 0.707107
   texture { texture4 }
}
sphere {
   <-1,1,0>, 0.707107
   texture { texture2 }
}
sphere {
   <1,1,0>, 0.707107
   texture { texture2 }
}
sphere {
   <0,2,0>, 0.707107
   texture { texture4 }
}
sphere {
   <-1,-2,1>, 0.707107
   texture { texture6 }
}
sphere {
   <1,-2,1>, 0.707107
   texture { texture6 }
}
sphere {
   <-2,-1,1>, 0.707107
   texture { texture6 }
}
sphere {
   <0,-1,1>, 0.707107
   texture { texture2 }
}
sphere {
   <2,-1,1>, 0.707107
   texture { texture6 }
}
sphere {
   <-1,0,1>, 0.707107
   texture { texture2 }
}
sphere {
   <1,0,1>, 0.707107
   texture { texture2 }
}
sphere {
   <-2,1,1>, 0.707107
   texture { texture6 }
}
sphere {
   <0,1,1>, 0.707107
   texture { texture2 }
}
sphere {
   <2,1,1>, 0.707107
   texture { texture6 }
}
sphere {
   <-1,2,1>, 0.707107
   texture { texture6 }
}
sphere {
   <1,2,1>, 0.707107
   texture { texture6 }
}
sphere {
   <-1,-1,2>, 0.707107
   texture { texture6 }
}
sphere {
   <1,-1,2>, 0.707107
   texture { texture6 }
}
sphere {
   <0,0,2>, 0.707107
   texture { texture4 }
}
sphere {
   <-1,1,2>, 0.707107
   texture { texture6 }
}
sphere {
   <1,1,2>, 0.707107
   texture { texture6 }
}
}
