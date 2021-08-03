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
int numFrames = 50;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

class Circle{
  int m = floor(random(20,70));
  float sz = random(2,25);
  
  float seed = random(10,1000);
  
  void show(float p){
    float z = map(p,0,1,-20000,1000);
    float rot = 5*(float)noise.eval(seed+10*p,0);
    
    fill(255);
    stroke(255);
    strokeWeight(1);
    
    push();
    translate(0,0,z);
    
    for(int i=0;i<m;i++){
      push();
      rotateZ(TWO_PI*i/m+rot);
      rotateX(HALF_PI);
      //rotateZ(TWO_PI*i/m);
      
      translate(0,0,200);
      
      ellipse(0,0,sz,sz);
      
      pop();
    }
    
    pop();
  }
}

int N = 10;

Circle[] array = new Circle[N];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<N;i++){
    array[i] = new Circle();
  }
}

int n = 60;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  for(int i=0;i<N;i++){
    for(int j=0;j<n;j++){
      array[i].show(1.0*(j+t+1.0*i/N)/n);
    }
  }
  
  stroke(255);
  strokeWeight(40);
  point(0,0);
  
  /*
  stroke(0);
  strokeWeight(5);
  point(0,0);*/
  
  pop();
}