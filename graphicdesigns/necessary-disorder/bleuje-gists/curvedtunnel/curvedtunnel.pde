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

int samplesPerFrame = 7;
int numFrames = 200;        
float shutterAngle = .8;

boolean recording = true;

OpenSimplexNoise noise;

float r = 200;
float R = 1000;

void drawRectangle(float theta, float alpha, float sz){
  push();
  translate(0,R-R*cos(alpha),R*sin(alpha));
  
  push();
  rotateX(-alpha);
  rotateZ(theta);
  rotateX(HALF_PI);  
  translate(0,0,r);
  
  fill(255);
  stroke(255);
  rect(0,0,sz/3,2*sz);
  
  translate(0,0,1);
  
  fill(0);
  stroke(0);
  rect(0,0,70,70);
  
  pop();
  
  pop();
}


void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  rectMode(CENTER);
}

int N = 8;
int K = 10;
int n = 30;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  for(int k=0;k<K;k++){
    float sz = map(k,0,K-1,12.0/K,12.0);
    for(int i=0;i<N;i++){
      for(int j=0;j<n;j++){
        float theta = TWO_PI*j/n;
        float alpha = map(i+1-5*lerp(ease(t,2.5),t,0.6)-1.0*j/n-1.0*k/K,0,N,PI,-PI);
        drawRectangle(theta,alpha,sz);
      }
    }
  }
  
  pop();
}