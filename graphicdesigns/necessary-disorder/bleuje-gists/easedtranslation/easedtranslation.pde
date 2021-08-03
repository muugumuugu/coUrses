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

int samplesPerFrame = 5;
int numFrames = 250;        
float shutterAngle = .5;

boolean recording = true;

OpenSimplexNoise noise;

float L = 2000;

int border = 100;

int nc = 7000;

PVector pos(float p){
  float rad = 4.5;
  float mr = 0.2;
  float x = width/2 + 0.25*width*(float)noise.eval(125+rad*cos(TWO_PI*p),rad*sin(TWO_PI*p),mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
  float y = p*L + 0.25*height*(float)noise.eval(1235+rad*cos(TWO_PI*p),rad*sin(TWO_PI*p),mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
  return new PVector(x,y);
}

void draw_curve(){
  stroke(255,70);
  for(int i=-nc;i<2*nc;i++){
    float p = 1.0*i/nc;
    PVector v = pos(p);
    float sw = map((float)noise.eval(12+3.0*cos(TWO_PI*p),3.0*sin(TWO_PI*p)),-1,1,0.75,5.0);
    strokeWeight(sw);
    point(v.x,v.y);
  }
}

int n = 130;

class Thing{
  float p = random(0,1);
  float sp = 150;
  float dx = random(-sp,sp);
  float dy = random(-sp,sp);
  
  float pmr = random(0.4,1.1);
  float r = 1.5*random(15,60);
  
  float seed = random(10,1000);
  
  float sz = random(2,9)/2;
  
  void show0(int k){
    push();
    PVector v = pos(p);
    translate(v.x,v.y + k*L);
    float dxx = dx + r*(float)noise.eval(seed+pmr*cos(TWO_PI*t),pmr*sin(TWO_PI*t));
    float dyy = dy + r*(float)noise.eval(2*seed+pmr*cos(TWO_PI*t),pmr*sin(TWO_PI*t));
    strokeWeight(sz);
    stroke(255);
    point(dxx,dyy);
    strokeWeight(sz/3);
    stroke(255,120);
    push();
    translate(0,0,-1);
    line(dxx,dyy,0,0);
    pop();
    pop();
  }
  
  void show(){
    show0(-1);
    show0(0);
    show0(1);
  }
}

Thing[] array = new Thing[n];

void setup(){
  size(500,500,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Thing();
  }
}

void draw_(){
  background(0);
  push();
  
  translate(0,-L*lerp(ease(t,2.7),t,0.2));
  
  draw_curve();
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
  
  pop();
}