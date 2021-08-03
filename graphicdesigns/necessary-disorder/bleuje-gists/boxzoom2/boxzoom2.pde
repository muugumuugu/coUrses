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
int numFrames = 100;        
float shutterAngle = 1.2;

boolean recording = true;

OpenSimplexNoise noise;

float L = 100;

float RATIO = 6.5;

float turn = 0.85;

int K = 6;


class Dot{
  int axis = floor(random(3));
  int side = floor(random(2));
  
  float px = random(-L,L);
  float py = random(-L,L);
  
  float sz = 8*pow(random(1),2.0);
  
  float seed = random(10,1000);
  
  void show(float p){
    float x,y,z;
    if(axis==0){
      z = (side==0?L:-L);
      x = px;
      y = py;
    } else if(axis==1){
      y = (side==0?L:-L);
      z = px;
      x = py;
    } else{
      x = (side==0?L:-L);
      y = px;
      z = py;
    }
    
    //strokeWeight(sz);
    stroke(255);
    fill(255);
    
    float f = map((float)noise.eval(seed,30*p),-1,1,0,2);
    
    push();
    translate(x,y,z);
    strokeWeight(sz*sin(PI*p)*f);
    stroke(255,350*sin(PI*p));
    point(0,0);
    rotateX(HALF_PI);
    point(0,0);
    rotateY(HALF_PI);
    point(0,0);
    rotateX(HALF_PI);
    point(0,0);
    strokeWeight(1);
    pop();
  }
}

class Sphere{
  float r = 10*pow(random(1),2.0);
  
  float x = 8*L*random(-1,1);
  float y = 8*L*random(-1,1);
  float z = 8*L*random(-1,1);
  
  void show(float p){
    
    float f = constrain(map(modelZ(x,y,z),100,250,1,0),0,1);
    float ff = constrain(map(modelZ(x,y,z),-100,-250,1,0),0,1);
    
    push();
    translate(x,y,z);
    stroke(355*sin(PI*p));
    fill(355*sin(PI*p));
    sphere(r*f*ff);
    pop();
  }
}

class Box{
  int n = 2000;
  
  Dot[] array = new Dot[n];
  
  int N = 60;
  
  Sphere[] array2 = new Sphere[n];
  
  Box(){
    for(int i=0;i<n;i++){
      array[i] = new Dot();
    }
    for(int i=0;i<N;i++){
      array2[i] = new Sphere();
    }
  }
  
  void draw_black_box(float p){
    fill(0);
    stroke(100*sin(PI*p));
    strokeWeight(0.7);
    
    push();
    for(int i=0;i<3;i++){
      if(i==1){
        rotateX(HALF_PI);
      }
      if(i==2){
        rotateY(HALF_PI);
      }
      beginShape();
      vertex(-L,-L,L);
      vertex(-L,L,L);
      vertex(L,L,L);
      vertex(L,-L,L);
      endShape();
      beginShape();
      vertex(-L,-L,-L);
      vertex(-L,L,-L);
      vertex(L,L,-L);
      vertex(L,-L,-L);
      endShape(CLOSE);
    }
    pop();
  }
  
  void show(float p,float ind){
    push();
    
    translate(0,(1+1/RATIO)*L*pow(1/RATIO,ind-t)/(1-1/RATIO));
    scale(pow(1/RATIO,ind-t));
    
    rotateY(turn*TWO_PI*p+0.1);
    
    draw_black_box(p);
    
    for(int i=0;i<n;i++){
      array[i].show(p);
    }
    
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