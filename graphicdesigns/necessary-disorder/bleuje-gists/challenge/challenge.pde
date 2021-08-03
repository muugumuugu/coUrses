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
float shutterAngle = .6;

boolean recording = false;

OpenSimplexNoise noise;

float R = 100;

float turns = 10;

float curvex(float p){
  return R*cos(5*TWO_PI*p);
}

float curvey(float p){
  return R*sin(5*TWO_PI*p);
}

float curvez(float p){
  return -400*(p-0.5);
}

float eps = 0.0000001;

PVector t(float p){
  float vx = (curvex(p+eps)-curvex(p))/eps;
  float vy = (curvey(p+eps)-curvey(p))/eps;
  float vz = (curvez(p+eps)-curvez(p))/eps;
  PVector res = new PVector(vx,vy,vz);
  res.normalize();
  return res;
}

public PVector pos2(float p,float theta,float r){
  PVector p0 = new PVector(curvex(p),curvey(p),curvez(p));
  PVector n = t(p);
  
  float d = - n.x*p0.x - n.y*p0.y - n.z*p0.z;
  
  float y = 1;
  float x = (-d-y*n.y)/n.x;
  
  PVector v1 = new PVector(x-p0.x,y-p0.y,-p0.z);
  v1.normalize();
  
  PVector v2 = v1.cross(n);
  v2.normalize();
  
  PVector res = new PVector(v1.x*cos(theta)+v2.x*sin(theta),v1.y*cos(theta)+v2.y*sin(theta),v1.z*cos(theta)+v2.z*sin(theta));
  res.mult(r);
  
  res.add(p0);
  
  return res;
}

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
}
int m = 3000;

int K = 25;

int N = 7;

float rr = 10;

int m2 = 400;

public void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  rotateY(0.01*mouseX);

  stroke(255,255);
  strokeWeight(3);
  
  for(int i=0;i<m;i++){
    float p = 1.0*i/m;
    push();
    translate(0,0,curvez(p));
    point(curvex(p),curvey(p));
    pop();
  }
  
  float q = 1.0*mouseY/height;
  
  PVector tang = t(q);
  
  stroke(255,0,0);
  
  float xx = curvex(q);
  float yy = curvey(q);
  float zz = curvez(q);
  
  line(xx,yy,zz,xx+100*tang.x,yy+100*tang.y,zz+100*tang.z);
  
  stroke(0,255,0);
  strokeWeight(1);
  
  for(int i=0;i<m2;i++){
    float p = 1.0*i/m2;
    
    int c = (i%N)<1?200:50;
    
    fill(c);
    stroke(c);
    
    beginShape(TRIANGLE_STRIP);
    for(int k=0;k<=K;k++){
      float theta = TWO_PI*k/K;
      PVector res1 = pos2(p,theta,rr);
      PVector res2 = pos2(p+1.0/m2,theta,rr);
      vertex(res1.x,res1.y,res1.z);
      vertex(res2.x,res2.y,res2.z);
    }
    endShape();
  }
  
  /*
  for(int i=0;i<=m2;i++){
    float interp =  1.0*i/m2;
    
    PVector res = pos;
    res.lerp(pos2,interp);
    
    point(res.x,res.y,res.z);
  }*/
  
/*
  for(int i=0;i<m;i++){
    float p1 = 1.0f*(i+N*t)/m;
    float p2 = 1.0f*(i+1+N*t)/m;
    
    float c = (i%N)<4?255:0;
    
    fill(c);
    noStroke();
    
    beginShape(TRIANGLE_STRIP);
    for(int k=0;k<=K;k++){
      float theta = TWO_PI*k/K;
      
      PVector v1 = pos2(p1,theta,rr).add(pos(p1));
      PVector v2 = pos2(p2,theta,rr).add(pos(p2));
      vertex(v1.x,v1.y,v1.z);
      vertex(v2.x,v2.y,v2.z);
    }
    endShape();
    /*
    push();
    translate(curvex(p),curvey(p),curvez(p));
    stroke(255);
    strokeWeight(3);
    point(0,0);
    pop();*/
  
  pop();
}