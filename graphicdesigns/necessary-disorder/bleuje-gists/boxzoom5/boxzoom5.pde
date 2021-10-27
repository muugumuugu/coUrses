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
int numFrames = 120;        
float shutterAngle = 1.2;

boolean recording = true;

OpenSimplexNoise noise;

float L = 100;

float RATIO = 6.5;

float turn = 0.85;

int K = 6;

float PW = 1.0;

class Dot2{
  float vx = random(-1,1);
  float vy = random(-1,1);
  float px = L*(vx>=0?pow(vx,PW):-pow(-vx,PW));
  float py = L*(vy>=0?pow(vy,PW):-pow(-vy,PW));
  
  float sz = 12*pow(random(1),3.0);
  
  float seed = random(10,1000);
  
  void show(float p){ 
    float f = map((float)noise.eval(seed,30*p),-1,1,0,1);
    float f2 = 0.5+ease(map(sin(TWO_PI*(10*p+1.2*dist(px,py,0,0)/L)+0*atan2(py,px)),-1,1,0,1),2.0)*1.0;
    /*
    strokeWeight(sz*sin(PI*p)*f*f2);
    stroke(350*sin(PI*p));
    point(px,py);*/
    float r = sz*pow(sin(PI*p),0.5)*f*f2;
    fill(350*pow(sin(PI*p),0.5));
    noStroke();
    ellipse(px,py,r,r);
  }
}

class Sphere{
  float r = 14*pow(random(1),2.0);
  
  float F = 10;
  
  float x = F*L*randomGaussian();
  float y = F*L*randomGaussian();
  float z = F*L*randomGaussian();
  
  void show(float p){
    
    float f = constrain(map(modelZ(x,y,z),100,300,1,0),0,1);
    float ff = constrain(map(modelZ(x,y,z),-1,-300,1,0),0,1);
    
    push();
    translate(x,y,z);
    stroke(355*sin(PI*p));
    fill(355*sin(PI*p));
    sphere(r*f*ff);
    pop();
  }
}

void drawFaces(){
  beginShape();
  vertex(-L,-L,L);
  vertex(-L,L,L);
  vertex(L,L,L);
  vertex(L,-L,L);
  endShape(CLOSE);
  beginShape();
  vertex(-L,-L,-L);
  vertex(-L,L,-L);
  vertex(L,L,-L);
  vertex(L,-L,-L);
  endShape(CLOSE);
}

class Box{
  int n = 1200;
  
  Dot2[] array = new Dot2[n];
  
  int N = 200;
  
  Sphere[] array2 = new Sphere[n];
  
  Box(){
    for(int i=0;i<n;i++){
      array[i] = new Dot2();
    }
    for(int i=0;i<N;i++){
      array2[i] = new Sphere();
    }
  }
  
  void draw_black_box(float p){
    fill(0);
    stroke(0*100*sin(PI*p));
    strokeWeight(0.7);
    
    push();
    for(int i=0;i<3;i++){
      if(i==1){
        rotateX(HALF_PI);
      }
      if(i==2){
        rotateY(HALF_PI);
      }
      drawFaces();
    }
    pop();
    
    /*
    stroke(400*sin(PI*p));
    strokeWeight(1);
    fill(400*sin(PI*p));
    
    for(int i=-1;i<=1;i+=2){
      for(int j=-1;j<=1;j+=2){
        for(int k=-1;k<=1;k+=2){
          push();
            translate(L*i,L*j,L*k);
            sphere(3);
          pop();
        }
      }
    }*/
  }
  
  void show(float p,float ind){
    push();
    
    translate(0,(1+1/RATIO)*L*pow(1/RATIO,ind-t)/(1-1/RATIO));
    scale(pow(1/RATIO,ind-t));
    
    rotateY(turn*TWO_PI*p+0.1 + 0*0.1*sin(TWO_PI*t));
    
    draw_black_box(p);
    
    push();
    for(int i=0;i<3;i++){
      push();
      if(i==1){
        rotateX(HALF_PI);
      }
      if(i==2){
        rotateY(HALF_PI);
      }
      translate(0,0,L+1);
      for(int j=0;j<n;j++){
        array[j].show(p);
      }
      translate(0,0,-2*L-2);
      for(int j=0;j<n;j++){
        array[j].show(p);
      }
      pop();
    }
    pop();
    
    for(int i=0;i<N;i++){
      array2[i].show(p);
    }
    
    pop();
  }
}

Box b;

void draw_structure(){
  for(int i=-1;i<K;i++){
    float p = map(i+1-t,0,K,0,1);
    b.show(p,i-1);
  }
}

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  b = new Box();
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2-150);
  rotateX(-0.25*HALF_PI);
  
  draw_structure();
  
  pop();
}