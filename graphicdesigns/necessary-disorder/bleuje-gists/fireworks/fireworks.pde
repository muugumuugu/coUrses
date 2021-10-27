// by Etienne JACOB
// motion blur template by beesandbombs
// may need opensimplexnoise code in another tab
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
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

float scale = 2.0;

float smoothpow(float p,float pw,float q){
  return map(pow(p+q,pw),pow(0+q,pw),pow(1+q,pw),0,1);
}

class Particle{
  float x,y;
  float R;
  
  float theta = random(TWO_PI);
  float f = random(0.25,1);
  
  float DY = scale*random(8,30);
  
  Particle(float x_,float y_,float R_){
    x = x_;
    y = y_;
    R = R_;
  }
  
  void showp1(float p){
    if(p>=0){
      float dy = DY*pow(p,2.0);
      float dxx = f*R*cos(theta)*smoothpow(p,0.3,0.05);
      float dyy = f*R*sin(theta)*smoothpow(p,0.3,0.05);
      
      point(x+dxx,y+dyy+dy);
    }
  }
  
  int K = 20;
  
  float seed = random(10,1000);
  
  float delay_length = random(0.2,0.7);
  
  void showp(float p){
    for(int i=0;i<K;i++){
      float delay = 1.0*i*map(p,0,1,0,delay_length)/K;
      float sz = map(i,0,K,8,1);
      
      stroke(255,100);
      strokeWeight((1-p)*sz*noise(seed+i));
      
      showp1(p-delay);
    }
  }
}

class Firework{
  int m = floor(random(25,75));
  
  Particle[] array = new Particle[m];
  
  float x = random(scale*50,height-scale*50);
  float y = random(scale*50,height-scale*50);
  float R = scale*random(25,125);
  
  float sz = scale*random(1,3);
  
  Firework(){
    for(int i=0;i<m;i++){
      array[i] = new Particle(x,y,R);
    }
  }
  
  void showp(float p){
    if(p<0.5){
      float pp = 2*p;
      float yy = lerp(height,y,1-smoothpow(1-pp,2.0,0.2));
      
      stroke(255);
      strokeWeight(sz);
      point(x,yy);
    } else {
      float pp = 2*p - 1;
      
      for(int i=0;i<m;i++){
        array[i].showp(pp);
      }
    }
  }
  
  float offset = random(1);
  
  void show(){
    showp((t+offset)%1);
  }
}

int n = 30;

Firework[] arrayf = new Firework[n];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    arrayf[i] = new Firework();
  }
}

void draw_(){
  background(0);
  for(int i=0;i<n;i++){
    arrayf[i].show();
  }
}