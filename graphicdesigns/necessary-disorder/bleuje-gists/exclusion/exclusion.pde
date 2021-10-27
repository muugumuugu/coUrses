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
int numFrames = 150;        
float shutterAngle = 1.2;

boolean recording = true;

OpenSimplexNoise noise;

int n = 80;

float border = 100;

class Thing{
  float x = random(border,width-border);
  float y = random(border,height-border);
  
  float sz = 15+50*pow(random(1),2.0);
  
  int rot = floor(1+random(3));
  
  int type = floor(random(2));
  
  float sw = random(1,3);
  
  float offset = 10+4.5*noise(0.01*x,0.01*y);
  
  int sign = 2*floor(random(2))-1;
  
  float off2 = random(1);
  
  void show(){
    rectMode(CENTER);
    push();
    translate(x,y);
    if(type == 0){
      fill(255);
      noStroke();
    }
    if(type == 1){
      noFill();
      stroke(255);
      strokeWeight(sw);
    }
    rot = 1;
    rotate(sign*HALF_PI*(t+off2)*rot);
    float sz2 = map(ease(map(sin(TWO_PI*(t+offset)),-1,1,0,1),4.0),0,1,0.5*sz,2*sz);
    rect(0,0,sz2,sz2);
    pop();
  }
}

Thing[] array = new Thing[n];

void setup(){
  size(500,500,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Thing();
  }
}

void draw_(){
  background(0);
  blendMode(EXCLUSION);
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
  
}