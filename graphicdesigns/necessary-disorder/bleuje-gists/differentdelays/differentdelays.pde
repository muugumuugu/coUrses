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

float r1 = 50;
float r2 = 75;

float x1(float p){
  return 0.25*width + r1*cos(3*TWO_PI*(p+t));
}
float y1(float p){
  return 0.25*height + r1*sin(3*TWO_PI*(p+t));
}

float x2(float p){
  return 0.75*width + r2*cos(-4*TWO_PI*(p+t));
}
float y2(float p){
  return 0.75*height + r2*sin(-4*TWO_PI*(p+t));
}

void setup(){
  size(600,600,P2D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
}

int m = 1500;

int K = 60;

void draw_(){
  background(0);
  push();
  
  for(int k=0;k<K;k++){
    float df = 0.025*k;
    
    for(int i=0;i<=m;i++){
      float tt = 1.0*i/m;
      float x = lerp(x1(-df*tt),x2(-df*(1-tt)),tt);
      float y = lerp(y1(-df*tt),y2(-df*(1-tt)),tt);
      
      stroke(255,map(k,0,K,75,10));
      strokeWeight(1.5);
      
      point(x,y);
    }
  }
  
  pop();
}