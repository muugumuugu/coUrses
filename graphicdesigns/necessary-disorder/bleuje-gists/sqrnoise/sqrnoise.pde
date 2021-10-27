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

int samplesPerFrame = 7;
int numFrames = 250;        
float shutterAngle = 2.3;

boolean recording = true;

OpenSimplexNoise noise;

int n = 60;

float R = 200;

float SEED;

class Thing{
  float x;
  float y;
  
  float offset;
  
  float theta = random(TWO_PI);
  float x2 = 0;
  float y2;
  
  float sz = 4;
  float f = 1+1.5*pow(random(1),4.0);
  float f2 = random(0.25,1);
  
  float seed = random(10,1000);
  float mr = 0.5;
  
  float rot = random(-7,7);
  
  int ii;
  int jj;
  
  Thing(int i,int j){
    ii = i;
    jj = j;
    
    x = map(i,0,n-1,-0.26*width,0.26*width);
    y = map(j,0,n-1,-0.26*width,0.26*width);
    
    offset = 0.15*(1+(float)noise.eval(SEED + 0.01*x,0.01*y));
    
    y2 = map(j+2*randomGaussian(),0,n-1,-0.4*width,0.4*width);
  }
  
  void show(){
    float interp = ease(map(sin(TWO_PI*(t+offset-0.5)),-1,1,0,1),3.0);
    
    float SZ = lerp(sz*f2,sz/4*f,interp);
    
    float l = 3+27*sin(PI*jj/(n-1));
    
    float xx = lerp(x,x2 + 5*l*(float)noise.eval(seed+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t)),interp) ;
    float yy = lerp(y,y2 + 3*l*(float)noise.eval(2*seed+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t)),interp);
    
    fill(255);
    noStroke();
    push();
    translate(xx,yy);
    rotate(rot*PI*interp);
    rect(0,0,SZ,SZ);
    pop();
  }
}

Thing[] array = new Thing[n*n];

void setup(){
  size(540,540,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  rectMode(CENTER);
  
  SEED = random(10,1000);
  
  int k = 0;
  for(int i=0;i<n;i++){
    for(int j=0;j<n;j++){
      array[k] = new Thing(i,j);
      k++;
    }
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  scale(0.75);
  for(int k=0;k<n*n;k++){
    array[k].show();
  }
  pop();
}