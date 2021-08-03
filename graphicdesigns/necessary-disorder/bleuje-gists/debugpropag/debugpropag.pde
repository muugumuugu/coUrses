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
int numFrames = 100;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

float R = 200;

float x0(float ph){
  float seed = 125;
  float mr = 0.5;
  return width/2 + 5*(float)noise.eval(seed + mr*cos(TWO_PI*(t+ph)),mr*sin(TWO_PI*(t+ph)));
}
float y0(float ph){
  float seed = 521;
  float mr = 0.5;
  return 0.9*height + 5*(float)noise.eval(seed + mr*cos(TWO_PI*(t+ph)),mr*sin(TWO_PI*(t+ph)));
}

int m = 500;

float l = 25;

float df2 = 0.2;

float periodic_function(float p){
  return pow(((1-p)+10000)%1,1.2)+max(0,-9+10*(p%1));
}

class Thing{
  float theta;
  
  float cx;
  float cy;
  
  float seed = 10+random(1000);
  
  float thetal = random(TWO_PI);
  
  float df = 2.5;
  
  float mr = 0.5;
  
  Thing(float theta_){
    theta = theta_;
    
    cx = width/2 + R*cos(theta);
    cy = 0.8*height + 1.7*R*sin(theta); 
  }
  
  float x(float ph){
    return cx + 20*(float)noise.eval(seed + mr*cos(TWO_PI*(t+ph)),mr*sin(TWO_PI*(t+ph)));
  }
  
  float y(float ph){
    return cy + 20*(float)noise.eval(2*seed + mr*cos(TWO_PI*(t+ph)),mr*sin(TWO_PI*(t+ph)));
  }
  
  float curvex(float p){
    return lerp(x(-df*p),x0(-df2*(1-p)),p);
  }
  float curvey(float p){
    return lerp(y(-df*p),y0(-df2*(1-p)),p);
  }
  
  void show1(){
    stroke(255);
    fill(255);
    ellipse(x(0),y(0),8,8);
  }
  
  void show(){
    for(int i=0;i<=m;i++){
      float p = 1.0*i/m;
      
      strokeWeight(2);
      stroke(255,100);
      point(curvex(p),curvey(p));
      
      if(i%4==0){
        float intensity2 = pow(min(5*p,1),0.75);
        float ll = intensity2*map(p,0,1,l,0.1*l);
        
        float intensity = pow(map(periodic_function(t+4*(1-pow(1-p,2.0))),0,1,0,1),2.5);
        
        float thetal2 = thetal + intensity*(float)noise.eval(10*seed + 2*i + 1.5*cos(TWO_PI*t),1.5*sin(TWO_PI*t));
        
        strokeWeight(1+2*intensity);
        stroke(255,100+155*intensity);
        line(curvex(p),curvey(p),curvex(p)+ll*cos(thetal2),curvey(p)+ll*sin(thetal2));
      }
    }
  }
}

int n = 10;

Thing[] array = new Thing[n];

void setup(){
  size(500,500,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    float th = map(i,0,n-1,0,-PI);
    
    array[i] = new Thing(th);
  }
}

void draw_(){
  background(0);
  /*
  for(int i=0;i<n;i++){
    array[i].show1();
  }*/
  
  stroke(255,200);
  strokeWeight(1);
  //line(x0(0),y0(0),width/2,1.1*height);
  float m2 = 100;
  for(int i=0;i<=m2;i++){
      float p = 1.0*i/m2;
      
      float intensity = pow(map(periodic_function(t+p),0,1,0,1),2.5);
      
      strokeWeight(2+5*intensity);
      stroke(255,100);
      point(lerp(x0(0),width/2,p),lerp(y0(0),1.1*height,p));
    }
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
}