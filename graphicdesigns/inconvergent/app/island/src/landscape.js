function UnstructuredLandscape(xInit,yInit,rInit,nodeRangeInit,heightRangeInit,proximityInit,nodeRangeExp,heightRangeExp,proximityExp,recursions){console.log('nodeRangeInit',nodeRangeInit);console.log('heightRangeInit',heightRangeInit);console.log('proximityInit',proximityInit);console.log('nodeRangeExp',nodeRangeExp);console.log('heightRangeExp',heightRangeExp);console.log('proximityExp',proximityExp);var maxN=65000;var attemptsMultiplier=2.1;var ndx=Ndarray(new Float32Array(maxN*3),[maxN,3]);var tree=new kdTree([],distance,['x','y']);function getHeightRange(k){return heightRangeInit*Math.pow(2,-k*heightRangeExp);}
function getNodeRange(k){return nodeRangeInit*Math.pow(2,-k*nodeRangeExp);}
function getProximity(k){return proximityInit*Math.pow(2,-k*proximityExp);}
function getNonBlockedCandidatesInDomain(prox,cn){var prox2=prox*prox;var r2=rInit*rInit;var doubleR=rInit*2;var xcand;var ycand;while(true){xcand=(0.5-Math.random())*doubleR;ycand=(0.5-Math.random())*doubleR;if(xcand*xcand+ycand*ycand>r2){continue;}
xcand+=xInit;ycand+=yInit;var near=tree.nearest({x:xcand,y:ycand},1,prox2);if(near.length<1){return[xcand,ycand];}}}
var currentN=0;var minHeight=0;var maxHeight=0;function set(x,y,z){ndx.set(currentN,0,x);ndx.set(currentN,1,y);ndx.set(currentN,2,z);tree.insert({'x':x,'y':y,'z':z});currentN++;if(z<minHeight){minHeight=z;}
if(z>maxHeight){maxHeight=z;}}
set(0,0,1000);var misses;var t=new Date();for(var k=0;k<recursions;k++){var nodeRange=getNodeRange(k);var nodeRange2=nodeRange*nodeRange;var proximity=getProximity(k);var heightRange=getHeightRange(k);var attempts=Math.pow(2,(k+1)*attemptsMultiplier);misses=0;console.log('k',k);console.log('attempts',attempts);console.log('nodeRange',nodeRange);console.log('proximity',proximity);console.log('heightRange',heightRange);console.log('currentN',currentN);for(var localItt=0;localItt<attempts;localItt++){var xycand=getNonBlockedCandidatesInDomain(proximity,currentN);var near=tree.nearest({x:xycand[0],y:xycand[1]},200,nodeRange2);if(near.length>0){var avg=near.reduce(doSum,0)/near.length;var z=avg+heightRange*(0.5-Math.random());set(xycand[0],xycand[1],z);}
else{misses++;}
if(currentN>=maxN){console.warning('>maxN',maxN,'k',k);k=recursions+1;break;}}}
var borderNum=200;for(var k=0;k<borderNum;k++){var theta=2*Math.PI/borderNum*k;var x=xInit+Math.cos(theta)*rInit*1.05;var y=yInit+Math.sin(theta)*rInit*1.05;set(x,y,minHeight);}
for(var k=0;k<currentN;k++){var z=ndx.get(k,2);ndx.set(k,2,z-minHeight);}
minHeight=0;maxHeight=maxHeight-minHeight;var triangles=Delaunay(toTuples(ndx,2,currentN));console.log('misses',misses);console.log('landscape time: ',new Date()-t);console.log('min, max',minHeight,maxHeight);console.log('num vertices',currentN);console.log('num triangles',triangles.length);return{vertices:ndx,vertNum:currentN,triangles:triangles,triangleNum:triangles.length,minMaxHeightWidth:[minHeight,maxHeight,rInit]};}
function distance(a,b){return Math.pow(a.x-b.x,2)+Math.pow(a.y-b.y,2);}
function doSum(a,b){return a+b[0].z;}
function toTuples(nd,dim,num){var res=[];for(var i=0;i<num;i++){var row=[];for(var j=0;j<dim;j++){row.push(nd.get(i,j));}
res.push(row);}
return res;}