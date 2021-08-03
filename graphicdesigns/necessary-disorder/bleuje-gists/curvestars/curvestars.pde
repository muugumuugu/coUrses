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

int samplesPerFrame = 4;
int numFrames = 100;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

class Curve{
  float seed = random(10,1000);
  
  float rad = 0.4;
  
  float l = 550;
  
  float x(float p,float q){
    return width/2 + 3*l*(float)noise.eval(seed+rad*cos(TWO_PI*p),rad*sin(TWO_PI*p),0.9*q)/(1+max(0,5*q));
  }
  
  float y(float p,float q){
    return 0.4*l*(float)noise.eval(2*seed+rad*cos(TWO_PI*p),rad*sin(TWO_PI*p),0.9*q)/(1+max(0,5*q));
  }
}

Curve cv;

float L = 250;

class Dot{
  float P = random(0,1);
  
  float X = random(width);
  float DY = random(-0.2*height,0.2*height);
  
  float pert = 0.1*random(-1,1);
  
  float q1(float k){
    return P+k-t;
  }
  
  float q2(float k){
    return P+floor(k)-t;
  }
  
  float y1(float k){
    float q = q1(k);
    float qq = q2(k);
    return qq*L + cv.y(P,q);
  }
  
  float x1(float k){
    float q = q1(k);
    return cv.x(P,q);
  }
  
  float x(float k){
    float q = q1(k);
    float Q = constrain(0.5*q+pert,0,1);
    return lerp(X,x1(k),ease(Q,2.5));
  }
  
  float y(float k){
    float q = q1(k);
    float qq = q2(k);
    float Q = constrain(0.5*q+pert,0,1);
    return lerp(qq*L+DY,y1(k),ease(Q,2.5));
  }
  
  float sz = 1+3*pow(random(1),3.0);
  
  void show(float k){
    float q = q1(k);
    
    stroke(255,200);
    strokeWeight(sz);
    
    float yy = y(k);
    
    float center = constrain(map(yy,0,height,0,1),0,1);
    
    float xx = lerp(x(k),width/2,center);
    
    point(xx,yy);
  }
}

int k1 = -2;

int k2 = 4;

int n = 2000;

Dot[] array = new Dot[n];

void setup(){
  size(600,800,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  cv = new Curve();
  
  for(int i=0;i<n;i++){
    array[i] = new Dot();
  }
}

void draw_(){
  background(0);
  push();
  translate(0,0.05*height);
  
  for(int i=0;i<n;i++){
    for(int k=k1;k<=k2;k++){
      for(int j=0;j<1;j++){
        array[i].show(k+0.0025*j);
      }
    }
  }
  pop();
}