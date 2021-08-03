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
int numFrames = 25;        
float shutterAngle = .8;

boolean recording = true;

OpenSimplexNoise noise;

class Thing{
  float seed = random(10,1000);
  
  //float x0 = random(0.2*width,0.8*width);
  //float y0 = random(0.2*height,0.8*height);
  float r = random(0.3*width);
  float theta = random(TWO_PI);
  float x0 = r*cos(theta)+0.5*width;
  float y0 = r*sin(theta)+0.5*height;
  
  float dt = 0.1;
  int nsteps = 100;
  
  int np = 10;
  
  PVector[] positions = new PVector[nsteps+1];
  
  float x = x0;
  float y = y0;
  
  void compute_positions(){
    positions[0] = new PVector(x0,y0);
    
    for(int i=1;i<=nsteps;i++){
      PVector f = field(x,y);
      x += dt*f.x;
      y += dt*f.y;
      positions[i] = new PVector(x,y);
    }
  }
  
  float sz = random(1,3);
  
  PVector interp(float p){
    float id = 0.9999*p*nsteps;
    int i1 = floor(id);
    int i2 = floor(id)+1;
    float terp = id-i1;
    PVector pos1 = positions[i1];
    PVector pos2 = positions[i2];
    float xx = lerp(pos1.x,pos2.x,terp);
    float yy = lerp(pos1.y,pos2.y,terp);
    return new PVector(xx,yy);
  }
  
  float offset = random(1);
  
  int m = 30;
  
  float rot0 = random(TWO_PI);
  
  void show(){
    for(int i=0;i<np;i++){
      float p = (1.0*(i+t+offset)%np)/np;
      
      PVector v = interp(p);
      
      stroke(255,255*sin(PI*p));
      strokeWeight(sz*sin(PI*p));
      
      push();
      translate(v.x,v.y);
      
      float rot = rot0 + 0.75*(float)noise.eval(seed + 2.0*p,0);
      rotate(rot);
      
      for(int j=0;j<m;j++){
        float q = 1.0*j/(m-1);
        
        float xx = lerp(-10,10,q);
        float yy = 0;
        
        float dx = 5*sin(PI*q)*(float)noise.eval(2*seed + 8.0*p,5*q);
        float dy = 5*sin(PI*q)*(float)noise.eval(3*seed + 8.0*p,5*q);
        
        stroke(255,50*sin(PI*p));
        strokeWeight(sz*sin(PI*p));
        point(xx+dx,yy+dy);
      }
      
      pop();
    }
  }
}

PVector field(float x,float y){
  //return new PVector(0,50);
  float cx = width/2;
  float cy = 0.5*height;
  PVector v1 = new PVector(-(y-cy),x-cx);
  v1.mult(30/v1.mag());
  
  float cx2 = width/2;
  float cy2 = 0.7*height;
  PVector v2 = new PVector(-(y-cy2),x-cx2);
  v2.mult(-30/v2.mag());
  
  //v1.add(v2);
  
  return v1; 
}

int n = 200;

Thing[] array = new Thing[n];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Thing();
    array[i].compute_positions();
  }
}

void draw_(){
  background(0);
  push();
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
  
  pop();
}