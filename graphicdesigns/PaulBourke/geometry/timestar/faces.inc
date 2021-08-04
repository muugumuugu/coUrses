#declare V1 = (sqrt(5.0) + 3) / 12.0;
#declare V2 = (sqrt(5.0) + 1) / 12.0;

#declare finish1 = finish {
   ambient 0.2
   diffuse 0.8
   specular 0.6
   roughness 0.01
}

#declare Texture3 = texture { pigment { color rgb <1,0.5,0.5> } finish { finish1 } }
#declare Texture1 = texture { pigment { color rgb <1,1,0.5> } finish { finish1 } }
#declare Texture4 = texture { pigment { color rgb <0.5,0.5,1> } finish { finish1 } }
#declare Texture2 = texture { pigment { color rgb <0.5,1,0.5> } finish { finish1 } }
#declare Texture5 = texture { pigment { color rgb <0.5,1,1> } finish { finish1 } }

mesh {
	triangle { <-1/6,0,-V1>, <-V2,-V2,V2>, <V1,-1/6,0> texture {Texture1} }
	triangle { <0,V1,1/6>, <V1,-1/6,0>, <-V2,-V2,V2> texture {Texture1} }
	triangle { <0,V1,1/6>, <-1/6,0,-V1>, <-V2,-V2,V2> texture {Texture1} }
	triangle { <V1,-1/6,0>, <-1/6,0,-V1>, <0,V1,1/6> texture {Texture1} }
	triangle { <-V2,-V2,-V2>, <V2,V2,-V2>, <V2,-V2,V2> texture {Texture2} }
	triangle { <V2,-V2,V2>, <-V2,V2,V2>, <-V2,-V2,-V2> texture {Texture2} }
	triangle { <V2,V2,-V2>, <V2,-V2,V2>, <-V2,V2,V2> texture {Texture2} }
	triangle { <-V2,V2,V2>, <-V2,-V2,-V2>, <V2,V2,-V2> texture {Texture2} }
	triangle { <V2,-V2,-V2>, <-V1,-1/6,0>, <1/6,0,V1> texture {Texture3} }
	triangle { <1/6,0,V1>, <V2,-V2,-V2>, <0,V1,-1/6> texture {Texture3} }
	triangle { <V2,-V2,-V2>, <-V1,-1/6,0>, <0,V1,-1/6> texture {Texture3} }
	triangle { <-V1,-1/6,0>, <1/6,0,V1>, <0,V1,-1/6> texture {Texture3} }
	triangle { <0,-V1,-1/6>, <-V2,V2,-V2>, <-1/6,0,V1> texture {Texture4} }
	triangle { <V1,1/6,0>, <0,-V1,-1/6>, <-V2,V2,-V2> texture {Texture4} }
	triangle { <-1/6,0,V1>, <0,-V1,-1/6>, <V1,1/6,0> texture {Texture4} }
	triangle { <V1,1/6,0>, <-V2,V2,-V2>, <-1/6,0,V1> texture {Texture4} }
	triangle { <V2,V2,V2>, <-V1,1/6,0>, <1/6,0,-V1> texture {Texture5} }
	triangle { <0,-V1,1/6>, <1/6,0,-V1>, <-V1,1/6,0> texture {Texture5} }
	triangle { <1/6,0,-V1>, <V2,V2,V2>, <0,-V1,1/6> texture {Texture5} }
	triangle { <-V1,1/6,0>, <0,-V1,1/6>, <V2,V2,V2> texture {Texture5} }
	scale <1,-1,1>
	rotate <0,0,90>
}
