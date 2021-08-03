window.requestAnimFrame=(function(){return window.requestAnimationFrame||window.webkitRequestAnimationFrame||window.mozRequestAnimationFrame||function(callback){window.setTimeout(callback,1000/60);};})();var PI=Math.PI;var PII=Math.PI*2;var FRONT='rgba(0,0,0,0.07)';var GRAINS=5;var CTX;var PX;var SIZE=700;var NUM=200;var MAXFRIENDS=5;var F=[];var SPEEDUP=10;var RAD=200;var RAD_NOISE=10;var NEARLIM=20;var FARLIM=100;var STEP=1/40;var FRIEND_PROBABILITY=0.3;var FRIEND_DISTRIBUTION=0.1
var BYTES=32/8;var XBUF=new ArrayBuffer(NUM*BYTES);var YBUF=new ArrayBuffer(NUM*BYTES);var SXBUF=new ArrayBuffer(NUM*BYTES);var SYBUF=new ArrayBuffer(NUM*BYTES);var RBUF=new ArrayBuffer(NUM*NUM*BYTES);var ABUF=new ArrayBuffer(NUM*NUM*BYTES);var X=new Float32Array(XBUF);var Y=new Float32Array(YBUF);var SX=new Float32Array(SXBUF);var SY=new Float32Array(SYBUF);var R=new Float32Array(RBUF);var A=new Float32Array(ABUF);var ITT=0;$(document).ready(function(){$('<canvas>').attr({id:'inconvergent'}).css({width:SIZE+'px',height:SIZE+'px'}).attr({width:SIZE,height:SIZE}).appendTo('#box');var C=$('#inconvergent');CTX=C[0].getContext("2d");C.click(init_canvas);init_canvas();(function animloop(){requestAnimFrame(animloop);for(var i=0;i<SPEEDUP;i++){run();}
if(ITT>3200){init_canvas();}})();});function init_canvas(){ITT=0;clear_friends();init();CTX.fillStyle='rgb(255,255,255)';CTX.fillRect(0,0,SIZE,SIZE);CTX.fillStyle=FRONT;CTX.webkitImageSmoothingEnabled=false;}
function init(){for(var i=0;i<NUM;i++){var the=Math.random()*PII;var y=Math.sin(the)*RAD;var x=Math.cos(the)*RAD;var phi=Math.random()*PII;var ny=Math.sin(phi)*RAD_NOISE;var nx=Math.cos(phi)*RAD_NOISE;X[i]=SIZE/2+x+nx;Y[i]=SIZE/2+y+ny;}}
function clear_friends(){for(var i=0;i<NUM;i++){F[i]=[];}}
function make_friends(i){if(F[i].length>MAXFRIENDS){return;}
var r=[];for(var j=0;j<NUM;j++){if(i!=j){r.push([j,R[i*NUM+j]]);}}
for(var h=0;h<NUM-1;h++){var index=h;var small=r[index][1];for(var k=h+1;k<NUM-1;k++){if(r[k][1]<small){small=r[k][1];index=k;}}
if(k!=index){var tmp=r[h];r[h]=r[index];r[index]=tmp;}}
var index=NUM-2;for(var k=0;k<NUM-1;k++){if(Math.random()<FRIEND_DISTRIBUTION){index=k;break;}}
for(var k=0;k<F[i].length;k++){if(F[i][k]==index){return;}}
F[i].push(r[index][0]);F[r[index][0]].push(i);}
function draw_connections(){for(var i=0;i<NUM;i++){for(var f=0;f<F[i].length;f++){if(i==F[i][f]||F[i][f]<i){continue;}
var dist=R[i*NUM+F[i][f]];var a=A[i*NUM+F[i][f]];var ax=Math.cos(a);var ay=Math.sin(a);var x=X[i];var y=Y[i];for(var q=0;q<GRAINS;q++){dd=Math.random()*dist;var x=Math.floor(X[i]-dd*ax);var y=Math.floor(Y[i]-dd*ay);CTX.fillRect(x,y,1.0,1.0);}}}}
function distance_matrix(){for(var i=0;i<NUM;i++){for(var j=i+1;j<NUM;j++){var dx=X[i]-X[j];var dy=Y[i]-Y[j];var a=Math.atan2(dy,dx);var dist=Math.sqrt(dx*dx+dy*dy);R[j*NUM+i]=dist;R[i*NUM+j]=dist;A[i*NUM+j]=a;A[j*NUM+i]=a+PI;}}}
function run(){ITT++;distance_matrix();for(var i=0;i<NUM;i++){SX[i]=0.0;SY[i]=0.0;}
for(var i=0;i<NUM;i++){for(var j=i+1;j<NUM;j++){if(F[i].length<1||F[j].length<1){continue;}
var f=false;for(var q=0;q<F[i].length;q++){if(j==F[i][q]){f=true;break;}}
var dist=R[i*NUM+j];var a=A[j*NUM+i];var cosa=Math.cos(a);var sina=Math.sin(a);if(dist>NEARLIM&&f){SX[i]+=cosa;SY[i]+=sina;SX[j]-=cosa;SY[j]-=sina;continue;}
if(dist<FARLIM){var force=(FARLIM-dist)/FARLIM;SX[i]-=cosa*force;SY[i]-=sina*force;SX[j]+=cosa*force;SY[j]+=sina*force;}}}
for(var i=0;i<NUM;i++){X[i]+=SX[i]*STEP;Y[i]+=SY[i]*STEP;}
if(Math.random()<FRIEND_PROBABILITY){make_friends(Math.floor(Math.random()*NUM));}
draw_connections();}