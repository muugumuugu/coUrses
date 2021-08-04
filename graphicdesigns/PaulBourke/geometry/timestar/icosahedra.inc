#declare Texture1 = texture {
	pigment {
		color rgbt <0,1,0,0.5>
	}
	finish {
		ambient 0.2
		diffuse 0.8
		specular 0.6
		roughness 0.01
	}
}
#declare V0 = (sqrt(5) - 1) / 4;
mesh {
	triangle { <0,V0,-1/2>, <V0,1/2,0>, <-V0,1/2,0> }
	triangle { <0,V0,1/2>, <-V0,1/2,0>, <V0,1/2,0> }
	triangle { <0,V0,1/2>, <0,-V0,1/2>, <-1/2,0,V0> }
	triangle { <0,V0,1/2>, <1/2,0,V0>, <0,-V0,1/2> }
	triangle { <0,V0,-1/2>, <0,-V0,-1/2>, <1/2,0,-V0> }
	triangle { <0,V0,-1/2>, <-1/2,0,-V0>, <0,-V0,-1/2> }
	triangle { <0,-V0,1/2>, <V0,-1/2,0>, <-V0,-1/2,0> }
	triangle { <0,-V0,-1/2>, <-V0,-1/2,0>, <V0,-1/2,0> }
	triangle { <-V0,1/2,0>, <-1/2,0,V0>, <-1/2,0,-V0> }
	triangle { <-V0,-1/2,0>, <-1/2,0,-V0>, <-1/2,0,V0> }
	triangle { <V0,1/2,0>, <1/2,0,-V0>, <1/2,0,V0> }
	triangle { <V0,-1/2,0>, <1/2,0,V0>, <1/2,0,-V0> }
	triangle { <0,V0,1/2>, <-1/2,0,V0>, <-V0,1/2,0> }
	triangle { <0,V0,1/2>, <V0,1/2,0>, <1/2,0,V0> }
	triangle { <0,V0,-1/2>, <-V0,1/2,0>, <-1/2,0,-V0> }
	triangle { <0,V0,-1/2>, <1/2,0,-V0>, <V0,1/2,0> }
	triangle { <0,-V0,-1/2>, <-1/2,0,-V0>, <-V0,-1/2,0> }
	triangle { <0,-V0,-1/2>, <V0,-1/2,0>, <1/2,0,-V0> }
	triangle { <0,-V0,1/2>, <-V0,-1/2,0>, <-1/2,0,V0> }
	triangle { <0,-V0,1/2>, <1/2,0,V0>, <V0,-1/2,0> }
	rotate <0,0,90>
}

