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

    saveFrame("fr###.png");
    println(frameCount,"/",numFrames);
    if (frameCount==numFrames)
      exit();
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 10;
int numFrames = 80;        
float shutterAngle = 1.0;

boolean recording = true;

OpenSimplexNoise noise;

int n = 1000;

float R=150;

float mrf = 2.5;

class Star{
  float sz = random(0.75,2);
  
  float offset = random(1);
  
  float dr = 35*randomGaussian();
  
  float seed = random(10,1000);
  
  void show(float p){
    float tt = (100+p+offset)%1;
    
    tt = lerp(ease(tt,4.0),tt,0.3);
    
    float theta = tt*TWO_PI;
    
    float l = 0.05+ease(sin(PI*((tt+0.5)%1)),2.0);
    
    float r = R + l*(dr + 20*(float)noise.eval(seed+2.9*cos(theta),2.9*sin(theta)));
    
    float x = r*cos(theta)-25;
    float y = r*sin(theta);
    
    float f = map((float)noise.eval(2*seed+mrf*cos(TWO_PI*t),mrf*sin(TWO_PI*t)),-1,1,0.2,1);
    
    strokeWeight(sz);
    stroke(255,255*f);
    
    point(x,y);
  }
}

Star[] array = new Star[n];


void setup(){
  size(540,540,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Star();
  }
}

int K = 3;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  rotate(-HALF_PI);
  
  for(int i=0;i<n;i++){
    for(int k=0;k<K;k++){
      array[i].show((k+t)/K);
    }
  }
  
  pop();
}