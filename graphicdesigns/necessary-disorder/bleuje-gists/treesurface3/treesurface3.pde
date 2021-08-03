// Processing code by Etienne JACOB
// motion blur template by beesandbombs
// opensimplexnoise code in another tab might be necessary
// --> code here : https://gist.github.com/Bleuje/fce86ef35b66c4a2b6a469b27163591e

// Warning : this code just shows how a gif was made, it's not intended to be pedagogical, show good coding practices or be clever

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

int samplesPerFrame = 3;
int numFrames = 35;        
float shutterAngle = .7;

boolean recording = true;

OpenSimplexNoise noise;


float smth = 650;

float rmin = 50;

PVector position(float p,float theta){
    float pp = map(p,0,1,-0.9*width,2.0*width);
    //float r = 0.3*(1.5-p*p)*(rmin + softplus(pp,smth));
    //float r = 0.5*(rmin + softplus(pp,smth));
    float r = 0.4*(1.55-p)*(0.4*rmin + 1.0*softplus(pp,smth));
    float z = -softplus(-pp,smth)+60+60*p;
    
    float x = r*cos(theta);
    float y = r*sin(theta);
    
    return new PVector(x,y,z);
}

float EPS = 0.001;

PVector normal_to_surface(float p,float theta){
    PVector v1 = position(p,theta);
    PVector v2 = position(p+EPS,theta);
    PVector v3 = position(p,theta+EPS);
    
    PVector w1 = v2.copy().sub(v1);
    PVector w2 = v3.copy().sub(v1);
    
    
    PVector n = w1.cross(w2);
    n.normalize();
    
    return n;
}

int n1 = 400;

int n2 = 80;

void draw_surface(){
  noStroke();
  fill(0);
  for(int i=0;i<n1;i++){
    beginShape(TRIANGLE_STRIP);
    for(int j=0;j<=n2;j++){
      float p1 = 1.0*(i)/n1;
      float p2 = 1.0*(i+1)/n1;
      float theta = TWO_PI*j/n2;
      PVector pos1 = position(p1,theta);
      PVector pos2 = position(p2,theta);
      vertex(pos1.x,pos1.y,pos1.z);
      vertex(pos2.x,pos2.y,pos2.z);
    }
    endShape();
  }
}

int K = 11;

class Thing{
  float seed = random(10,1000);
  float offset = random(1);
  float sz = 3*pow(random(1),2.5);
  float theta0 = random(TWO_PI);
  
  int N = floor(1+60*pow(random(1),2.0));
  
  float dm = random(0.25,1);
  
  float col = random(100,350);
  
  void show(){
    for(int k=0;k<K;k++){
      for(int j=0;j<N;j++){
        float p = ((k+0.16*j/50+t+offset)/K)%1;
        
        float q = map(j,0,N,0,1);
        
        float SZ = 1.2*sz*q*pow(sin(PI*p),0.2);
        strokeWeight(SZ);
        stroke(255);
        
        //float theta1 = theta0+3*pow(1-p,5.0);
        //float theta1 = theta0+4*p;
        float theta1 = theta0+3*pow(1-p,2.0);
        
        
        PVector pos = position(p,theta1);
        
        PVector n = normal_to_surface(p,theta1);
        
        pos.add(n.mult(-4.0*dm));
        
        push();
        translate(pos.x,pos.y,pos.z);
        noStroke();
        fill(255);
        ellipse(0,0,SZ,SZ);
        rotateX(HALF_PI);
        ellipse(0,0,SZ,SZ);
        pop();
      }
    }
  }
}

int n = 2100;

Thing[] array = new Thing[n];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();

  for(int i=0;i<n;i++){
      array[i] = new Thing();
  }
}

void draw_(){
  background(0);
  push();
  
  translate(width/2,height/2,0.05*width);
  
  //scale(0.7);
  
  //rotateZ(-0.7*HALF_PI);
  
  rotateX(2.97);
  
  draw_surface();
  
  for(int k=0;k<n;k++){
    array[k].show();
  }

  pop();
}