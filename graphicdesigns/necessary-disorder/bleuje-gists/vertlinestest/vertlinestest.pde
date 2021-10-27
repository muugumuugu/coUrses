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

int samplesPerFrame = 1;
int numFrames = 40;        
float shutterAngle = .9;

boolean recording = true;

OpenSimplexNoise noise;

int K = 5;

int n = 200;

class Thing{
  
  //float x0 = random(-1,1);
  //float y0 = random(-1,1);
  //float z0 = random(-1,1);
  float x0 = random(-2000,2000);
  float y0 = random(-2000,2000);
  float z0 = 0;
  
  //float vx = random(-1,1);
  //float vy = random(-1,1);
  //float vz = random(-1,1);
  float vx = 0;
  float vy = random(-1,1);
  float vz = 0;
  
  float offset = random(1);
  
  float swf = 13*pow(random(0,1),2.0);
  
  int m = 500;
  
  void show(){
    stroke(255);
    strokeWeight(2);
    
    for(int k=0;k<K;k++){
      float r = 200*(k+(t+offset)%1);
      float p = 1.0*(k+(t+offset)%1)/K;
      
      //float x = r*x0;
      //float y = r*y0;
      //float z = r*z0;
      
      float x = x0;
      float y = y0;
      float z = map(p,0,1,-2000,zdist+10);
      
      for(int i=0;i<m;i++){
        float q = 1.0*i/m;
        
        float f = 5;
        
        x = lerp(x,x+f*vx,q);
        y = lerp(y,y+f*vy,q);
        z = lerp(z,z+f*vz,q);
              
        PVector proj = projection(new PVector(x,y,z));
        //point(x,y,z);
        stroke(255,20*sin(PI*p));
        strokeWeight(swf*300*proj.z);
        
        if(-z+zdist>0){
          point(proj.x,proj.y);
        }
      }
    }
  }
}

float zdist = 200;

PVector projection(PVector v){
  float inv = 1.0/(-v.z+zdist);
  float xx = 100*v.x*inv;
  float yy = 100*v.y*inv;
  return new PVector(xx,yy,inv);
}

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
  
  translate(width/2,height/2);
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
  
  pop();
}