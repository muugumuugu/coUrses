#declare RADIUS = sqrt(46);
#declare texture0 = texture {
   pigment { color rgb <0,0,1> }
   finish { specular 0.2 }
}
#declare texture1 = texture {
   pigment { color rgb <0,0.0869565,1> }
   finish { specular 0.2 }
}
#declare texture2 = texture {
   pigment { color rgb <0,0.173913,1> }
   finish { specular 0.2 }
}
#declare texture3 = texture {
   pigment { color rgb <0,0.26087,1> }
   finish { specular 0.2 }
}
#declare texture4 = texture {
   pigment { color rgb <0,0.347826,1> }
   finish { specular 0.2 }
}
#declare texture5 = texture {
   pigment { color rgb <0,0.434783,1> }
   finish { specular 0.2 }
}
#declare texture6 = texture {
   pigment { color rgb <0,0.521739,1> }
   finish { specular 0.2 }
}
#declare texture7 = texture {
   pigment { color rgb <0,0.608696,1> }
   finish { specular 0.2 }
}
#declare texture8 = texture {
   pigment { color rgb <0,0.695652,1> }
   finish { specular 0.2 }
}
#declare texture9 = texture {
   pigment { color rgb <0,0.782609,1> }
   finish { specular 0.2 }
}
#declare texture10 = texture {
   pigment { color rgb <0,0.869565,1> }
   finish { specular 0.2 }
}
#declare texture11 = texture {
   pigment { color rgb <0,0.956522,1> }
   finish { specular 0.2 }
}
#declare texture12 = texture {
   pigment { color rgb <0,1,0.956522> }
   finish { specular 0.2 }
}
#declare texture13 = texture {
   pigment { color rgb <0,1,0.869565> }
   finish { specular 0.2 }
}
#declare texture14 = texture {
   pigment { color rgb <0,1,0.782609> }
   finish { specular 0.2 }
}
#declare texture15 = texture {
   pigment { color rgb <0,1,0.695652> }
   finish { specular 0.2 }
}
#declare texture16 = texture {
   pigment { color rgb <0,1,0.608696> }
   finish { specular 0.2 }
}
#declare texture17 = texture {
   pigment { color rgb <0,1,0.521739> }
   finish { specular 0.2 }
}
#declare texture18 = texture {
   pigment { color rgb <0,1,0.434783> }
   finish { specular 0.2 }
}
#declare texture19 = texture {
   pigment { color rgb <0,1,0.347826> }
   finish { specular 0.2 }
}
#declare texture20 = texture {
   pigment { color rgb <0,1,0.26087> }
   finish { specular 0.2 }
}
#declare texture21 = texture {
   pigment { color rgb <0,1,0.173913> }
   finish { specular 0.2 }
}
#declare texture22 = texture {
   pigment { color rgb <0,1,0.0869565> }
   finish { specular 0.2 }
}
#declare texture23 = texture {
   pigment { color rgb <0,1,0> }
   finish { specular 0.2 }
}
#declare texture24 = texture {
   pigment { color rgb <0.0869565,1,0> }
   finish { specular 0.2 }
}
#declare texture25 = texture {
   pigment { color rgb <0.173913,1,0> }
   finish { specular 0.2 }
}
#declare texture26 = texture {
   pigment { color rgb <0.26087,1,0> }
   finish { specular 0.2 }
}
#declare texture27 = texture {
   pigment { color rgb <0.347826,1,0> }
   finish { specular 0.2 }
}
#declare texture28 = texture {
   pigment { color rgb <0.434783,1,0> }
   finish { specular 0.2 }
}
#declare texture29 = texture {
   pigment { color rgb <0.521739,1,0> }
   finish { specular 0.2 }
}
#declare texture30 = texture {
   pigment { color rgb <0.608696,1,0> }
   finish { specular 0.2 }
}
#declare texture31 = texture {
   pigment { color rgb <0.695652,1,0> }
   finish { specular 0.2 }
}
#declare texture32 = texture {
   pigment { color rgb <0.782609,1,0> }
   finish { specular 0.2 }
}
#declare texture33 = texture {
   pigment { color rgb <0.869565,1,0> }
   finish { specular 0.2 }
}
#declare texture34 = texture {
   pigment { color rgb <0.956522,1,0> }
   finish { specular 0.2 }
}
#declare texture35 = texture {
   pigment { color rgb <1,0.956522,0> }
   finish { specular 0.2 }
}
#declare texture36 = texture {
   pigment { color rgb <1,0.869565,0> }
   finish { specular 0.2 }
}
#declare texture37 = texture {
   pigment { color rgb <1,0.782609,0> }
   finish { specular 0.2 }
}
#declare texture38 = texture {
   pigment { color rgb <1,0.695652,0> }
   finish { specular 0.2 }
}
#declare texture39 = texture {
   pigment { color rgb <1,0.608696,0> }
   finish { specular 0.2 }
}
#declare texture40 = texture {
   pigment { color rgb <1,0.521739,0> }
   finish { specular 0.2 }
}
#declare texture41 = texture {
   pigment { color rgb <1,0.434783,0> }
   finish { specular 0.2 }
}
#declare texture42 = texture {
   pigment { color rgb <1,0.347826,0> }
   finish { specular 0.2 }
}
#declare texture43 = texture {
   pigment { color rgb <1,0.26087,0> }
   finish { specular 0.2 }
}
#declare texture44 = texture {
   pigment { color rgb <1,0.173913,0> }
   finish { specular 0.2 }
}
#declare texture45 = texture {
   pigment { color rgb <1,0.0869565,0> }
   finish { specular 0.2 }
}
#declare texture46 = texture {
   pigment { color rgb <1,0,0> }
   finish { specular 0.2 }
}
union {
sphere {
   <-1,-3,-6>, 0.707107
   texture { texture46 }
}
sphere {
   <1,-3,-6>, 0.707107
   texture { texture46 }
}
sphere {
   <-2,-2,-6>, 0.707107
   texture { texture44 }
}
sphere {
   <0,-2,-6>, 0.707107
   texture { texture40 }
}
sphere {
   <2,-2,-6>, 0.707107
   texture { texture44 }
}
sphere {
   <-3,-1,-6>, 0.707107
   texture { texture46 }
}
sphere {
   <-1,-1,-6>, 0.707107
   texture { texture38 }
}
sphere {
   <1,-1,-6>, 0.707107
   texture { texture38 }
}
sphere {
   <3,-1,-6>, 0.707107
   texture { texture46 }
}
sphere {
   <-2,0,-6>, 0.707107
   texture { texture40 }
}
sphere {
   <0,0,-6>, 0.707107
   texture { texture36 }
}
sphere {
   <2,0,-6>, 0.707107
   texture { texture40 }
}
sphere {
   <-3,1,-6>, 0.707107
   texture { texture46 }
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
   <3,1,-6>, 0.707107
   texture { texture46 }
}
sphere {
   <-2,2,-6>, 0.707107
   texture { texture44 }
}
sphere {
   <0,2,-6>, 0.707107
   texture { texture40 }
}
sphere {
   <2,2,-6>, 0.707107
   texture { texture44 }
}
sphere {
   <-1,3,-6>, 0.707107
   texture { texture46 }
}
sphere {
   <1,3,-6>, 0.707107
   texture { texture46 }
}
sphere {
   <-1,-4,-5>, 0.707107
   texture { texture42 }
}
sphere {
   <1,-4,-5>, 0.707107
   texture { texture42 }
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
   <-4,-1,-5>, 0.707107
   texture { texture42 }
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
   <4,-1,-5>, 0.707107
   texture { texture42 }
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
   <-4,1,-5>, 0.707107
   texture { texture42 }
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
   <4,1,-5>, 0.707107
   texture { texture42 }
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
   <-1,4,-5>, 0.707107
   texture { texture42 }
}
sphere {
   <1,4,-5>, 0.707107
   texture { texture42 }
}
sphere {
   <-1,-5,-4>, 0.707107
   texture { texture42 }
}
sphere {
   <1,-5,-4>, 0.707107
   texture { texture42 }
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
   <-5,-1,-4>, 0.707107
   texture { texture42 }
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
   <5,-1,-4>, 0.707107
   texture { texture42 }
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
   <-5,1,-4>, 0.707107
   texture { texture42 }
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
   <5,1,-4>, 0.707107
   texture { texture42 }
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
   <-1,5,-4>, 0.707107
   texture { texture42 }
}
sphere {
   <1,5,-4>, 0.707107
   texture { texture42 }
}
sphere {
   <-1,-6,-3>, 0.707107
   texture { texture46 }
}
sphere {
   <1,-6,-3>, 0.707107
   texture { texture46 }
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
   <-6,-1,-3>, 0.707107
   texture { texture46 }
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
   <6,-1,-3>, 0.707107
   texture { texture46 }
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
   <-6,1,-3>, 0.707107
   texture { texture46 }
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
   <6,1,-3>, 0.707107
   texture { texture46 }
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
   <-1,6,-3>, 0.707107
   texture { texture46 }
}
sphere {
   <1,6,-3>, 0.707107
   texture { texture46 }
}
sphere {
   <-2,-6,-2>, 0.707107
   texture { texture44 }
}
sphere {
   <0,-6,-2>, 0.707107
   texture { texture40 }
}
sphere {
   <2,-6,-2>, 0.707107
   texture { texture44 }
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
   <-6,-2,-2>, 0.707107
   texture { texture44 }
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
   <6,-2,-2>, 0.707107
   texture { texture44 }
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
   <-6,0,-2>, 0.707107
   texture { texture40 }
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
   <6,0,-2>, 0.707107
   texture { texture40 }
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
   <-6,2,-2>, 0.707107
   texture { texture44 }
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
   <6,2,-2>, 0.707107
   texture { texture44 }
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
   <-2,6,-2>, 0.707107
   texture { texture44 }
}
sphere {
   <0,6,-2>, 0.707107
   texture { texture40 }
}
sphere {
   <2,6,-2>, 0.707107
   texture { texture44 }
}
sphere {
   <-3,-6,-1>, 0.707107
   texture { texture46 }
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
   <3,-6,-1>, 0.707107
   texture { texture46 }
}
sphere {
   <-4,-5,-1>, 0.707107
   texture { texture42 }
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
   <4,-5,-1>, 0.707107
   texture { texture42 }
}
sphere {
   <-5,-4,-1>, 0.707107
   texture { texture42 }
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
   <5,-4,-1>, 0.707107
   texture { texture42 }
}
sphere {
   <-6,-3,-1>, 0.707107
   texture { texture46 }
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
   <6,-3,-1>, 0.707107
   texture { texture46 }
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
   <-6,3,-1>, 0.707107
   texture { texture46 }
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
   <6,3,-1>, 0.707107
   texture { texture46 }
}
sphere {
   <-5,4,-1>, 0.707107
   texture { texture42 }
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
   <5,4,-1>, 0.707107
   texture { texture42 }
}
sphere {
   <-4,5,-1>, 0.707107
   texture { texture42 }
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
   <4,5,-1>, 0.707107
   texture { texture42 }
}
sphere {
   <-3,6,-1>, 0.707107
   texture { texture46 }
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
   <3,6,-1>, 0.707107
   texture { texture46 }
}
sphere {
   <-2,-6,0>, 0.707107
   texture { texture40 }
}
sphere {
   <0,-6,0>, 0.707107
   texture { texture36 }
}
sphere {
   <2,-6,0>, 0.707107
   texture { texture40 }
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
   <-6,-2,0>, 0.707107
   texture { texture40 }
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
   <6,-2,0>, 0.707107
   texture { texture40 }
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
   <-6,2,0>, 0.707107
   texture { texture40 }
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
   <6,2,0>, 0.707107
   texture { texture40 }
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
   <-2,6,0>, 0.707107
   texture { texture40 }
}
sphere {
   <0,6,0>, 0.707107
   texture { texture36 }
}
sphere {
   <2,6,0>, 0.707107
   texture { texture40 }
}
sphere {
   <-3,-6,1>, 0.707107
   texture { texture46 }
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
   <3,-6,1>, 0.707107
   texture { texture46 }
}
sphere {
   <-4,-5,1>, 0.707107
   texture { texture42 }
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
   <4,-5,1>, 0.707107
   texture { texture42 }
}
sphere {
   <-5,-4,1>, 0.707107
   texture { texture42 }
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
   <5,-4,1>, 0.707107
   texture { texture42 }
}
sphere {
   <-6,-3,1>, 0.707107
   texture { texture46 }
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
   <6,-3,1>, 0.707107
   texture { texture46 }
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
   <-6,3,1>, 0.707107
   texture { texture46 }
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
   <6,3,1>, 0.707107
   texture { texture46 }
}
sphere {
   <-5,4,1>, 0.707107
   texture { texture42 }
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
   <5,4,1>, 0.707107
   texture { texture42 }
}
sphere {
   <-4,5,1>, 0.707107
   texture { texture42 }
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
   <4,5,1>, 0.707107
   texture { texture42 }
}
sphere {
   <-3,6,1>, 0.707107
   texture { texture46 }
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
   <3,6,1>, 0.707107
   texture { texture46 }
}
sphere {
   <-2,-6,2>, 0.707107
   texture { texture44 }
}
sphere {
   <0,-6,2>, 0.707107
   texture { texture40 }
}
sphere {
   <2,-6,2>, 0.707107
   texture { texture44 }
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
   <-6,-2,2>, 0.707107
   texture { texture44 }
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
   <6,-2,2>, 0.707107
   texture { texture44 }
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
   <-6,0,2>, 0.707107
   texture { texture40 }
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
   <6,0,2>, 0.707107
   texture { texture40 }
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
   <-6,2,2>, 0.707107
   texture { texture44 }
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
   <6,2,2>, 0.707107
   texture { texture44 }
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
   <-2,6,2>, 0.707107
   texture { texture44 }
}
sphere {
   <0,6,2>, 0.707107
   texture { texture40 }
}
sphere {
   <2,6,2>, 0.707107
   texture { texture44 }
}
sphere {
   <-1,-6,3>, 0.707107
   texture { texture46 }
}
sphere {
   <1,-6,3>, 0.707107
   texture { texture46 }
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
   <-6,-1,3>, 0.707107
   texture { texture46 }
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
   <6,-1,3>, 0.707107
   texture { texture46 }
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
   <-6,1,3>, 0.707107
   texture { texture46 }
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
   <6,1,3>, 0.707107
   texture { texture46 }
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
   <-1,6,3>, 0.707107
   texture { texture46 }
}
sphere {
   <1,6,3>, 0.707107
   texture { texture46 }
}
sphere {
   <-1,-5,4>, 0.707107
   texture { texture42 }
}
sphere {
   <1,-5,4>, 0.707107
   texture { texture42 }
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
   <-5,-1,4>, 0.707107
   texture { texture42 }
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
   <5,-1,4>, 0.707107
   texture { texture42 }
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
   <-5,1,4>, 0.707107
   texture { texture42 }
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
   <5,1,4>, 0.707107
   texture { texture42 }
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
   <-1,5,4>, 0.707107
   texture { texture42 }
}
sphere {
   <1,5,4>, 0.707107
   texture { texture42 }
}
sphere {
   <-1,-4,5>, 0.707107
   texture { texture42 }
}
sphere {
   <1,-4,5>, 0.707107
   texture { texture42 }
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
   <-4,-1,5>, 0.707107
   texture { texture42 }
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
   <4,-1,5>, 0.707107
   texture { texture42 }
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
   <-4,1,5>, 0.707107
   texture { texture42 }
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
   <4,1,5>, 0.707107
   texture { texture42 }
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
   <-1,4,5>, 0.707107
   texture { texture42 }
}
sphere {
   <1,4,5>, 0.707107
   texture { texture42 }
}
sphere {
   <-1,-3,6>, 0.707107
   texture { texture46 }
}
sphere {
   <1,-3,6>, 0.707107
   texture { texture46 }
}
sphere {
   <-2,-2,6>, 0.707107
   texture { texture44 }
}
sphere {
   <0,-2,6>, 0.707107
   texture { texture40 }
}
sphere {
   <2,-2,6>, 0.707107
   texture { texture44 }
}
sphere {
   <-3,-1,6>, 0.707107
   texture { texture46 }
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
   <3,-1,6>, 0.707107
   texture { texture46 }
}
sphere {
   <-2,0,6>, 0.707107
   texture { texture40 }
}
sphere {
   <0,0,6>, 0.707107
   texture { texture36 }
}
sphere {
   <2,0,6>, 0.707107
   texture { texture40 }
}
sphere {
   <-3,1,6>, 0.707107
   texture { texture46 }
}
sphere {
   <-1,1,6>, 0.707107
   texture { texture38 }
}
sphere {
   <1,1,6>, 0.707107
   texture { texture38 }
}
sphere {
   <3,1,6>, 0.707107
   texture { texture46 }
}
sphere {
   <-2,2,6>, 0.707107
   texture { texture44 }
}
sphere {
   <0,2,6>, 0.707107
   texture { texture40 }
}
sphere {
   <2,2,6>, 0.707107
   texture { texture44 }
}
sphere {
   <-1,3,6>, 0.707107
   texture { texture46 }
}
sphere {
   <1,3,6>, 0.707107
   texture { texture46 }
}
}
