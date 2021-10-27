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


void setup(){
  size(500,500,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
}

int m = 450;

float motion_rad = 0.1;

float size = 0.4;

float x1(float ph){
  return 0.0*width+size*width*(float)noise.eval(75+motion_rad*cos(TWO_PI*(t+ph)),motion_rad*sin(TWO_PI*(t+ph)));
}

float y1(float ph){
  return size*width*(float)noise.eval(100+motion_rad*cos(TWO_PI*(t+ph)),motion_rad*sin(TWO_PI*(t+ph)));
}

float x2(float ph){
  return 0.3*width+0.5*size*width*(float)noise.eval(200+motion_rad*cos(TWO_PI*(t+ph)),motion_rad*sin(TWO_PI*(t+ph)));
}

float y2(float ph){
  return 0.5*size*width*(float)noise.eval(300+motion_rad*cos(TWO_PI*(t+ph)),motion_rad*sin(TWO_PI*(t+ph)));
}

float offset_factor = 2.0;

int parts = 8;

void drawThing(int j){
  float ph2 = -parts*1.0*j/n;
  
  float xx1 = x1(ph2);
  float yy1 = y1(ph2);
  float xx2 = x2(ph2);
  float yy2 = y2(ph2);
  
  stroke(255);
  fill(255);
  ellipse(xx1,yy1,3,3);
  ellipse(xx2,yy2,3,3);
  
  stroke(255,50);
  strokeWeight(2);
  for(int i=0;i<=m;i++){
    float tt = 1.0*i/m;
    
    float xx = lerp(x1(-offset_factor*tt+ph2),x2(-offset_factor*(1-tt)+ph2),tt);
    float yy = lerp(y1(-offset_factor*tt+ph2),y2(-offset_factor*(1-tt)+ph2),tt);
    
    point(xx,yy);
  }
}

int n = 50;

void draw_(){
  background(0);
  
  push();
  translate(width/2,height/2);
  
  for(int i=0;i<n;i++){
    push();
    rotate(i*TWO_PI/n);
    drawThing(i);
    pop();
  }
  
  pop();
}