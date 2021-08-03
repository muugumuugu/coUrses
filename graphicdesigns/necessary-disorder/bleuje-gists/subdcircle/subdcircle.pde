// by Etienne JACOB
// motion blur template by beesandbombs
// needs opensimplexnoise code in another tab
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
int numFrames = 300;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

int N = 14;

int nmax = 100;

class Subdivision{
  int n;
  
  float r;
  
  Subdivision(int i){
    n = 2 + i;
    r = map(i,0,N-1,0.05*width,0.25*width);
  }
  
  float sum_values;
  
  float[] cum_sum = new float[nmax];
  
  float seed = random(10,1000);
  float seed2 = random(10,1000);
  float mr2 = 2.25;
  float vmin = 0.1;
  float PW = 4.0;
  float mr = 1.5;
  
  float value(int i){
    return vmin + lerp(pow(map((float)noise.eval(seed*(i+1)+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t)),-1,1,0,1),PW),0.5,map(cos(TWO_PI*t),-1,1,0,1.0));
  }
  
  float SW(int i){
    return lerp(map((float)noise.eval(seed2*(i+1)+mr2*cos(TWO_PI*t),mr2*sin(TWO_PI*t)),-1,1,1,5),1.4,map(cos(TWO_PI*t),-1,1,0,1));
  }
  
  void compute_sums(){
    cum_sum[0] = 0;
    float cur = 0;
    for(int i=1;i<=n;i++){
      cur += value(i-1);
      cum_sum[i] = cur;
    }
    sum_values = cur;
  }
  
  int m = 10;
  
  void show(){
    compute_sums();
    
    stroke(255);
    
    
    for(int i=0;i<n;i++){
      strokeWeight(SW(i));
      
      float theta1 = TWO_PI*(cum_sum[i]/sum_values+(n%2==0?1:1)*2*t/n);
      float theta2 = TWO_PI*(cum_sum[i+1]/sum_values+(n%2==0?1:1)*2*t/n);
      for(int j=1;j<m;j++){
        float theta = lerp(theta1,theta2,1.0*j/m);
        
        float x = r*cos(theta);
        float y = r*sin(theta);
        
        point(x,y);
      }
      
      strokeWeight(1.5);
      
      float dr = 6*map(cos(TWO_PI*t),-1,1,1,0.25);
      float x1 = (r-dr)*cos(theta2);
      float y1 = (r-dr)*sin(theta2);
      float x2 = (r+dr)*cos(theta2);
      float y2 = (r+dr)*sin(theta2);
      line(x1,y1,x2,y2);
    }
  }
  
}

Subdivision[] array = new Subdivision[N];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<N;i++){
    array[i] = new Subdivision(i);
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  rotate(-HALF_PI);
  
  for(int i=0;i<N;i++){
    array[i].show();
  }
  
  pop();

}