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
int numFrames = 300;        
float shutterAngle = .6;

boolean recording = false;

OpenSimplexNoise noise;

int n = 50;
int m = 25;

class Thing{
  
  float theta;
  
  float sz = random(0.1,2.5);
  
  float toff;
  
  Thing(float theta_){
    theta = theta_;
    
    toff = 0.0;
  }
  
  void show(){
    stroke(255);
    
    float tt_ = (t+toff)%1;
    float tt = 35*lerp(ease(tt_,5.0),tt_,0.5)%1;
    
    for(int i=0;i<m;i++){
      float p = pow(1.0*(i+tt)/m,2.5);
      float r = 0.75*p*width;
      
      float theta2 = theta + (1-p)*1.0*(float)noise.eval(1.2*cos(theta),1.2*sin(theta),5.5*p,2.5*map(sin(TWO_PI*t),-1,1,0,1));
      
      float x = r*cos(theta2);
      float y = r*sin(theta2);
      
      float sz2 = map((float)noise.eval(0.1*x,0.1*y,0.5*cos(TWO_PI*t),0.5*sin(TWO_PI*t)),-1,1,0.5,1.5);
      
      strokeWeight(1+sz2*sz*3*p);
      
      point(x,y);
    }
  }
}

Thing[] array = new Thing[n];


void setup(){
  size(540,540,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    float theta = TWO_PI*i/n;
    array[i] = new Thing(theta);
  }
  

}

void draw_(){
  push();
  background(0);
  
  translate(width/2,height/2);
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
  pop();
}
