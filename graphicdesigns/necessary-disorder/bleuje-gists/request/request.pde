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

int samplesPerFrame = 3;
int numFrames = 75;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

float l = 135;
float motion_radius = 0.2;

float CX = 250;
float CY = 50;

class Dot{
  float r = pow(random(1),0.2)*0.3*width;
  float theta = random(TWO_PI);
  
  float mrad = random(0.2,0.5);
  
  float id = random(10000);
  
  float r(float ph){
    return l*(1+(float)noise.eval(id + mrad*cos(TWO_PI*(t+ph)),mrad*sin(TWO_PI*(t+ph))));
  }
  
  float x(float ph){
    return width/2 + r(ph)*cos(theta);
  }
  
  float y(float ph){
    return height/2 + r(ph)*sin(theta);
  }
  
  void show(){
    strokeWeight(0.5);
    float xx = x(0);
    float yy = y(0);
    
    stroke(255,150);
    line(xx,yy,CX,CY);
    
    stroke(255);
    fill(255);
    ellipse(xx,yy,3,3);
  }
}

int n = 50;

Dot[] array = new Dot[n];

void setup(){
  size(500,500);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Dot();
  }
}

int m = 150;

float offset_factor = 4.0;

float swmax = 2;

void draw_(){
  blendMode(BLEND);
  background(0);
  
  push();
  //translate(width/2,height/2);
  
  stroke(255,40);
  for(int i=0;i<n;i++){
    for(int j=0;j<i;j++){
      float d = 1.0*dist(array[i].x(0),array[i].y(0),array[j].x(0),array[j].y(0))/(1.0*width);
      
      float sw = constrain(map(d*width,0,0.45*width,swmax,0),0,swmax);
      
      strokeWeight(sw);
      
      for(int k=0;k<=m;k++){
        float tt = 1.0*k/m;
        
        float xx = lerp(array[i].x(-d*offset_factor*tt),array[j].x(-d*offset_factor*(1-tt)),tt);
        float yy = lerp(array[i].y(-d*offset_factor*tt),array[j].y(-d*offset_factor*(1-tt)),tt);
        
        point(xx,yy);
      }
    }
  }
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
  
  pop();
  /*
  blendMode(EXCLUSION);
  fill(255);
  stroke(255);
  rect(-width,-height,2*width,2*height);*/
}