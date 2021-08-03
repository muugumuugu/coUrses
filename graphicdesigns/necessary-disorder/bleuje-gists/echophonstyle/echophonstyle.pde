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
    if (frameCount==numFrames)
      exit();
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 10;
int numFrames = 150;        
float shutterAngle = .9;

boolean recording = false;

void setup() {
  size(500, 500);
  result = new int[width*height][3];
  rectMode(CENTER);
  
  noiseSeed(1);
}

float x, y, tt;
int N = 20;
float l = 4;

void drawDot(float x,float y,float q){
  float qq = ease(map(cos(TWO_PI*q),-1,1,0,1),7);
  float xx = lerp(x,2*x,qq);
  float yy = lerp(y,2*y,qq);
  float sz = lerp(l,l/5,qq);
  
  fill(255);
  noStroke();
  rect(xx,yy,sz,sz);
}

float sp = 1.5*l;

void draw_() {
  background(0); 
  push();
  translate(width/2, height/2);
  for (int i=-N; i<=N; i++) {
    for (int j=-N; j<=N; j++) {
      x = i*sp;
      y = j*sp;
      tt = (t + 0.5*noise(100+x*0.1,100+y*0.1))%1;
      drawDot(x,y,tt);
    }
  }
  pop();
}