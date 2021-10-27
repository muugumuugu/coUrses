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
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

float R = 250;

float RAD = 0.85;

float curvex(float p){
  return R*(float)noise.eval(12+RAD*cos(TWO_PI*p),RAD*sin(TWO_PI*p));
}

float curvey(float p){
  return R*(float)noise.eval(123+RAD*cos(TWO_PI*p),RAD*sin(TWO_PI*p));
}

float curvez(float p){
  return R*(float)noise.eval(1234+RAD*cos(TWO_PI*p),RAD*sin(TWO_PI*p));
}

float eps = 0.001;

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
  
  float x,y,z;
  
  if(abs(n.x)>0.25){
    z = 0;
    y = 1;
    x = (-d-y*n.y)/n.x;
  } else if(abs(n.y)>0.25) {
    z = 0;
    x = 1;
    y = (-d-x*n.x)/n.y;
  } else {
    x = 0;
    y = 1;
    z = (-d-y*n.y)/n.z;
  }
  
  PVector v1 = new PVector(x-p0.x,y-p0.y,z-p0.z);
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

int N = 100;

float rr = 23;

int m2 = 2000;

public void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  rotateY(TWO_PI*t);

  stroke(255,255);
  strokeWeight(3);
  
  for(int i=0;i<m;i++){
    float p = 1.0*i/m;
    push();
    translate(0,0,curvez(p));
    point(curvex(p),curvey(p));
    pop();
  }
  
  stroke(0,255,0);
  strokeWeight(1);
  
  for(int i=0;i<m2;i++){
    float p = 1.0*(i+13*N*t)/m2;
    
    int c = (i%N)<4?13:232;
    
    fill(c);
    noStroke();
    
    ArrayList<PVector> list1 = new ArrayList<PVector>();
    ArrayList<PVector> list2 = new ArrayList<PVector>();
    for(int k=0;k<K;k++){
      float theta = TWO_PI*k/K;
      PVector res1 = pos2(p,theta,rr);
      PVector res2 = pos2(p+1.0/m2,theta,rr);
      list1.add(res1);
      list2.add(res2);
    }
    
    float rec = 1e10;
    int ind_offset = 0;
    PVector ref = list1.get(0);
    for(int k=0;k<K;k++){
      PVector sec = list2.get(k);
      float d = dist(ref.x,ref.y,ref.z,sec.x,sec.y,sec.z);
      if(d<rec){
        rec = d;
        ind_offset = k;
      }
    }
    
    beginShape(TRIANGLE_STRIP);
    for(int k=0;k<=K;k++){
      PVector res1 = list1.get(k%K);
      PVector res2 = list2.get((k+ind_offset)%K);
      vertex(res1.x,res1.y,res1.z);
      vertex(res2.x,res2.y,res2.z);
    }
    endShape();
  }
  pop();
}