function RandomCircle(xinit,yinit,rinit,proximity,n){var proximity2=proximity*proximity;var x=new Float32Array(n*2);var ndx=ndarray(x,[n,2]);var r2=rinit*rinit;var i=0;while(i<n){var xcand=(0.5-rand())*rinit*2;var ycand=(0.5-rand())*rinit*2;var free=true;for(var j=0;j<i;j++){var dx=xinit+xcand-ndx.get(j,0);var dy=yinit+ycand-ndx.get(j,1);if(dx*dx+dy*dy<proximity2){free=false;break;}}
if(!free){continue;}
ndx.set(i,0,xinit+xcand);ndx.set(i,1,yinit+ycand);i++;}
console.log(ndx);return ndx;}
function toTuples(nd){var res=[];for(var i=0;i<nd.shape[0];i++){var row=[]
for(var j=0;j<nd.shape[1];j++){row.push(nd.get(i,j));}
res.push(row);}
return res;}
function halfrand(x){return(Math.rand()-0.5)*x;}