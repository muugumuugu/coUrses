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

int samplesPerFrame = 7;
int numFrames = 60;        
float shutterAngle = .7;

boolean recording = true;

OpenSimplexNoise noise;

int n = 600;

int K = 12;

int sides = 3;

int L = 300;

class Triangle{
  float x = random(-L,L)/1.17;
  int type = floor(random(sides));
  float offset = random(1);
  
  float eps = random(-1,1);
  
  float sz = random(3,13);
  
  float rot = random(TWO_PI);
  
  float seed = random(10,1000);
  
  float sw = random(0.5,2.5);
  
  float sz(float p){
    float mr = 8.0;
    return sz*map((float)noise.eval(seed+mr*cos(TWO_PI*p),mr*sin(TWO_PI*p)),-1,1,0.8,1.2)*(1+1*pow(map(sin(TWO_PI*(10*p+t)),-1,1,0,1),7.0));
  }
  
  float the(float p){
    float mr = 0.5;
    return 0*25*map((float)noise.eval(2*seed+mr*cos(TWO_PI*p),mr*sin(TWO_PI*p)),-1,1,0,1);
  }
  
  void show(float p){
    push();
    translate(0,0,map(1-p,0,1,2000,-6000));
    
    rotateZ(TWO_PI*(type-t)/sides+PI+10*p);
    rotateX(HALF_PI);
    translate(x,0,L/2+eps);
    
    float Z = modelZ(0,0,0);
    
    float col = constrain(map(Z,0,-4500,1,0),0,1);
    col = 1;
    
    fill(0);
    stroke(255);
    strokeWeight(sw+7*(1-col));
    beginShape();
    for(int i=0;i<3;i++){
      float theta = TWO_PI*i/3+rot+the(p);
      vertex(sz(p)*cos(theta)*col,sz(p)*sin(theta)*col);
    }
    endShape(CLOSE);
    
    pop();
  }
}

Triangle[] array = new Triangle[n];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Triangle();
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  for(int i=0;i<n;i++){
    for(int k=0;k<K;k++){
      float p = map(k+t+array[i].offset,0,K,0,1);
      array[i].show(p);
    }
  }
  
  /*
  float rs = 28;
  fill(255);
  stroke(255);
  strokeWeight(2);
  beginShape();
  for(int i=0;i<sides;i++){
    float x = rs*cos(TWO_PI*i/sides-HALF_PI);
    float y = rs*sin(TWO_PI*i/sides-HALF_PI);
    vertex(x,y);
  }
  endShape(CLOSE);
  */
  pop();
}