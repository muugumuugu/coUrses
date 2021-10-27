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

int samplesPerFrame = 1;
int numFrames = 50;        
float shutterAngle = 1.6;

boolean recording = true;

OpenSimplexNoise noise;

float R = 100;

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
}

int m = 3000;

int N = 20;

int n = 8*N;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  for(int i=0;i<n;i++){
    float theta01 = TWO_PI*(i+3*N*t)/n;
    float theta02 = TWO_PI*(i+1+3*N*t)/n;
    
    noStroke();
    
    beginShape(TRIANGLE_STRIP);
    for(int j=0;j<m;j++){
      float theta1 = theta01 + 4*TWO_PI*j/m;
      float theta2 = theta02 + 4*TWO_PI*j/m;
      
      float Z = map(j,m,0,-1000,500);
      
      float rad = 0.6;
      
      float offset = 0.003*Z;
      
      //float dr = 35*(float)noise.eval(123+0.001*Z+rad*cos(TWO_PI*(-t+offset)),rad*sin(TWO_PI*(-t+offset)),0.1*cos(TWO_PI*i/m),0.1*sin(TWO_PI*i/m));
      float dr = 35*(float)noise.eval(123+0.001*Z+rad*cos(TWO_PI*(-t+offset)),rad*sin(TWO_PI*(-t+offset)));
      
      float r = map(j,0,m,3*R,0)+dr;
      
      float col = i%N<3?255:0;
      
      col *= constrain(map(Z,-500,-1000,1,0),0,1);

      
      fill(col);
      
      vertex(r*cos(theta1),r*sin(theta1),Z);
      vertex(r*cos(theta2),r*sin(theta2),Z);
    }
    endShape();
  }
  
  pop();
}