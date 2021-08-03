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
int numFrames = 90;        
float shutterAngle = 1.4;

boolean recording = true;

OpenSimplexNoise noise;

int n = 10;

int N = 12000;

int K = 4;

class Dot{
  int ind = floor(random(n));
  float x = map(ind,0,n-1,100,width-100);
  float offset = random(1);
  
  //float dx = random(-20,20);
  float dx = 15*randomGaussian();
  float seed = random(10,1000);
  
  float add = random(0,300);
  
  float sz = 1;
  
  Dot(){
    
  }
  
  void show(){
    for(int k=0;k<K;k++){
      float p = (1.0*(k+1*(t+offset))/K)%1;
      float y = map(p,0,1,-100,height+100+add);
      
      float mr = 0.3;
      
      float ns = ease(constrain(map((float)noise.eval(123+0.02*x,0.015*y,mr*cos(TWO_PI*t),mr*sin(TWO_PI*t)),-1,1,-1.5,1.5),0.1,1),1.5);
      
      float xx = x + ns*dx;
      
      stroke(255,255);
      strokeWeight(sz);
      point(xx,y);
    }
  }
  
  
}


Dot[] array = new Dot[N];

void setup(){
  size(540,540,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<N;i++){
    array[i] = new Dot();
  }
}

void draw_(){
  background(0);
  
  for(int i=0;i<N;i++){
    array[i].show();
  }
}