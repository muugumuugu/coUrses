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

    saveFrame("fr###.png");
    println(frameCount,"/",numFrames);
    if (frameCount==numFrames)
      exit();
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 5;
int numFrames = 100;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

int m = 200;

int m2 = 1500;

float mr = 0.3;

float R = 150;

class Snake{
  float px = random(-0.25*width,0.25*width);
  float py = random(-0.25*height,0.25*height);
  
  float DX = random(-150,150);
  
  float seed = random(10,1000);
  
  float offset = random(0.5);
  
  float sz1 = random(13,23)/2;
  float sz2 = random(13,23)/2;
  
  float rot = random(TWO_PI);
  
  Snake(int i){
    float theta = TWO_PI*i/n;
    px = R*cos(theta);
    py = R*sin(theta);
    
    offset = 1.0*i/n;
  }
  
  void show(){
    stroke(255,255);
    strokeWeight(1.5);
    
    float f = 0.2+ease(map(sin(TWO_PI*(t+offset)),-1,1,0,1),1.5);
    
    push();
    translate(px,py,-1);
    
    fill(0);
    rotate(rot);
    ellipse(0,0,sz1*f,sz2*f);
    
    pop();
    
    push();
    translate(0,0,-2);
    stroke(255,60);
    strokeWeight(1);
   
    for(int i=0;i<m2;i++){
      float p = 1.0*i/m2;
      
      float x1 = lerp(0,px,p);
      float y1 = lerp(-0.4*height,py,p);
      float dy = +200*sin(PI*p) + 25*(float)noise.eval(p,2*seed+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t))*sin(PI*p);
      float dx = 25*(float)noise.eval(p,3*seed+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t))*sin(PI*p);
      
      point(x1,y1+dy);
    }
    
    pop();
    
    stroke(255,255);
    
    for(int i=0;i<m;i++){
      float tt = (100+t-0.55*i/m + offset)%1;
      float p = tt;
      
      float pp = 1.0*i/m;
      
      float y = py-1.5*height*pow(p,2.0);
      float q = map(y,0,height,0,1);
      float x = px+DX*pow(p,0.7) + p*40*(float)noise.eval(seed + 5*q,mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
      
      float sz = 8*pow(sin(PI*i/m),0.4);
      
      float l = 0.15+pow(map((float)noise.eval(4*seed + 6*pp,0),-1,1,0.25,1),2.0);
      
      strokeWeight(sz*l);
    
      point(x,y);
    }
  }
}

int n = 16;

Snake[] array = new Snake[n];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Snake(i);
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  translate(0,70);
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
  
  pop();
}