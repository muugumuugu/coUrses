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

float R = 200;

float D = 150;

float rad1 = 0.5;

float rad2 = 0.05;

float L = 175;

float RAD = 0.07;

float X(float p){
  return L*(float)noise.eval(3*SEED + RAD*cos(TWO_PI*p),RAD*sin(TWO_PI*p));
}
float Y(float p){
  return L*(float)noise.eval(4*SEED + RAD*cos(TWO_PI*p),RAD*sin(TWO_PI*p));
}

int N = 3;

class Thing{
  float seed = random(10,1000);
  
  float ind;
  
  Thing(int i){
    ind = i;
    
  }
  
  float x(float p){
    float theta = TWO_PI*ind/n;
    return (R + D*(float)noise.eval(SEED + rad1*cos(theta), rad1*sin(theta),rad2*cos(TWO_PI*p),rad2*sin(TWO_PI*p)))*cos(theta);
  }
  
  float y(float p){
    float theta = TWO_PI*ind/n;
    return (R + D*(float)noise.eval(2*SEED + rad1*cos(theta), rad1*sin(theta),rad2*cos(TWO_PI*p),rad2*sin(TWO_PI*p)))*sin(theta);
  }
  
  PVector pos(float p){
    float df = 4.0f;
    float xx = lerp(x(t - df*p),X(t - df*(1-p)),p);
    float yy = lerp(y(t - df*p),Y(t - df*(1-p)),p);
    
    return new PVector(xx,yy);
  }
  
  int K = 4;
  
  void show(){
    stroke(255);
    strokeWeight(3);
    
    //point(x(t),y(t));
    
    float offset = map(ind,0,n,0,N)%1;
    
    float tt = (t-offset+1)%1;
    
    for(int i=0;i<K;i++){
      //float pw = 0.7;
      //float p = map(pow(0.1+map(i+tt,0,K,0,1),pw),pow(0.1,pw),pow(1.1,pw),0,1);
      
      float p = ease(map(i+tt,0,K,0,1),2.0);
      
      PVector v = pos(p);
      
      stroke(255,200);
      strokeWeight(4*(1.1-p));
      
      point(v.x,v.y);
      
      //float r = 100*pow(ease(map(sin(TWO_PI*(-t+N*p)),-1,1,0,1),2.0),3.0)*(1.1-p);
      float r = 4*sin(PI*p);
      
      stroke(255,255);
      strokeWeight(r);
      noFill();
      
      point(v.x,v.y);
      
      //ellipse(v.x,v.y,r,r);
    }
    
    int m = 50;
    
    for(int i=0;i<m;i++){
      
      float p = map((2*m+i+offset-10*t)%m,0,m,0,1);
      
      PVector v = pos(p);
      
      stroke(255,100*(1.1-p));
      strokeWeight(2.0);
      
      point(v.x,v.y);
    }
  }
}

float SEED;

int n = 75;

Thing[] array = new Thing[n];

void setup(){
  size(600,600,P3D);
  
  result = new int[width*height][3];
  
  SEED = random(10,1000);
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Thing(i);
  }
}

void draw_(){
  randomSeed(123);
  background(0);
  push();
  translate(width/2,height/2);
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
  
  for(int i=0;i<N;i++){
    int M = 100;
    for(int j=0;j<M;j++){
      float theta = TWO_PI*(i+t)/N - 0.020*j + 0.015;
      
      float x = (R + D*(float)noise.eval(SEED + rad1*cos(theta), rad1*sin(theta),rad2*cos(TWO_PI*t),rad2*sin(TWO_PI*t)))*cos(theta);
      float y = (R + D*(float)noise.eval(2*SEED + rad1*cos(theta), rad1*sin(theta),rad2*cos(TWO_PI*t),rad2*sin(TWO_PI*t)))*sin(theta);
      
      
      stroke(255,255);
      strokeWeight(5*map(j,0,M,1,0));
      
      point(x,y);
    }
  }
  
  int nn = 2000;
  
  for(int i=0;i<nn;i++){
    float theta = TWO_PI*i/nn + 0.015;
    
    float x = (R + D*(float)noise.eval(SEED + rad1*cos(theta), rad1*sin(theta),rad2*cos(TWO_PI*t),rad2*sin(TWO_PI*t)))*cos(theta);
    float y = (R + D*(float)noise.eval(2*SEED + rad1*cos(theta), rad1*sin(theta),rad2*cos(TWO_PI*t),rad2*sin(TWO_PI*t)))*sin(theta);
    
    
    stroke(255,50);
    strokeWeight(2.0);
    
    point(x,y);
  }
  
  pop();
}