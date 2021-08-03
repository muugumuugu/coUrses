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

float offset_rad = 4.0;

class Thing{
  float theta;
  
  float offset;
  
  float rmin = 50;
  float rmax = 220;
  
  float easing = 3.0;
  
  Thing(float th){
    theta = th;
    offset = 0.6*noise(100+offset_rad*cos(theta),100+offset_rad*sin(theta));
  }
  
  void show(){
    float tt = (t+offset)%1;
    float r = map(ease(map(sin(TWO_PI*tt),-1,1,0,1),3.0),0,1,rmin,rmax);
    
    float x = r*cos(theta);
    float y = r*sin(theta);
    
    fill(255);
    stroke(255);
    ellipse(x,y,2,2);
  }
}

int n = 100;

Thing[] array = new Thing[n];


void setup(){
  size(500,500,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    
    array[i] = new Thing(1.0*i*TWO_PI/n);
    println(array[i].theta);
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  for(int i=0;i<n;i++){
    array[i].show();
    //println(array[i].theta);
  }
  pop();
}