// by Etienne JACOB
// motion blur template by beesandbombs
// needs opensimplexnoise code in another tab
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

int n = 65;

int m = 70;

int R = 180;

int r = 40;

float Z = 80;

class Section{
  float id;
  float col;
  
  Section(int i){
    id = i;
    //col = (id%10==0?25:230);
    col = 230;
  }
  
  void show(){
    float theta1 = map(id,0,n,0,TWO_PI);
    float theta2 = map(id+1,0,n,0,TWO_PI);
    
    float ES = 4.0;
    float part = 0.05;
    
    float dz;
    
    if(id>=n/2 && t<=0.5){
      dz = Z*ease(constrain(part*n*(t+1-1.0*id/n),0,1),ES)-Z;
    } else{
      dz = Z*ease(constrain(part*n*(t-1.0*id/n),0,1),ES);
    }
    
    float dz1 = map(theta1,0,TWO_PI,0,Z)+dz;
    float dz2 = map(theta2,0,TWO_PI,0,Z)+dz;
    
    noStroke();
    fill(col);
    
    beginShape(TRIANGLE_STRIP);
    for(int i=0;i<=m;i++){
      float v = 1.0*i/m*TWO_PI;
      vertex((R+r*cos(v))*cos(theta1),(R+r*cos(v))*sin(theta1),r*sin(v)+dz1);
      vertex((R+r*cos(v))*cos(theta2),(R+r*cos(v))*sin(theta2),r*sin(v)+dz2);
    }
    endShape(CLOSE);
    
    stroke(200);
    fill(id%2==0?25:200);
    beginShape();
    for(int i=0;i<m;i++){
      float v = 1.0*i/m*TWO_PI;
      vertex((R+r*cos(v))*cos(theta1),(R+r*cos(v))*sin(theta1),r*sin(v)+dz1);
    }
    endShape(CLOSE);
    beginShape();
    for(int i=0;i<m;i++){
      float v = 1.0*i/m*TWO_PI;
      vertex((R+r*cos(v))*cos(theta2),(R+r*cos(v))*sin(theta2),r*sin(v)+dz2);
    }
    endShape(CLOSE);
  }
}

Section[] array = new Section[n];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Section(i);
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  rotateX(0.3*PI);
  
  translate(0,0,-Z*t);
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
  
  pop();
}