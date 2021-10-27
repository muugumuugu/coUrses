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

int samplesPerFrame = 4;
int numFrames = 100;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

/*
float l = 25;
float motion_radius = 1.0;
*/
float l = 100;
float motion_radius = 0.5;

class Dot{
  float r = sqrt(random(1))*0.3*width;
  float theta = random(TWO_PI);
  float cx = r*cos(theta);
  float cy = r*sin(theta);
  
  float id1 = random(10000);
  float id2 = random(10000);
  
  float x(float ph){
    return cx + l*(float)noise.eval(id1 + motion_radius*cos(TWO_PI*(t+ph)),motion_radius*sin(TWO_PI*(t+ph)));
  }
  
  float y(float ph){
    return cy + l*(float)noise.eval(id2 + motion_radius*cos(TWO_PI*(t+ph)),motion_radius*sin(TWO_PI*(t+ph)));
  }
  
  void show(){
    stroke(255);
    fill(255);
    
    ellipse(x(0),y(0),5,5);
  }
}

int n = 75;

Dot[] array = new Dot[n];

void setup(){
  size(500,500,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Dot();
  }
}

int m = 100;

float offset_factor = 3.0;

float swmax = 5;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  stroke(255,50);
  for(int i=0;i<n;i++){
    for(int j=0;j<i;j++){
      float d = 1.0*dist(array[i].x(0),array[i].y(0),array[j].x(0),array[j].y(0))/(1.0*width);
      
      float sw = constrain(map(d*width,0,0.15*width,swmax,0),0,swmax);
      
      strokeWeight(sw);
      
      for(int k=0;k<=m;k++){
        float tt = 1.0*k/m;
        
        float xx = lerp(array[i].x(-d*offset_factor*tt),array[j].x(-d*offset_factor*(1-tt)),tt);
        float yy = lerp(array[i].y(-d*offset_factor*tt),array[j].y(-d*offset_factor*(1-tt)),tt);
        
        point(xx,yy,-1);
      }
    }
  }
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
  
  pop();
}