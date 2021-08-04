#declare RADIUS = sqrt(38);
#declare texture0 = texture {
   pigment { color rgb <0,0,1> }
   finish { specular 0.2 }
}
#declare texture1 = texture {
   pigment { color rgb <0,0.105263,1> }
   finish { specular 0.2 }
}
#declare texture2 = texture {
   pigment { color rgb <0,0.210526,1> }
   finish { specular 0.2 }
}
#declare texture3 = texture {
   pigment { color rgb <0,0.315789,1> }
   finish { specular 0.2 }
}
#declare texture4 = texture {
   pigment { color rgb <0,0.421053,1> }
   finish { specular 0.2 }
}
#declare texture5 = texture {
   pigment { color rgb <0,0.526316,1> }
   finish { specular 0.2 }
}
#declare texture6 = texture {
   pigment { color rgb <0,0.631579,1> }
   finish { specular 0.2 }
}
#declare texture7 = texture {
   pigment { color rgb <0,0.736842,1> }
   finish { specular 0.2 }
}
#declare texture8 = texture {
   pigment { color rgb <0,0.842105,1> }
   finish { specular 0.2 }
}
#declare texture9 = texture {
   pigment { color rgb <0,0.947368,1> }
   finish { specular 0.2 }
}
#declare texture10 = texture {
   pigment { color rgb <0,1,0.947368> }
   finish { specular 0.2 }
}
#declare texture11 = texture {
   pigment { color rgb <0,1,0.842105> }
   finish { specular 0.2 }
}
#declare texture12 = texture {
   pigment { color rgb <0,1,0.736842> }
   finish { specular 0.2 }
}
#declare texture13 = texture {
   pigment { color rgb <0,1,0.631579> }
   finish { specular 0.2 }
}
#declare texture14 = texture {
   pigment { color rgb <0,1,0.526316> }
   finish { specular 0.2 }
}
#declare texture15 = texture {
   pigment { color rgb <0,1,0.421053> }
   finish { specular 0.2 }
}
#declare texture16 = texture {
   pigment { color rgb <0,1,0.315789> }
   finish { specular 0.2 }
}
#declare texture17 = texture {
   pigment { color rgb <0,1,0.210526> }
   finish { specular 0.2 }
}
#declare texture18 = texture {
   pigment { color rgb <0,1,0.105263> }
   finish { specular 0.2 }
}
#declare texture19 = texture {
   pigment { color rgb <0,1,0> }
   finish { specular 0.2 }
}
#declare texture20 = texture {
   pigment { color rgb <0.105263,1,0> }
   finish { specular 0.2 }
}
#declare texture21 = texture {
   pigment { color rgb <0.210526,1,0> }
   finish { specular 0.2 }
}
#declare texture22 = texture {
   pigment { color rgb <0.315789,1,0> }
   finish { specular 0.2 }
}
#declare texture23 = texture {
   pigment { color rgb <0.421053,1,0> }
   finish { specular 0.2 }
}
#declare texture24 = texture {
   pigment { color rgb <0.526316,1,0> }
   finish { specular 0.2 }
}
#declare texture25 = texture {
   pigment { color rgb <0.631579,1,0> }
   finish { specular 0.2 }
}
#declare texture26 = texture {
   pigment { color rgb <0.736842,1,0> }
   finish { specular 0.2 }
}
#declare texture27 = texture {
   pigment { color rgb <0.842105,1,0> }
   finish { specular 0.2 }
}
#declare texture28 = texture {
   pigment { color rgb <0.947368,1,0> }
   finish { specular 0.2 }
}
#declare texture29 = texture {
   pigment { color rgb <1,0.947368,0> }
   finish { specular 0.2 }
}
#declare texture30 = texture {
   pigment { color rgb <1,0.842105,0> }
   finish { specular 0.2 }
}
#declare texture31 = texture {
   pigment { color rgb <1,0.736842,0> }
   finish { specular 0.2 }
}
#declare texture32 = texture {
   pigment { color rgb <1,0.631579,0> }
   finish { specular 0.2 }
}
#declare texture33 = texture {
   pigment { color rgb <1,0.526316,0> }
   finish { specular 0.2 }
}
#declare texture34 = texture {
   pigment { color rgb <1,0.421053,0> }
   finish { specular 0.2 }
}
#declare texture35 = texture {
   pigment { color rgb <1,0.315789,0> }
   finish { specular 0.2 }
}
#declare texture36 = texture {
   pigment { color rgb <1,0.210526,0> }
   finish { specular 0.2 }
}
#declare texture37 = texture {
   pigment { color rgb <1,0.105263,0> }
   finish { specular 0.2 }
}
#declare texture38 = texture {
   pigment { color rgb <1,0,0> }
   finish { specular 0.2 }
}
union {
sphere {
   <-1,-1,-6>, 0.707107
   texture { texture38 }
}
sphere {
   <1,-1,-6>, 0.707107
   texture { texture38 }
}
sphere {
   <0,0,-6>, 0.707107
   texture { texture36 }
}
sphere {
   <-1,1,-6>, 0.707107
   texture { texture38 }
}
sphere {
   <1,1,-6>, 0.707107
   texture { texture38 }
}
sphere {
   <-2,-3,-5>, 0.707107
   texture { texture38 }
}
sphere {
   <0,-3,-5>, 0.707107
   texture { texture34 }
}
sphere {
   <2,-3,-5>, 0.707107
   texture { texture38 }
}
sphere {
   <-3,-2,-5>, 0.707107
   texture { texture38 }
}
sphere {
   <-1,-2,-5>, 0.707107
   texture { texture30 }
}
sphere {
   <1,-2,-5>, 0.707107
   texture { texture30 }
}
sphere {
   <3,-2,-5>, 0.707107
   texture { texture38 }
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
   <-3,0,-5>, 0.707107
   texture { texture34 }
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
   <3,0,-5>, 0.707107
   texture { texture34 }
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
   <-3,2,-5>, 0.707107
   texture { texture38 }
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
   <3,2,-5>, 0.707107
   texture { texture38 }
}
sphere {
   <-2,3,-5>, 0.707107
   texture { texture38 }
}
sphere {
   <0,3,-5>, 0.707107
   texture { texture34 }
}
sphere {
   <2,3,-5>, 0.707107
   texture { texture38 }
}
sphere {
   <-2,-4,-4>, 0.707107
   texture { texture36 }
}
sphere {
   <0,-4,-4>, 0.707107
   texture { texture32 }
}
sphere {
   <2,-4,-4>, 0.707107
   texture { texture36 }
}
sphere {
   <-3,-3,-4>, 0.707107
   texture { texture34 }
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
   <3,-3,-4>, 0.707107
   texture { texture34 }
}
sphere {
   <-4,-2,-4>, 0.707107
   texture { texture36 }
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
   <4,-2,-4>, 0.707107
   texture { texture36 }
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
   <-4,0,-4>, 0.707107
   texture { texture32 }
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
   <4,0,-4>, 0.707107
   texture { texture32 }
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
   <-4,2,-4>, 0.707107
   texture { texture36 }
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
   <4,2,-4>, 0.707107
   texture { texture36 }
}
sphere {
   <-3,3,-4>, 0.707107
   texture { texture34 }
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
   <3,3,-4>, 0.707107
   texture { texture34 }
}
sphere {
   <-2,4,-4>, 0.707107
   texture { texture36 }
}
sphere {
   <0,4,-4>, 0.707107
   texture { texture32 }
}
sphere {
   <2,4,-4>, 0.707107
   texture { texture36 }
}
sphere {
   <-2,-5,-3>, 0.707107
   texture { texture38 }
}
sphere {
   <0,-5,-3>, 0.707107
   texture { texture34 }
}
sphere {
   <2,-5,-3>, 0.707107
   texture { texture38 }
}
sphere {
   <-3,-4,-3>, 0.707107
   texture { texture34 }
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
   <3,-4,-3>, 0.707107
   texture { texture34 }
}
sphere {
   <-4,-3,-3>, 0.707107
   texture { texture34 }
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
   <4,-3,-3>, 0.707107
   texture { texture34 }
}
sphere {
   <-5,-2,-3>, 0.707107
   texture { texture38 }
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
   <5,-2,-3>, 0.707107
   texture { texture38 }
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
   <-5,0,-3>, 0.707107
   texture { texture34 }
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
   <5,0,-3>, 0.707107
   texture { texture34 }
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
   <-5,2,-3>, 0.707107
   texture { texture38 }
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
   <5,2,-3>, 0.707107
   texture { texture38 }
}
sphere {
   <-4,3,-3>, 0.707107
   texture { texture34 }
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
   <4,3,-3>, 0.707107
   texture { texture34 }
}
sphere {
   <-3,4,-3>, 0.707107
   texture { texture34 }
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
   <3,4,-3>, 0.707107
   texture { texture34 }
}
sphere {
   <-2,5,-3>, 0.707107
   texture { texture38 }
}
sphere {
   <0,5,-3>, 0.707107
   texture { texture34 }
}
sphere {
   <2,5,-3>, 0.707107
   texture { texture38 }
}
sphere {
   <-3,-5,-2>, 0.707107
   texture { texture38 }
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
   <3,-5,-2>, 0.707107
   texture { texture38 }
}
sphere {
   <-4,-4,-2>, 0.707107
   texture { texture36 }
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
   <4,-4,-2>, 0.707107
   texture { texture36 }
}
sphere {
   <-5,-3,-2>, 0.707107
   texture { texture38 }
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
   <5,-3,-2>, 0.707107
   texture { texture38 }
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
   <-5,3,-2>, 0.707107
   texture { texture38 }
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
   <5,3,-2>, 0.707107
   texture { texture38 }
}
sphere {
   <-4,4,-2>, 0.707107
   texture { texture36 }
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
   <4,4,-2>, 0.707107
   texture { texture36 }
}
sphere {
   <-3,5,-2>, 0.707107
   texture { texture38 }
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
   <3,5,-2>, 0.707107
   texture { texture38 }
}
sphere {
   <-1,-6,-1>, 0.707107
   texture { texture38 }
}
sphere {
   <1,-6,-1>, 0.707107
   texture { texture38 }
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
   <-6,-1,-1>, 0.707107
   texture { texture38 }
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
   <6,-1,-1>, 0.707107
   texture { texture38 }
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
   <-6,1,-1>, 0.707107
   texture { texture38 }
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
   <6,1,-1>, 0.707107
   texture { texture38 }
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
   <-1,6,-1>, 0.707107
   texture { texture38 }
}
sphere {
   <1,6,-1>, 0.707107
   texture { texture38 }
}
sphere {
   <0,-6,0>, 0.707107
   texture { texture36 }
}
sphere {
   <-3,-5,0>, 0.707107
   texture { texture34 }
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
   <3,-5,0>, 0.707107
   texture { texture34 }
}
sphere {
   <-4,-4,0>, 0.707107
   texture { texture32 }
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
   <4,-4,0>, 0.707107
   texture { texture32 }
}
sphere {
   <-5,-3,0>, 0.707107
   texture { texture34 }
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
   <5,-3,0>, 0.707107
   texture { texture34 }
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
   <-6,0,0>, 0.707107
   texture { texture36 }
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
   <6,0,0>, 0.707107
   texture { texture36 }
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
   <-5,3,0>, 0.707107
   texture { texture34 }
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
   <5,3,0>, 0.707107
   texture { texture34 }
}
sphere {
   <-4,4,0>, 0.707107
   texture { texture32 }
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
   <4,4,0>, 0.707107
   texture { texture32 }
}
sphere {
   <-3,5,0>, 0.707107
   texture { texture34 }
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
   <3,5,0>, 0.707107
   texture { texture34 }
}
sphere {
   <0,6,0>, 0.707107
   texture { texture36 }
}
sphere {
   <-1,-6,1>, 0.707107
   texture { texture38 }
}
sphere {
   <1,-6,1>, 0.707107
   texture { texture38 }
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
   <-6,-1,1>, 0.707107
   texture { texture38 }
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
   <6,-1,1>, 0.707107
   texture { texture38 }
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
   <-6,1,1>, 0.707107
   texture { texture38 }
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
   <6,1,1>, 0.707107
   texture { texture38 }
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
   <-1,6,1>, 0.707107
   texture { texture38 }
}
sphere {
   <1,6,1>, 0.707107
   texture { texture38 }
}
sphere {
   <-3,-5,2>, 0.707107
   texture { texture38 }
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
   <3,-5,2>, 0.707107
   texture { texture38 }
}
sphere {
   <-4,-4,2>, 0.707107
   texture { texture36 }
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
   <4,-4,2>, 0.707107
   texture { texture36 }
}
sphere {
   <-5,-3,2>, 0.707107
   texture { texture38 }
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
   <5,-3,2>, 0.707107
   texture { texture38 }
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
   <-5,3,2>, 0.707107
   texture { texture38 }
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
   <5,3,2>, 0.707107
   texture { texture38 }
}
sphere {
   <-4,4,2>, 0.707107
   texture { texture36 }
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
   <4,4,2>, 0.707107
   texture { texture36 }
}
sphere {
   <-3,5,2>, 0.707107
   texture { texture38 }
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
   <3,5,2>, 0.707107
   texture { texture38 }
}
sphere {
   <-2,-5,3>, 0.707107
   texture { texture38 }
}
sphere {
   <0,-5,3>, 0.707107
   texture { texture34 }
}
sphere {
   <2,-5,3>, 0.707107
   texture { texture38 }
}
sphere {
   <-3,-4,3>, 0.707107
   texture { texture34 }
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
   <3,-4,3>, 0.707107
   texture { texture34 }
}
sphere {
   <-4,-3,3>, 0.707107
   texture { texture34 }
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
   <4,-3,3>, 0.707107
   texture { texture34 }
}
sphere {
   <-5,-2,3>, 0.707107
   texture { texture38 }
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
   <5,-2,3>, 0.707107
   texture { texture38 }
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
   <-5,0,3>, 0.707107
   texture { texture34 }
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
   <5,0,3>, 0.707107
   texture { texture34 }
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
   <-5,2,3>, 0.707107
   texture { texture38 }
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
   <5,2,3>, 0.707107
   texture { texture38 }
}
sphere {
   <-4,3,3>, 0.707107
   texture { texture34 }
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
   <4,3,3>, 0.707107
   texture { texture34 }
}
sphere {
   <-3,4,3>, 0.707107
   texture { texture34 }
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
   <3,4,3>, 0.707107
   texture { texture34 }
}
sphere {
   <-2,5,3>, 0.707107
   texture { texture38 }
}
sphere {
   <0,5,3>, 0.707107
   texture { texture34 }
}
sphere {
   <2,5,3>, 0.707107
   texture { texture38 }
}
sphere {
   <-2,-4,4>, 0.707107
   texture { texture36 }
}
sphere {
   <0,-4,4>, 0.707107
   texture { texture32 }
}
sphere {
   <2,-4,4>, 0.707107
   texture { texture36 }
}
sphere {
   <-3,-3,4>, 0.707107
   texture { texture34 }
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
   <3,-3,4>, 0.707107
   texture { texture34 }
}
sphere {
   <-4,-2,4>, 0.707107
   texture { texture36 }
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
   <4,-2,4>, 0.707107
   texture { texture36 }
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
   <-4,0,4>, 0.707107
   texture { texture32 }
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
   <4,0,4>, 0.707107
   texture { texture32 }
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
   <-4,2,4>, 0.707107
   texture { texture36 }
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
   <4,2,4>, 0.707107
   texture { texture36 }
}
sphere {
   <-3,3,4>, 0.707107
   texture { texture34 }
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
   <3,3,4>, 0.707107
   texture { texture34 }
}
sphere {
   <-2,4,4>, 0.707107
   texture { texture36 }
}
sphere {
   <0,4,4>, 0.707107
   texture { texture32 }
}
sphere {
   <2,4,4>, 0.707107
   texture { texture36 }
}
sphere {
   <-2,-3,5>, 0.707107
   texture { texture38 }
}
sphere {
   <0,-3,5>, 0.707107
   texture { texture34 }
}
sphere {
   <2,-3,5>, 0.707107
   texture { texture38 }
}
sphere {
   <-3,-2,5>, 0.707107
   texture { texture38 }
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
   <3,-2,5>, 0.707107
   texture { texture38 }
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
   <-3,0,5>, 0.707107
   texture { texture34 }
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
   <3,0,5>, 0.707107
   texture { texture34 }
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
   <-3,2,5>, 0.707107
   texture { texture38 }
}
sphere {
   <-1,2,5>, 0.707107
   texture { texture30 }
}
sphere {
   <1,2,5>, 0.707107
   texture { texture30 }
}
sphere {
   <3,2,5>, 0.707107
   texture { texture38 }
}
sphere {
   <-2,3,5>, 0.707107
   texture { texture38 }
}
sphere {
   <0,3,5>, 0.707107
   texture { texture34 }
}
sphere {
   <2,3,5>, 0.707107
   texture { texture38 }
}
sphere {
   <-1,-1,6>, 0.707107
   texture { texture38 }
}
sphere {
   <1,-1,6>, 0.707107
   texture { texture38 }
}
sphere {
   <0,0,6>, 0.707107
   texture { texture36 }
}
sphere {
   <-1,1,6>, 0.707107
   texture { texture38 }
}
sphere {
   <1,1,6>, 0.707107
   texture { texture38 }
}
}
