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
int numFrames = 45;        
float shutterAngle = .9;

boolean recording = true;

OpenSimplexNoise noise;

float border = 150;

int n = 130;
int m = 170;

float l = 200;

float SEED;

void setup(){
  size(600,600,P2D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  SEED = random(10,1000);
}

void draw_(){
  background(0);
  push();
  
  translate(width/2,height/2);
  
  randomSeed(10);
  
  for(int i=0;i<n;i++){
    for(int j=0;j<m;j++){
      float x = map(i,0,n-1,-2.5*width,2.5*width);
      float p = map(j+6*t,0,m-1,0,1);
      
      float z = map(p,0,1,600,-1150);
      
      float y = -3000*pow(p,3.0)+50;
      
      float nrad = 0.8;
      float phase = -20*p;
      
      float pp = 4*pow(constrain(p-0.1,0,1),2.0);
      
      float dx = pp*0.75*l*(float)noise.eval(SEED + 0.006*x,nrad*cos(TWO_PI*t - phase),nrad*sin(TWO_PI*t - phase),5*p);
      float dz = pp*0.75*l*(float)noise.eval(2*SEED + 0.006*x,nrad*cos(TWO_PI*t - phase),nrad*sin(TWO_PI*t - phase),5*p);
      
      PVector proj1 = projection(x,y,z);
      PVector proj2 = projection(x+dx,y,z+dz);
      
      if(-z+zdist>0){
        //strokeWeight(1300*proj2.z*random(0.7,1.1));
        strokeWeight(1+1000*proj2.z);
        stroke(255,255);
        point(proj2.x,proj2.y);
      }
      
      /*
      stroke(255,170);
      strokeWeight(200.0*(proj1.z+proj2.z));
      line(proj1.x,proj1.y,proj2.x,proj2.y);*/
      
    }
  }
  
  pop();
}

float zdist = 400;

PVector projection(float x,float y,float z){
  float xx = 250*x/(-z+zdist);
  float yy = 250*y/(-z+zdist);
  return new PVector(xx,yy,1/(-z+zdist));
}