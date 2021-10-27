function mountain(maxItt,H,initRange,initArray){function makeMountain(z,itt){if(itt>=maxItt){return z;}
var nx=z.shape[0];var ny=z.shape[1];var newnx=2*nx-1;var newny=2*ny-1;var newz=ndarray(new Float32Array(newnx*newny),[newnx,newny]);var i,j,oldi,oldj;var v1,v2,v3,v4;for(i=0;i<newnx;i+=2){oldi=floor((i+1)*0.5);for(j=0;j<newny;j+=2){oldj=floor((j+1)*0.5);var v=z.get(oldi,oldj);newz.set(i,j,v);}}
for(i=0;i<newnx;i+=2){oldi=floor((i+1)/2);for(j=1;j<newny;j+=2){oldj=floor((j+1)/2);v1=z.get(oldi,oldj-1);v2=z.get(oldi,oldj);newz.set(i,j,(v1+v2)*0.5);}}
for(i=1;i<newnx;i+=2){oldi=floor((i+1)/2);for(j=0;j<newny;j+=2){oldj=floor((j+1)/2);v1=z.get(oldi-1,oldj);v2=z.get(oldi,oldj);newz.set(i,j,(v1+v2)*0.5);}}
for(i=1;i<newnx;i+=2){oldi=floor((i+1)/2);for(j=1;j<newny;j+=2){oldj=floor((j+1)/2);v1=z.get(oldi,oldj);v2=z.get(oldi-1,oldj);v3=z.get(oldi-1,oldj-1);v4=z.get(oldi,oldj-1);var mean=(v1+v2+v3+v4)*0.25;var rnd=(0.5-rand())*initRange*Math.pow(2,-itt*H);newz.set(i,j,mean+rnd);}}
return makeMountain(newz,itt+1,Math.pow(2,-H));}
var z=ndarray(new Float32Array(initArray),[2,2])
return makeMountain(z,0,initRange);}