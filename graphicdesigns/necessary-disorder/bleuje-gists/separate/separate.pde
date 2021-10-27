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
int numFrames = 150;        
float shutterAngle = .8;

boolean recording = true;

OpenSimplexNoise noise;

PVector cur(float p){
  float rad = 1.7;
  float mr = 0.06;
  float x = 0.7*width*(float)noise.eval(723+rad*cos(TWO_PI*p),rad*sin(TWO_PI*p),mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
  float y = 0.7*height*(float)noise.eval(7234+rad*cos(TWO_PI*p),rad*sin(TWO_PI*p),mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
  
  return new PVector(x,y);
}

float sw(float p){
  float rad = 1.5;
  float mr = 0.05;
  float res = map((float)noise.eval(12+rad*cos(TWO_PI*p),rad*sin(TWO_PI*p),mr*cos(TWO_PI*t),mr*sin(TWO_PI*t)),-1,1,1,3.5);
  return res;
}


int m = 700;

void draw_curve(){
  stroke(255,75);
  for(int i=0;i<m;i++){
    float p = 1.0*i/m;
    PVector res = cur(p);
    strokeWeight(sw(p));
    point(res.x,res.y);
  }
  
}

int K = 5;

int mm = 20;

void draw_dots(int k,float c){
  float p = 1.0*(k+t+c)/K;
  PVector res = cur(p);
  float l = map(ease(pow(map(sin(TWO_PI*(p+c)*3),-1,1,0,1),2.5),3.0),0,1,2,50);
  push();
  translate(res.x,res.y);
  float rot = (float)noise.eval(19+10*(c+1)+1.0*cos(TWO_PI*p),1.0*sin(TWO_PI*p));
  rotate(TWO_PI*rot);
  float mr = 0.5;
  for(int i=0;i<mm;i++){
    float dx = l*(float)noise.eval(14*(c+1)+i+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
    float dy = l*(float)noise.eval(44*(c+1)+i+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
    float sz = map((float)noise.eval(444*(c+1)+i+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t)),-1,1,0,5);
    stroke(255,200);
    strokeWeight(sz);
    point(dx,dy);
  }
  pop();
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
  
  draw_curve();
  
  for(int i=0;i<K;i++){
    draw_dots(i,0);
  }
  
  for(int i=0;i<K;i++){
    draw_dots(i,0.25);
  }
  
    for(int i=0;i<K;i++){
    draw_dots(i,0.5);
  }
  
  for(int i=0;i<K;i++){
    draw_dots(i,0.75);
  }
  
  pop();
}