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

int samplesPerFrame = 1;
int numFrames = 30;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

int n1 = 90;

int n2 = 60*3;

int N = 4;

int K = n2/N;

float smth = 90;

float rmin = 100;

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

PVector position2(float p,float theta){
    float pp = map(p,0,1,-0.9*width,2.9*width);
    float r = rmin + softplus(pp,smth);
    float z = -softplus(-pp,smth)+100-3000*pow(p,3.0);
    
    float x = r*cos(theta);
    float y = r*sin(theta);
    
    return new PVector(x,y,z);
}

class Thing{
  float seed = random(10,1000);
  
  int i,j;
  
  Thing(int i_,int j_){
    i = i_;
    j = j_;
  }
  
  float col = 300*pow(random(1),5.0);
  
  /*
  float r(float p){
    return R - (1-0.4*p)*200*pow(map((float)noise.eval(seed+2.0*p,0),-1,1,0,1),3.0);
  }*/
  
  float coladd(float p){
    return 15+300*pow(map((float)noise.eval(2*seed+29.5*p,0),-1,1,0,1),6.0);
  }
  
  float displacementI = 14;
  
  PVector displacement(float p){
    return new PVector(dx(p),dy(p),dz(p));
  }
  
  float dx(float p){
    return displacementI*(float)noise.eval(3*seed+8.0*p,0);
  }
  
  float dy(float p){
    return displacementI*(float)noise.eval(4*seed+8.0*p,0);
  }
  
  float dz(float p){
    return displacementI*(float)noise.eval(5*seed+8.0*p,0);
  }
  
  float dr(float p){
    return ((float)noise.eval(6*seed+11.0*p,0)+1)/2;
  }
  
  float sf = random(0,1.5);
  
  void show(){
    for(int k=0;k<=K;k++){
      float theta = TWO_PI*i/n1;
      float ind = j+(k-t)*N;
      
      float p0 = map(ind+0.5,0,n2,0,1);
      float p1 = map(ind,0,n2,0,1);
      float p2 = map(ind+1,0,n2,0,1);
      
      float theta0 = TWO_PI*(i+0.5)/n1;
      float theta1 = TWO_PI*(i)/n1;
      float theta2 = TWO_PI*(i+1)/n1;
      
      //float mt = 2*ease(map(sin(TWO_PI*(5*p0-t)),-1,1,0,1),2.0);
      
      PVector v0 = position2(p0,theta0).add(displacement(p0).mult(0.8));
      PVector v1 = position2(p1,theta1);
      PVector v2 = position2(p2,theta1);
      PVector v3 = position2(p2,theta2);
      PVector v4 = position2(p1,theta2);
      
      //stroke(20+map(v0.z,-ZMAX,0,0,1.0)*coladd(p0)/5);
      //stroke(20);
      stroke(5+coladd(p0));
      fill(0);
      strokeWeight(1.7);
      
      beginShape();
      vertex(v0.x,v0.y,v0.z);
      vertex(v1.x,v1.y,v1.z);
      vertex(v2.x,v2.y,v2.z);
      endShape(CLOSE);
      
      beginShape();
      vertex(v0.x,v0.y,v0.z);
      vertex(v3.x,v3.y,v3.z);
      vertex(v2.x,v2.y,v2.z);
      endShape(CLOSE);
      
      beginShape();
      vertex(v0.x,v0.y,v0.z);
      vertex(v3.x,v3.y,v3.z);
      vertex(v4.x,v4.y,v4.z);
      endShape(CLOSE);
      
      beginShape();
      vertex(v0.x,v0.y,v0.z);
      vertex(v1.x,v1.y,v1.z);
      vertex(v4.x,v4.y,v4.z);
      endShape(CLOSE);
      
      float sz = 3*pow(map(sin(TWO_PI*(11*p0-t)+2*theta0),-1,1,0,1),1.7);
      

      noStroke();
      fill(255);
      push();
      translate(v0.x,v0.y,v0.z);
      sphere(1.0*dr(p0)*sz*sf+1.0);
      pop();
    }
  }
}

Thing[] array = new Thing[n1*N];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  int k=0;
  for(int i=0;i<n1;i++){
    for(int j=0;j<N;j++){
      array[k] = new Thing(i,j);
      k++;
    }
  }
}

void draw_(){
  background(0);
  push();
  
  float cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
  perspective(PI/2.5, width/height, cameraZ/10.0, cameraZ*10.0);
  
  translate(width/2,-40+height/2,+0.35*width);
  
  //rotateZ(-0.7*HALF_PI);
  
  rotateX(0.7);
  
  translate(0,+50,50);
  
  for(int k=0;k<n1*N;k++){
    array[k].show();
  }

  pop();
}