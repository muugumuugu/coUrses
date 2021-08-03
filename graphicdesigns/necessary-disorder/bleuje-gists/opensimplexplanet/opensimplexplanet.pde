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
int numFrames = 35;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

float R = 200;

int ns = 200;

void draw_surface(){
  for(int i=0;i<ns;i++){
    strokeWeight(1);
    stroke(0);
    fill(0);
    beginShape(TRIANGLE_STRIP);
    for(int j=0;j<=ns/2;j++){
      float phi1 = map(i,0,ns,0,TWO_PI);
      float phi2 = map(i+1,0,ns,0,TWO_PI);
      float theta = map(j,0,ns,0,PI);
      
      float x1 = R*sin(theta)*cos(phi1);
      float y1 = R*sin(theta)*sin(phi1);
      float x2 = R*sin(theta)*cos(phi2);
      float y2 = R*sin(theta)*sin(phi2);
      float z = R*cos(theta);
      
      vertex(x1,y1,z);
      vertex(x2,y2,z);
    }
    endShape();
  }
}

class Thing{
  float seed = random(10,1000);
  float phi = random(TWO_PI);
  
  int m = 1800;
  
  float rad = 0.8;
  
  int k = 50;
  
  void show(){
    for(int i=0;i<m;i++){
      float p = 1.0*i/m;
      float theta = HALF_PI*p;
      
      float change = 3.0;
      
      float freq = 10.0;
      
      float dphi = 0.4*(float)noise.eval(0*seed + 20.0*cos(phi) + rad*cos(TWO_PI*(freq*p-t)),rad*sin(TWO_PI*(freq*p-t)),change*p) + PI*pow(p,1.0);
      float dtheta = 0.1*(float)noise.eval(0*2*seed + 20.0*cos(phi) + rad*cos(TWO_PI*(freq*p-t)),rad*sin(TWO_PI*(freq*p-t)),change*p);
      
      float eps = 1;
      
      float r = R + eps;
      
      float phi_ = phi + dphi;
      float theta_ = theta + dtheta;
      
      float x = r*sin(theta_)*cos(phi_);
      float y = r*sin(theta_)*sin(phi_);
      float z = r*cos(theta_);
      
      stroke(255,50);
      float f = pow((1+(float)noise.eval(seed+0*10*i,0))/2,2.0);
      strokeWeight(4*f);
      
      point(x,y,z);
    }
  }
}

int n = 200;

Thing[] array = new Thing[n];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Thing();
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2,0.35*width);
  
  rotateX(0.6*HALF_PI);
  
  translate(0,0,-0.3*width);
  
  draw_surface();
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
  
  pop();
}