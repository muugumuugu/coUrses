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
int numFrames = 150;        
float shutterAngle = 1.6;

boolean recording = true;

OpenSimplexNoise noise;

int nStar = 5000;

class Star{
  float x = random(0,width);
  float y = random(0,height);
  
  float sz = random(0.5,2.5);
  
  float seed = random(10,1000);
  
  void show(){
    float r = sz*map((float)noise.eval(seed+1.8*cos(TWO_PI*t),1.8*sin(TWO_PI*t)),-1,1,0.5,1.5);
    
    float dx = 0;
    float dy = 0;
    
    for(int i=0;i<nc;i++){
      float q = map(i+t,0,nc,0,1);
      PVector center = new PVector(ct.R*cos(TWO_PI*q)+width/2,ct.R*sin(TWO_PI*q)+height/2);
      PVector n = new PVector(center.x-x,center.y-y);
      n.normalize();
      float d = dist(center.x,center.y,x,y);
      //float m = 30*exp(-d*d/50/50);
      float m = 30*exp(-d/70);
      n.mult(m);
      dx += n.x;
      dy += n.y;
    }
    strokeWeight(r);
    stroke(255,200);
    point(x+dx,y+dy);
  }
}

Star[] array = new Star[nStar];

class Contour{
  float seed = random(10,1000);
  
  float r = 50;
  
  int n = 800;
  
  float rad = 1.0;
  
  float mr = 1.3;
  
  float R = 170;
  
  float r(float p,float q){
    return map((float)noise.eval(seed+rad*cos(TWO_PI*p),rad*sin(TWO_PI*p),mr*cos(TWO_PI*q),mr*sin(TWO_PI*q)),-1,1,r/2,2*r);
  }
  
  float sz(float p,float q){
    return map((float)noise.eval(seed+rad*cos(TWO_PI*p),rad*sin(TWO_PI*p),mr*cos(TWO_PI*q),mr*sin(TWO_PI*q)),-1,1,0,0.8);
  }
  
  float x(float p,float q){
    return width/2+R*cos(TWO_PI*q)+r(p,q)*cos(TWO_PI*p);
  }
  
  float y(float p,float q){
    return height/2+R*sin(TWO_PI*q)+r(p,q)*sin(TWO_PI*p);
  }
  
  void show0(float q){
    stroke(255,100);
    
    for(int i=0;i<n;i++){
      float p = 1.0*i/n;
      strokeWeight(3.0*sz(p,q));
      point(x(p,q),y(p,q));
    }
  }
  
  void draw_mask(float q){
    noStroke();
    fill(255);
    
    beginShape();
    for(int i=0;i<n;i++){
      float p = 1.0*i/n;
      vertex(x(p,q),y(p,q));
    }
    endShape(CLOSE);
  }
}

Contour ct;

PImage msk;
PImage imgStars;

PImage putIntoImage(){
  PImage res = createImage(width,height,RGB);
  for(int i=0;i<width;i++){
    for(int j=0;j<height;j++){
      res.set(i,j,get(i,j));
    }
  }
  return res;
}

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  ct = new Contour();  
  
  for(int i=0;i<nStar;i++){
    array[i] = new Star();
  }
}

int nc = 5;

void draw_(){
  background(0);
  push();
  for(int i=0;i<nc;i++){
    float q = map(i+t,0,nc,0,1);
    ct.draw_mask(q);
  }
  msk = putIntoImage();
  background(0);
  
  for(int i=0;i<nStar;i++){
    array[i].show();
  }
  
  imgStars = putIntoImage();
  background(0);
  
  imgStars.mask(msk);
  
  image(imgStars,0,0);
  for(int i=0;i<nc;i++){
    float q = map(i+t,0,nc,0,1);
    ct.show0(q);
  }
  
  pop();
}