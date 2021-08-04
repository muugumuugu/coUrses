#declare RADIUS = 0.01;
#declare V1 = (sqrt(5) + 3) / 12;
#declare V2 = (sqrt(5) + 1) / 12;
cylinder { <V1,0,-1/6>, <-V2,V2,-V2>, RADIUS texture { TETRA_0 } }
sphere { <V1,0,-1/6>, RADIUS texture { TETRA_0 } }
sphere { <-V2,V2,-V2>, RADIUS texture { TETRA_0 } }
cylinder { <0,1/6,V1>, <V1,0,-1/6>, RADIUS texture { TETRA_0 } }
sphere { <0,1/6,V1>, RADIUS texture { TETRA_0 } }
sphere { <V1,0,-1/6>, RADIUS texture { TETRA_0 } }
cylinder { <-V2,V2,-V2>, <0,1/6,V1>, RADIUS texture { TETRA_0 } }
sphere { <-V2,V2,-V2>, RADIUS texture { TETRA_0 } }
sphere { <0,1/6,V1>, RADIUS texture { TETRA_0 } }
cylinder { <0,1/6,V1>, <-1/6,-V1,0>, RADIUS texture { TETRA_0 } }
sphere { <0,1/6,V1>, RADIUS texture { TETRA_0 } }
sphere { <-1/6,-V1,0>, RADIUS texture { TETRA_0 } }
cylinder { <V1,0,-1/6>, <-1/6,-V1,0>, RADIUS texture { TETRA_0 } }
sphere { <V1,0,-1/6>, RADIUS texture { TETRA_0 } }
sphere { <-1/6,-V1,0>, RADIUS texture { TETRA_0 } }
cylinder { <-1/6,-V1,0>, <-V2,V2,-V2>, RADIUS texture { TETRA_0 } }
sphere { <-1/6,-V1,0>, RADIUS texture { TETRA_0 } }
sphere { <-V2,V2,-V2>, RADIUS texture { TETRA_0 } }
cylinder { <-V2,-V2,-V2>, <V2,V2,-V2>, RADIUS texture { TETRA_1 } }
sphere { <-V2,-V2,-V2>, RADIUS texture { TETRA_1 } }
sphere { <V2,V2,-V2>, RADIUS texture { TETRA_1 } }
cylinder { <-V2,-V2,-V2>, <V2,-V2,V2>, RADIUS texture { TETRA_1 } }
sphere { <-V2,-V2,-V2>, RADIUS texture { TETRA_1 } }
sphere { <V2,-V2,V2>, RADIUS texture { TETRA_1 } }
cylinder { <-V2,V2,V2>, <-V2,-V2,-V2>, RADIUS texture { TETRA_1 } }
sphere { <-V2,V2,V2>, RADIUS texture { TETRA_1 } }
sphere { <-V2,-V2,-V2>, RADIUS texture { TETRA_1 } }
cylinder { <V2,-V2,V2>, <-V2,V2,V2>, RADIUS texture { TETRA_1 } }
sphere { <V2,-V2,V2>, RADIUS texture { TETRA_1 } }
sphere { <-V2,V2,V2>, RADIUS texture { TETRA_1 } }
cylinder { <V2,V2,-V2>, <V2,-V2,V2>, RADIUS texture { TETRA_1 } }
sphere { <V2,V2,-V2>, RADIUS texture { TETRA_1 } }
sphere { <V2,-V2,V2>, RADIUS texture { TETRA_1 } }
cylinder { <-V2,V2,V2>, <V2,V2,-V2>, RADIUS texture { TETRA_1 } }
sphere { <-V2,V2,V2>, RADIUS texture { TETRA_1 } }
sphere { <V2,V2,-V2>, RADIUS texture { TETRA_1 } }
cylinder { <1/6,V1,0>, <0,-1/6,V1>, RADIUS texture { TETRA_2 } }
sphere { <1/6,V1,0>, RADIUS texture { TETRA_2 } }
sphere { <0,-1/6,V1>, RADIUS texture { TETRA_2 } }
cylinder { <V2,-V2,-V2>, <0,-1/6,V1>, RADIUS texture { TETRA_2 } }
sphere { <V2,-V2,-V2>, RADIUS texture { TETRA_2 } }
sphere { <0,-1/6,V1>, RADIUS texture { TETRA_2 } }
cylinder { <V2,-V2,-V2>, <-V1,0,-1/6>, RADIUS texture { TETRA_2 } }
sphere { <V2,-V2,-V2>, RADIUS texture { TETRA_2 } }
sphere { <-V1,0,-1/6>, RADIUS texture { TETRA_2 } }
cylinder { <0,-1/6,V1>, <-V1,0,-1/6>, RADIUS texture { TETRA_2 } }
sphere { <0,-1/6,V1>, RADIUS texture { TETRA_2 } }
sphere { <-V1,0,-1/6>, RADIUS texture { TETRA_2 } }
cylinder { <1/6,V1,0>, <V2,-V2,-V2>, RADIUS texture { TETRA_2 } }
sphere { <1/6,V1,0>, RADIUS texture { TETRA_2 } }
sphere { <V2,-V2,-V2>, RADIUS texture { TETRA_2 } }
cylinder { <-V1,0,-1/6>, <1/6,V1,0>, RADIUS texture { TETRA_2 } }
sphere { <-V1,0,-1/6>, RADIUS texture { TETRA_2 } }
sphere { <1/6,V1,0>, RADIUS texture { TETRA_2 } }
cylinder { <-1/6,V1,0>, <0,-1/6,-V1>, RADIUS texture { TETRA_3 } }
sphere { <-1/6,V1,0>, RADIUS texture { TETRA_3 } }
sphere { <0,-1/6,-V1>, RADIUS texture { TETRA_3 } }
cylinder { <V1,0,1/6>, <0,-1/6,-V1>, RADIUS texture { TETRA_3 } }
sphere { <V1,0,1/6>, RADIUS texture { TETRA_3 } }
sphere { <0,-1/6,-V1>, RADIUS texture { TETRA_3 } }
cylinder { <0,-1/6,-V1>, <-V2,-V2,V2>, RADIUS texture { TETRA_3 } }
sphere { <0,-1/6,-V1>, RADIUS texture { TETRA_3 } }
sphere { <-V2,-V2,V2>, RADIUS texture { TETRA_3 } }
cylinder { <-1/6,V1,0>, <V1,0,1/6>, RADIUS texture { TETRA_3 } }
sphere { <-1/6,V1,0>, RADIUS texture { TETRA_3 } }
sphere { <V1,0,1/6>, RADIUS texture { TETRA_3 } }
cylinder { <-V2,-V2,V2>, <-1/6,V1,0>, RADIUS texture { TETRA_3 } }
sphere { <-V2,-V2,V2>, RADIUS texture { TETRA_3 } }
sphere { <-1/6,V1,0>, RADIUS texture { TETRA_3 } }
cylinder { <V1,0,1/6>, <-V2,-V2,V2>, RADIUS texture { TETRA_3 } }
sphere { <V1,0,1/6>, RADIUS texture { TETRA_3 } }
sphere { <-V2,-V2,V2>, RADIUS texture { TETRA_3 } }
cylinder { <0,1/6,-V1>, <1/6,-V1,0>, RADIUS texture { TETRA_4 } }
sphere { <0,1/6,-V1>, RADIUS texture { TETRA_4 } }
sphere { <1/6,-V1,0>, RADIUS texture { TETRA_4 } }
cylinder { <0,1/6,-V1>, <V2,V2,V2>, RADIUS texture { TETRA_4 } }
sphere { <0,1/6,-V1>, RADIUS texture { TETRA_4 } }
sphere { <V2,V2,V2>, RADIUS texture { TETRA_4 } }
cylinder { <-V1,0,1/6>, <0,1/6,-V1>, RADIUS texture { TETRA_4 } }
sphere { <-V1,0,1/6>, RADIUS texture { TETRA_4 } }
sphere { <0,1/6,-V1>, RADIUS texture { TETRA_4 } }
cylinder { <V2,V2,V2>, <-V1,0,1/6>, RADIUS texture { TETRA_4 } }
sphere { <V2,V2,V2>, RADIUS texture { TETRA_4 } }
sphere { <-V1,0,1/6>, RADIUS texture { TETRA_4 } }
cylinder { <1/6,-V1,0>, <V2,V2,V2>, RADIUS texture { TETRA_4 } }
sphere { <1/6,-V1,0>, RADIUS texture { TETRA_4 } }
sphere { <V2,V2,V2>, RADIUS texture { TETRA_4 } }
cylinder { <-V1,0,1/6>, <1/6,-V1,0>, RADIUS texture { TETRA_4 } }
sphere { <-V1,0,1/6>, RADIUS texture { TETRA_4 } }
sphere { <1/6,-V1,0>, RADIUS texture { TETRA_4 } }

