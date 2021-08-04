#declare RADIUS = sqrt(34);
#declare texture0 = texture {
   pigment { color rgb <0,0,1> }
   finish { specular 0.2 }
}
#declare texture1 = texture {
   pigment { color rgb <0,0.117647,1> }
   finish { specular 0.2 }
}
#declare texture2 = texture {
   pigment { color rgb <0,0.235294,1> }
   finish { specular 0.2 }
}
#declare texture3 = texture {
   pigment { color rgb <0,0.352941,1> }
   finish { specular 0.2 }
}
#declare texture4 = texture {
   pigment { color rgb <0,0.470588,1> }
   finish { specular 0.2 }
}
#declare texture5 = texture {
   pigment { color rgb <0,0.588235,1> }
   finish { specular 0.2 }
}
#declare texture6 = texture {
   pigment { color rgb <0,0.705882,1> }
   finish { specular 0.2 }
}
#declare texture7 = texture {
   pigment { color rgb <0,0.823529,1> }
   finish { specular 0.2 }
}
#declare texture8 = texture {
   pigment { color rgb <0,0.941176,1> }
   finish { specular 0.2 }
}
#declare texture9 = texture {
   pigment { color rgb <0,1,0.941176> }
   finish { specular 0.2 }
}
#declare texture10 = texture {
   pigment { color rgb <0,1,0.823529> }
   finish { specular 0.2 }
}
#declare texture11 = texture {
   pigment { color rgb <0,1,0.705882> }
   finish { specular 0.2 }
}
#declare texture12 = texture {
   pigment { color rgb <0,1,0.588235> }
   finish { specular 0.2 }
}
#declare texture13 = texture {
   pigment { color rgb <0,1,0.470588> }
   finish { specular 0.2 }
}
#declare texture14 = texture {
   pigment { color rgb <0,1,0.352941> }
   finish { specular 0.2 }
}
#declare texture15 = texture {
   pigment { color rgb <0,1,0.235294> }
   finish { specular 0.2 }
}
#declare texture16 = texture {
   pigment { color rgb <0,1,0.117647> }
   finish { specular 0.2 }
}
#declare texture17 = texture {
   pigment { color rgb <0,1,0> }
   finish { specular 0.2 }
}
#declare texture18 = texture {
   pigment { color rgb <0.117647,1,0> }
   finish { specular 0.2 }
}
#declare texture19 = texture {
   pigment { color rgb <0.235294,1,0> }
   finish { specular 0.2 }
}
#declare texture20 = texture {
   pigment { color rgb <0.352941,1,0> }
   finish { specular 0.2 }
}
#declare texture21 = texture {
   pigment { color rgb <0.470588,1,0> }
   finish { specular 0.2 }
}
#declare texture22 = texture {
   pigment { color rgb <0.588235,1,0> }
   finish { specular 0.2 }
}
#declare texture23 = texture {
   pigment { color rgb <0.705882,1,0> }
   finish { specular 0.2 }
}
#declare texture24 = texture {
   pigment { color rgb <0.823529,1,0> }
   finish { specular 0.2 }
}
#declare texture25 = texture {
   pigment { color rgb <0.941176,1,0> }
   finish { specular 0.2 }
}
#declare texture26 = texture {
   pigment { color rgb <1,0.941176,0> }
   finish { specular 0.2 }
}
#declare texture27 = texture {
   pigment { color rgb <1,0.823529,0> }
   finish { specular 0.2 }
}
#declare texture28 = texture {
   pigment { color rgb <1,0.705882,0> }
   finish { specular 0.2 }
}
#declare texture29 = texture {
   pigment { color rgb <1,0.588235,0> }
   finish { specular 0.2 }
}
#declare texture30 = texture {
   pigment { color rgb <1,0.470588,0> }
   finish { specular 0.2 }
}
#declare texture31 = texture {
   pigment { color rgb <1,0.352941,0> }
   finish { specular 0.2 }
}
#declare texture32 = texture {
   pigment { color rgb <1,0.235294,0> }
   finish { specular 0.2 }
}
#declare texture33 = texture {
   pigment { color rgb <1,0.117647,0> }
   finish { specular 0.2 }
}
#declare texture34 = texture {
   pigment { color rgb <1,0,0> }
   finish { specular 0.2 }
}
union {
sphere {
   <0,-3,-5>, 0.707107
   texture { texture34 }
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
   <-1,2,-5>, 0.707107
   texture { texture30 }
}
sphere {
   <1,2,-5>, 0.707107
   texture { texture30 }
}
sphere {
   <0,3,-5>, 0.707107
   texture { texture34 }
}
sphere {
   <0,-4,-4>, 0.707107
   texture { texture32 }
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
   <0,4,-4>, 0.707107
   texture { texture32 }
}
sphere {
   <0,-5,-3>, 0.707107
   texture { texture34 }
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
   <0,5,-3>, 0.707107
   texture { texture34 }
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
   <0,-5,3>, 0.707107
   texture { texture34 }
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
   <0,5,3>, 0.707107
   texture { texture34 }
}
sphere {
   <0,-4,4>, 0.707107
   texture { texture32 }
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
   <0,4,4>, 0.707107
   texture { texture32 }
}
sphere {
   <0,-3,5>, 0.707107
   texture { texture34 }
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
   <-1,2,5>, 0.707107
   texture { texture30 }
}
sphere {
   <1,2,5>, 0.707107
   texture { texture30 }
}
sphere {
   <0,3,5>, 0.707107
   texture { texture34 }
}
}
