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
int numFrames = 150;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

int MAX_DEPTH = 7;

float MR = 0.6;

float VMIN = 0.3;

class Triangle{
  float depth;
  float seed = random(10,1000);
  float mr;
  float vmin;
  
  Triangle top,right,left;
  
  Triangle(int d,float mr_,float vmin_){
    depth = d;
    mr = mr_;
    vmin = vmin_;
    
    if(d<MAX_DEPTH){
      top = new Triangle(d+1,mr*1.2,vmin*0.9);
      right = new Triangle(d+1,mr*1.2,vmin*0.9);
      left = new Triangle(d+1,mr*1.2,vmin*0.9);
    }
  }
  
  float value(){
    return vmin+pow(map((float)noise.eval(seed+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t)),-1,1,0,1),2.8);
  }
  
  void show(float xt,float yt,float xr,float yr,float xl,float yl){
    if(depth == MAX_DEPTH){
      
      noStroke();
      fill(255);
      
      /*
      stroke(255);
      noFill();*/
      
      beginShape();
      vertex(xt,yt);
      vertex(xr,yr);
      vertex(xl,yl);
      endShape(CLOSE);
    } else {
      float vt = top.value();
      float vr = right.value();
      float vl = left.value();
      
      float xtr = lerp(xt,xr,vt/(vt+vr));
      float ytr = lerp(yt,yr,vt/(vt+vr));
      
      float xrl = lerp(xr,xl,vr/(vr+vl));
      float yrl = lerp(yr,yl,vr/(vr+vl));
      
      float xlt = lerp(xl,xt,vl/(vl+vt));
      float ylt = lerp(yl,yt,vl/(vl+vt));
      
      top.show(xt,yt,xtr,ytr,xlt,ylt);
      right.show(xtr,ytr,xr,yr,xrl,yrl);
      left.show(xlt,ylt,xrl,yrl,xl,yl);
    }
  }
}

Triangle tri;

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  tri = new Triangle(0,MR,VMIN);
}

float R = 250;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  translate(0,50);
  tri.show(R*cos(TWO_PI*0/3 - HALF_PI),R*sin(TWO_PI*0/3 - HALF_PI),R*cos(TWO_PI*1/3 - HALF_PI),R*sin(TWO_PI*1/3 - HALF_PI),R*cos(TWO_PI*2/3 - HALF_PI),R*sin(TWO_PI*2/3 - HALF_PI));
  pop();
}