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
int numFrames = 100;        
float shutterAngle = 0.3;

boolean recording = true;

OpenSimplexNoise noise;

int n = 15;

float R = 270;

class Thing{
  float theta;
  
  float seed = random(10,1000);
  
  Thing(int i){
    theta = TWO_PI*i/n;
  }
  
  int m = 100;
  int N = 30;
  
  void show(){
    
    for(int j=0;j<=N;j++){
      for(int i=0;i<m;i++){
        float p = 1.0*(i+(100*noise(100*j)%1))/m;
        float r = map(p,0,1,R,0);
        
        float radtheta = 0.25;
        
        float freq = 3.0;
        
        //float offset = -floor(15*pow(1.7,2.5*p))/15.0;
        float offset = -pow(1.7,2.5*p);
        
        float intensity = pow(p,0.7);
        
        //float add = (1+2*pow(map(1-(t-offset-theta/TWO_PI)%1,-1,1,0,1),4.0));
        float add = (1+1*pow(map(sin(TWO_PI*(t-offset)-3*theta),-1,1,0,1),4.0));
        
        float dtheta = intensity*0.7*(float)noise.eval(seed + radtheta*cos(TWO_PI*(t-offset)),radtheta*sin(TWO_PI*(t-offset)),0.18*j+3*p)/pow(add,2.5);
        
        float x = r*cos(theta+dtheta);
        float y = r*sin(theta+dtheta);
        
        float sz = 3*pow(map((float)noise.eval(2*seed+j,100*p),-1,1,0,1),2.7);
        
        stroke(255,150*add);
        strokeWeight(1.0*pow(sin(PI*j/N),2.0)*sz*add);
        
        point(x,y);
      }
    }
  }
}

Thing[] array = new Thing[n];


void setup(){
  size(600,600,P3D);
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