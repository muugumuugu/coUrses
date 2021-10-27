// Processing code by Etienne JACOB
// motion blur template by beesandbombs
// result of this is more like tumblr version than twitter version (https://necessary-disorder.tumblr.com/image/190425356073)

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
int numFrames = 140;        
float shutterAngle = 0.8;

boolean recording = true;

//OpenSimplexNoise noise;


class Cube{
  int i,j;
  
  float x,y;
  
  float offset;
  
  Cube(int i_,int j_){
    i = i_;
    j = j_;
    
    x = map(i+0.5,0,n,-width,width);
    y = map(j+0.5,0,n,-width,width);
    
    offset = 0.0038*dist(x,y,0,0) + 0.3*random(1);
  }
  
  void show(){
    float z = -453*ease(constrain(4.0*(t>1.99?0:t)-offset,0,1),3.0);
      
    push();
    translate(x,y,z);
    
    if(i%2==0&&j%2==0){
      rotateZ(0);
    }
    if(i%2==1&&j%2==0){
      rotateZ(HALF_PI);
    }
    if(i%2==1&&j%2==1){
      rotateZ(2*HALF_PI);
    }
    if(i%2==0&&j%2==1){
      rotateZ(3*HALF_PI);
    }
    
    drawCube(2*width/n,2.5,t);
    
    pop();
  }
  
  float swspeed1 = random(5.0,10.0);
  float swspeed2 = random(5.0,10.0);
  
  float off1 = random(TWO_PI);
  float off2 = random(TWO_PI);
  
  void drawCube(float L,float sw,float p){
    rectMode(CENTER);
    stroke(255);
    fill(0);
    strokeWeight(sw);
    float sw2 = constrain(sw+0.8-swspeed1*p+0.9*(offset-0.7),0,sw);
    float sw3 = constrain(sw+0.8-swspeed2*p+0.9*(offset-0.7),0,sw);

    fill(0);
    push();
    translate(0,0,L/2);
    strokeWeight(0);
    rect(0,0,L,L);
    strokeWeight(sw);
    translate(0,0,-L);
    rect(0,0,L,L);
    pop();
    
    push();
    rotateY(HALF_PI);
    translate(0,0,L/2);
    strokeWeight(sw);
    rect(0,0,L,L);
    translate(0,0,-L);
    strokeWeight(sw2);
    rect(0,0,L,L);
    pop();
    
    push();
    rotateX(HALF_PI);
    translate(0,0,L/2);
    strokeWeight(sw3);
    rect(0,0,L,L);
    translate(0,0,-L);
    strokeWeight(sw);
    rect(0,0,L,L);
    pop();
    
  }
}

int n = 38;

Cube[] array = new Cube[n*n];

void setup(){
  size(540,540,P3D);
  result = new int[width*height][3];
  
  //noise = new OpenSimplexNoise();
  
  int k=0;
  for(int i=0;i<n;i++){
    for(int j=0;j<n;j++){
      array[k] = new Cube(i,j);
      k++;
    }
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  translate(random(-0.5,0.5),random(-0.5,0.5));// for little blur
  
  for(int i=0;i<n*n;i++){
    array[i].show();
  }
  

  pop();
}