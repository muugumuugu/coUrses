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
int numFrames = 43;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

PVector position(float r,float theta,float phi){
  return new PVector(r*cos(theta)*sin(phi),1.4*r*cos(phi),r*sin(theta)*sin(phi));
}

float R = 130;

int n = 70;

int K = 10;

int N = n/K;

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


class Thing{
  int i;
  int j;
  
  float seed = random(10,1000);
  float rad = 1.5;
  float DR = 30;
  float RR = 130;
  float f = 1.0;
  float f2 = random(0.5,1.0);
  
  Thing(int i_, int j_, float DR_,float RR_,float rad_,float f_){
    i = i_;
    j = j_;
    DR = DR_;
    RR = RR_;
    rad = rad_;
    f = f_;
  }
  
  void show(){
    for(int k=0;k<K;k++){
      float ind = i+(k-t)*N;
      float theta1 = map(ind,0,n,0,TWO_PI);
      float theta2 = map(ind+1,0,n,0,TWO_PI);
      float theta0 = map(ind+0.5,0,n,0,TWO_PI);
      
      float phi1 = map(j,0,n,0,PI);
      float phi2 = map(j+1,0,n,0,PI);
      float phi0 = map(j+0.5,0,n,0,PI);
      
      float dr = DR*lerp(sin(phi0),1,0.5)*pow(softplus(map((float)noise.eval(seed+rad*cos(theta0),rad*sin(theta0)),-1,1,-0.1,1),0.25),3.0);
      
      PVector v0 = position(RR+dr,theta0,phi0);
      PVector v1 = position(RR,theta1,phi1);
      PVector v2 = position(RR,theta1,phi2);
      PVector v3 = position(RR,theta2,phi2);
      PVector v4 = position(RR,theta2,phi1);
      
      stroke(map(v0.z,-RR,RR,0,f2*f*115));
      fill(0);
      strokeWeight(1.6);
      
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
      
      strokeWeight(4.0);
      stroke((f2+1)/2*255);
      point(v0.x,v0.y,v0.z);
    }
  }
}

Thing[] array = new Thing[n*N];

Thing[] array2 = new Thing[n*N];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  int k=0;
  for(int i=0;i<N;i++){
    for(int j=0;j<n;j++){
      array[k] = new Thing(i,j,30,130,1.3,0.7);
      k++;
    }
  }
  k = 0;
  for(int i=0;i<N;i++){
    for(int j=0;j<n;j++){
      array2[k] = new Thing(i,j,-60,230,0.7,1.0);
      k++;
    }
  }
}

void draw_(){
  background(0);
  float cameraZ =  ((height/2.0) / tan(PI*60.0/360.0));
  perspective(PI/2.4, width/height, cameraZ/10.0, cameraZ*10.0);
  push();
  translate(width/2,height/2);
  rotate(HALF_PI);
  translate(70,120,340);
  //rotate(QUARTER_PI);
  for(int k=0;k<N*n;k++){
    array[k].show();
  }
  for(int k=0;k<N*n;k++){
    array2[k].show();
  }
  pop();
}