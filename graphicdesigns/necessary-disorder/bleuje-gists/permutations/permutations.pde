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

int samplesPerFrame = 5;
int numFrames = 300;        
float shutterAngle = .8;

boolean recording = true;

OpenSimplexNoise noise;

float distort(float q,float es){
  if(q<0) return 0;
  if(q>1) return 1;
  if(q<0.5){
    return 0.5*ease(2*q,es);
  } else {
    return 0.5+0.5*ease(2*(q-0.5),es);
  }
}

int n = 10;

float rb = 5;
float bsp = 0.35;

float MR2 = 1.5;
float RR = 15;

class TBase{
  int k;
  
  float x;
  float y;
  
  float seed = 10 + random(100);
  
  float r = RR;
  
  TBase(int k_){
    k = k_;
    float theta = map(k,0,n-1,-HALF_PI-bsp,-HALF_PI+bsp);
    float R = 0.9*width;
    x = R*cos(theta);
    y = R*sin(theta)+height/2;
  }
  
  float x(){
    return x + r*(float)noise.eval(seed + MR2*cos(TWO_PI*t),MR2*sin(TWO_PI*t));
  }
  
  float y(){
    return y + r*(float)noise.eval(2*seed + MR2*cos(TWO_PI*t),MR2*sin(TWO_PI*t));
  }
  
  void show(){
    stroke(255);
    strokeWeight(1);
    fill(0);
    push();
    translate(0,0,1);
    ellipse(x(),y(),2*rb,2*rb);
    pop();
  }
}

class BBase{
  int k;
  
  float x;
  float y;
  
  float seed = 10 + random(100);
  
  float r = RR;
  
  BBase(int k_){
    k = k_;
    float theta = map(k,0,n-1,HALF_PI-bsp,HALF_PI+bsp);
    float R = 0.9*width;
    x = R*cos(theta);
    y = R*sin(theta)-height/2;
  }
  
  float x(){
    return x + r*(float)noise.eval(seed + MR2*cos(TWO_PI*t),MR2*sin(TWO_PI*t));
  }
  
  float y(){
    return y + r*(float)noise.eval(2*seed + MR2*cos(TWO_PI*t),MR2*sin(TWO_PI*t));
  }
  
  void show(){
    stroke(255);
    strokeWeight(1);
    fill(0);
    push();
    translate(0,0,1);
    ellipse(x(),y(),2*rb,2*rb);
    pop();
  }
}

class Base{
  int k;
  int kk;
  float x;
  float y;
  
  float r;
  
  int sign = 2*floor(random(2.0)) - 1;
  
  int turn = sign*(1+floor(random(10,25)));
  
  Base(int k_,int kk_,float x_,float y_,float r_){
    k = k_;
    kk = kk_;
    x = x_;
    y = y_;
    r = r_;
  }
  
  float x(int kk_){
    float theta = TWO_PI*(kk_+turn*t)/kk;
    return x+r*cos(theta);
  }
  
  float y(int kk_){
    float theta = TWO_PI*(kk_+turn*t)/kk;
    return y+r*sin(theta);
  }
  
  void show(){
    strokeWeight(1);
    fill(255);
    ellipse(x,y,10,10);
    fill(0);
    for(int i=0;i<kk;i++){
      float theta = TWO_PI*(i+turn*t)/kk;
      float xx = x+r*cos(theta);
      float yy = y+r*sin(theta);
      stroke(255,175);
      line(x,y,xx,yy);
      stroke(255);
      push();
      translate(0,0,1);
      ellipse(xx,yy,2*rb,2*rb);
      pop();
    }
  }
  
  
}

TBase[] tarray = new TBase[n];
BBase[] barray = new BBase[n];

int K = 4;

Base[] basearray = new Base[K];

float ES = 6.2;

float SZ = 5;

float QL = 0.07;

float ALPH = 200;

int M = 150;

float MP = 15.0;

float MR = 0.8;

float OFF = 0.09;

float L = 50;

class TDot{
  int k = 0;
  int kk = 0;
  int i1;
  int i2;
  
  float mp = MP;
  float mr = MR;
  float l = L;
  
