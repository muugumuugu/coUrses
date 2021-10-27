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
int numFrames = 140;        
float shutterAngle = .7;

boolean recording = true;

OpenSimplexNoise noise;


int n = 20;

float ax = 250;
float ay = 450;

int m = 1500;


void setup(){
  size(500,500,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
}

float offset_factor = 2.5;

float xx1 = 0.1*width;
float yy1 = 0.5*height;

float xx2 = 0.8*width;
float yy2 = 0.5*height;

float x1(float ph){
  return 0.1*width;
}

float y1(float ph){
  return 0.5*height + 100*(1+sin(TWO_PI*(t+ph)))/2*sin(6*TWO_PI*(t+ph));
}

float x2(float ph){
  return 0.87*width + 0.05*width*cos(2*TWO_PI*(t+ph));
}

float y2(float ph){
  return 0.5*height + 0.05*width*sin(2*TWO_PI*(t+ph));
}

void draw_(){
  background(0);
  push();
  translate(0,-0.05*width);
  
  float xx1 = 0.1*width;
  float yy1 = 0.5*height;
  
  float xx2 = 0.87*width;
  float yy2 = 0.5*height;
  
  stroke(255);
  strokeWeight(3);
  fill(255);
  ellipse(x1(0),y1(0),7,7);
  ellipse(x2(0),y2(0),7,7);
  
  stroke(255,100);
  for(int i=0;i<=m;i++){
    float tt = 1.0*i/m;
    
    float xx = lerp(x1(-offset_factor*tt),x2(-offset_factor*(1-tt)),tt);
    float yy = lerp(y1(-offset_factor*tt),y2(-offset_factor*(1-tt)),tt);
    
    point(xx,yy);
  }
  
  translate(0,0.35*width);
  ellipse(x1(0),y1(0),7,7);
  ellipse(xx2,yy2,7,7);
  for(int i=0;i<=m;i++){
    float tt = 1.0*i/m;
    
    float xx = lerp(x1(-offset_factor*tt),xx2,tt);
    float yy = lerp(y1(-offset_factor*tt),yy2,tt);
    
    point(xx,yy);
  }
  
  translate(0,-0.7*width);
  ellipse(xx1,yy1,7,7);
  ellipse(x2(0),y2(0),7,7);
  for(int i=0;i<=m;i++){
    float tt = 1.0*i/m;
    
    float xx = lerp(xx1,x2(-offset_factor*(1-tt)),tt);
    float yy = lerp(yy1,y2(-offset_factor*(1-tt)),tt);
    
    point(xx,yy);
  }
  pop();
}