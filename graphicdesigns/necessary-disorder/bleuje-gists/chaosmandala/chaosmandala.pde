// by Etienne JACOB
// uses a formula inspired by @ozachou_g (on twitter)

//click on canvas to generate a new one
//press key to save

float x,y,z,t;

float[] A = new float[12];
float[] f = new float[12];
float[] ph = new float[12];

int N;
float rot0,v;

int frame = 0;

void initialize(){
  frame = 0;
  
  for(int i=0;i<12;i++){
    A[i] = random(-3.0,3.0);
    f[i] = random(-1.2,1.2);
    ph[i] = random(TWO_PI);
  }
  
  x = random(-1,1);
  y = random(-1,1);
  z = random(-1,1);
  
  t = 0;
  
  v = 0.0000001*pow(10,random(5));

  background(235);
  
  rot0 = random(TWO_PI);
  N = floor(random(5,15));
}

void setup() {
  //createCanvas(windowWidth, windowHeight);
  size(1000, 1000, P2D);
  
  initialize();
}

void move(){
  float xx = A[0]*sin(f[0]*x+ph[0]) + A[1]*cos(f[1]*y+ph[1]) + 2*A[2]*sin(f[2]*t+ph[2]) + A[3]*sin(f[3]*z+ph[3]);
  float yy = A[4]*cos(f[4]*x+ph[4]) + A[5]*sin(f[5]*y+ph[5]) + 2*A[6]*cos(f[6]*t+ph[6]) + A[7]*sin(f[7]*z+ph[7]);
  float zz = A[8]*sin(f[8]*x+ph[8]) + A[9]*cos(f[9]*y+ph[9]) + 2*A[10]*sin(f[10]*t+ph[10]) + A[11]*cos(f[11]*z+ph[11]);
  float tt = t + v;
  
  x = xx;
  y = yy;
  z = zz;
  t = tt;
}

void step(){
  move();
  
  float scale = 0.2;
  
  float F = 0.5;
  
  float xx = scale*sin(F*x);
  float yy = scale*sin(F*y);
  float zz = scale*sin(F*z);

  stroke(0,4);
  
  if(-zz+zdist>0){
    PVector proj = projection(xx,yy,zz);
    
    for(int r=0;r<N;r++){
      pushMatrix();
      
      translate(width/2,height/2);
      rotate(TWO_PI*r/N + 0*rot0);

      strokeWeight(1+random(0,0.35)*proj.z);
      
      float std = 0.25;
      
      point(proj.x+std*randomGaussian(),proj.y+std*randomGaussian());
      
      popMatrix();
    }
  }
}

float zdist = 0.4;

PVector projection(float xx,float yy,float zz){
  float inv = 1.0/(-zz+zdist);
  float xxx = 300*xx*inv;
  float yyy = 300*yy*inv;
  return new PVector(xxx,yyy,inv);
}

void saveF(){
  println("saving");
  saveFrame("res"+floor(random(1000000))+".png");
  //stop();
}

void keyPressed() {
  saveF();
}

void mousePressed(){
  initialize();
}

int numFrames = 50;

int K = 8500;

void draw() {
  frame++;
  
  for(int k=0;k<K;k++){
    step();
  }
  
  println(frame,'/',numFrames);
  
  if(frame==numFrames){
    saveF();
  }
}