  float ql = QL;
  
  float seed = 100 + random(1000);
  
  float offset = random(-OFF,OFF);
  
  TDot(int i){
    i1 = i;
    i2 = i;
  }
  
  void set(int k_,int kk_){
    k = k_;
    kk = kk_;
  }
  
  float curvex(float q){
    q = constrain(q,0,1);
    if(q<0.5){
      float q1 = 2*q;
      float xx = lerp(tarray[i1].x(),basearray[k].x(kk),q1);
      float vx = l*(float)noise.eval(seed + mp*q,mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
      float intensity = 0.8*sin(PI*q1);
      return lerp(xx,xx+vx,intensity);
    } else {
      float q2 = 2*(q-0.5);
      float xx = lerp(barray[i2].x(),basearray[k].x(kk),1-q2);
      float vx = l*(float)noise.eval(2*seed + mp*q,mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
      float intensity = 0.7*sin(PI*q2);
      return lerp(xx,xx+vx,intensity);
    }
  }
  
  float curvey(float q){
    q = constrain(q,0,1);
    if(q<0.5){
      float q1 = 2*q;
      float yy = lerp(tarray[i1].y(),basearray[k].y(kk),q1);
      float vy = l*(float)noise.eval(3*seed + mp*q,mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
      float intensity = 0.7*sin(PI*q1);
      return lerp(yy,yy+vy,intensity);
    } else {
      float q2 = 2*(q-0.5);
      float yy = lerp(barray[i2].y(),basearray[k].y(kk),1-q2);
      float vy = l*(float)noise.eval(4*seed + mp*q,mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
      float intensity = 0.7*sin(PI*q2);
      return lerp(yy,yy+vy,intensity);
    }
  }
  
  void drawCurve_0(){
    int m = 500;
    stroke(255,100);
    for(int i=0;i<=m;i++){
      float p = 1.0*i/m;
      point(curvex(p),curvey(p));
    }
  }
  
  void show(){
    push();
    translate(0,0,2);
    int m = M;
    stroke(255,ALPH);
    for(int i=0;i<=m;i++){
      float p =1.0*i/m;
      float q = t + ql*(p-0.5) + offset;
      
      q = distort(q,ES);
      
      float sz = SZ*pow(sin(PI*p),3.0);
      strokeWeight(sz);
      point(curvex(q),curvey(q));
    }
    pop();
  }
}

TDot[] tdarray = new TDot[n];

class BDot{
  int k = 0;
  int kk = 0;
  int i1;
  int i2;
  
  float mp = MP;
  float mr = MR;
  float l = L;
  
  float ql = QL;
  
  float seed = 100 + random(1000);
  
  float offset = random(-OFF,OFF);
  
  BDot(int i){
    i1 = i;
    i2 = i;
  }
  
  void set(int k_,int kk_){
    k = k_;
    kk = kk_;
  }
  
  float curvex(float q){
    q = constrain(q,0,1);
    if(q<0.5){
      float q1 = 2*q;
      float xx = lerp(barray[i1].x(),basearray[k].x(kk),q1);
      float vx = l*(float)noise.eval(seed + mp*q,mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
      float intensity = 0.7*sin(PI*q1);
      return lerp(xx,xx+vx,intensity);
    } else {
      float q2 = 2*(q-0.5);
      float xx = lerp(tarray[i2].x(),basearray[k].x(kk),1-q2);
      float vx = l*(float)noise.eval(2*seed + mp*q,mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
      float intensity = 0.7*sin(PI*q2);
      return lerp(xx,xx+vx,intensity);
    }
  }
  
  float curvey(float q){
    q = constrain(q,0,1);
    if(q<0.5){
      float q1 = 2*q;
      float yy = lerp(barray[i1].y(),basearray[k].y(kk),q1);
      float vy = l*(float)noise.eval(3*seed + mp*q,mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
      float intensity = 0.7*sin(PI*q1);
      return lerp(yy,yy+vy,intensity);
    } else {
      float q2 = 2*(q-0.5);
      float yy = lerp(tarray[i2].y(),basearray[k].y(kk),1-q2);
      float vy = l*(float)noise.eval(4*seed + mp*q,mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
      float intensity = 0.7*sin(PI*q2);
      return lerp(yy,yy+vy,intensity);
    }
  }
  
  void drawCurve_0(){
    int m = 500;
    stroke(255,100);
    for(int i=0;i<=m;i++){
      float p = 1.0*i/m;
      point(curvex(p),curvey(p));
    }
  }
  
  void show(){
    push();
    translate(0,0,2);
    int m = M;
    stroke(255,ALPH);
    for(int i=0;i<=m;i++){
      float p =1.0*i/m;
      float q = t + ql*(p-0.5) + offset;
      
      q = distort(q,ES);
      
      float sz = SZ*pow(sin(PI*p),3.0);
      strokeWeight(sz);
      point(curvex(q),curvey(q));
    }
    pop();
  }
}

BDot[] bdarray = new BDot[n];

void swap1(){
  int i = floor(random(n));
  int j = floor(random(n));
  int val = tdarray[i].i2;
  tdarray[i].i2 = tdarray[j].i2;
  tdarray[j].i2 = val;
}

void swap2(){
  int i = floor(random(n));
  int j = floor(random(n));
  int val1 = tdarray[i].k;
  int val2 = tdarray[i].kk;
  tdarray[i].k = tdarray[j].k;
  tdarray[i].kk = tdarray[j].kk;
  tdarray[j].k = val1;
  tdarray[j].kk = val2;
}

void swap3(){
  int i = floor(random(n));
  int j = floor(random(n));
  int val = bdarray[i].i2;
  bdarray[i].i2 = bdarray[j].i2;
  bdarray[j].i2 = val;
}

void swap4(){
  int i = floor(random(n));
  int j = floor(random(n));
  int val1 = bdarray[i].k;
  int val2 = bdarray[i].kk;
  bdarray[i].k = bdarray[j].k;
  bdarray[i].kk = bdarray[j].kk;
  bdarray[j].k = val1;
  bdarray[j].kk = val2;
}

int NSWAPS = 1000;

void do_swaps(){
  for(int i=0;i<NSWAPS;i++){
    swap1();
    swap2();
    swap3();
    swap4();
  }
}

void setup(){
  size(500,500,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
   tarray[i] = new TBase(i);
   barray[i] = new BBase(i);
   tdarray[i] = new TDot(i);
   bdarray[i] = new BDot(i);
  }
  
  float theta = TWO_PI*1/4;
  float rad = 75;
  basearray[0] = new Base(0,5,rad*cos(theta),rad*sin(theta),40);
  theta = TWO_PI*2/4;
  basearray[1] = new Base(0,2,rad*cos(theta),rad*sin(theta),45);
  theta = TWO_PI*3/4;
  basearray[2] = new Base(0,6,rad*cos(theta),rad*sin(theta),40);
  theta = TWO_PI*4/4;
  basearray[3] = new Base(0,7,rad*cos(theta),rad*sin(theta),50);
  
  
  int ind = 0;
  for(int k=0;k<K;k++){
    for(int kk=0;kk<basearray[k].kk;kk++){
      if(ind<n){
        tdarray[ind%n].set(k,kk);
      } else {
        bdarray[ind%n].set(k,kk);
      }
      ind++;
    }
  }
  
  do_swaps();

}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  for(int i=0;i<n;i++){
    stroke(255,175);
    strokeWeight(1);
    line(0,-0.45*height,tarray[i].x(),tarray[i].y());
    line(0,0.45*height,barray[i].x(),barray[i].y());
  }
  
  for(int i=0;i<n;i++){
   tarray[i].show();
   barray[i].show();
  }
  
  for(int i=0;i<K;i++){
    basearray[i].show();
  }
  
  /*
  for(int i=0;i<n;i++){
    tdarray[i].drawCurve_0();
  }
    for(int i=0;i<n;i++){
    bdarray[i].drawCurve_0();
  }*/
  for(int i=0;i<n;i++){
    tdarray[i].show();
  }
    for(int i=0;i<n;i++){
    bdarray[i].show();
  }
  
  pop();
}