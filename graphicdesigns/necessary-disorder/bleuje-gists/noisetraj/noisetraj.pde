OpenSimplexNoise noise;

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
int numFrames = 60;        
float shutterAngle = .8;

boolean recording = true;

float R = 1.2;
float L = 160;
float scl = 0.013;

float radius = 200;

class Star{
  float r = sqrt(random(1))*radius;
  float the = random(TWO_PI);
  float y = height/2 + r*sin(the);

  float x = width/2 + r*cos(the);
  
  
  void show(){
    float intensity = pow(map(dist(x,y,width/2,height/2),0,radius,1,0),0.75);

    float xx = x + intensity*L*(float)noise.eval(scl*x,scl*y,R*cos(TWO_PI*t),R*sin(TWO_PI*t));
    float yy = y + intensity*L*(float)noise.eval(100+scl*x,scl*y,R*cos(TWO_PI*t),R*sin(TWO_PI*t));

    stroke(255);
    strokeWeight(1);
    point(xx,yy);
  }
}

void drawCurve(){
  int m = 200;
  stroke(255);
  noFill();
  beginShape();
  for(int i=0;i<m;i++){
    float theta = i*TWO_PI/m;
    float y = height/2+radius*cos(theta);
    float x = width/2+radius*sin(theta);
    float intensity = pow(map(dist(x,y,width/2,height/2),0,radius,1,0),0.75);
    float xx = x + intensity*L*(float)noise.eval(scl*x,scl*y,R*cos(TWO_PI*t),R*sin(TWO_PI*t));
    float yy = y + intensity*L*(float)noise.eval(100+scl*x,scl*y,R*cos(TWO_PI*t),R*sin(TWO_PI*t));
    vertex(xx,yy);
  }
  endShape(CLOSE);
}

int n = 40000;

Star[] array = new Star[n];

void setup(){
  size(500,500);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Star();
  }
  
}

void draw_(){
  background(0);
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
  
  stroke(255);
  strokeWeight(1);
  drawCurve();
}