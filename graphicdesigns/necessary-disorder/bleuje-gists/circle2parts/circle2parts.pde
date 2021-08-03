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
int numFrames = 80;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

float R = 180;

class Thing{
  float seed = random(10,1000);
  
  float x0,y0,x1,y1;
  
  Thing(int i){
    x0 = map(i,0,n-1,width/2-250,width/2+250);
    float theta = map(i,0,n-1,HALF_PI-1.5,HALF_PI+1.5);
    x0 = R*cos(theta);
    y0 = R*sin(theta);
    x1 = x0;
    y1 = -y0;
  }
  
  PVector pos(float p,float tt){
    
    p = constrain(p,0,1);
    
    float y = map(p,0,1,y0,y1);
    
    float rad = 0.7;
    float change = 8.0;
    float freq = 4.0;
    float variation = 0.012;
    
    float intensity = ease(pow(sin(PI*p),2.0),1.3)+0;
    
    float pp = p;
    
    float dx = 0.2*intensity*200*(float)noise.eval(SEED + rad*cos(TWO_PI*(freq*pp - tt)), rad*sin(TWO_PI*(freq*pp - tt)),change*p,variation*x0);
    float dy = 0.2*intensity*150*(float)noise.eval(2*SEED + rad*cos(TWO_PI*(freq*pp - tt)), rad*sin(TWO_PI*(freq*pp - tt)),change*p,variation*x0);
    
    float x = lerp(map(p,0,1,x0,x1)+dx,width/4,pow(sin(PI*p),3.0)/1.1);
    y = lerp(y,-0*height/6,pow(sin(PI*p),3.0)/1.1);
    
    return new PVector(x,y+dy);
  }
  
  int K = 3+floor(15*pow(random(1),2.0));
  
  void show_dots(float tt){
    for(int i=0;i<K;i++){
      int N = 50;
      for(int q=0;q<N;q++){
        float p = map(i+1-tt+0.01*q,0,K,-0.1,1.1);
        
        PVector dot = pos(p,t);
        
        strokeWeight(4.0*pow(map(q,0,N,1,0),1.5));
        stroke(255,50);
        point(dot.x,dot.y);
      }
    }
  }
  
  int m = 600;
  
  void show_curve(){
    for(int i=0;i<=m;i++){
      float p = map(i,0,m,0,1);
      
      PVector dot = pos(p,t);
      
      strokeWeight(1.7);
      stroke(255,30);
      point(dot.x,dot.y);
    }
  }
  
  float offset = random(1);
  
  void show(){
    float tt = (t+offset)%1;
    show_curve();
    show_dots(tt);
    
    strokeWeight(6.0);
    stroke(255,255);
    point(x0,y0);
    point(x1,y1);
  }
}

int n = 40;

Thing[] array = new Thing[n];

float SEED;

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  SEED = random(10,1000);
  
  for(int i=0;i<n;i++){
    array[i] = new Thing(i);
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
  pop();
}