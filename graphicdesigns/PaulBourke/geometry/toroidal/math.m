Clear[f,g,h,f1,g1,h1]
f[t_]  = Cos[t];
g[t_]  = Cos[(t + 2 Pi / 3)];
h[t_]  = Cos[(t + 4 Pi / 3)];
f1[t_] = Sin[t];
g1[t_] = Sin[(t + 2 Pi / 3)];
h1[t_] = Sin[(t + 4 Pi / 3)];
ParametricPlot3D[{f1[t](1+f[p]) ,g1[t](1+g[p]),h1[t ] (1+h[p])},
                 {t,-Pi,Pi,Pi/30},{p,-Pi,Pi,Pi/30},
                 ViewPoint->{3.379, 3.383, 7.625},Boxed->False,Axes->False];
