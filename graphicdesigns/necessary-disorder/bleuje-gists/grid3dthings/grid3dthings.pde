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

float gl = 15;

int ni = 40;

int npmax = 50;

class Thing{
  float x0 = gl*(floor(random(ni))-ni/2);
  float y0 = gl*(floor(random(ni))-ni/2);
  float z0 = gl*(floor(random(5*ni))-5*ni/2);
  
  int np = floor(random(npmax/2,npmax));
  
  PVector[] path = new PVector[np+1];
  
  float x = x0;
  float y = y0;
  float z = z0;
  
  Thing(){
    path[0] = new PVector(x0,y0,z0);
    
    compute_path();
  }
  
  void compute_path(){
    for(int i=0;i<np;i++){
      int choice = floor(random(6));
      
      int jump = 1+floor(random(4));
      
      if(choice==0){
        x += jump*gl;
      }
      if(choice==1){
        x -= jump*gl;
      }
      if(choice==2){
        y += jump*gl;
      }
      if(choice==3){
        y -= jump*gl;
      }
      if(choice==4){
        z += jump*gl;
      }
      if(choice==5){
        z -= jump*gl;
      }
      
      path[i+1] = new PVector(x,y,z);
    }
  }
  
  PVector position(float p){
    float loc = 0.9999*p*np;
    int id1 = floor(loc);
    int id2 = id1+1;
    float interp = loc - floor(loc);
    
    float xx = lerp(path[id1].x,path[id2].x,interp);
    float yy = lerp(path[id1].y,path[id2].y,interp);
    float zz = lerp(path[id1].z,path[id2].z,interp);
    
    return new PVector(xx,yy,zz);
  }
  
  int m = 150;
  float part = 0.035;
  
  void show(float q){
    for(int i=0;i<m;i++){
      float p = constrain(map(q+part*i/m,0,1,-part,1),0,1);
      
      PVector pos = position(p);
      pos.add(new PVector(0,0,gl*4*q*K));
      
      stroke(255,20);
      strokeWeight(3);
      
      if((-pos.z + zdist)>0){
        //point(pos.x,pos.y,pos.z);
        PVector proj = projection(pos.x,pos.y,pos.z);
        strokeWeight(1000*proj.z);
        stroke(255,20*sin(PI*p));
        point(proj.x,proj.y);
      }
    }
  }
  
  int K = 7;
  
  void show(){
    for(int k=0;k<K;k++){
      float q = map(k+t,0,K,0,1);
      show(q);
    }
  }
}

float zdist = 150;

PVector projection(float x,float y,float z){
  float xx = 250*x/(-z + zdist);
  float yy = 250*y/(-z + zdist);
  return new PVector(xx,yy,1.0/(-z + zdist));
}

int n = 70;

Thing[] array = new Thing[n];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Thing();
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
  
  pop();
}