// by Etienne JACOB
// motion blur template by beesandbombs
// needs opensimplexnoise code in another tab
// --> code here : https://gist.github.com/Bleuje/fce86ef35b66c4a2b6a469b27163591e

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

    saveFrame("fr###.gif");
    println(frameCount,"/",numFrames);
    if (frameCount==numFrames)
      exit();
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 5;
int numFrames = 75;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;


void setup(){
  size(600,600,P2D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
}

float turns = 12;

int n = 7000;

int K = 8;

float rad = 1.5;


void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  stroke(255,100);
  strokeWeight(1.5);
  noFill();
  
  for(int k=0;k<K;k++){
    for(int i=1;i<n;i++){
      float p = (1.0*(i+0*t)/n)%1;
      
      float pp = pow(p,0.5);
      
      float c1 = 0.1+ease(constrain(map(p,0.85,1,1,0),0,1),2.0);
      float c2 = ease(constrain(map(p,0,.02,0,1),0,1),2.0);
      
      float theta = turns*TWO_PI*pow(0.1+0.9*pp,0.5);
      float r = 0.4*width*pow(p,0.5);
      float x = r*cos(theta);
      float y = r*sin(theta)+(0.25*width-0.25*width*pow(0.05+0.95*p,0.4+0.03*cos(TWO_PI*t)));
      
      float l = 25*c1*c2*constrain(map(y,-height/2,height/2-100,2.0,0),0.12,1);
      
      float part = 20.0;
      
      float dx = l*(float)noise.eval(12+0.79*k+rad*cos(TWO_PI*(part*p-t)),rad*sin(TWO_PI*(part*p-t)),30*p);
      float dy = l*(float)noise.eval(92+0.79*k+rad*cos(TWO_PI*(part*p-t)),rad*sin(TWO_PI*(part*p-t)),30*p);
      
      stroke(255*c1,30*c1);
      point(x+dx,y+dy);
    }
  }
  
  pop();
}