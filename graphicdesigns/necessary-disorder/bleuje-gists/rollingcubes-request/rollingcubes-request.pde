// Processing code by Etienne JACOB
// motion blur template by beesandbombs
// opensimplexnoise code in another tab might be necessary
// --> code here : https://gist.github.com/Bleuje/fce86ef35b66c4a2b6a469b27163591e

int[][] result;
float t, c;

float ease(float p) {
  return 3*p*p - 2*p*p*p;
}

float ease(float p, float g) {
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

float softplus(float q,float p){
  float qq = q+p;
  if(qq<=0){
    return 0;
  }
  if(qq>=2*p){
    return qq-p;
  }
  return 1/(4*p)*qq*qq;
}

float mn = .5*sqrt(3), ia = atan(sqrt(.5));

void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popStyle();
  popMatrix();
}

void draw() {

  if (!recording) {
    t = mouseX*1.0/width;
    c = mouseY*1.0/height;
    if (mousePressed)
      println(c);
    draw_();
  } else {
    for (int i=0; i<width*height; i++)
      for (int a=0; a<3; a++)
        result[i][a] = 0;

    c = 0;
    for (int sa=0; sa<samplesPerFrame; sa++) {
      t = map(frameCount-1 + sa*shutterAngle/samplesPerFrame, 0, numFrames, 0, 1);
      draw_();
      loadPixels();
      for (int i=0; i<pixels.length; i++) {
        result[i][0] += pixels[i] >> 16 & 0xff;
        result[i][1] += pixels[i] >> 8 & 0xff;
        result[i][2] += pixels[i] & 0xff;
      }
    }

    loadPixels();
    for (int i=0; i<pixels.length; i++)
      pixels[i] = 0xff << 24 | 
        int(result[i][0]*1.0/samplesPerFrame) << 16 | 
        int(result[i][1]*1.0/samplesPerFrame) << 8 | 
        int(result[i][2]*1.0/samplesPerFrame);
    updatePixels();

    saveFrame("fr###.gif");
    println(frameCount,"/",numFrames);
    if (frameCount==numFrames)
      exit();
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 4;
int numFrames = 75;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

float L = 22;

color [] colorArray = {#ff5335,#dfe0d4,#3e92a3,#29252c};

void drawCube(){
  rectMode(CENTER);
  stroke(255);
  fill(0);
  
  noStroke();
  
  fill(colorArray[0]);
  push();
  translate(0,0,L/2);
  rect(0,0,L,L);
  translate(0,0,-L);
  rect(0,0,L,L);
  pop();
  
  fill(colorArray[1]);
  push();
  rotateY(HALF_PI);
  translate(0,0,L/2);
  rect(0,0,L,L);
  translate(0,0,-L);
  rect(0,0,L,L);
  pop();
  
  fill(colorArray[2]);
  push();
  rotateX(HALF_PI);
  translate(0,0,L/2);
  rect(0,0,L,L);
  translate(0,0,-L);
  rect(0,0,L,L);
  pop();
  
}

void showRollingCube(float p,float type){
  stroke(255);
  strokeWeight(1.6);
  //noFill();
  fill(200);
  push();
  float rot = HALF_PI*pow(p,3.0);
  rotateY(rot);
  translate(-L/2,0,L/2);
  rotateY(HALF_PI*type);
  drawCube();
  pop();
  
}

void rollManyTimesCube(int k,float p,float interp){
  int pi = floor(1337+p)-1337;
  float pf = p-pi;
  p = pi + lerp(pf,ease(pf,3.0),interp);
  int i = floor(1337+k*p)-1337;
  push();
  translate(L*i,0);
  float q = (1337+k*p)%1;
  showRollingCube(q,i);
  pop();
}

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
}

int N = 2;

int n = 48+24;

void draw_(){
  background(240);
  push();
  translate(width/2,height/2);
  
  rotateX(0.9);
  
  rotateZ(0.5*HALF_PI);

  
  for(int i=-2*n;i<n;i++){
    for(int j=-2*n;j<n;j++){
      push();
      
      float y = map(i+(j%2)/2.0,0,n-1,-2*1.5*height,1.5*height);
      float x = map(j,0,n-1,-2*1.5*height,1.5*height);
      
      translate(-L*N*t+L+x,y+L/2);
      
      float interp = 0.0; //no easing
      rollManyTimesCube(N,t-0.0021*dist(x,y,0,0),interp);
      
      pop();
    }
  }

  pop();
}