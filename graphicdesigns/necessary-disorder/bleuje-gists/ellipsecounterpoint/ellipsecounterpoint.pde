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

int samplesPerFrame = 1;
int numFrames = 300;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

int m = 3500;
int n = 10;

float SEED;

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  SEED = random(10,1000);
}

float R = 180;

void draw_(){
  background(0);
  push();
  
  translate(width/2,height/2);
  
  for(int k=0;k<n;k++){
    for(int i=0;i<m;i++){
      float p = 1.0*i/m;
      
      float drad = 1.3;
      float per = 2;
      
      float rad1 = 2.0;
      float dradbis = 1.0;
      float mr1 = 1.0;
      
      //float I = 0+100*ease(constrain(map((float)noise.eval(5*SEED+rad1*cos(TWO_PI*p),rad1*sin(TWO_PI*p),mr1*cos(TWO_PI*t),mr1*sin(TWO_PI*t))+0.3*sin(TWO_PI*(t-0.25))-0.2,-1,1,-1,2),0,2)/2,2.0)*2;
      
      //float I = 70*ease(constrain(map(sin(TWO_PI*(0.003*R*sin(TWO_PI*p)+t)),-1,1,-1,3),0,4)/4,2.0);
      float I = 50*ease(constrain(map(sin(TWO_PI*(1*p-t)),-1,1,-1,3),0,4)/4,2.0);
      
      float dx = I*(float)noise.eval(SEED + 0.07*k + drad*cos(TWO_PI*(per*p+t)),drad*sin(TWO_PI*(per*p+t)),dradbis*cos(TWO_PI*p),dradbis*sin(TWO_PI*p));
      float dy = I*(float)noise.eval(2*SEED+ 0.07*k + drad*cos(TWO_PI*(per*p+t)),drad*sin(TWO_PI*(per*p+t)),dradbis*cos(TWO_PI*p),dradbis*sin(TWO_PI*p));
      
      /*
      float drad2 = 7.0;
      float per2 = -5;
      
      
      float I2 = 2.5;
      
      float ddx = I2*(float)noise.eval(3*SEED + 100*k + drad2*cos(TWO_PI*(per2*p-t)),drad2*sin(TWO_PI*(per2*p-t)),dradbis*cos(TWO_PI*p),dradbis*sin(TWO_PI*p));
      float ddy = I2*(float)noise.eval(4*SEED+ 100*k + drad2*cos(TWO_PI*(per2*p-t)),drad2*sin(TWO_PI*(per2*p-t)),dradbis*cos(TWO_PI*p),dradbis*sin(TWO_PI*p));*/
      
      float x = 0.7*(R+0.25*k)*cos(TWO_PI*p)+dx;
      float y = (R+0.25*k)*sin(TWO_PI*p)+dy;
      
      stroke(255,17);
      strokeWeight(1.5);
      
      point(x,y);
    }
  }
  
  pop();
}