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

int samplesPerFrame = 1;
int numFrames = 15;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

float R = 290;
float r = 10;

int S = 4;

float EPS = 0.01;

class Structure{
  float f = random(0.5,4.0);
  
  float angle_offset = random(1);
  
  PVector crv(float p){
    float turns = 4.5-f;
    float phi = p*turns*TWO_PI+TWO_PI*angle_offset;
    float RR = 30+R*map(p,0,1,0.1,1)/f;
    return new PVector(RR*cos(phi),RR*sin(phi),map(p,0,1,-500*f,400*f));
  }
  
  PVector position(float p, float theta,float rf){
    float theta2 = theta - 15*p;
    
    PVector v1 = crv(p);
    PVector v2 = crv(p-EPS);
    PVector v3 = crv(p+EPS);
    
    PVector u1 = v2.copy().sub(v1);
    PVector u2 = v3.copy().sub(v1);
    
    PVector w2 = u1.copy().cross(u2);
    w2.normalize();
    PVector w1 = u2.normalize();
    PVector w3 = w2.copy().cross(w1);
    
    PVector pos = v1.copy().add(w2.copy().mult(p*r*rf*cos(theta2))).add(w3.copy().mult(p*r*rf*sin(theta2)));
    
    return pos;
  }
  
  PVector position2(float p,float theta){
    float ind = 0.999999*S*theta/TWO_PI;
    int s = floor(ind);
    float interp = ind-s;
    float theta1 = s*TWO_PI/S;
    float theta2 = (s+1)*TWO_PI/S;
    PVector v1 = position(p,theta1,1.07);
    PVector v2 = position(p,theta2,1.07);
    v1.lerp(v2,interp);
    return v1;
  }
  
  int m1 = 200;
  int m2 = S;
  
  void show(){
    stroke(0);
    fill(0);
    for(int i=0;i<m2;i++){
      float theta1 = map(i,0,m2,0,TWO_PI);
      float theta2 = map(i+1,0,m2,0,TWO_PI);
      beginShape(TRIANGLE_STRIP);
      for(int j=0;j<=m1;j++){
        float p = constrain(map(j+0*5*t,5,m1,0,1),0,1);
        
        PVector v1 = position(p,theta1,1.0);
        PVector v2 = position(p,theta2,1.0);
        
        vertex(v1.x,v1.y,v1.z);
        vertex(v2.x,v2.y,v2.z);
      }
      endShape();
    }
  }
}

void sphere2(float sz){
  push();
  ellipse(0,0,sz,sz);
  push();
  rotateX(HALF_PI);
  ellipse(0,0,sz,sz);
  pop();
  push();
  rotateY(HALF_PI);
  ellipse(0,0,sz,sz);
  pop();
  pop();
}

class Thing{
  int sind = floor(random(N));
  
  Thing(int i){
    sind = i%N;
  }
  
  float sz = random(0.5,1.2);
  float theta = random(TWO_PI);
  int K = 140;
  
  int m = 75;
  
  float offset = random(1);
  
  void show(){
    float tt = (t+offset)%1;
    for(int i=0;i<K;i++){
      for(int j=0;j<m;j++){
        float p = map(i+tt,0,K,0,1);
        
        float dtheta = TWO_PI*1.0*j/m;
        
        PVector pos = array[sind].position2(p,theta+dtheta);
        
        push();
        translate(pos.x,pos.y,pos.z);
        stroke(255);
        fill(255);
        sphere2(sz);
        pop();
      }
    }
  }
}

int N = 40;

Structure[] array = new Structure[N];

int n = N*1;

Thing[] array2 = new Thing[n];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();

  for(int i=0;i<N;i++){
    array[i] = new Structure();
  }
  
  for(int i=0;i<n;i++){
    array2[i] = new Thing(i);
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  rotateX(0.6);
  
  translate(-50,120);
  
  for(int i=0;i<N;i++){
    array[i].show();
  }
  
  for(int i=0;i<n;i++){
    array2[i].show();
  }
  
  pop();
}