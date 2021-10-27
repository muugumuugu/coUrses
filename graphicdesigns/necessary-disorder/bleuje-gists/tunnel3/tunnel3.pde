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

int samplesPerFrame = 10;
int numFrames = 45;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

int n = 8;

//int m = 1500;

float R = 200;

class Thing{
  float seed = random(10,1000);
  
  void show(float tt){
    float rad = 3*pow(pow(tt,7.0),2.5);
    
    float z = map(tt,0,1,-25000,2000);
    
    float start2 = pow(constrain(5*tt,0,1),2.9);
    
    float l = map(pow(tt,1.5),0,1,130,70);
    
    int m = floor(map(pow(tt,3.5),0,1,100,2500))/10;
    
    for(int i=0;i<m;i++){
      float theta = TWO_PI*i/m;
      
      float start = ease(constrain(5*tt,0,1),2.0);
      
      float ph = 0.0*TWO_PI*pow(tt,2.0);
      
      float dx = start*l*(float)noise.eval(seed+rad*cos(theta+ph),rad*sin(theta+ph),10.0*tt);
      float dy = start*l*(float)noise.eval(2*seed+rad*cos(theta+ph),rad*sin(theta+ph),10.0*tt);
      
      float x = R*cos(theta) + dx;
      float y = R*sin(theta) + dy;
      
      float mr = 0.8;
      
      float sw = pow(map((float)noise.eval(3*seed+1.5*cos(theta),1.5*sin(theta),mr*cos(TWO_PI*t),mr*sin(TWO_PI*t)),-1,1,0,1),2.0)*4+0.5;
      
      strokeWeight(3*sw);
      stroke(255,start2*200);
      
      push();
      translate(0,0,z);
      point(x,y);
      pop();
    }
  }
  
}

class Star{
  float size = random(1,3.5);
  float alpha = random(255,255);
  float r = random(25,150);
  float theta = random(TWO_PI);
  float pos = random(-1000,1000);
  
  float x = r*cos(theta);
  float y = r*sin(theta);
  
  float offset = random(1);
  
  void show(){
    float tt = (t+offset)%1;
    
    //float end = ease(constrain(4*(1-tt),0,1),2.0);
    float end = 1;
    
    strokeWeight(size);
    stroke(255,alpha*pow(sin(PI*tt),0.7));
    
    float z = pos + map(tt,0,1,-1000,0);
    
    push();
    translate(0,0,z);
    
    point(end*x,end*y);
    
    pop();
  }
}

Thing[] array = new Thing[n];

int n2 = 6000;

Star[] array2 = new Star[n2];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Thing();
  }
  
  for(int i=0;i<n2;i++){
    array2[i] = new Star();
  }
}

int K = 15;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  stroke(255);
  fill(255);
  ellipse(0,0,43,43);
  
  for(int i=0;i<n;i++){
    for(int k=0;k<K;k++){
      float p = 1.0*k/K+1.0*i/n/K + t/K;
      array[i].show(p);
    }
  }
  
  for(int i=0;i<n2;i++){
    array2[i].show();
  }
  
  pop();
}