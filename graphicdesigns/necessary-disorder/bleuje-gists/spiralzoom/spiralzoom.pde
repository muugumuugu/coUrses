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
int numFrames = 60;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

int K = 10;

float RATIO = 1.6;

int N = 2;

class Thing{
  float theta = random(TWO_PI);
  
  float seed = random(10,1000);
  
  //float sw = 2*pow(random(1),1.25);
  
  float sw = random(0.75,1.25);
  
  float offset = random(1);
  
  Thing(int i){
    offset = (N*1.0*i/n)%1;
    theta = TWO_PI*i/n;
  }
  
  int m = 100;
  
  void show(){
    for(int k=0;k<K;k++){
      float p = map(k+t,0,K,0,1);
      float q = 7*pow(RATIO,p*K+offset);
      
      push();
      rotate(-0.5*TWO_PI*p);
      
      
      //stroke(255);
      
      float R = q*1.0;
      
      float X = R*cos(theta);
      float Y = R*sin(theta);
      
      float var1 = map((float)noise.eval(3*seed,18*p),-1,1,0.5,2.0);
      
      for(int i=0;i<m;i++){
        float v = 1.0*i/m;
        
        float pp = 5*pow(p,3.0);
        
        float r = R+v*pp*0.12*R*(float)noise.eval(seed,200*v*v*1,20*p) - v*v*2*0.2*R;
        float the = theta+v*pp*0.12*theta*(float)noise.eval(2*seed,40*v*v*1,10*p) + 1.7*v*pp;
        
        float x = r*cos(the);
        float y = r*sin(the);
        
        float f = (i==0?2:1);
        
        float f2 = map((float)noise.eval(4*seed,1000*v),-1,1,0.5,1.5)*(1.1-v);
        
        strokeWeight(0.007*sw*q*f*var1*f2);
        stroke(255,(i==0?255:355*p));
        
        point(x,y);
      }
      
      //point(x,y);
      
      pop();
    }
  }
}

int n = 10*N;

Thing[] array = new Thing[n];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Thing(i);
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