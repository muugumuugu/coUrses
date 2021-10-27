float x,y,z,t;

float[] A = new float[6];
float[] f = new float[6];

int p = 3;
int q = 3;

float A1,A2,A3,A4,A5,A6;
float f1,f2,f3,f4,f5,f6;

int frame = 0;

int line;

void initialize(){
  frame = 0;
  
  for(int i=0;i<6;i++){
    A[i] = random(-2.0,2.0);
    f[i] = random(-2,2);
  }
  
  A1 = A[0];
  A2 = A[1];
  A3 = A[2];
  A4 = A[3];
  A5 = A[4];
  A6 = A[5];
  
  f1=f[0];
  f2=f[1];
  f3=f[2];
  f4=f[3];
  f5=f[4];
  f6=f[5];
  
  x = random(-1,1);
  y = random(-1,1);
  t = 0;
  
  px = 2*border;
  py = border;
  
  line = 0;

  background(235);
}

float border = 75;
float ystep;

OpenSimplexNoise noise;

void setup(){
  size(1000,1000);
  
  initialize();
  
  ystep = (height-2*border)/nlines;
  
  noise = new OpenSimplexNoise();
}

int numFrames = 1500;

void finish(){
  stop();
  println("finished");
  saveFrame("res"+floor(random(1000000))+".png");
}

void mousePressed() {
  finish();
}

void keyPressed(){
  initialize();
}

float quantity = 1.0;

float v = 0.001;

int nlines = 10;

void move(){
  x *= 2*noise.eval(0.02*t,0);
  y *= 2*noise.eval(123+0.02*t,0);
  //x = 1.5*floor(quantity*x)/quantity;
  //y = 1.5*floor(quantity*y)/quantity;
  float xx = A1*pow(sin(f1*x),p) + A2*pow(cos(f2*y),q) + A3*pow(sin(f3*t),p);
  float yy = A4*pow(cos(f4*x),q) + A5*pow(sin(f5*y),p) + A6*pow(cos(f6*t),q);
  float tt = t + v;
  x = xx;
  y = yy;
  t = tt;
}

float px;
float py;

void step(){
  move();
  
  pushMatrix();
  
  translate(px,py);
  
  float rot = map((float)noise.eval(0.01*px,0.01*py),-1,1,-TWO_PI,TWO_PI);
  
  rotate(rot);
  
  float xx = map(0.5*x,-1.1,1.1,-20,20)+0.5*randomGaussian();
  float yy = map(0.5*y,-1.1,1.1,-20,20)+0.5*randomGaussian();
  
  px += 0.0002 + 0.0007*(1+noise.eval(0.05*px,0)/2);
  
  if(px>width-border){
    line++;
    px = border;
    py += ystep;
  }
  
  if(line>=nlines){
    finish();
  }
  
  strokeWeight(1);
  stroke(0,2);
  point(xx,yy);
  
  popMatrix();
}

int K = 30000;

void draw(){
  frame++;
  
  if(keyPressed){
    initialize();
  }
  
  for(int k=0;k<K;k++){
    step();
  }
  println(frame,'/',numFrames);
  if(frame>=numFrames){
    finish();
  }
}