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
int numFrames = 150;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

PVector position(float r,float theta,float phi){
  return new PVector(r*cos(theta)*sin(phi),r*cos(phi),r*sin(theta)*sin(phi));
}

int m = 400;

float R = 100;

int steps = -24;

float D = 250;
float scl = 0.018;
float SEED;
float mr = 0.8;

PVector distortion(PVector pos){
  float dx = D*(float)noise.eval(SEED+scl*pos.x,scl*pos.y+mr*cos(TWO_PI*t),scl*pos.z+mr*sin(TWO_PI*t));
  float dy = D*(float)noise.eval(2*SEED+scl*pos.x,scl*pos.y+mr*cos(TWO_PI*t),scl*pos.z+mr*sin(TWO_PI*t));
  float dz = D*(float)noise.eval(3*SEED+scl*pos.x,scl*pos.y+mr*cos(TWO_PI*t),scl*pos.z+mr*sin(TWO_PI*t));
  
  return new PVector(dx,dy,dz);
}

float activation(PVector pos){
  float intensity = pow(sin(map(pos.y,-R,R,0,1)*PI),0.2);
  float val = intensity*pow((1+(float)noise.eval(4*SEED+scl*pos.x/2,scl*pos.y/2+mr*cos(TWO_PI*t),scl*pos.z/2+mr*sin(TWO_PI*t)))/2,4.0);
  
  return val;
}

PVector project(PVector pos){
  float A = 250;
  float B = 0.45*width;
  
  pos.add(distortion(pos).mult(activation(pos)));
  
  return new PVector(A*pos.x/(-pos.z+B),A*pos.y/(-pos.z+B));
}

float sw(float z){
  return 1.0+1.0*pow(map(z,-R,R,0,1),2.0);
}

float alp(float z){
  return (100+155*pow(map(z,-R,R,0,1),2.0))/3;
}

void draw_theta(float theta){
  for(int i=0;i<m;i++){
    PVector pos = position(R,theta,PI*i/m);
    float x = pos.x;
    float y = pos.y;
    float z = pos.z;
    
    strokeWeight(sw(z));
    stroke(255,alp(z));
    
    PVector pix = project(pos);
    
    point(pix.x,pix.y);
  }
}

void draw_phi(float phi){
  for(int i=0;i<m;i++){
    PVector pos = position(R,TWO_PI*(1.0*i/m+steps*t/n),phi);
    float x = pos.x;
    float y = pos.y;
    float z = pos.z;
    
    strokeWeight(sw(z));
    stroke(255,alp(z));
    
    PVector pix = project(pos);
    
    point(pix.x,pix.y);
  }
}

void setup(){
  size(600,600,P2D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  SEED = random(10,1000);
}

int n = 35;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  for(int i=0;i<n;i++){
    draw_theta(TWO_PI*(i+steps*t)/n);
    draw_phi(PI*i/n);
  }

  pop();
}