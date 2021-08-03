OpenSimplexNoise noise;

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

int samplesPerFrame = 1;
int numFrames = 80;        
float shutterAngle = .8;

boolean recording = true;



void setup(){
  size(500,500);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
}

int N = 40;
float b = 50;
float l = 10;
float scl = 0.01;
float r = 0.6;

void draw_(){
  background(0);
  
  stroke(255);
  strokeWeight(2);
  for(int i=0;i<N;i++){
    for(int j=0;j<N;j++){
      float x = map(i,0,N-1,b,width-b);
      float y = map(j,0,N-1,b,height-b);
      float theta = 25*(float)noise.eval(scl*x,scl*y,r*cos(TWO_PI*t),r*sin(TWO_PI*t));
      float vx = l*cos(theta);
      float vy = l*sin(theta);
      float intensity = 0.1+1.5*ease(map((float)noise.eval(200+scl*x,scl*y,r*cos(TWO_PI*t),r*sin(TWO_PI*t)),-1,1,0,1),3.5);
      vx*=intensity;
      vy*=intensity;
      line(x,y,x+vx,y+vy);
    }
  }
  
}