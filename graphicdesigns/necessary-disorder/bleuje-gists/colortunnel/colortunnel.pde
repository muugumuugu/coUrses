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

int samplesPerFrame = 4;
int numFrames = 25;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

int n1 = 40;

int n2 = 300;

int N = 20;

int K = n2/N;

float R = 300;

float ZMAX = 4000;

float smth = 0.007;

float smthpw(float p,float pw){
  return map(pow(p+smth,pw),pow(smth,pw),pow(1+smth,pw),0,1);
}

float ccos(float p,float pw){
  float v = cos(p);
  return (v>=0?smthpw(v,pw):-smthpw(-v,pw));
}

float ssin(float p,float pw){
  float v = sin(p);
  return (v>=0?smthpw(v,pw):-smthpw(-v,pw));
}

PVector position(float r,float p,float theta){
  return new PVector(r*ccos(theta+4.0*p,0.5),r*ssin(theta+4.0*p,0.5)-pow((1-p),2.0)*2700-150,-ZMAX*(1-p)+250);
}

//color[] colorArray = new int[]{#4CB5F5, #B7B8B6, #34675C, #B3C100};
//color[] colorArray = new int[]{#021C1E, #004445, #2C7873, #6FB98F};
//color[] colorArray = new int[]{#F52549, #FA6475, #FFD64D, #9BC01C};
color[] colorArray = new int[]{#00293C, #1E656D, #F1F3CE, #F62A00};

class Thing{
  float seed = random(10,1000);
  
  int i,j;
  
  float r = R-130*pow(random(0.9),5.5);
  
  Thing(int i_,int j_){
    i = i_;
    j = j_;
  }

  float offset = 0.1*randomGaussian();
  
  float darken(float p){
    return 0*0.7*pow(map((float)noise.eval(2*seed+7.0*p,0),-1,1,0,1),4.0);
  }
  
  void show(){
    for(int k=0;k<K;k++){
      float theta = TWO_PI*i/n1;
      float ind = j+(k+t)*N;
      
      float p0 = map(ind+0.5,0,n2,-0.5,1.5);
      float p1 = map(ind,0,n2,-0.5,1.5);
      float p2 = map(ind+1,0,n2,-0.5,1.5);
      
      float theta0 = TWO_PI*(i+0.5)/n1;
      float theta1 = TWO_PI*(i)/n1;
      float theta2 = TWO_PI*(i+1)/n1;
      
      PVector v1 = position(R,p1,theta1);
      PVector v2 = position(R,p2,theta1);
      PVector v3 = position(R,p2,theta2);
      PVector v4 = position(R,p1,theta2);
      PVector v = position(R,p0,theta0);

      int colorind = floor((40*p0+offset+1337-4*t + 4*4*theta/TWO_PI))%4;
      
      color col = lerpColor(colorArray[colorind],#000000,2*darken(p0));
      stroke(0);
      fill(col);
      strokeWeight(0.7);
      
      
      beginShape();
      vertex(v1.x,v1.y,v1.z);
      vertex(v2.x,v2.y,v2.z);
      vertex(v3.x,v3.y,v3.z);
      endShape(CLOSE);
      
      beginShape();
      vertex(v3.x,v3.y,v3.z);
      vertex(v4.x,v4.y,v4.z);
      vertex(v1.x,v1.y,v1.z);
      endShape(CLOSE);
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
  translate(width/2+ 0.1*height,height/2);
  
  rotateX(-0.2);
  
  rotate(PI);
  
  for(int k=0;k<n1*N;k++){
    array[k].show();
  }
  
  pop();
}