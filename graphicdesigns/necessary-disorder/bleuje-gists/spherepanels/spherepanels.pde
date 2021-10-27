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
int numFrames = 150;        
float shutterAngle = 1.0;

boolean recording = true;

OpenSimplexNoise noise;

PVector position(float r,float theta,float phi){
  return new PVector(r*cos(theta)*sin(phi),r*cos(phi),r*sin(theta)*sin(phi));
}

PVector project(PVector pos){
  float A = 200;
  float B = 0.35*width;
  
  return new PVector(A*pos.x/(-pos.z+B),A*pos.y/(-pos.z+B));
}

float R = 120;

int n = 50;

int N = 8;

int K = 5;

class Thing{
  
  float seed = random(10,1000);
  
  int i,j;
  
  Thing(int i_,int j_){
    i = i_;
    j = j_;
  }
  
  float mr = 1.7;
  
  float mr2 = 1.5;
  
  float mr3 = 12.0;
  
  float st = random(100,255);
  
  void show(boolean bo){
    for(int k=0;k<K;k++){
      float p = map(k+t,0,K,0,1);
      
      float dr = 150*pow(constrain(map((float)noise.eval(seed+mr*cos(TWO_PI*p),mr*sin(TWO_PI*p)),-1,1,-0.9,1),0,1),4.5);
      float dphi = 0.08*(float)noise.eval(2*seed+mr2*cos(TWO_PI*p),mr2*sin(TWO_PI*p))*dr/100;
      float dtheta = 0.08*(float)noise.eval(3*seed+mr2*cos(TWO_PI*p),mr2*sin(TWO_PI*p))*dr/100;
      float fl = 450*pow(constrain(map((float)noise.eval(4*seed+mr3*cos(TWO_PI*p),mr3*sin(TWO_PI*p)),-1,1,-1.5,1),0,1),3.0);
      
      if(bo){
        dr = 0;
        dphi=0;
        dtheta=0;
        fl = 0;
      }
      
      float theta = -TWO_PI*p + j*TWO_PI/(N*K) + dtheta;
      float theta2 = -TWO_PI*p + (j+1)*TWO_PI/(N*K) + dtheta;
      float phi = PI*i/n + dphi;
      float phi2 = PI*(i+1)/n + dphi;
      
      
      
      PVector vec1 = position(R+dr,theta,phi);
      PVector vec2 = position(R+dr,theta,phi2);
      PVector vec3 = position(R+dr,theta2,phi2);
      PVector vec4 = position(R+dr,theta2,phi);
      PVector vec5 = position(R+dr-3,(theta+theta2)/2,(phi+phi2)/2);
      
      stroke(st/3);
      //noStroke();
      fill(fl);
      beginShape();
      vertex(vec1.x,vec1.y,vec1.z);
      vertex(vec2.x,vec2.y,vec2.z);
      vertex(vec3.x,vec3.y,vec3.z);
      vertex(vec4.x,vec4.y,vec4.z);
      endShape(CLOSE);
      
      stroke(st);
      line(0,0,0,vec5.x,vec5.y,vec5.z);
    }
    
  }
  
}

Thing[] array = new Thing[n*N];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  int k = 0;
  for(int i=0;i<n;i++){
    for(int j=0;j<N;j++){
      array[k] = new Thing(i,j);
      k++;
    }
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  for(int k=0;k<n*N;k++){
    array[k].show(true);
    array[k].show(false);
  }

  pop();
}