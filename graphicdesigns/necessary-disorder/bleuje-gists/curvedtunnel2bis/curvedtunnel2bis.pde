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
int numFrames = 50;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

float r = 170;
float R = 1000;

void drawRectangle(float theta, float alpha, float sz){
  push();
  translate(0,-R+R*cos(alpha),R*sin(alpha));
  
  push();
  rotateX(alpha);
  rotateZ(theta);
  rotateX(HALF_PI);  
  translate(0,0,r);
  
  fill(255);
  stroke(255);
  rect(0,0,sz/3,4*sz);
  
  translate(0,0,1);
  
  fill(0);
  stroke(0);
  rect(0,0,70,70);
  
  pop();
  
  pop();
}

int n = 1500;

class Star{
  float sz = random(1,12);
  float seed = random(10,1000);
  
  float mr = 0.75;
  
  float theta = random(TWO_PI);
  
  float offset = random(1);
  
  float sz(){
    return map((float)noise.eval(seed+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t)),-1,1,sz/3,sz);
  }
}

Star[] array = new Star[n];


void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  rectMode(CENTER);
  
  for(int i=0;i<n;i++){
    array[i] = new Star();
  }
}

int N = 10;


void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  translate(0,-0.1*height,0.2*height);
  
  for(int i=0;i<n;i++){
    Star st = array[i];
    for(int j=0;j<N;j++){
      float alpha = map(j+st.offset+t,0,N,-PI,PI);
      drawRectangle(st.theta,alpha,st.sz());
    }
  }
  
  pop();
}