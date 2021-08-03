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
    println(frameCount,"/",numFrames);
    if (frameCount==numFrames)
      exit();
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 5;
int numFrames = 100;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

int n = 7;

class Thing{
  float cx = random(-100,100);
  //float cy = random(-50,50);
  float cy = 0;
  
  float seed = random(10,1000);
  
  int m = floor(random(500,800));
  
  int K = floor(random(4,8));
  
  float sw = random(1,2.0);
  
  float l = random(200,400);
  
  float dl = 70;
  
  float mr1 = 0.2;
  
  float mr2 = 0.3;
  
  float rad = 1.0;
  
  Thing(int i){
    cx = map(i,0,n-1,-150,150);
    l = map(sin(PI*i/(n-1)),0,1,200,400);
  }
  
  float x(){
    return cx + 10*(float)noise.eval(seed+mr1*cos(TWO_PI*t),mr1*sin(TWO_PI*t));
  }
  
  float y(){
    return cy + 10*(float)noise.eval(2*seed+mr1*cos(TWO_PI*t),mr1*sin(TWO_PI*t));
  }
  
  void show(){
    stroke(255,100);
    strokeWeight(sw);
    
    float y1 = y()-l/2;
    float y2 = y()+l/2;
    
    for(int k=0;k<K;k++){
      for(int i=0;i<=m;i++){
        float p = 1.0*i/m;
        float xx = x()+2*dl*(float)noise.eval(3*seed+rad*cos(TWO_PI*(p+t)),rad*sin(TWO_PI*(p+t)),mr2*cos(TWO_PI*t),mr2*sin(TWO_PI*t)+0.08*k);
        float dy = dl*(float)noise.eval(4*seed+rad*cos(TWO_PI*(p+t)),rad*sin(TWO_PI*(p+t)),mr2*cos(TWO_PI*t),mr2*sin(TWO_PI*t)+0.08*k);
        float yy = lerp(y1,y2,p);
        yy = lerp(yy,yy+dy,sin(PI*p));
        xx = lerp(x(),xx,sin(PI*p));
        point(xx,yy);
      }
    }
    stroke(255);
    strokeWeight(3*sw);
    point(x(),y1);
    point(x(),y2);
  }
}

Thing[] array = new Thing[n];


void setup(){
  size(500,500,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Thing(i);
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  for(int i=0;i<n;i++){
    array[i].show();
  }
  pop();
}