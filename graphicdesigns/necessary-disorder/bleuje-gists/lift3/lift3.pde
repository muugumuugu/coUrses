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
int numFrames = 45;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;


PImage img;

int n = 1000;

float R = 180;

int m = 100;

float SEED;

float radius(float theta,int k){
  if(k==3){
    theta += PI/6;
  }
  return 1.1*R*cos(PI/k)/cos(theta - TWO_PI/k * floor((k*theta + PI)/TWO_PI));
}

class Thing{
  float theta;
  
  //float offset = random(0.02);
  float offset = 0.037*randomGaussian();
  
  float seed = random(10,1000);
  
  float dtheta = random(-0.01,0.01);
  
  float fact = 1.5*pow(random(1),2.0);
  
  //float dr = randomGaussian();
  
  float l = random(0.03,0.08)/15;
  
  float theta(float p){
    //float rad = 1.0;
    //return theta + dtheta + (1+(1-p))/2*0.06*(noise(seed+20*p)-0.5) + (1-p)*0.15*(float)noise.eval(3*seed+2.5*p,0) + (1+(1-p))/2*0.65*(float)noise.eval(SEED+2.5*p,rad*cos(theta),rad*sin(theta));
    //return theta + dtheta + (1+(1-p))/2*0.06*(noise(seed+20*p)-0.5) + (1-p)*0.15*(float)noise.eval(3*seed+2.5*p,0) + 0.8*(float)noise.eval(SEED+2.0*p,0);
    return theta + dtheta + (1+(1-p))/2*0.06*(noise(seed+20*p)-0.5) + (1-p)*0.35*(float)noise.eval(3*seed+2.5*p,0) - 9.8*pow(p,3.5);
  }
  
  /*
  float r(float p){
    return 0+R*ease(p,4.0);
  }*/
  
  float r(float p){
    return 0+radius(theta(p),6)*ease(p,3.0);
  }
  
  Thing(int i){
    theta = TWO_PI*i/n;
  }
  
  void showDot(float p){
    p = (12337+p)%1;
    
    float alpha = 10*pow(constrain(map(p,0.5,1.0,1,0),0,1),2.0);
    stroke(255,alpha);
    
    float x = r(p)*cos(theta(p));
    float y = r(p)*sin(theta(p));
    
    point(x,y);
  }
  
  void show(float tt){
    float rad = 2.0;
    float ll = l + 0.01*(float)noise.eval(10*seed+rad*cos(TWO_PI*tt),rad*sin(TWO_PI*tt));
    
    for(int i=0;i<m;i++){
      float p = (100+tt - ll*i/m - offset)%1;
      
      stroke(255,10);
      strokeWeight(fact*(1+sin(PI*i/m)*(0.5+1.2*noise(2*seed+15*p))));
      showDot(p);
    }
  }
}

Thing[] array = new Thing[n];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  //img = loadImage("hands3.png");
  
  for(int i=0;i<n;i++){
    array[i] = new Thing(i);
  }
  
  SEED = random(10,1000);
}

int K = 9;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  noFill();
  strokeWeight(1.0);
  /*
  for(int i=0;i<100;i++){
    float alpha = 255*pow(map(i,0,20,1,0),3.0);
    stroke(255,alpha);
    ellipse(0,0,2*R+i,2*R+i);
  }*/
  
  for(int k=0;k<K;k++){
    for(int i=0;i<n;i++){
      array[i].show(1.0*k/K+t/K);
    }
  }
  pop();
  
  //image(img,50,50);
}