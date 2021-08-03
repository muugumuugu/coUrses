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
int numFrames = 75;        
float shutterAngle = .5;

boolean recording = true;

OpenSimplexNoise noise;

int n = 400;

int m = 200;

PVector displaced(float x,float y){
  float sigma = 50;
  float dz = -constrain(map(-y+DY*t+280,0,DY,0,100),0,1000);
  float DX = 70*sin(TWO_PI*(-y/DY));
  float diff = x-DX;
  dz *= exp(-diff*diff/sigma/sigma);
  return new PVector(x,y,dz);
}

class Particle{
  float y0 = random(0,DY);
  float x = 130*randomGaussian();
  float sz = 5*pow(random(0,1),2.0);
  
  void show(){
    for(int k=-3;k<=4;k++){
      float y = y0 + k*DY;
      
      PVector v = displaced(x,y);
      
      float factor = map(modelZ(v.x,v.y,v.z),-600,250,0,3);
      
      strokeWeight(sz);
      stroke(255*factor);
      point(v.x,v.y,v.z+1);
    }
  }
}

int np = 5000;

Particle[] array = new Particle[np];

void draw_surface(){
  for(int i=0;i<n;i++){
    //float col = i%4==0?255:0;
    float col = 0;
    float y1 = map(i,0,n-1,-1.5*height,1.5*height);
    float y2 = map(i+1,0,n-1,-1.5*height,1.5*height);
    //float factor = map(i,0,n,0,3);
    float factor = map(modelZ(0,y1,0),-600,250,0,3);
    stroke(col*factor);
    fill(col*factor);
    
    beginShape(TRIANGLE_STRIP);
    for(int j=0;j<m;j++){
      
      float x = map(j,0,m,-width,width);
      
      //vertex(x,y1);
      //vertex(x,y2);
      
      PVector v1 = displaced(x,y1);
      PVector v2 = displaced(x,y2);
      
      vertex(v1.x,v1.y,v1.z);
      vertex(v2.x,v2.y,v2.z);
    }
    endShape();
  }
}

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<np;i++){
    array[i] = new Particle();
  }
}

float DY = 500;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  rotateX(0.9);
  translate(0,-DY*t);
  draw_surface();
  
  for(int i=0;i<np;i++){
    array[i].show();
  }
  pop();
}