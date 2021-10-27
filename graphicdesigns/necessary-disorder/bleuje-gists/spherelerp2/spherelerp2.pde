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
int numFrames = 75;        
float shutterAngle = 1.0;

boolean recording = true;

OpenSimplexNoise noise;

int n = 140;

int K = 3;

float R = 180;

int m = 500;

class Dot{
  float theta0 = random(TWO_PI);
  float rd = random(-1,1);
  float phi0 = random(PI);
  
  float seed = random(10,1000);
  //float seed = 2*noise(100+0.3*phi0,100+0.3*theta0);
  
  float dph = 0.45;
  
  float dth = 0.45;
  
  float mr = 0.9;
  
  float alp = random(0.3,1.0);
  
  float sz0 = random(0.8,2.5);
  
  Dot(int i){
    //phi0 = map(i,0,n-1,0,PI);
    //theta0 = map(i,0,n-1,0,TWO_PI);
  }
  
  float phi(float p){
    return phi0 + dth*(float)noise.eval(seed+mr*cos(TWO_PI*p),mr*sin(TWO_PI*p));
  }
  
  float theta(float p){
    return theta0-TWO_PI*p + dph*(float)noise.eval(2*seed+mr*cos(TWO_PI*p),mr*sin(TWO_PI*p));
  }
  
  float dr = 10;
  
  float r(float p){
    return R + dr*(float)noise.eval(4*seed+mr*cos(TWO_PI*p),mr*sin(TWO_PI*p));
  }
  
  float x(float p){
    return r(p)*cos(theta(p))*sin(phi(p)); 
  }
  
  float y(float p){
    return r(p)*cos(phi(p)); 
  }
  
  float z(float p){
    return r(p)*sin(theta(p))*sin(phi(p));
  }
  
  float sz(float p){
    return sz0*(1+0.2*(float)noise.eval(3*seed+1*cos(TWO_PI*p),1*sin(TWO_PI*p)));
  }
  
  void show(float p){
    push();
    float x = x(p);
    float y = y(p);
    float z = z(p);
    float sz = sz(p);
    
    float f = map(z,R,-R,1.3,0.2);
    
    stroke(255,255*f);
    strokeWeight(1.5*sz*f);
    
    float A = 120;
    float B = 0.35*width;
    
    float xx = A*x/(-z+B);
    float yy = A*y/(-z+B);
    
    point(xx,yy);
    
    float df = 0.3;
    
    for(int i=0;i<=m;i++){
      float q = 1.0*i/m;
      float xi = lerp(x(p+q*df),0,q);
      float yi = lerp(y(p+q*df),0,q);
      float zi = lerp(z(p+q*df),0,q);
      
      xx = A*xi/(-zi+B);
      yy = A*yi/(-zi+B);
      
      f = map(zi,R,-R,1.3,0.2);
      
      strokeWeight(1.5*f);
      stroke(255,map(q,0,1,1,0.15)*35*f*alp);
      
      point(xx,yy);
    }
    
    pop();
  }
}

Dot[] array = new Dot[n];

void setup(){
  size(600,600,P2D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Dot(i);
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  for(int i=0;i<n;i++){
    for(int k=0;k<K;k++){
      array[i].show(1.0*(k+t)/K);
    }
  }
  
  pop();
}