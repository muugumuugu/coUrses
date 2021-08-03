// Processing code by Etienne JACOB
// motion blur template by beesandbombs
// opensimplexnoise code in another tab might be necessary
// --> code here : https://gist.github.com/Bleuje/fce86ef35b66c4a2b6a469b27163591e

// Warning : this code just shows how a gif was made, it's not intended to be pedagogical, show good coding practices or be clever

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
int numFrames = 130;        
float shutterAngle = .9;

boolean recording = true;

OpenSimplexNoise noise;

float depth = 3;

float L = 100;

float RATIO = 9.0;

class Dot{
  float seed = random(10,1000);
  
  float i = floor(random(3));
  float j = floor(random(2));
  
  float sz = 3+5*pow(random(1),2.0);
  
  int K = 3;
  
  Dot(int k,int n){
    
  }
  
  float theta0 = random(TWO_PI);
  
  float theta(float p){
    return theta0 + map((float)noise.eval(2*seed+10*p,0),-1,1,0,0.3*TWO_PI);
  }
  
  float r(float p){
    return map((float)noise.eval(3*seed+10*p,0),-1,1,0,0.5*L);
  }
  
  void show(float p){
    fill(255);
    stroke(255);
    strokeWeight(1.0);
    
    float sz2 = sz*map((float)noise.eval(seed+27*p,0),-1,1,0.25,1);
    
    float d = 1.01*L/2;
    push();
    if(i==1){
      rotateX(HALF_PI);
    }
    if(i==2){
      rotateY(HALF_PI);
    }
    if(j==0){
      translate(0,0,d);
    } else {
      translate(0,0,-d);
    }
    float xx = r(p)*cos(theta(p));
    float yy = r(p)*sin(theta(p));
    translate(xx,yy);
    ellipse(0,0,sz2,sz2);
    pop();
  }
}

class Box{
  int ndots = 300;
  
  Dot[] dots = new Dot[ndots];
  
  Box(){
    for(int i=0;i<ndots;i++){
      dots[i] = new Dot(i,ndots);
    }
  }
  
  void show(float p){
    //stroke(255);
    noStroke();
    fill(0);
    strokeWeight(1.0);
    
    rectMode(CENTER);
    
    float l = 1.0001*L;
    
    push();
    translate(0,0,l/2);
    rect(0,0,l,l);
    translate(0,0,-l);
    rect(0,0,l,l);
    pop();
    
    push();
    rotateX(HALF_PI);
    translate(0,0,l/2);
    rect(0,0,l,l);
    translate(0,0,-l);
    rect(0,0,l,l);
    pop();
    
    push();
    rotateY(HALF_PI);
    translate(0,0,l/2);
    rect(0,0,l,l);
    translate(0,0,-l);
    rect(0,0,l,l);
    pop();
    
    for(int i=0;i<ndots;i++){
      dots[i].show(p);
    }
  }
}

class Thing{
  Box[] array = new Box[25];
  
  Thing(){
    for(int i=0;i<25;i++){
      array[i] = new Box();
    }
  }
  
  void show(float p,int ind){
    push();

    float rot =  2*TWO_PI*pow(1-constrain(1.6*(1-p)-0.6,0,1),3.5);
    
    rotateX(rot);
    scale(pow(1/RATIO,ind-t));
    
    int l = 0;
    for(int i=-1;i<=1;i++){
      for(int j=-1;j<=1;j++){
        for(int k=-1;k<=1;k++){
          if(!(i==0&&j==0&&(k==1||k==0))){
            float x = i*L;
            float y = j*L;
            float z = k*L;
            push();
            translate(x,y,z);
            array[l].show(p);
            pop();
            l++;
          }
        }
      }
    }
    
    stroke(255);
    fill(255);
    strokeWeight(1.0);
    
    float r = L/4;
    
    push();
    translate(-1.5*L,0,0);
    sphere(r);
    translate(3*L,0,0);
    sphere(r);
    pop();
    
    push();
    translate(-1.5*L-3*L,0,0);
    sphere(r);
    translate(3*L+6*L,0,0);
    sphere(r);
    pop();
    
    strokeWeight(8.0);
    
    line(-1.5*L,0,0,-1.5*L-3*L,0,0);
    line(1.5*L,0,0,1.5*L+3*L,0,0);
    
    int N = 4;
    float R = 2.0*L;
    
    strokeWeight(8.0);
    
    for(int i=0;i<N;i++){
      float theta = TWO_PI*i/N;
      float X = R*cos(theta);
      float Y = R*sin(theta);
      line(-1.5*L-3*L,0,0,-1.5*L-3*L,X,Y);
      line(1.5*L+3*L,0,0,1.5*L+3*L,X,Y);
    }
    
    pop();
  }
  
  void show(){
    for(int i=-1;i<depth;i++){
      float p = map(i+1-t,0,depth,0,1);
      show(p,i);
    }
  }
}

Thing thing;

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  thing = new Thing();
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  thing.show();
  
  pop();
}