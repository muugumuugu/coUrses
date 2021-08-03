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

int m = 2450;

int n = 6;

float motion_rad = 0.9;

float size = 0.4;

float x(float ph){
  return size*width*(float)noise.eval(25+motion_rad*cos(TWO_PI*(t+ph)),motion_rad*sin(TWO_PI*(t+ph)));
}

float y(float ph){
  return size*width*(float)noise.eval(50+motion_rad*cos(TWO_PI*(t+ph)),motion_rad*sin(TWO_PI*(t+ph)));
}

float offset_factor = 1.0;

int parts = 20;

float spacing = 0.4;

void drawThing(){
  
  float xx1 = x(0);
  float yy1 = y(0);

  
  stroke(255);
  fill(255);
  ellipse(xx1,yy1,7,7);
  
  //stroke(255,50);
  strokeWeight(2);
  
  for(int j=0;j<n;j++){
    float theta = j*TWO_PI/n;
    
    noStroke();
    ellipse(spacing*width*cos(theta),spacing*width*sin(theta),5,5);
    
    stroke(255,50);
    for(int i=0;i<=m;i++){
      float tt = 1.0*i/m;
      
      float xx = lerp(x(-offset_factor*tt),spacing*width*cos(theta),tt);
      float yy = lerp(y(-offset_factor*tt),spacing*width*sin(theta),tt);
      
      point(xx,yy);
    }
  }
}

void draw_(){
  background(0);
  
  push();
  translate(width/2,height/2);
  
  drawThing();
  
  pop();
}