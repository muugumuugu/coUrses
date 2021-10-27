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

int samplesPerFrame = 1;
int numFrames = 40;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

int n = 1300;
int m = 1500;

float R = 200;

void drawSphere(){
  randomSeed(1337);
  for(int i=0;i<n;i++){
    float theta = map(i,0,n,0,TWO_PI);
    for(int j=0;j<m;j++){
      float v = map(j+1,0,m+1,-1,1);
      float phi = acos(v);
      
      float x = R*cos(theta)*sin(phi);
      float z = R*sin(theta)*sin(phi);
      float y = R*cos(phi);

      float D = 15;
      float rad = 1.2;
      float offset = -4.5*phi+4*theta/TWO_PI;

      float dx = D*(float)noise.eval(123+rad*cos(TWO_PI*(t-offset)),rad*sin(TWO_PI*(t-offset)),3.0*phi);
      float dy = D*(float)noise.eval(223+rad*cos(TWO_PI*(t-offset)),rad*sin(TWO_PI*(t-offset)),3.0*phi);
      float dz = D*(float)noise.eval(323+rad*cos(TWO_PI*(t-offset)),rad*sin(TWO_PI*(t-offset)),3.0*phi);
      
      x += dx;
      y += dy;
      z += dz;
      
      
      //drawing with self made projection
      
      float df = 1.7;
      
      stroke(255,6);
      strokeWeight(400.0/(-z+df*R));
      
      float xx = 240*x/(-z+df*R);
      float yy = 240*y/(-z+df*R);
      
      point(xx,yy);
    }
  }
}


void setup(){
  size(600,600,P2D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  drawSphere();

  pop();
}