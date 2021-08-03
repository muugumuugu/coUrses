// by Etienne JACOB
// motion blur template by beesandbombs
// needs opensimplexnoise code in another tab
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
float shutterAngle = 1.0;

boolean recording = true;

OpenSimplexNoise noise;

int ndot = 87;

float L = 15;
float R = 270;
float DRmax = 60;

float rad = 1.0;

float curvex(float theta){
  return R*(float)noise.eval(3337+rad*cos(theta),rad*sin(theta));
}

float curvey(float theta){
  return R*(float)noise.eval(4337+rad*cos(theta),rad*sin(theta));
}

class Dot{
  float theta;
  float DX = random(-L,L);
  float DY = random(-L,L);
  float DR = random(-DRmax,DRmax);
  
  float x,y;
  
  float sz = random(0.75,3.5);
  
  Dot(int i){
    theta = TWO_PI*i/ndot;
    //x = DX + (R+DR)*cos(theta);
    //y = DY + (R+DR)*sin(theta);
    x = DX + curvex(theta);
    y = DY + curvey(theta);
  }
  
  void show(){
    stroke(255,255);
    strokeWeight(sz*1);
    point(x(),y());
  }
  
  float seed = random(10,1000);
  
  float r = random(0,25);
  
  float x(){
    return x+r*(float)noise.eval(seed+0.3*cos(TWO_PI*t),0.3*sin(TWO_PI*t));
  }
  float y(){
    return y+r*(float)noise.eval(2*seed+0.3*cos(TWO_PI*t),0.3*sin(TWO_PI*t));
  }
}

int m = 3500;

float l = 300;

float scl = 0.03;

void draw_curve(float tt,float seed){
  stroke(255,15);
  for(int i=0;i<m;i++){
    float p = (100+tt - 0.25*i/m)%1;
    float q = 1.0*i/m;
    float qi = 1-1.0*i/m;
    
    strokeWeight(1.5*qi+0.25);
    
    float loc = p*ndot;
    int i1 = floor(loc);
    int i2 = (floor(loc)+1)%ndot;
    float interp = loc - floor(loc);
    
    interp = ease(interp,2.7);
    
    float x = lerp(array[i1].x(),array[i2].x(),interp);
    float y = lerp(array[i1].y(),array[i2].y(),interp);
    
    float dx = l*pow(q,2.0)*(float)noise.eval(seed+scl*x,scl*y);
    float dy = l*pow(q,2.0)*(float)noise.eval(2*seed+scl*x,scl*y); 
    
    point(x+dx,y+dy);
  }
}

Dot[] array = new Dot[ndot];

void setup(){
  size(540,540,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<ndot;i++){
    array[i] = new Dot(i);
  }
}

int K = 5;
int n = 4;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  for(int i=0;i<ndot;i++){
    array[i].show();
  }
  
  for(int i=0;i<n;i++){
    for(int k=0;k<K;k++){
      draw_curve((t+k)/K,15*i);
    }
  }
  pop();
}