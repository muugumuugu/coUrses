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
int numFrames = 300;        
float shutterAngle = 1.2;

boolean recording = true;

OpenSimplexNoise noise;



int n = 9;

float EASE = 1.8;

int m = 1500;

float R = 150;

float r(float theta,int k){
  if(k==3){
    theta += PI/6;
  }
  return 1.1*R*cos(PI/k)/cos(theta - TWO_PI/k * floor((k*theta + PI)/TWO_PI));
}

float RAD = 1.8;

float MR = 0.8;

float L = 30;

float SEED = 321;

float f = 1.0;

float SW = 1.0;

float alph = 40;

class Thing{
  float offset;
  int ind;
  
  Thing(int i){
    ind = i;
    offset = 0.01*i/n;
  }
  
  void show(){
    float tt = (100+t-offset)%1;
    
    stroke(255,alph);
    strokeWeight(SW);
    
    float x1,y1,x2,y2,p;
    
    float phi = 2*TWO_PI*t;
    
    for(int i=0;i<m;i++){
      float theta = TWO_PI*i/m;
      
      if(tt<1.0/3){
        p = 3*tt;
        p = ease(p,EASE);
        
        x1 = r(theta,3)*cos(theta);
        y1 = r(theta,3)*sin(theta);
        x2 = r(theta,4)*cos(theta);
        y2 = r(theta,4)*sin(theta);
      } else if(tt<2.0/3){
        p = 3*tt-1;
        p = ease(p,EASE);
        
        x1 = r(theta,4)*cos(theta);
        y1 = r(theta,4)*sin(theta);
        x2 = R*cos(theta);
        y2 = R*sin(theta);
      } else {
        p = 3*tt-2;
        p = ease(p,EASE);
      
        x1 = R*cos(theta);
        y1 = R*sin(theta);
        x2 = r(theta,3)*cos(theta);
        y2 = r(theta,3)*sin(theta);
      }
    
      float dx = L*(float)noise.eval(SEED+f*ind/n+RAD*cos(theta+phi),RAD*sin(theta+phi),MR*cos(TWO_PI*t),MR*sin(TWO_PI*t));
      float dy = L*(float)noise.eval(2*SEED+f*ind/n+RAD*cos(theta+phi),RAD*sin(theta+phi),MR*cos(TWO_PI*t),MR*sin(TWO_PI*t));
      
      float xx = lerp(x1,x2,p) + dx*(0.25+sin(PI*p));
      float yy = lerp(y1,y2,p) + dy*(0.25+sin(PI*p));
      
      point(xx,yy);
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