// using code by dave aka @beesandbombs :)

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

    saveFrame("frame###.png");
    if (frameCount==numFrames)
      exit();
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 8;
int numFrames = 150;        
float shutterAngle = 1.5;

boolean recording = true;

void setup() {
  size(500, 500);
  smooth(8);
  result = new int[width*height][3];
  rectMode(CENTER);
  fill(32);
  noStroke();
  
}

void recurDraw(float x1,float y1,float x2,float y2,float x3,float y3,int n){
  if (n<=0) {
        return;
    } else{
        float tt = (3*t)%1;
        stroke(255,255/3*(n-tt));
        float xx1 = (x1+x2)/2;
        float yy1 = (y1+y2)/2;
        float xx2 = (x2+x3)/2;
        float yy2 = (y2+y3)/2;
        float xx3 = (x3+x1)/2;
        float yy3 = (y3+y1)/2;
        line(xx1,yy1,xx2,yy2);
        line(xx3,yy3,xx2,yy2);
        line(xx1,yy1,xx3,yy3);
        recurDraw(x1,y1,xx1,yy1,xx3,yy3,n-1);
        recurDraw(x2,y2,xx1,yy1,xx2,yy2,n-1);
        recurDraw(x3,y3,xx3,yy3,xx2,yy2,n-1);
    }
}

float rad = 200;

void draw_() {
  background(0); 
  push();
  translate(0,50);
  float tt = (3*t)%1;
  stroke(255);
  
  float offset = PI/6 + 2*PI/3*floor(3*t);

  float x1 = width/2 + rad*cos(2*PI*0+offset);
  float y1 = height/2 + rad*sin(2*PI*0+offset);
  float x2 = width/2 + rad*cos(2*PI*1/3+offset);
  float y2 = height/2 + rad*sin(2*PI*1/3+offset);
  float x3 = width/2 + rad*cos(2*PI*2/3+offset);
  float y3 = height/2 + rad*sin(2*PI*2/3+offset);
  
  line(x1,y1,x2,y2);
  line(x2,y2,x3,y3);
  line(x3,y3,x1,y1);
  
  float interp = lerp(0,0.5,ease(tt,5));
  
  float xx1 = lerp(x1,x2,interp);
  float yy1 = lerp(y1,y2,interp);
  float xx2 = lerp(x2,x3,interp);
  float yy2 = lerp(y2,y3,interp);
  float xx3 = lerp(x3,x1,1-interp);
  float yy3 = lerp(y3,y1,1-interp);
  float xx4 = lerp(x2,x1,interp);
  float yy4 = lerp(y2,y1,interp);
  
  line(xx3,yy3,xx2,yy2);
  line(xx4,yy4,xx2,yy2);
  line(xx1,yy1,xx3,yy3);
  
  recurDraw(x1,y1,xx1,yy1,xx3,yy3,5);
  recurDraw(x2,y2,xx4,yy4,xx2,yy2,5);
  recurDraw(x3,y3,xx3,yy3,xx2,yy2,5);
  
  pop();
}