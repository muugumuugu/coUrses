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
int numFrames = 200;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

int n = 30;

int m = 200;

class Thing{
  int N = 1;
  
  float es = random(3.2,3.5);
  
  float theta,phi;
  
  float seed = random(10,1000);
  
  Thing(int i){
    theta = -HALF_PI+0.1;
    
    phi = TWO_PI*i/n;
  }
  
  void show(float tt){
    float mr = 0.8;
    
    for(int k=0;k<N;k++){
      for(int i=0;i<m;i++){
        float ttt = (2019+tt+0.14*i/m-0.07)%1;
        float sz = 0.5+1.0*sin(PI*i/m);
        
        stroke(255,(i==m-1?255:255));
        strokeWeight((i==m-1?3:1.5*sz));
        
        if(ttt%1<0.5){
          float p = ease(2*(ttt%1),es);
          
          float xx = lerp(0,0.4*width*cos(theta)*cos(phi),p);
          float dx = 80*(float)noise.eval(seed+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t),4*p,1.0*i/m);
          xx = lerp(xx,xx+dx,sin(PI*p));
          
          float yy = lerp(0.4*height,0.4*width*sin(theta),p);
          float dy = 80*(float)noise.eval(2*seed+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t),4*p,1.0*i/m);
          yy = lerp(yy,yy+dy,sin(PI*p));
          
          float zz = lerp(0,0.4*width*cos(theta)*sin(phi),p);
          float dz = 80*(float)noise.eval(3*seed+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t),4*p,1.0*i/m);
          zz = lerp(zz,zz+dz,sin(PI*p));
          
          point(xx,yy,zz);
        } else {
          float p = ease(2*((ttt-0.5)%1),es);
          
          float th;
          
          if(theta<-HALF_PI){
            th = lerp(theta,-PI-HALF_PI,p);
          } else {
            th = lerp(theta,HALF_PI,p);
          }
          
          float xx = 0.4*width*cos(th)*cos(phi);
          float yy = 0.4*width*sin(th);
          float zz = 0.4*width*cos(th)*sin(phi);
          
          point(xx,yy,zz);
        }
          
      }
    }
  }
}

Thing[] array = new Thing[n];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Thing(i);
  }
}

int K = 2;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  for(int i=0;i<n;i++){
    for(int j=0;j<K;j++){
      array[i].show(t/K+1.0*j/K);
    }
  }
  
  pop();
}