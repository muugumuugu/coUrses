float x,y,z,t;

float[] A = new float[6];
float[] f = new float[6];

int p = 3;
int q = 3;

float A1,A2,A3,A4,A5,A6;
float f1,f2,f3,f4,f5,f6;

int frame = 0;

int line;

boolean cont = true;

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
  
  px = 1.5*border;
  py = border;
  
  line = 0;
  
  SEED = random(10,10000);

  cont = true;

  background(235);
}

float border = 75;
float ystep;

OpenSimplexNoise noise;

float SEED;

void setup(){
  size(1000,1000);
  
  initialize();
  
  ystep = (height-2*border)/nlines;
  
  noise = new OpenSimplexNoise();
}

int numFrames = 1500;

void finish(){
  println("finished");
  saveFrame("large/res"+floor(random(1000000))+".jpg");
  stop();
}

void mousePressed() {
  finish();
}

void keyPressed(){
  initialize();
}

float quantity = 1.0;

float v = 0.0002;

int nlines = 15;

void move(){
  x *= 2*noise.eval(3*SEED+0.15*t,0);
  y *= 2*noise.eval(4*SEED+0.15*t,0);
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
  
  float rot = map((float)noise.eval(SEED+0.05*px,0.05*py),-1,1,-TWO_PI,TWO_PI);
  
  rotate(0.1*rot);
  
  float xx = map(0.5*x,-1.1,1.1,-28,28)+0.5*randomGaussian();
  float yy = map(0.3*y,-1.1,1.1,-28,28)+0.5*randomGaussian();
  
  px += 0.0002 + 0.0006*(1+noise.eval(2*SEED+0.05*px,0.05*py)/2);
  
  if(random(80000)<1){
    px += random(5,25);
  }
  
  if(px>width-border){
    line++;
    px = border;
    py += ystep;
  }
  
  if(line>=nlines){
    cont = false;
  }
  
  //strokeWeight(1+ 0.5*(1+(float)noise.eval(0.05*frame,0)/2));
  strokeWeight(1);
  stroke(0,3);
  point(xx,yy);
  
  popMatrix();
}

int K = 30000;

void draw(){
  if(line>=nlines){
    finish();
  }
  
  frame++;
  
  if(keyPressed){
    initialize();
  }
  
  for(int k=0;k<K;k++){
    if(cont){
      step();
    } else {
      break;
    }
  }
  println(frame,'/',numFrames);
  if(frame>=numFrames){
    finish();
  }
}