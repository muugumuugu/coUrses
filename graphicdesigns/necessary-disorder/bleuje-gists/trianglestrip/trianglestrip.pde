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
int numFrames = 30;        
float shutterAngle = 0.8;

boolean recording = true;

OpenSimplexNoise noise;

int n = 300;

int K = 60;

/*
float depth(float x,float y){
  return 2000*dist(x,y,0,0)/(0.6*width)-2000;
}*/

float depth(float x,float y){
  return 100*(float)noise.eval(0.01*x,0.01*y)-50;
}

class Thing{
  float l = random(10,100);
  float h = random(1,3);
  
  float offset = random(1);
  
  float Y = random(-height/1.5,height/1.5);
  
  void show(float p){
    p = (1234+p+offset)%1;
    
    float X = map(p,0,1,-0.8*width,0.8*width);
    
    fill(255);
    stroke(255);
    
    beginShape(TRIANGLE_STRIP);
    for(int i=0;i<K;i++){
      float dx = map(i,0,K-1,0,l);
      float x = X+dx;
      float y1 = Y-h/2;
      float y2 = Y+h/2;
      float z1 = depth(x,y1);
      float z2 = depth(x,y2);
      vertex(x,y1,z1);
      vertex(x,y2,z2);
    }
    endShape();
  }
}

Thing[] array = new Thing[n];

int res = 1000;

float div = 1.5;

void draw_black(){
  for(int i=0;i<res;i++){
    
    fill(0);
    stroke(0);
    
    beginShape(TRIANGLE_STRIP);
    for(int j=0;j<res;j++){
      float x = map(i,0,res-1,-width/div,width/div);
      float y = map(j,0,res,-height/div,height/div);
      float y2 = map(j+1,0,res,-height/div,height/div);
      float d = depth(x,y);
      vertex(x,y,d-3);
      vertex(x,y2,d-3);
    }
    endShape();
  }
}

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Thing();
  }
}

int N = 5;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2-150);
  rotateX(0.3*PI);
  
  draw_black();
  
  for(int j=0;j<N;j++){
    for(int i=0;i<n;i++){
      array[i].show((t+j)/N);
    }
  }
  
  pop();
}