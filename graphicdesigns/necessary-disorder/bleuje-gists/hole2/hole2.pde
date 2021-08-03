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
int numFrames = 40;        
float shutterAngle = .6;

boolean recording = true;

//OpenSimplexNoise noise;

int K = 13;

int n = 1300;

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

float smth = 110;

float rmin = 70;

PVector position(float p,float theta){
    float pp = map(p,0,1,-0.5*width,2.5*width);
    float r = rmin + softplus(pp,smth);
    float z = -softplus(-pp,smth);
    
    float x = r*cos(theta);
    float y = r*sin(theta);
    
    return new PVector(x,y,z);
}

int n1 = 100;
int n2 = 50;

void draw_surface(){
  for(int i=0;i<n1;i++){
    float p1 = 1.0*i/n1;
    float p2 = 1.0*(i+1)/n1;
    
    beginShape(TRIANGLE_STRIP);
    for(int j=0;j<=n2;j++){
      float theta1 = TWO_PI*j/n2;
      
      PVector pos1 = position(p1,theta1);
      PVector pos2 = position(p2,theta1);
      
      fill(0);
      noStroke();
      
      vertex(pos1.x,pos1.y,pos1.z-1);
      vertex(pos2.x,pos2.y,pos2.z-1);
      
      
    }
    endShape();
  }
}

class Dot{
  float offset = random(1);
  float sz = 4*pow(random(1),2.5);
  float theta0 = random(TWO_PI);
  
  int N = floor(1+60*pow(random(1),2.0));
  
  void show(){
    for(int k=0;k<K;k++){
      for(int j=0;j<N;j++){
        float p = 1-((k+0.1*j/50+t+offset)/K)%1;
        
        strokeWeight(sz);
        stroke(255);
        
        PVector pos = position(p,theta0+7*pow(1-p,4.0));
        
        point(pos.x,pos.y,pos.z);
      }
    }
  }
}

Dot[] array = new Dot[n];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  //noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Dot();
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,-70+height/2,0.35*width);
  
  rotateX(0.9);
  
  draw_surface();
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
  
  pop();
}