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
int numFrames = 150;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

int n = 10;

int m = 100;

class Thing{
  int N = 5;
  
  float es = random(3.2,3.5);
  
  float theta;
  
  float seed = random(10,1000);
  
  Thing(int i){
    theta = map(i,0,n-1,-PI-0.4,0.4);
  }
  
  void show(float tt){
    float mr = 0.4;
    
    for(int k=0;k<N;k++){
      for(int i=0;i<m;i++){
        float ttt = tt+0.1*i/m;
        float sz = 1+1*sin(PI*i/m);
        
        stroke(255,200);
        strokeWeight(sz + 1.5*noise(k));
        
        if(ttt%1<0.5){
          float p = ease(2*(ttt%1),es);
          
          float xx = lerp(0,0.4*width*cos(theta),p);
          float dx = 50*(float)noise.eval(seed+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t),0.25*k*sin(PI*i/m),5*p);
          xx = lerp(xx,xx+dx,sin(PI*p));
          
          float yy = lerp(0.4*height,0.4*width*sin(theta),p);
          float dy = 50*(float)noise.eval(2*seed+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t),0.25*k*sin(PI*i/m),5*p);
          yy = lerp(yy,yy+dy,sin(PI*p));
          
          point(xx,yy);
        } else {
          float p = ease(2*((ttt-0.5)%1),es);
          
          float th;
          
          if(theta<-HALF_PI){
            th = lerp(theta,-PI-HALF_PI,p);
          } else {
            th = lerp(theta,HALF_PI,p);
          }
          
          float xx = 0.4*width*cos(th);
          float yy = 0.4*width*sin(th);
          
          point(xx,yy);
        }
          
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
    array[i].show(t/2);
    array[i].show(t/2+0.5);
  }
  
  pop();
}