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
int numFrames = 24;        
float shutterAngle = 1.0;

boolean recording = true;

OpenSimplexNoise noise;

float r = 170;
float R = 1000;

void drawDigit(float theta, float alpha, char c){
  push();
  translate(0,-R+R*cos(alpha),R*sin(alpha));
  
  push();
  rotateX(alpha);
  rotateZ(theta);
  rotateX(HALF_PI);  
  translate(0,0,r);
  
  push();
  rotateX(PI);
  rotate(3*HALF_PI);
  
  fill(255);
  stroke(255);
  textSize(20);
  text(c,0,0);
  
  pop();
  
  translate(0,0,1);
  
  fill(0);
  stroke(0);
  rect(0,0,50,50);
  
  pop();
  
  pop();
}

int n = 45;

int L = 6;

class Digit{
  float mr = 0.75;
  
  float theta = random(TWO_PI);
  
  float offset = 1.0*floor(random(6))/6;
  
  float seed = random(10,1000);
  int seed2 = floor(random(100,10000));
  int seed3 = floor(random(100,10000));
  
  int mod = 2017;
  
  Digit(int i,int k){
    offset = 1.0*k/L;
    theta = TWO_PI*i/n;
    
    k = (k+seed3)%L;
    
    if(k==0){
      mod = 13;
    }
    if(k==1){
      mod = 17;
    }
    if(k==2){
      mod = 29;
    }
    if(k==3){
      mod = 23;
    }
    if(k==4){
      mod = 31;
    }
    if(k==5){
      mod = 37;
    }
    
  }
  
  char value(float alpha){
    float p = alpha/TWO_PI;
    int mult = floor(2*seed2+15*(1+p+0.8*(float)noise.eval(1.5*p,seed)));
    
    int d = (seed2+mult*mod)%10;
    
    return (char)(d + '0');
  }
}

Digit[] array = new Digit[n*L];


void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  rectMode(CENTER);
  
  int k = 0;
  for(int j=0;j<L;j++){
    for(int i=0;i<n;i++){
      array[k] = new Digit(i,j);
      k++;
    }
  }
}

int nn = 30;

int N = 60;


void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  rotate(HALF_PI*3);
  translate(0,-0.05*height,0.1*height);
  
  for(int i=0;i<n*L;i++){
    Digit d = array[i];
    for(int j=0;j<N;j++){
      float alpha = map(j+d.offset-t,N,0,-PI,PI);
      drawDigit(d.theta+0.0*alpha,alpha,d.value(alpha));
    }
  }
  
  pop();
}