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

int samplesPerFrame = 3;
int numFrames = 150;        
float shutterAngle = .7;

boolean recording = true;

OpenSimplexNoise noise;

int n = 8;

float L = 300;

int m = 180;

float mr = 0.2;

class Thing{
  float x,y,xx;
  
  int K = 5;
  
  float offset = random(0.7);
  
  float seed = random(10,1000);
  
  Thing(int i, int j){
    x = map(i,0,n-1,-250,250);
    xx = 1.0*i/n;
    y = 1.0*j/N;
    
    //offset = map((float)noise.eval(1479+3*xx,4*y),-1,1,0,0.5);
    offset = random(0.65);
  }
  
  void show(){
    for(int k=0;k<K;k++){
      for(int i=0;i<m;i++){
        float p = constrain(4*(t-offset-0.1*i/m),0,1);
        p = ease(p,3.0);
        
        float sz = 1+1.5*sin(PI*i/m);
        
        stroke(255,70);
        strokeWeight(sz);
        
        float xx = x;
        float dx = 60*(float)noise.eval(seed+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t),0.25*k*sin(PI*i/m),4*p);
        xx = lerp(xx,xx+dx,sin(PI*p));
        
        float yy = lerp(-50,-50-L,p);
        float dy = 40*(float)noise.eval(2*seed+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t),0.25*k*sin(PI*i/m),4*p);
        yy = lerp(yy,yy+dy,sin(PI*p));
        
        point(xx,yy);
      }
    }
  }
}

int N = 10;

Thing[][] array = new Thing[n][N];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  rectMode(CENTER);
  
  for(int j=0;j<N;j++){
    for(int i=0;i<n;i++){
      array[i][j] = new Thing(i,j);
    }
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  translate(0,L*t);
  
  for(int j=0;j<N;j++){
    push();
    translate(0,0,-j*45*5);
    for(int i=0;i<n;i++){
      array[i][j].show();
    }
    pop();
  }
  
  pop();
}