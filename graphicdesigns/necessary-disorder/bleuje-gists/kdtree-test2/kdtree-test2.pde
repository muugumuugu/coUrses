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
int numFrames = 250;        
float shutterAngle = 0.8;

boolean recording = true;

OpenSimplexNoise noise;

class Polygon{
  float seed = random(10,1000);
  
  Polygon child1,child2;
  
  int depth;

  int md = 12;
  
  Polygon(int d){
    depth=d;
    
    if(d<=md){
      child1 = new Polygon(d+1);
      child2 = new Polygon(d+1);
    }
  }
  
  float change = 6.0;
  
  float ef = 3.0;
  
  float ppfromp(float p){
    float low = map(depth,0,md,0,0.55);
    return constrain(map(p,low,1,0,1),0,1);
  }
  
  float weight0(float p){
    float pp = ppfromp(p);
    return lerp(1,5+map((float)noise.eval(seed,change*p),-1,1,2,4+4*depth),ease(sin(PI*pp),ef));
  }
  
  float weight1(float p){
    float pp = ppfromp(p);
    return lerp(10,map((float)noise.eval(2*seed,change*p),-1,1,0,25+4*depth),ease(sin(PI*pp),ef));
  }
  
  float weight2(float p){
    float pp = ppfromp(p);
    return lerp(10,map((float)noise.eval(3*seed,change*p),-1,1,0,25+4*depth),ease(sin(PI*pp),ef));
  }
  
  void show(PVector p1,PVector p2,PVector p3,PVector p4){
    if(depth>=md){
      strokeWeight(1.3);
      stroke(255);
      noFill();

      beginShape();
      vertex(p1.x,p1.y);
      vertex(p2.x,p2.y);
      vertex(p3.x,p3.y);
      vertex(p4.x,p4.y);
      endShape(CLOSE);
    } else {
      float w1 = child1.weight0(t);
      float w2 = child2.weight0(t);
      float w1_1 = w1+child1.weight1(t);
      float w2_1 = w2+child2.weight1(t);
      float w1_2 = w1+child1.weight2(t);
      float w2_2 = w2+child2.weight2(t);
      
      float q1 = w1_1/(w1_1+w2_1);
      float q2 = w1_2/(w1_2+w2_2);
      
      if(depth%2==0){
        PVector mid1 = p1.copy().lerp(p2,q1);
        PVector mid2 = p4.copy().lerp(p3,q2);
        
        child1.show(p1,mid1,mid2,p4);
        child2.show(mid1,p2,p3,mid2);
      } else {
        PVector mid1 = p2.copy().lerp(p3,q1);
        PVector mid2 = p1.copy().lerp(p4,q2);
        
        child1.show(p1,p2,mid1,mid2);
        child2.show(mid2,mid1,p3,p4);
      }
      
     
    }
  }
}

Polygon poly;

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  poly = new Polygon(0);
}

void draw_(){
  background(0);
  push();
  
  float mrg = 120;
  
  PVector p1 = new PVector(mrg,mrg);
  PVector p2 = new PVector(width-mrg,mrg);
  PVector p3 = new PVector(width-mrg,height-mrg);
  PVector p4 = new PVector(mrg,height-mrg);
  
  poly.show(p1,p2,p3,p4);
  
  stroke(255);
  strokeWeight(2.0);
  
  rect(mrg,mrg,width-2*mrg,height-2*mrg);

  pop();
}