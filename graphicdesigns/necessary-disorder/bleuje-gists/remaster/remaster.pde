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

int samplesPerFrame = 4;
int numFrames = 100;        
float shutterAngle = .7;

boolean recording = true;

OpenSimplexNoise noise;

int n = 10;

int r = 170;

float motion_rad = 0.5;

float l = 40;

class Center{
  float cx;
  float cy;
  
  float seed = random(1000);
  
  float ii;
  float theta;
  
  Center(float i){
    theta = i*TWO_PI/n;
    
    ii = i;
    
    cx = r*cos(theta);
    cy = r*sin(theta);
  }
  
  float x(float q){
    return cx+l*(float)noise.eval(seed+motion_rad*cos(TWO_PI*(t+q)),motion_rad*sin(TWO_PI*(t+q)));
  }
  
  float y(float q){
    return cy+l*(float)noise.eval(2*seed+motion_rad*cos(TWO_PI*(t+q)),motion_rad*sin(TWO_PI*(t+q)));
  }
  
  /*float x(float q){
    return r*cos(theta)+l*cos(TWO_PI*(t+q+1.0*ii/n));
  }
  
  float y(float q){
    return r*sin(theta)+l*sin(TWO_PI*(t+q+1.0*ii/n));
  }*/
  
  void show(){
    fill(255);
    //noStroke();
    //fill(255,125);
    stroke(255);
    ellipse(x(0),y(0),4,4);
  }
}

Center[] array = new Center[n];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Center(i);
  }
}

int m = 450;

float offset_factor = 2.8;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  strokeWeight(1);
  for(int i=0;i<n;i++){
    array[i].show();
  }
  
  stroke(255,30);
  strokeWeight(2);
  for(int i=0;i<n;i++){
    for(int j=0;j<i;j++){
      //float d = 1.0*dist(array[i].x(0),array[i].y(0),array[j].x(0),array[j].y(0))/(1.0*width);
      float d = 1.0;
      
      for(int k=0;k<=m;k++){
        float tt = 1.0*k/m;
        
        float pw = tt;
        
        float xx = lerp(array[i].x(-d*offset_factor*pw),array[j].x(-d*offset_factor*(1-pw)),tt);
        float yy = lerp(array[i].y(-d*offset_factor*pw),array[j].y(-d*offset_factor*(1-pw)),tt);
        
        stroke(255,13+70*(1-sin(PI*tt)));
        
        point(xx,yy);
      }
    }
  }
  
  /*
  stroke(255);
  strokeWeight(1);
  for(int i=0;i<n;i++){
    line(array[i].x(0),array[i].y(0),0,0);
  }
  
  fill(255);
  ellipse(0,0,6,6);*/
  
  pop();
}