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
int numFrames = 20;        
float shutterAngle = .9;

boolean recording = true;

OpenSimplexNoise noise;

class Digit{
  int nd = floor(random(5,10));
  
  ArrayList<Integer> digits = new ArrayList<Integer>();
  ArrayList<Float> digittime = new ArrayList<Float>();
  
  float tm = 0;
  
  Digit(){
    digittime.add(0.0);
    for(int i=0;i<nd;i++){
      digits.add(floor(random(0,10)));
      float tmp = random(1,10);
      tm += tmp;
      digittime.add(tm);
    }
  }
  
  float offset = random(1);
  
  int res(float p){
    p = (p+1324+offset)%1;
    int res = 0;
    int i = 0;
    while(digittime.get(i)/tm<=p){
      res = digits.get(i);
      i++;
    }
    return res;
  }
}

int m = 170;

float R = 170;

class Circle{
  Digit[] array = new Digit[m];
  
  Circle(){
    for(int i=0;i<m;i++){
      array[i] = new Digit();
    }
  }
  
  float seed = random(10,100);
  
  void show(float p){
    float y = map(p,0,1,-height,height);
    
    push();
    translate(0,y,0);
    
    for(int i=0;i<m;i++){
      push();
      float rot = p*1.5*(float)noise.eval(seed+9*p,0);
      rotateY(TWO_PI*i/m+rot);
      translate(0,0,R);
      
      textSize(10);
      
      float strok = map(modelZ(0,0,0),R/2,-R,255,0);
      
      stroke(strok);
      fill(strok);
      
      text(array[i].res(2.7*p),0,0);
      
      pop();
    }
    
    
    pop();
  }
}

int n = 3;

Circle[] arraycircles = new Circle[n];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    arraycircles[i] = new Circle();
  }
}

int K = 40;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  rotateX(0.0);
  
  for(int i=0;i<n;i++){
    for(int k=0;k<K;k++){
      float p = map(k+t+1.0*i/n,0,K,0,1);
      arraycircles[i].show(p);
    }
  }
  
  pop();
}