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
int numFrames = 30;        
float shutterAngle = 1.0;

boolean recording = true;

OpenSimplexNoise noise;

int m = 5000;

float R = 200;

class Curve{
  float seed = random(10,1000);
  
  PVector pos(float q,float p){
    float theta = TWO_PI*(q*3.0-p);
    float phi = PI*q;
    
    float x = R*cos(theta)*sin(phi);
    float y = R*cos(phi);
    float z = R*sin(theta)*sin(phi);
    
    return new PVector(x,y,z);
  }
  
  float sign;
  
  Curve(){
    //sign = (i%2)*2-1;
  }
  
  void show(float p){
    p = (p+1234)%1;
    for(int i=0;i<m;i++){
      float q = 1.0*i/m;
      
      PVector ps = pos(q,p);
      
      float x = ps.x;
      float y = ps.y;
      float z = ps.z;
      
      float per = -1*20.0;
      float D = 7;
      float rad = 2.5;
      float change = 20.0;
      
      float dx = sin(PI*q)*D*(float)noise.eval(seed + rad*cos(TWO_PI*(per*q+t)),rad*sin(TWO_PI*(per*q+t)),change*q);
      float dy = sin(PI*q)*D*(float)noise.eval(2*seed + rad*cos(TWO_PI*(per*q+t)),rad*sin(TWO_PI*(per*q+t)),change*q);
      float dz = sin(PI*q)*D*(float)noise.eval(3*seed + rad*cos(TWO_PI*(per*q+t)),rad*sin(TWO_PI*(per*q+t)),change*q);
      
      x+=dx;
      y+=dy;
      z+=dz;
      
      float alpha = constrain(map(ps.z,-R/2,R,0,255),100,255)/3.5;
      float sw = map(ps.z,-R,R,1.4,3.1)/2;
      
      stroke(255,alpha);
      strokeWeight(sw);
      
      float xx = 270*x/(-z+1.7*R);
      float yy = 270*y/(-z+1.7*R);
      
      point(xx,yy);
    }
  }
}

Curve cv1,cv2;

int n = 4;

Curve[] array = new Curve[n];

void setup(){
  size(600,600,P2D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Curve();
  }
}

int K = 8;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  /*
  for(int k=0;k<K;k++){
    cv1.show((k+t)/K);
  }
  for(int k=0;k<K;k++){
    cv2.show((k+t+0.5)/K);
  }*/
  
  for(int i=0;i<n;i++){
    for(int k=0;k<K;k++){
      array[i].show((k+t+1.0*i/n)/K);
    }
  }
  
  pop();
}