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
int numFrames = 25;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

float R1 = 300;

float R2 = 1500;

class Particle{
  float theta = random(TWO_PI);
  float offset = random(1);
  float r = random(-5,5)+R1;
  
  float sz = random(1,2.0);
  
  float seed = random(10,1000);
  
  int K = 6;
  
  float L = random(5,120);
  int m = floor(random(40,60));
  float D = random(5,25);
  float change2 = random(1.0,7.0);
  
  float change1 = 4.0;
  
  void show(){
    for(int i=0;i<K;i++){
      float p = (1.0*(i-t+offset)/K)%1;
      
      float alp = map(p,0,1,-PI,-HALF_PI+0.3);
      
      float x = R1*sin(theta);
      float y = R2+(R2+r*cos(theta))*cos(alp)-50;
      float z = (R2+r*cos(theta))*sin(alp)-50;
      
      float x1 = x + L*(float)noise.eval(change1*p,seed);
      float y1 = y + L*(float)noise.eval(change1*p,2*seed);
      float z1 = z + L*(float)noise.eval(change1*p,3*seed);
      
      float x2 = x + L*(float)noise.eval(change1*p,4*seed);
      float y2 = y + L*(float)noise.eval(change1*p,5*seed);
      float z2 = z + L*(float)noise.eval(change1*p,6*seed);
      
      
      for(int j=0;j<=m;j++){
        float q = 1.0*j/m;
        
        float dx = D*sin(PI*q)*(float)noise.eval(change2*q,7*seed+change1*p);
        float dy = D*sin(PI*q)*(float)noise.eval(change2*q,8*seed+change1*p);
        float dz = D*sin(PI*q)*(float)noise.eval(change2*q,9*seed+change1*p);
        
        float xx = lerp(x1,x2,q)+dx;
        float yy = lerp(y1,y2,q)+dy;
        float zz = lerp(z1,z2,q)+dz;
        
        stroke(255,40);
        strokeWeight(sz+map(z,-R2,0,0,1));
        
        float xxx = 500*xx/(-zz+0.5*width);
        float yyy = 500*yy/(-zz+0.5*width);
      
      if(-zz+0.5*width>0) point(xxx,yyy);
      }
    }
  }
}

int n = 400;

Particle[] array = new Particle[n];


void setup(){
  size(600,600,P2D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Particle();
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