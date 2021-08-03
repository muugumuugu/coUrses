// Processing code by Etienne JACOB
// motion blur template by beesandbombs
// opensimplexnoise code in another tab might be necessary
// --> code here : https://gist.github.com/Bleuje/fce86ef35b66c4a2b6a469b27163591e

// A lot of hidden blocks are drawn, I don't really care

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

int samplesPerFrame = 4;
int numFrames = 50;        
float shutterAngle = .75;

boolean recording = true;

OpenSimplexNoise noise;

float RATIO = 0.8;

int N = 3;

int m = 70;

float DZ = 35.0;

int nz = 13;

class Thing{
  int i,j,l;
  float offset;
  
  Thing(int i_,int j_,int l_){
    i = i_;
    j = j_;
    l = l_;
    
    float theta = (j+0.5)*TWO_PI/m;
    float rad = 2.0;
    offset = 0.4*(float)noise.eval(2*i,2*j) + 2.7*(float)noise.eval(4337+rad*cos(theta),rad*sin(theta))+2.7-1.0*i/N+0.07*l+theta/TWO_PI;
  }
  
  float seed = random(10,1000);
  
  float col = random(230,265);
  
  float sw = random(0.3,0.7);
  
  void show(float p){
    float pp = p + offset;
    
    float theta1 = j*TWO_PI/m;
    float theta2 = (j+1)*TWO_PI/m;
    float R = 100.0;
    float r1 = pow(RATIO,p)*pow(1/RATIO,1.0*i/N)*R;
    float r2 = pow(RATIO,p)*pow(1/RATIO,1.0*(i+1)/N)*R;
    
    float x1 = r1*cos(theta1);
    float y1 = r1*sin(theta1);
    float x2 = r1*cos(theta2);
    float y2 = r1*sin(theta2);
    float x3 = r2*cos(theta2);
    float y3 = r2*sin(theta2);
    float x4 = r2*cos(theta1);
    float y4 = r2*sin(theta1);
    
    float f = 0.5+5*pow(map((float)noise.eval(seed+1.0*p,0),-1,1,0,1),3.0);
    
    float q = max(0,0.5*pp);
    
    float dz = pow(RATIO,p)*1700*pow(q,2.0);
    
    float DZ2 = 0.6*DZ*pow(RATIO,p);
    
    float z = -dz-l*DZ2;
    
    push();
    translate(0,0,z);
    
    strokeWeight(sw*f);
    stroke(col+0.34*z);
    fill(0);
    beginShape();
    vertex(x1,y1,0);
    vertex(x2,y2,0);
    vertex(x3,y3,0);
    vertex(x4,y4,0);
    endShape(CLOSE);
    beginShape();
    vertex(x1,y1,0);
    vertex(x2,y2,0);
    vertex(x2,y2,-DZ2);
    vertex(x1,y1,-DZ2);
    endShape(CLOSE);
    beginShape();
    vertex(x3,y3,0);
    vertex(x4,y4,0);
    vertex(x4,y4,-DZ2);
    vertex(x3,y3,-DZ2);
    endShape(CLOSE);
    beginShape();
    vertex(x1,y1,0);
    vertex(x4,y4,0);
    vertex(x4,y4,-DZ2);
    vertex(x1,y1,-DZ2);
    endShape(CLOSE);
    beginShape();
    vertex(x2,y2,0);
    vertex(x3,y3,0);
    vertex(x3,y3,-DZ2);
    vertex(x2,y2,-DZ2);
    endShape(CLOSE);
    beginShape();
    vertex(x1,y1,-DZ2);
    vertex(x2,y2,-DZ2);
    vertex(x3,y3,-DZ2);
    vertex(x4,y4,-DZ2);
    endShape(CLOSE);
    pop();
  }
  
  int K = 5;
  
  void show(){
    for(int ii=-2*K;ii<K;ii++){
      show(ii+t);
    }
  }
  
}

Thing[] array = new Thing[m*N*nz];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  int k=0;
  for(int i=0;i<N;i++){
    for(int j=0;j<m;j++){
      for(int l=0;l<nz;l++){
        array[k] = new Thing(i,j,l);
        k++;
      }
    }
  }
}

void draw_(){
  background(0);
  push();
  
  translate(width/2,height/2);
  
  rotateX(0.8);
  
  translate(0,0,100);
  
  for(int i=0;i<N*m*nz;i++){
    array[i].show();
  }
  
  pop();
}