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

int samplesPerFrame = 5;
int numFrames = 100;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

int n = 18;

float L = 15;

float margin = 100;

//color[] colorArray = {#FF8080,#FFBA92,#E0F5B9,#C6F1D6};
color[] colorArray = {#EAEAEA,#A1DD70,#00BDAA,#8559A5};

void drawFaces(){
  noStroke();
  rectMode(CENTER);
  
  fill(colorArray[1]);
  push();
  translate(0,0,L/2);
  rect(0,0,L,L);
  translate(0,0,-L);
  rect(0,0,L,L);
  pop();
  
  fill(colorArray[2]);
  push();
  rotateY(HALF_PI);
  translate(0,0,L/2);
  rect(0,0,L,L);
  translate(0,0,-L);
  rect(0,0,L,L);
  pop();
  
  fill(colorArray[3]);
  push();
  rotateX(HALF_PI);
  translate(0,0,L/2);
  rect(0,0,L,L);
  translate(0,0,-L);
  rect(0,0,L,L);
  pop();
}

class Cube{
  float x,y;
  
  Cube(int i,int j){
    x = map(i,0,n-1,margin,width-margin);
    y = map(j,0,n-1,margin,height-margin);
  }
  
  void show(){
    push();
    translate(x,y);
    
    float scl = 0.01;
    float rad = 0.4;
    float offset = -0.0015*y;
    
    float MIN = -9;
    float MAX = 9;
    
    float rx = map((float)noise.eval(SEED+scl*x,0.07*scl*y,rad*cos(TWO_PI*(t-offset)),rad*sin(TWO_PI*(t-offset))),-1,1,MIN,MAX);
    float ry =  map((float)noise.eval(2*SEED+scl*x,0.07*scl*y,rad*cos(TWO_PI*(t-offset)),rad*sin(TWO_PI*(t-offset))),-1,1,MIN,MAX);
    float rz =  map((float)noise.eval(3*SEED+scl*x,0.07*scl*y,rad*cos(TWO_PI*(t-offset)),rad*sin(TWO_PI*(t-offset))),-1,1,MIN,MAX);
    
    rotateX(2*TWO_PI*t);
    
    rotateX(rx);
    rotateY(ry);
    rotateZ(rz);
    
    drawFaces();
    
    pop();
  }
    
}

Cube[] array = new Cube[n*n];

float SEED;

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  SEED = random(10,1000);
  
  int k=0;
  for(int i=0;i<n;i++){
    for(int j=0;j<n;j++){
      array[k] = new Cube(i,j);
      k++;
    }
  }
  
  ortho();
}

void draw_(){
  background(colorArray[0]);
  push();
  
  for(int k=0;k<n*n;k++){
    array[k].show();
  }
  
  pop();
}