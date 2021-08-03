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

float softplus(float q,float p){
  float qq = q+p;
  if(qq<=0){
    return 0;
  }
  if(qq>=2*p){
    return qq-p;
  }
  return 1/(4*p)*qq*qq;
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
int numFrames = 40;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;


void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
}

int n = 200;
int m = 180;

float R = 220;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  for(int i=0;i<n;i++){
    for(int j=0;j<m;j++){
      float theta = TWO_PI*i/n;
      
      float r = map(j,0,m,0,1)*R;
      
      float rad = 1.7;
      float rad2 = 4.0;

      float offset = 5*theta/TWO_PI + 1*0.02*j;

      float dr = 0.8*25*(float)noise.eval(123+rad*cos(TWO_PI*(t-offset)),rad*sin(TWO_PI*(t-offset)),rad2*cos(theta)*j/m,rad2*sin(theta)*j/m)*ease(sin(0.98*PI*j/m),2.1)*j/m;
      float dtheta = 0.4*0.5*(float)noise.eval(123+rad*cos(TWO_PI*(t-offset)),rad*sin(TWO_PI*(t-offset)),rad2*cos(theta)*j/m,rad2*sin(theta)*j/m)*ease(sin(0.98*PI*j/m),2.1)*j/m;
      
      float x = (r+dr)*cos(theta+dtheta)+0.15*randomGaussian();
      float y = (r+dr)*sin(theta+dtheta)+0.15*randomGaussian();
      
      stroke(255,50 + 60*(i%2)+70*(1-1.0*j/m));
      strokeWeight(1.7 + 3*(i%2)*int(j==m-1));
      point(x,y);
      
    }
  }

  pop();
}