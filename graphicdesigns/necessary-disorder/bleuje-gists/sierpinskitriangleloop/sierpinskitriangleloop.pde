// Processing code by Etienne JACOB
// motion blur template by beesandbombs
// opensimplexnoise code in another tab might be necessary
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

float softplus(float q,float p){
  float qq = q+p;
  if(qq<=0){
    return 0;
  }
  if(qq>=2*p){
    return qq-p;
  }
  return 1/(4*p)*qq*qq;
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
int numFrames = 180;        
float shutterAngle = .6;

boolean recording = true;

//OpenSimplexNoise noise;

int DEPTH = 5;
float SWMAX = 3.0;
float R = 300;

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  //noise = new OpenSimplexNoise();
  
}

void drawFractal(int it,PVector v1,PVector v2,PVector v3,float p)
{
  if(it>=DEPTH) return;
  
  float sw = map(it+p,0,DEPTH,SWMAX,0);
  strokeWeight(sw);
  
  triangle(v1.x,v1.y,v2.x,v2.y,v3.x,v3.y);
  
  PVector u1 = v1.copy().add(v2).mult(0.5);
  PVector u2 = v2.copy().add(v3).mult(0.5);
  PVector u3 = v3.copy().add(v1).mult(0.5);
  
  drawFractal(it+1,v1,u1,u3,p);
  drawFractal(it+1,u1,v2,u2,p);
  drawFractal(it+1,u3,u2,v3,p);
}

void drawThing(float p,PVector v1,PVector v2,PVector v3)
{
  PVector u1 = v1.copy().add(v2).mult(0.5);
  PVector u2 = v2.copy().add(v3).mult(0.5);
  PVector u3 = v3.copy().add(v1).mult(0.5);
  
  PVector w1 = v2.copy().lerp(u1,p);
  PVector w2 = v2.copy().lerp(u2,p);
  PVector w3 = v3.copy().lerp(u2,p);
  PVector w4 = v3.copy().lerp(u3,p);
  
  drawFractal(0,v1,w1,w4,p);
  drawFractal(0,w1,v2,w2,p);
  drawFractal(0,w4,w3,v3,p);
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2+50);
  
  noFill();
  
  blendMode(ADD);
  
  for(int col=0;col<3;col++)
  {
    stroke(255*int(col==0),255*int(col==1),255*int(col==2));
    
    float a1 = TWO_PI*0.0/3.0-HALF_PI;
    PVector v1 = new PVector(R*cos(a1),R*sin(a1));
    float a2 = TWO_PI*1.0/3.0-HALF_PI;
    PVector v2 = new PVector(R*cos(a2),R*sin(a2));
    float a3 = TWO_PI*2.0/3.0-HALF_PI;
    PVector v3 = new PVector(R*cos(a3),R*sin(a3));
    
    strokeWeight(SWMAX);
    triangle(v1.x,v1.y,v2.x,v2.y,v3.x,v3.y);
    
    int N = 16;
    for(int i=0;i<N;i++){
      float t2 = 3*t+0.011*col+0.0015*i;
      float q = t2%1;
      float rot = floor(t2)%3;
      push();
      rotate(TWO_PI*rot/3);
      drawThing(ease(constrain(q,0,1),2.1),v1,v2,v3);
      pop();
    }
  }
  
  blendMode(NORMAL);


  pop();
}