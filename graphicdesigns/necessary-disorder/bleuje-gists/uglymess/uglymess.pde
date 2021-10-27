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

int samplesPerFrame = 4;
int numFrames = 30;        
float shutterAngle = 0.6;

boolean recording = true;

OpenSimplexNoise noise;

float xmin,xmax;

float ymin,ymax;

void setup(){
  size(640,640,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  xmin = -1.7*width;
  xmax = 1.7*width;
  
  ymin = -8.5*width;
  ymax = .8*width;
}

int n = 50;

int m = 2000;

int N = 6;

float depth(float x,float y){
  float p = map(y,ymin,ymax,1,0);
  float q = map(x,xmin,xmax,0,1);
  return -400+350*(1-sin(PI*p))+650*pow(((cos(TWO_PI*q)+1)/2),1.7);
}

float f = 0.5;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2-200,5);
  rotateX(0.32*PI);
  
  /*
  float cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
  perspective(PI/7.5, width/height, cameraZ/10.0, cameraZ*10.0);*/
  
  for(int i=0;i<n*N;i++){
    float c = (i%3)<1?232:15;
    
    float x1 = map(i,0,n*N,xmin,xmax);
    float x2 = map(i+1,0,n*N,xmin,xmax);
    
    fill(c);
    noStroke();
    
    beginShape(TRIANGLE_STRIP);
    for(int j=0;j<m;j++){
      float y = map(j,0,m-1,ymin,ymax);
      
      float p = map(y,ymin,ymax,1,0);
      
      float xx1 = (1-p)*x1;
      float xx2 = (1-p)*x2;
      
      float xxx1 = (1-0.7*p)*x1;
      float xxx2 = (1-0.7*p)*x2;
      
      float offset = 15.0*pow(1-p,2.0)/5;
      
      float seed = 123;
      float rad = 0.8;
      float change = 1.5;
      float ds1 = 40*(float)noise.eval(seed+change*offset+rad*cos(TWO_PI*(-t+offset)),rad*sin(TWO_PI*(-t+offset)),0.01*xx1);
      float ds2 = 40*(float)noise.eval(seed+change*offset+rad*cos(TWO_PI*(-t+offset)),rad*sin(TWO_PI*(-t+offset)),0.01*xx2);
      float dy = 45*(float)noise.eval(2*seed+change*offset+rad*cos(TWO_PI*(-t+offset)),rad*sin(TWO_PI*(-t+offset)),0.01*xx2);

      float d1 = 2*depth(xx1,y+dy)+dy;
      float d2 = 2*depth(xx2,y+dy)+dy;
      
      float ff = constrain(map(modelZ((xxx1+ds1+xxx2+ds2)/2,y,(d1+d2)/2),-3000,500,0,1),0,1);
      
      fill(ff*c);
     
      vertex(xxx1+ds1,y,d1);
      vertex(xxx2+ds2,y,d2);
    }
    endShape();
  }
  
  pop();
}