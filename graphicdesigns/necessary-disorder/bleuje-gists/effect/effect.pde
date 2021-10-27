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
int numFrames = 50;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

class Thing{
  int ind, ind2;
  
  float seed = random(10,1000);
  
  float h = 50;
  float rad;
  float per = 5;
  float change = 1.0;
  
  Thing(int i){
    ind = i;
    
    ind2 = min(i,n-i-1);
    
    rad = 0.7*(ind2+1);
    per = 16.0/(ind2+1);
    change = 8.0/(ind2+1);
  }
  
  int m = 2000;
  int K = 1;
  
  void show(){
    for(int k=0;k<K;k++){
      for(int i=0;i<=m;i++){
        float p = 1.0*i/m;
        
        //float intensity = pow(sin(PI*p),0.3);
        float intensity = ease(sin(PI*p),2.0);
        
        float dy = intensity*h*(float)noise.eval(seed+rad*cos(TWO_PI*(per*p-t)),rad*sin(TWO_PI*(per*p-t)),change*p);
        float dx = intensity*3*h*(float)noise.eval(2*seed+rad*cos(TWO_PI*(per*p-t)),rad*sin(TWO_PI*(per*p-t)),change*p);
        
        float x = dx + map(p,0,1,50,width-50);
        float y = dy + map(ind,0,n-1,125,height-125);
        
        y = lerp(y,height/2,1-ease(sin(PI*p),1.5));
        
        strokeWeight(1.6);
        stroke(255,30);
        
        point(x,y);
      }
    }
  }
}

int n = 40;

Thing[] array = new Thing[n];

void setup(){
  size(600,600,P2D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Thing(i);
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