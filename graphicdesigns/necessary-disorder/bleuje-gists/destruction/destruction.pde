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
int numFrames = 60;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;


int n = 40;

int L = 400;

float seed = 132;

class Thing{
  float x,y;
  float szf = random(0.1,1);
  
  float offset;
  
  float dx = random(-50,50)*3;
  float dy = random(-50,50)*3;
  
  float rot = random(-PI,PI)*4;
  
  Thing(int i,int j){
    x = map(i,0,2*n-1,-L/2,L/2);
    y = map(j,0,n-1,-L/4.0,L/4.0);
    
    offset = 2.0*noise(seed+0.06*x) +1.0*(1-1.0*j/n) -0.5 + 0.4*noise(2*seed+0.02*y)-0.2-0.4;
  }
  
  void show(float tt){
    float p = tt-offset;
    
    rectMode(CENTER);
    noStroke();
    
    if(p<0.5){
      push();
      translate(x,y);
      
      rect(0,0,0.5*szf*L/n,0.5*szf*L/n);
      
      pop();
    } else { 
      float smooth = 0.5;
      float ex = 0.75;
      float interp = map(pow(p-0.5+smooth,ex),pow(smooth,ex),1,0,1);
      float sz2 = constrain(1-interp,0,1);
      
      float xx = lerp(x,x+dx,interp);
      float yy = lerp(y,y+dy,interp)+50*(p-0.5);
      
      push();
      translate(xx,yy);
      
      rotate(rot*interp);
      
      rect(0,0,sz2*0.4*szf*L/n,sz2*0.4*szf*L/n);
      
      pop();
    }
  }
}

Thing[] array = new Thing[2*n*n];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  int k = 0;
  for(int i=0;i<2*n;i++){
    for(int j=0;j<n;j++){
      array[k] = new Thing(i,j);
      k++;
    }
  }
}

int I = 4;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  for(int i=-1;i<I;i++){
    push();
    translate(0,0.5*(L*t+L*(i-I/3)));
    for(int k=0;k<2*n*n;k++){
      array[k].show(t+i);
    }
    pop();
  }
  
  pop();
}