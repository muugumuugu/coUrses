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
int numFrames = 30;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

float R = 250;

PVector pos(float p,float theta){
  float x = R*cos(theta);
  float y0 = R*sin(theta);
  float z = map(p,0,1,400,-1500);
  float y = y0 - 2000*pow(p,3.0);
  
  return new PVector(x,y,z);
}

int n = 150;

int m = 150;

float zdist = 500;

PVector project(PVector vec){
  float x = 380*vec.x/(-vec.z+zdist);
  float y = 380*vec.y/(-vec.z+zdist);
  return new PVector(x,y,1/(-vec.z+zdist));
}

void showDot(float p,float theta){
  PVector v = pos(p,theta);
  
  float rad = 1.0;
  float a = 33.0;
  float offset = 7.0*p;
  float intensity = 5*pow(p,2.0);
  
  v.x += intensity*a*(float)noise.eval(123+0*10*theta+rad*cos(TWO_PI*(t-offset)),rad*sin(TWO_PI*(t-offset)),5*sin(theta),7*p);
  v.y += intensity*a*(float)noise.eval(1234+0*10*theta+rad*cos(TWO_PI*(t-offset)),rad*sin(TWO_PI*(t-offset)),5*sin(theta),7*p);
  
  PVector w = project(v);
  
  strokeWeight(1500*w.z);
  stroke(255,180);
  point(w.x,w.y);
}

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  for(int i=0;i<n;i++){
    float theta = TWO_PI*i/n;
    
    for(int j=0;j<m;j++){
      float p = map(j-6*t,0,m,0,1);
      
      showDot(p,theta);
    }
  }
  
  pop();
}