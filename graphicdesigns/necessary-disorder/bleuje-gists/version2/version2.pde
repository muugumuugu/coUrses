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

int n = 20;

int m = 3000;

float mrsw = 0.5;

class Thing{
  float ind;
  
  float seed = random(10,1000);
  
  Thing(int i){
    ind = i;
  }
  
  void show(){
    stroke(255,50);
    for(int i=0;i<m;i++){
      float y = map(i,0,m-1,-height/2-10,height/2+100);
      float x = map(ind,0,n-1,-1.99,1.99)*width*(0.1+pow(1.0*i/m,2.0));
      
      float p = 1.0*i/m;
      
      float l = map(pow(p,2.0),0,1,5,30);
      
      float intensity = ease(map(sin(TWO_PI*(8*pow(p,1.8)-1*t-1.5*sin(PI*ind/(n-1)))),-1,1,0.0,1),2.0);
      
      //float rad = 4*pow(p,1.5);
      float rad = 6;
      float part = 10.0;
      
      //float dx = l*(float)noise.eval(seed+80*pow(p,1.5)*cos(TWO_PI*(p+t)),mrsw*cos(TWO_PI*t),mrsw*sin(TWO_PI*t));
      //float dy = l*(float)noise.eval(2*seed+80*pow(p,1.5)*cos(TWO_PI*(p+t),mrsw*cos(TWO_PI*t),mrsw*sin(TWO_PI*t));
      float dx = intensity*l*(float)noise.eval(seed+rad*cos(TWO_PI*(part*p+t)),rad*sin(TWO_PI*(part*p+t)));
      float dy = intensity*l*(float)noise.eval(2*seed+rad*cos(TWO_PI*(part*p+t)),rad*sin(TWO_PI*(part*p+t)));
      
      float sw = map((float)noise.eval(3*seed+30*pow((1-p),2.0),mrsw*cos(TWO_PI*t),mrsw*sin(TWO_PI*t)),-1,1,0.5,3.0);
      
      strokeWeight(sw);
      
      point(x+dx,y+dy);

    }
  }
}

Thing[] array = new Thing[n];

void setup(){
  size(540,540,P3D);
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