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

int samplesPerFrame = 1;
int numFrames = 100;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

float R = 150;

float AX,AY;

float ATTRACTION = 1.3;

class Thing{
  float seed = random(10,1000);
  
  float phi;
  
  int K;
  
  float offset;
  
  float sw = random(0.5,1.7);
  
  int ind;
  
  Thing(int i){
    phi = map(i,0,n,0,TWO_PI);

    K = 7;
    
    offset = map(i,0,n,0,2)%1;
  }
  
  PVector pos(float p,float tt,float q){
    
    p = constrain(p,0,1);
    
    float theta = map(p,0,1,0,PI);
    
    float std = 0.2;
    
    float dphi = std*(float)noise.eval(50*p,1*seed)*q*(1.025-sin(theta));
    float dtheta =  3*std*(float)noise.eval(60*p,3*seed)*q*(1.025-sin(theta));

    float x = R*sin(theta+dtheta)*cos(phi+dphi);
    float z = R*sin(theta+dtheta)*sin(phi+dphi);
    float y = R*cos(theta+dtheta);
    
    return new PVector(x,y,z);
  }

  
  void show_dots(float tt){
    for(int i=0;i<K;i++){
      int N = 300;
      for(int q=0;q<N;q++){
        float p = map((i+1-tt+0.001*q)%K,0,K,-0.1,1.1);
        
        PVector dot = pos(p,t,1-1.0*q/N);
        
        float pp = constrain(p,0,1);
        
        float factor = pow(sin(PI*pp),0.5);
        
        PVector v = projection(dot.x,dot.y,dot.z);
        
        strokeWeight(max(0.15,factor*sw*40.0*pow(map(q,0,N,1,0),1.5)*v.z*20));
        stroke(255,factor*1.5*pow(map(q,0,N,1,0),1.5)*50);
      
        if(-dot.z+zdist>0){
          point(v.x,v.y);
        }
      }
    }
  }
  
  void show(){
    float tt = (t+offset)%1;
    show_dots(tt);
  }
}

float zdist = 400;

PVector projection(float x,float y,float z){
  float xx = 2.0*250*x/(-z+zdist);
  float yy = 2.0*250*y/(-z+zdist);
  return new PVector(xx,yy,1/(-z+zdist));
}

int n = 110;

Thing[] array = new Thing[n];

float SEED;

void setup(){
  size(600,600,P2D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  SEED = random(10,1000);
  
  AX = R*random(-1,1);
  AY = R*random(-1,1);
  
  for(int i=0;i<n;i++){
    array[i] = new Thing(i);
  }
}

void draw_(){
  randomSeed(1337);
  
  background(0);
  push();
  translate(width/2,height/2);
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
  pop();
}