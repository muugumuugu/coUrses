// Processing code by Etienne JACOB
// motion blur template by beesandbombs
// opensimplexnoise code in another tab might be necessary
// --> code here : https://gist.github.com/Bleuje/fce86ef35b66c4a2b6a469b27163591e

// gif inspired by : https://beesandbombs.tumblr.com/post/109914868554/twisting-box


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
float shutterAngle = 0.8;

boolean recording = true;

OpenSimplexNoise noise;

float R = 100;

float EASE = 7.5;

int N = 5;

int m = 100;

class Dot{
  float x,y,z;
  
  float sw = 2.0;
  
  float offset = 0;
  
  Dot(float x_,float y_,float z_,boolean b){
    x = x_;
    y = y_;
    z = z_;
    
    sw = (b?4:2);
    
    float scale1 = 0.0045;
    float scale2 = 0.05;
    
    offset = 0.12*((float)noise.eval(123 + scale1*x,scale1*y,scale1*z)) + 0.02*((float)noise.eval(1234 + scale2*x,scale2*y,scale2*z));
  }
  
  void show(){
    push();
    
    float tt = t+offset;
    
    float t1 = ease(constrain(3*tt,0,1),EASE);
    float t2 = ease(constrain(3*tt-1,0,1),EASE);
    float t3 = ease(constrain(3*tt-2,0,1),EASE);
    
    rotateX(HALF_PI*t1);
    rotateY(HALF_PI*t2);
    rotateX(HALF_PI*t3);
    
    stroke(255,255);
    strokeWeight(sw);
    point(x,y,z);
    pop();
  }
}

ArrayList<Dot> array = new ArrayList<Dot>();

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int side=-1;side<=1;side+=2){
    float x = side*R;
    for(int j=0;j<N;j++){
      float y = map(j,0,N-1,-R,R);
      for(int i=0;i<m;i++){
        float z = map(i,0,m-1,-R,R);
        array.add(new Dot(x,y,z,j==0 || j==N-1));
      }
    }
    for(int j=0;j<N;j++){
      float z = map(j,0,N-1,-R,R);
      for(int i=0;i<m;i++){
        float y = map(i,0,m-1,-R,R);
        array.add(new Dot(x,y,z,j==0 || j==N-1));
      }
    }
  }
  
  for(int side=-1;side<=1;side+=2){
    float y = side*R;
    for(int j=0;j<N;j++){
      float x = map(j,0,N-1,-R,R);
      for(int i=0;i<m;i++){
        float z = map(i,0,m-1,-R,R);
        array.add(new Dot(x,y,z,j==0 || j==N-1));
      }
    }
    for(int j=0;j<N;j++){
      float z = map(j,0,N-1,-R,R);
      for(int i=0;i<m;i++){
        float x = map(i,0,m-1,-R,R);
        array.add(new Dot(x,y,z,j==0 || j==N-1));
      }
    }
  }
  
  for(int side=-1;side<=1;side+=2){
    float z = side*R;
    for(int j=0;j<N;j++){
      float x = map(j,0,N-1,-R,R);
      for(int i=0;i<m;i++){
        float y = map(i,0,m-1,-R,R);
        array.add(new Dot(x,y,z,j==0 || j==N-1));
      }
    }
    for(int j=0;j<N;j++){
      float y = map(j,0,N-1,-R,R);
      for(int i=0;i<m;i++){
        float x = map(i,0,m-1,-R,R);
        array.add(new Dot(x,y,z,j==0 || j==N-1));
      }
    }
  }
  
  ortho();
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);

  rotateX(-ia);
  rotateY(0.25*PI);
  rotateZ(0*PI);
  
  for(Dot d : array){
    d.show();
  }
  
  pop();
}