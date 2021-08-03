//using code by dave (@beesandbombs)

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

void pop(){
  popStyle();
  popMatrix();
}

void draw() {
  
  if(!recording){
    t = mouseX*1.0/width;
    c = mouseY*1.0/height;
    if(mousePressed)
        println(c);
    draw_();
  }
  
  else {
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

  saveFrame("frame-###.png");
  if (frameCount==numFrames)
    exit();
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 8;
int numFrames = 200;        
float shutterAngle = .9;

boolean recording = false;

int n = 500;
float r = 50;

float x(float q){
  return r*(sin(q) + 2*sin(2*q));
}

float y(float q){
  return r*(cos(q) - 2*cos(2*q));
}

float h = 1e-4;

float xp(float q){
  return r*(cos(q)+4*cos(2*q));
}

float yp(float q){
  return -r*(sin(q)-4*sin(2*q));
}

float xpp(float q){
  return (xp(q+h/2)-xp(q-h/2))/h;
}

float ypp(float q){
  return (yp(q+h/2)-yp(q-h/2))/h;
}

float xpn(float q){
  return xp(q)/dist(xp(q),yp(q),0,0);
}

float ypn(float q){
  return yp(q)/dist(xp(q),yp(q),0,0);
}

float th;

void drawCurve(){
  stroke(255);
  noFill();
  beginShape();
  for(int i=0; i<n; i++){
    th = TWO_PI*i/n;
    vertex(x(th),y(th));
  }
  endShape(CLOSE);
}

float radius,xd,yd,xx,yy;

void drawDisk(){
  th = TWO_PI*t;
  radius = pow(xp(th)*xp(th)+yp(th)*yp(th),1.5)/(xp(th)*ypp(th) - xpp(th)*yp(th));
  xd = x(th) - ypn(th)*radius;
  yd = y(th) + xpn(th)*radius;
  xx = x(th);
  yy = y(th);
  noStroke();
  fill(255);
  ellipse(xd,yd,2*radius-7,2*radius-7);
  ellipse(xx,yy,5,5);

}

void setup() {
  size(640,640);
  result = new int[width*height][3];
  rectMode(CENTER);
  stroke(255);
  noFill();
  strokeWeight(7);
}

void draw_() {
  background(0); 
  push();
  translate(width/2,height/2);
  blendMode(BLEND);
  drawCurve();
  push();
  blendMode(EXCLUSION);
  drawDisk();
  pop();
  pop();
}