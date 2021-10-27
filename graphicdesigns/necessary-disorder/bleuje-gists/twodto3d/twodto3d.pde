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

float softplus(float q,float p){
  float qq = q+p;
  if(qq<=0){
    return 0;
  }
  if(qq>=2*p){
    return qq-p;
  }
  return 1/(4*p)*qq*qq;
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
    t = (mouseX*1.5/width)%1;
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
int numFrames = 150;        
float shutterAngle = .9;

boolean recording = true;

OpenSimplexNoise noise;

class Thing{
  float x,y,z;
  
  float r = random(1,5);
  
  Thing(){
    x = 2000*randomGaussian();
    y = 2000*randomGaussian();
    z = 7000*randomGaussian();
  }

  void show(){
    fill(255);
    stroke(255);
    push();
    
    translate(x,y,z);

    float rr = r*pow(1-t,0.3);
    strokeWeight(rr);
    point(0,0,0);
    pop();
  }
}

int n = 7000;

Thing [] array = new Thing[n];

PImage img;

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  randomSeed(1337);
  
  for(int i=0;i<n;i++){
    array[i] = new Thing();
  }
  
  img = loadImage("try4_4.png");
}

void drawCube(){
  push();
  float L = img.width;
  
  float rectOffset = 2;
  
  rectMode(CENTER);
  stroke(255);
  strokeWeight(2.0*pow(1-t,1.6));
  noFill();
  
  push();
  translate(0,0,L/2);
  image(img,-L/2,-L/2);
  rect(0,0,L+rectOffset,L+rectOffset);
  pop();
  
  push();
  rotateY(HALF_PI);
  translate(0,0,L/2);
  image(img,-L/2,-L/2);
  rect(0,0,L+rectOffset,L+rectOffset);
  pop();
  
  push();
  rotateY(2*HALF_PI);
  translate(0,0,L/2);
  image(img,-L/2,-L/2);
  rect(0,0,L+rectOffset,L+rectOffset);
  pop();
  
  push();
  rotateY(3*HALF_PI);
  translate(0,0,L/2);
  image(img,-L/2,-L/2);
  rect(0,0,L+rectOffset,L+rectOffset);
  pop();
  
  push();
  rotateX(HALF_PI);
  translate(0,0,L/2);
  image(img,-L/2,-L/2);
  rect(0,0,L+rectOffset,L+rectOffset);
  pop();
  
  push();
  rotateX(-HALF_PI);
  translate(0,0,L/2);
  image(img,-L/2,-L/2);
  rect(0,0,L+rectOffset,L+rectOffset);
  pop();
  
  pop();
}

void draw_(){
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*1000.0);
  
  background(0);
  push();
  
  translate(width/2,height/2);
  
  translate(0,0,6000*pow(t,0.5));
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
  
  translate(0,0,-6300);
  push();
  rotateX(PI*ease(1-t,3.0));
  rotateY(HALF_PI*ease(1-t,3.0));
  drawCube();
  pop();
  
  /* Use this to save the first frame
  if(frameCount==1){
    saveFrame("try4_4.png");
  }*/

  pop();
}