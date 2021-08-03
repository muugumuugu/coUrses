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

int samplesPerFrame = 4;
int numFrames = 28;        
float shutterAngle = .3;

boolean recording = true;

OpenSimplexNoise noise;

int I = 80;
int J = 10;
int K = 5;

float W1 = 2500;
float W2 = 300;
float D = 160;

class Thing{
  int i,j,k;
  float offset;
  Thing(int i_,int j_,int k_){
    i = i_;
    j = j_;
    k = k_;
    
    offset = 2.0*j/J + 1.0*k/K + 0.75*(float)noise.eval(SEED+20.0*i/I,3.0*k/K)+5-50*abs(1.0*i/I-0.5);
  }
  
  int K2 = 3;
  
  void show(float p){
    float pp = p + offset;
    float q = max(0,0.5*pp);
    
    float dy = 600*pow(q,2.5);
    
    float x = map(i,0,I,-W1/2,W1/2);
    float y = dy + map(j,0,J,-W2/2,W2/2);
    float z = p*D + map(k,0,K,0,D);
    
    push();
    translate(x,y,z);
    drawBox(p);
    pop();
  }
  
  void show(){
    for(int i=-3*K2;i<K2;i++){
      float p = i+t;
      show(p);
    }
  }
  
  float col = random(200,255);
  
  float sw = random(0.25,1.3);
  float seed = random(10,1000);
  
  void drawBox(float p){
    stroke(col);
    fill(0);
    float f = 0.5+3*pow(map((float)noise.eval(seed+1.2*p,0),-1,1,0,1),2.0);
    strokeWeight(sw*f);
    rectMode(CENTER);
    push();
    translate(W1/I/2,W2/J/2,D/K/2);
    
    push();
    translate(0,0,D/K/2);
    rect(0,0,W1/I,W2/J);
    translate(0,0,-D/K);
    rect(0,0,W1/I,W2/J);
    pop();
    
    push();
    rotateX(HALF_PI);
    translate(0,0,W2/J/2);
    rect(0,0,W1/I,D/K);
    translate(0,0,-W2/J);
    rect(0,0,W1/I,D/K);
    pop();
    
    push();
    rotateY(HALF_PI);
    translate(0,0,W1/I/2);
    rect(0,0,D/K,W2/J);
    translate(0,0,-W1/I);
    rect(0,0,D/K,W2/J);
    pop();
    
    pop();
  }
}

float SEED;

Thing[] array = new Thing[I*J*K];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  SEED = random(10,1000);
  
  int ind = 0;
  
  for(int i=0;i<I;i++){
    for(int j=0;j<J;j++){
      for(int k=0;k<K;k++){
        array[ind] = new Thing(i,j,k);
        ind++;
      }
    }
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);

  rotateX(-0.39*HALF_PI);
  
  for(int ind=0;ind<I*J*K;ind++){
    array[ind].show();
  }
  
  pop();
}