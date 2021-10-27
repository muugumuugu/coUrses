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

int samplesPerFrame = 1;
int numFrames = 25;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

int K = 4;
int n = 3000;
int turns = 45;

class Digit{
  float seed = random(10,1000);
  int seed2 = floor(random(100,10000));
  
  void show(float p){
    int mult = floor(2*seed2+700*(1+p+0.8*(float)noise.eval(1.0*p,seed)));
    
    int d = (seed2+mult*2017)%10;
    
    float alpha = 255*constrain(450*p-0.5,0,1);
    
    textSize(11);
    fill(255,alpha);
    
    text(d,0,0);
  }
}

Digit[] array = new Digit[K];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<K;i++){
    array[i] = new Digit();
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  rotate(-HALF_PI);
  
  for(int k=0;k<K;k++){
    for(int i=0;i<n;i++){
      float p = (1.0*(i+t+1.0*k/K)/n)%1;
      
      float theta = turns*TWO_PI*pow(p,0.5);
      float r = 1.0*width*pow(p,0.5);
      float x = r*cos(theta);
      float y = r*sin(theta);
      
      push();
      translate(x,y);
      rotate(theta+HALF_PI);
      
      array[k].show(p);
      
      pop();
    }
  }
  
  pop();
}