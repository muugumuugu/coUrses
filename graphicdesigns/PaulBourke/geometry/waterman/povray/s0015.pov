#declare RADIUS = sqrt(30);
#declare texture0 = texture {
   pigment { color rgb <0,0,1> }
   finish { specular 0.2 }
}
#declare texture1 = texture {
   pigment { color rgb <0,0.133333,1> }
   finish { specular 0.2 }
}
#declare texture2 = texture {
   pigment { color rgb <0,0.266667,1> }
   finish { specular 0.2 }
}
#declare texture3 = texture {
   pigment { color rgb <0,0.4,1> }
   finish { specular 0.2 }
}
#declare texture4 = texture {
   pigment { color rgb <0,0.533333,1> }
   finish { specular 0.2 }
}
#declare texture5 = texture {
   pigment { color rgb <0,0.666667,1> }
   finish { specular 0.2 }
}
#declare texture6 = texture {
   pigment { color rgb <0,0.8,1> }
   finish { specular 0.2 }
}
#declare texture7 = texture {
   pigment { color rgb <0,0.933333,1> }
   finish { specular 0.2 }
}
#declare texture8 = texture {
   pigment { color rgb <0,1,0.933333> }
   finish { specular 0.2 }
}
#declare texture9 = texture {
   pigment { color rgb <0,1,0.8> }
   finish { specular 0.2 }
}
#declare texture10 = texture {
   pigment { color rgb <0,1,0.666667> }
   finish { specular 0.2 }
}
#declare texture11 = texture {
   pigment { color rgb <0,1,0.533333> }
   finish { specular 0.2 }
}
#declare texture12 = texture {
   pigment { color rgb <0,1,0.4> }
   finish { specular 0.2 }
}
#declare texture13 = texture {
   pigment { color rgb <0,1,0.266667> }
   finish { specular 0.2 }
}
#declare texture14 = texture {
   pigment { color rgb <0,1,0.133333> }
   finish { specular 0.2 }
}
#declare texture15 = texture {
   pigment { color rgb <0,1,0> }
   finish { specular 0.2 }
}
#declare texture16 = texture {
   pigment { color rgb <0.133333,1,0> }
   finish { specular 0.2 }
}
#declare texture17 = texture {
   pigment { color rgb <0.266667,1,0> }
   finish { specular 0.2 }
}
#declare texture18 = texture {
   pigment { color rgb <0.4,1,0> }
   finish { specular 0.2 }
}
#declare texture19 = texture {
   pigment { color rgb <0.533333,1,0> }
   finish { specular 0.2 }
}
#declare texture20 = texture {
   pigment { color rgb <0.666667,1,0> }
   finish { specular 0.2 }
}
#declare texture21 = texture {
   pigment { color rgb <0.8,1,0> }
   finish { specular 0.2 }
}
#declare texture22 = texture {
   pigment { color rgb <0.933333,1,0> }
   finish { specular 0.2 }
}
#declare texture23 = texture {
   pigment { color rgb <1,0.933333,0> }
   finish { specular 0.2 }
}
#declare texture24 = texture {
   pigment { color rgb <1,0.8,0> }
   finish { specular 0.2 }
}
#declare texture25 = texture {
   pigment { color rgb <1,0.666667,0> }
   finish { specular 0.2 }
}
#declare texture26 = texture {
   pigment { color rgb <1,0.533333,0> }
   finish { specular 0.2 }
}
#declare texture27 = texture {
   pigment { color rgb <1,0.4,0> }
   finish { specular 0.2 }
}
#declare texture28 = texture {
   pigment { color rgb <1,0.266667,0> }
   finish { specular 0.2 }
}
#declare texture29 = texture {
   pigment { color rgb <1,0.133333,0> }
   finish { specular 0.2 }
}
#declare texture30 = texture {
   pigment { color rgb <1,0,0> }
   finish { specular 0.2 }
}
union {
sphere {
   <-1,-2,-5>, 0.707107
   texture { texture30 }
}
sphere {
   <1,-2,-5>, 0.707107
   texture { texture30 }
}
sphere {
   <-2,-1,-5>, 0.707107
   texture { texture30 }
}
sphere {
   <0,-1,-5>, 0.707107
   texture { texture26 }
}
sphere {
   <2,-1,-5>, 0.707107
   texture { texture30 }
}
sphere {
   <-1,0,-5>, 0.707107
   texture { texture26 }
}
sphere {
   <1,0,-5>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,1,-5>, 0.707107
   texture { texture30 }
}
sphere {
   <0,1,-5>, 0.707107
   texture { texture26 }
}
sphere {
   <2,1,-5>, 0.707107
   texture { texture30 }
}
sphere {
   <-1,2,-5>, 0.707107
   texture { texture30 }
}
sphere {
   <1,2,-5>, 0.707107
   texture { texture30 }
}
sphere {
   <-1,-3,-4>, 0.707107
   texture { texture26 }
}
sphere {
   <1,-3,-4>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,-2,-4>, 0.707107
   texture { texture24 }
}
sphere {
   <0,-2,-4>, 0.707107
   texture { texture20 }
}
sphere {
   <2,-2,-4>, 0.707107
   texture { texture24 }
}
sphere {
   <-3,-1,-4>, 0.707107
   texture { texture26 }
}
sphere {
   <-1,-1,-4>, 0.707107
   texture { texture18 }
}
sphere {
   <1,-1,-4>, 0.707107
   texture { texture18 }
}
sphere {
   <3,-1,-4>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,0,-4>, 0.707107
   texture { texture20 }
}
sphere {
   <0,0,-4>, 0.707107
   texture { texture16 }
}
sphere {
   <2,0,-4>, 0.707107
   texture { texture20 }
}
sphere {
   <-3,1,-4>, 0.707107
   texture { texture26 }
}
sphere {
   <-1,1,-4>, 0.707107
   texture { texture18 }
}
sphere {
   <1,1,-4>, 0.707107
   texture { texture18 }
}
sphere {
   <3,1,-4>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,2,-4>, 0.707107
   texture { texture24 }
}
sphere {
   <0,2,-4>, 0.707107
   texture { texture20 }
}
sphere {
   <2,2,-4>, 0.707107
   texture { texture24 }
}
sphere {
   <-1,3,-4>, 0.707107
   texture { texture26 }
}
sphere {
   <1,3,-4>, 0.707107
   texture { texture26 }
}
sphere {
   <-1,-4,-3>, 0.707107
   texture { texture26 }
}
sphere {
   <1,-4,-3>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,-3,-3>, 0.707107
   texture { texture22 }
}
sphere {
   <0,-3,-3>, 0.707107
   texture { texture18 }
}
sphere {
   <2,-3,-3>, 0.707107
   texture { texture22 }
}
sphere {
   <-3,-2,-3>, 0.707107
   texture { texture22 }
}
sphere {
   <-1,-2,-3>, 0.707107
   texture { texture14 }
}
sphere {
   <1,-2,-3>, 0.707107
   texture { texture14 }
}
sphere {
   <3,-2,-3>, 0.707107
   texture { texture22 }
}
sphere {
   <-4,-1,-3>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,-1,-3>, 0.707107
   texture { texture14 }
}
sphere {
   <0,-1,-3>, 0.707107
   texture { texture10 }
}
sphere {
   <2,-1,-3>, 0.707107
   texture { texture14 }
}
sphere {
   <4,-1,-3>, 0.707107
   texture { texture26 }
}
sphere {
   <-3,0,-3>, 0.707107
   texture { texture18 }
}
sphere {
   <-1,0,-3>, 0.707107
   texture { texture10 }
}
sphere {
   <1,0,-3>, 0.707107
   texture { texture10 }
}
sphere {
   <3,0,-3>, 0.707107
   texture { texture18 }
}
sphere {
   <-4,1,-3>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,1,-3>, 0.707107
   texture { texture14 }
}
sphere {
   <0,1,-3>, 0.707107
   texture { texture10 }
}
sphere {
   <2,1,-3>, 0.707107
   texture { texture14 }
}
sphere {
   <4,1,-3>, 0.707107
   texture { texture26 }
}
sphere {
   <-3,2,-3>, 0.707107
   texture { texture22 }
}
sphere {
   <-1,2,-3>, 0.707107
   texture { texture14 }
}
sphere {
   <1,2,-3>, 0.707107
   texture { texture14 }
}
sphere {
   <3,2,-3>, 0.707107
   texture { texture22 }
}
sphere {
   <-2,3,-3>, 0.707107
   texture { texture22 }
}
sphere {
   <0,3,-3>, 0.707107
   texture { texture18 }
}
sphere {
   <2,3,-3>, 0.707107
   texture { texture22 }
}
sphere {
   <-1,4,-3>, 0.707107
   texture { texture26 }
}
sphere {
   <1,4,-3>, 0.707107
   texture { texture26 }
}
sphere {
   <-1,-5,-2>, 0.707107
   texture { texture30 }
}
sphere {
   <1,-5,-2>, 0.707107
   texture { texture30 }
}
sphere {
   <-2,-4,-2>, 0.707107
   texture { texture24 }
}
sphere {
   <0,-4,-2>, 0.707107
   texture { texture20 }
}
sphere {
   <2,-4,-2>, 0.707107
   texture { texture24 }
}
sphere {
   <-3,-3,-2>, 0.707107
   texture { texture22 }
}
sphere {
   <-1,-3,-2>, 0.707107
   texture { texture14 }
}
sphere {
   <1,-3,-2>, 0.707107
   texture { texture14 }
}
sphere {
   <3,-3,-2>, 0.707107
   texture { texture22 }
}
sphere {
   <-4,-2,-2>, 0.707107
   texture { texture24 }
}
sphere {
   <-2,-2,-2>, 0.707107
   texture { texture12 }
}
sphere {
   <0,-2,-2>, 0.707107
   texture { texture8 }
}
sphere {
   <2,-2,-2>, 0.707107
   texture { texture12 }
}
sphere {
   <4,-2,-2>, 0.707107
   texture { texture24 }
}
sphere {
   <-5,-1,-2>, 0.707107
   texture { texture30 }
}
sphere {
   <-3,-1,-2>, 0.707107
   texture { texture14 }
}
sphere {
   <-1,-1,-2>, 0.707107
   texture { texture6 }
}
sphere {
   <1,-1,-2>, 0.707107
   texture { texture6 }
}
sphere {
   <3,-1,-2>, 0.707107
   texture { texture14 }
}
sphere {
   <5,-1,-2>, 0.707107
   texture { texture30 }
}
sphere {
   <-4,0,-2>, 0.707107
   texture { texture20 }
}
sphere {
   <-2,0,-2>, 0.707107
   texture { texture8 }
}
sphere {
   <0,0,-2>, 0.707107
   texture { texture4 }
}
sphere {
   <2,0,-2>, 0.707107
   texture { texture8 }
}
sphere {
   <4,0,-2>, 0.707107
   texture { texture20 }
}
sphere {
   <-5,1,-2>, 0.707107
   texture { texture30 }
}
sphere {
   <-3,1,-2>, 0.707107
   texture { texture14 }
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
   <3,1,-2>, 0.707107
   texture { texture14 }
}
sphere {
   <5,1,-2>, 0.707107
   texture { texture30 }
}
sphere {
   <-4,2,-2>, 0.707107
   texture { texture24 }
}
sphere {
   <-2,2,-2>, 0.707107
   texture { texture12 }
}
sphere {
   <0,2,-2>, 0.707107
   texture { texture8 }
}
sphere {
   <2,2,-2>, 0.707107
   texture { texture12 }
}
sphere {
   <4,2,-2>, 0.707107
   texture { texture24 }
}
sphere {
   <-3,3,-2>, 0.707107
   texture { texture22 }
}
sphere {
   <-1,3,-2>, 0.707107
   texture { texture14 }
}
sphere {
   <1,3,-2>, 0.707107
   texture { texture14 }
}
sphere {
   <3,3,-2>, 0.707107
   texture { texture22 }
}
sphere {
   <-2,4,-2>, 0.707107
   texture { texture24 }
}
sphere {
   <0,4,-2>, 0.707107
   texture { texture20 }
}
sphere {
   <2,4,-2>, 0.707107
   texture { texture24 }
}
sphere {
   <-1,5,-2>, 0.707107
   texture { texture30 }
}
sphere {
   <1,5,-2>, 0.707107
   texture { texture30 }
}
sphere {
   <-2,-5,-1>, 0.707107
   texture { texture30 }
}
sphere {
   <0,-5,-1>, 0.707107
   texture { texture26 }
}
sphere {
   <2,-5,-1>, 0.707107
   texture { texture30 }
}
sphere {
   <-3,-4,-1>, 0.707107
   texture { texture26 }
}
sphere {
   <-1,-4,-1>, 0.707107
   texture { texture18 }
}
sphere {
   <1,-4,-1>, 0.707107
   texture { texture18 }
}
sphere {
   <3,-4,-1>, 0.707107
   texture { texture26 }
}
sphere {
   <-4,-3,-1>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,-3,-1>, 0.707107
   texture { texture14 }
}
sphere {
   <0,-3,-1>, 0.707107
   texture { texture10 }
}
sphere {
   <2,-3,-1>, 0.707107
   texture { texture14 }
}
sphere {
   <4,-3,-1>, 0.707107
   texture { texture26 }
}
sphere {
   <-5,-2,-1>, 0.707107
   texture { texture30 }
}
sphere {
   <-3,-2,-1>, 0.707107
   texture { texture14 }
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
   <3,-2,-1>, 0.707107
   texture { texture14 }
}
sphere {
   <5,-2,-1>, 0.707107
   texture { texture30 }
}
sphere {
   <-4,-1,-1>, 0.707107
   texture { texture18 }
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
   <4,-1,-1>, 0.707107
   texture { texture18 }
}
sphere {
   <-5,0,-1>, 0.707107
   texture { texture26 }
}
sphere {
   <-3,0,-1>, 0.707107
   texture { texture10 }
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
   <3,0,-1>, 0.707107
   texture { texture10 }
}
sphere {
   <5,0,-1>, 0.707107
   texture { texture26 }
}
sphere {
   <-4,1,-1>, 0.707107
   texture { texture18 }
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
   <4,1,-1>, 0.707107
   texture { texture18 }
}
sphere {
   <-5,2,-1>, 0.707107
   texture { texture30 }
}
sphere {
   <-3,2,-1>, 0.707107
   texture { texture14 }
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
   <3,2,-1>, 0.707107
   texture { texture14 }
}
sphere {
   <5,2,-1>, 0.707107
   texture { texture30 }
}
sphere {
   <-4,3,-1>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,3,-1>, 0.707107
   texture { texture14 }
}
sphere {
   <0,3,-1>, 0.707107
   texture { texture10 }
}
sphere {
   <2,3,-1>, 0.707107
   texture { texture14 }
}
sphere {
   <4,3,-1>, 0.707107
   texture { texture26 }
}
sphere {
   <-3,4,-1>, 0.707107
   texture { texture26 }
}
sphere {
   <-1,4,-1>, 0.707107
   texture { texture18 }
}
sphere {
   <1,4,-1>, 0.707107
   texture { texture18 }
}
sphere {
   <3,4,-1>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,5,-1>, 0.707107
   texture { texture30 }
}
sphere {
   <0,5,-1>, 0.707107
   texture { texture26 }
}
sphere {
   <2,5,-1>, 0.707107
   texture { texture30 }
}
sphere {
   <-1,-5,0>, 0.707107
   texture { texture26 }
}
sphere {
   <1,-5,0>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,-4,0>, 0.707107
   texture { texture20 }
}
sphere {
   <0,-4,0>, 0.707107
   texture { texture16 }
}
sphere {
   <2,-4,0>, 0.707107
   texture { texture20 }
}
sphere {
   <-3,-3,0>, 0.707107
   texture { texture18 }
}
sphere {
   <-1,-3,0>, 0.707107
   texture { texture10 }
}
sphere {
   <1,-3,0>, 0.707107
   texture { texture10 }
}
sphere {
   <3,-3,0>, 0.707107
   texture { texture18 }
}
sphere {
   <-4,-2,0>, 0.707107
   texture { texture20 }
}
sphere {
   <-2,-2,0>, 0.707107
   texture { texture8 }
}
sphere {
   <0,-2,0>, 0.707107
   texture { texture4 }
}
sphere {
   <2,-2,0>, 0.707107
   texture { texture8 }
}
sphere {
   <4,-2,0>, 0.707107
   texture { texture20 }
}
sphere {
   <-5,-1,0>, 0.707107
   texture { texture26 }
}
sphere {
   <-3,-1,0>, 0.707107
   texture { texture10 }
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
   <3,-1,0>, 0.707107
   texture { texture10 }
}
sphere {
   <5,-1,0>, 0.707107
   texture { texture26 }
}
sphere {
   <-4,0,0>, 0.707107
   texture { texture16 }
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
   <4,0,0>, 0.707107
   texture { texture16 }
}
sphere {
   <-5,1,0>, 0.707107
   texture { texture26 }
}
sphere {
   <-3,1,0>, 0.707107
   texture { texture10 }
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
   <3,1,0>, 0.707107
   texture { texture10 }
}
sphere {
   <5,1,0>, 0.707107
   texture { texture26 }
}
sphere {
   <-4,2,0>, 0.707107
   texture { texture20 }
}
sphere {
   <-2,2,0>, 0.707107
   texture { texture8 }
}
sphere {
   <0,2,0>, 0.707107
   texture { texture4 }
}
sphere {
   <2,2,0>, 0.707107
   texture { texture8 }
}
sphere {
   <4,2,0>, 0.707107
   texture { texture20 }
}
sphere {
   <-3,3,0>, 0.707107
   texture { texture18 }
}
sphere {
   <-1,3,0>, 0.707107
   texture { texture10 }
}
sphere {
   <1,3,0>, 0.707107
   texture { texture10 }
}
sphere {
   <3,3,0>, 0.707107
   texture { texture18 }
}
sphere {
   <-2,4,0>, 0.707107
   texture { texture20 }
}
sphere {
   <0,4,0>, 0.707107
   texture { texture16 }
}
sphere {
   <2,4,0>, 0.707107
   texture { texture20 }
}
sphere {
   <-1,5,0>, 0.707107
   texture { texture26 }
}
sphere {
   <1,5,0>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,-5,1>, 0.707107
   texture { texture30 }
}
sphere {
   <0,-5,1>, 0.707107
   texture { texture26 }
}
sphere {
   <2,-5,1>, 0.707107
   texture { texture30 }
}
sphere {
   <-3,-4,1>, 0.707107
   texture { texture26 }
}
sphere {
   <-1,-4,1>, 0.707107
   texture { texture18 }
}
sphere {
   <1,-4,1>, 0.707107
   texture { texture18 }
}
sphere {
   <3,-4,1>, 0.707107
   texture { texture26 }
}
sphere {
   <-4,-3,1>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,-3,1>, 0.707107
   texture { texture14 }
}
sphere {
   <0,-3,1>, 0.707107
   texture { texture10 }
}
sphere {
   <2,-3,1>, 0.707107
   texture { texture14 }
}
sphere {
   <4,-3,1>, 0.707107
   texture { texture26 }
}
sphere {
   <-5,-2,1>, 0.707107
   texture { texture30 }
}
sphere {
   <-3,-2,1>, 0.707107
   texture { texture14 }
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
   <3,-2,1>, 0.707107
   texture { texture14 }
}
sphere {
   <5,-2,1>, 0.707107
   texture { texture30 }
}
sphere {
   <-4,-1,1>, 0.707107
   texture { texture18 }
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
   <4,-1,1>, 0.707107
   texture { texture18 }
}
sphere {
   <-5,0,1>, 0.707107
   texture { texture26 }
}
sphere {
   <-3,0,1>, 0.707107
   texture { texture10 }
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
   <3,0,1>, 0.707107
   texture { texture10 }
}
sphere {
   <5,0,1>, 0.707107
   texture { texture26 }
}
sphere {
   <-4,1,1>, 0.707107
   texture { texture18 }
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
   <4,1,1>, 0.707107
   texture { texture18 }
}
sphere {
   <-5,2,1>, 0.707107
   texture { texture30 }
}
sphere {
   <-3,2,1>, 0.707107
   texture { texture14 }
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
   <3,2,1>, 0.707107
   texture { texture14 }
}
sphere {
   <5,2,1>, 0.707107
   texture { texture30 }
}
sphere {
   <-4,3,1>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,3,1>, 0.707107
   texture { texture14 }
}
sphere {
   <0,3,1>, 0.707107
   texture { texture10 }
}
sphere {
   <2,3,1>, 0.707107
   texture { texture14 }
}
sphere {
   <4,3,1>, 0.707107
   texture { texture26 }
}
sphere {
   <-3,4,1>, 0.707107
   texture { texture26 }
}
sphere {
   <-1,4,1>, 0.707107
   texture { texture18 }
}
sphere {
   <1,4,1>, 0.707107
   texture { texture18 }
}
sphere {
   <3,4,1>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,5,1>, 0.707107
   texture { texture30 }
}
sphere {
   <0,5,1>, 0.707107
   texture { texture26 }
}
sphere {
   <2,5,1>, 0.707107
   texture { texture30 }
}
sphere {
   <-1,-5,2>, 0.707107
   texture { texture30 }
}
sphere {
   <1,-5,2>, 0.707107
   texture { texture30 }
}
sphere {
   <-2,-4,2>, 0.707107
   texture { texture24 }
}
sphere {
   <0,-4,2>, 0.707107
   texture { texture20 }
}
sphere {
   <2,-4,2>, 0.707107
   texture { texture24 }
}
sphere {
   <-3,-3,2>, 0.707107
   texture { texture22 }
}
sphere {
   <-1,-3,2>, 0.707107
   texture { texture14 }
}
sphere {
   <1,-3,2>, 0.707107
   texture { texture14 }
}
sphere {
   <3,-3,2>, 0.707107
   texture { texture22 }
}
sphere {
   <-4,-2,2>, 0.707107
   texture { texture24 }
}
sphere {
   <-2,-2,2>, 0.707107
   texture { texture12 }
}
sphere {
   <0,-2,2>, 0.707107
   texture { texture8 }
}
sphere {
   <2,-2,2>, 0.707107
   texture { texture12 }
}
sphere {
   <4,-2,2>, 0.707107
   texture { texture24 }
}
sphere {
   <-5,-1,2>, 0.707107
   texture { texture30 }
}
sphere {
   <-3,-1,2>, 0.707107
   texture { texture14 }
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
   <3,-1,2>, 0.707107
   texture { texture14 }
}
sphere {
   <5,-1,2>, 0.707107
   texture { texture30 }
}
sphere {
   <-4,0,2>, 0.707107
   texture { texture20 }
}
sphere {
   <-2,0,2>, 0.707107
   texture { texture8 }
}
sphere {
   <0,0,2>, 0.707107
   texture { texture4 }
}
sphere {
   <2,0,2>, 0.707107
   texture { texture8 }
}
sphere {
   <4,0,2>, 0.707107
   texture { texture20 }
}
sphere {
   <-5,1,2>, 0.707107
   texture { texture30 }
}
sphere {
   <-3,1,2>, 0.707107
   texture { texture14 }
}
sphere {
   <-1,1,2>, 0.707107
   texture { texture6 }
}
sphere {
   <1,1,2>, 0.707107
   texture { texture6 }
}
sphere {
   <3,1,2>, 0.707107
   texture { texture14 }
}
sphere {
   <5,1,2>, 0.707107
   texture { texture30 }
}
sphere {
   <-4,2,2>, 0.707107
   texture { texture24 }
}
sphere {
   <-2,2,2>, 0.707107
   texture { texture12 }
}
sphere {
   <0,2,2>, 0.707107
   texture { texture8 }
}
sphere {
   <2,2,2>, 0.707107
   texture { texture12 }
}
sphere {
   <4,2,2>, 0.707107
   texture { texture24 }
}
sphere {
   <-3,3,2>, 0.707107
   texture { texture22 }
}
sphere {
   <-1,3,2>, 0.707107
   texture { texture14 }
}
sphere {
   <1,3,2>, 0.707107
   texture { texture14 }
}
sphere {
   <3,3,2>, 0.707107
   texture { texture22 }
}
sphere {
   <-2,4,2>, 0.707107
   texture { texture24 }
}
sphere {
   <0,4,2>, 0.707107
   texture { texture20 }
}
sphere {
   <2,4,2>, 0.707107
   texture { texture24 }
}
sphere {
   <-1,5,2>, 0.707107
   texture { texture30 }
}
sphere {
   <1,5,2>, 0.707107
   texture { texture30 }
}
sphere {
   <-1,-4,3>, 0.707107
   texture { texture26 }
}
sphere {
   <1,-4,3>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,-3,3>, 0.707107
   texture { texture22 }
}
sphere {
   <0,-3,3>, 0.707107
   texture { texture18 }
}
sphere {
   <2,-3,3>, 0.707107
   texture { texture22 }
}
sphere {
   <-3,-2,3>, 0.707107
   texture { texture22 }
}
sphere {
   <-1,-2,3>, 0.707107
   texture { texture14 }
}
sphere {
   <1,-2,3>, 0.707107
   texture { texture14 }
}
sphere {
   <3,-2,3>, 0.707107
   texture { texture22 }
}
sphere {
   <-4,-1,3>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,-1,3>, 0.707107
   texture { texture14 }
}
sphere {
   <0,-1,3>, 0.707107
   texture { texture10 }
}
sphere {
   <2,-1,3>, 0.707107
   texture { texture14 }
}
sphere {
   <4,-1,3>, 0.707107
   texture { texture26 }
}
sphere {
   <-3,0,3>, 0.707107
   texture { texture18 }
}
sphere {
   <-1,0,3>, 0.707107
   texture { texture10 }
}
sphere {
   <1,0,3>, 0.707107
   texture { texture10 }
}
sphere {
   <3,0,3>, 0.707107
   texture { texture18 }
}
sphere {
   <-4,1,3>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,1,3>, 0.707107
   texture { texture14 }
}
sphere {
   <0,1,3>, 0.707107
   texture { texture10 }
}
sphere {
   <2,1,3>, 0.707107
   texture { texture14 }
}
sphere {
   <4,1,3>, 0.707107
   texture { texture26 }
}
sphere {
   <-3,2,3>, 0.707107
   texture { texture22 }
}
sphere {
   <-1,2,3>, 0.707107
   texture { texture14 }
}
sphere {
   <1,2,3>, 0.707107
   texture { texture14 }
}
sphere {
   <3,2,3>, 0.707107
   texture { texture22 }
}
sphere {
   <-2,3,3>, 0.707107
   texture { texture22 }
}
sphere {
   <0,3,3>, 0.707107
   texture { texture18 }
}
sphere {
   <2,3,3>, 0.707107
   texture { texture22 }
}
sphere {
   <-1,4,3>, 0.707107
   texture { texture26 }
}
sphere {
   <1,4,3>, 0.707107
   texture { texture26 }
}
sphere {
   <-1,-3,4>, 0.707107
   texture { texture26 }
}
sphere {
   <1,-3,4>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,-2,4>, 0.707107
   texture { texture24 }
}
sphere {
   <0,-2,4>, 0.707107
   texture { texture20 }
}
sphere {
   <2,-2,4>, 0.707107
   texture { texture24 }
}
sphere {
   <-3,-1,4>, 0.707107
   texture { texture26 }
}
sphere {
   <-1,-1,4>, 0.707107
   texture { texture18 }
}
sphere {
   <1,-1,4>, 0.707107
   texture { texture18 }
}
sphere {
   <3,-1,4>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,0,4>, 0.707107
   texture { texture20 }
}
sphere {
   <0,0,4>, 0.707107
   texture { texture16 }
}
sphere {
   <2,0,4>, 0.707107
   texture { texture20 }
}
sphere {
   <-3,1,4>, 0.707107
   texture { texture26 }
}
sphere {
   <-1,1,4>, 0.707107
   texture { texture18 }
}
sphere {
   <1,1,4>, 0.707107
   texture { texture18 }
}
sphere {
   <3,1,4>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,2,4>, 0.707107
   texture { texture24 }
}
sphere {
   <0,2,4>, 0.707107
   texture { texture20 }
}
sphere {
   <2,2,4>, 0.707107
   texture { texture24 }
}
sphere {
   <-1,3,4>, 0.707107
   texture { texture26 }
}
sphere {
   <1,3,4>, 0.707107
   texture { texture26 }
}
sphere {
   <-1,-2,5>, 0.707107
   texture { texture30 }
}
sphere {
   <1,-2,5>, 0.707107
   texture { texture30 }
}
sphere {
   <-2,-1,5>, 0.707107
   texture { texture30 }
}
sphere {
   <0,-1,5>, 0.707107
   texture { texture26 }
}
sphere {
   <2,-1,5>, 0.707107
   texture { texture30 }
}
sphere {
   <-1,0,5>, 0.707107
   texture { texture26 }
}
sphere {
   <1,0,5>, 0.707107
   texture { texture26 }
}
sphere {
   <-2,1,5>, 0.707107
   texture { texture30 }
}
sphere {
   <0,1,5>, 0.707107
   texture { texture26 }
}
sphere {
   <2,1,5>, 0.707107
   texture { texture30 }
}
sphere {
   <-1,2,5>, 0.707107
   texture { texture30 }
}
sphere {
   <1,2,5>, 0.707107
   texture { texture30 }
}
}
