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

int samplesPerFrame = 3;
int numFrames = 300;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

float R = 180;

int K = 6;

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
}

int m = 2500;

float rad1 = 3.0;
float rad2 = 3.9;

float mr1 = 1.2;
float mr2 = 2.1;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  for(int k=0;k<K;k++){
    for(int i=0;i<m;i++){
      float theta = TWO_PI*i/m;
      float p = 1.0*i/m;
      
      float l = 1+30*ease(constrain(map((float)noise.eval(15+rad1*cos(theta),rad1*sin(theta),mr1*cos(TWO_PI*t),mr1*sin(TWO_PI*t))+0.25*sin(TWO_PI*(t-0.25))-0.25,-1,1,-1,2),0,1),2.0);
      
      float part = 2.0;
      
      
      float dx = l*(float)noise.eval(129+0.29*k+rad2*cos(TWO_PI*(part*p-t)),rad2*sin(TWO_PI*(part*p-t)),mr2*cos(TWO_PI*t),mr2*sin(TWO_PI*t));
      float dy = l*(float)noise.eval(923+0.29*k+rad2*cos(TWO_PI*(part*p-t)),rad2*sin(TWO_PI*(part*p-t)),mr2*cos(TWO_PI*t),mr2*sin(TWO_PI*t));
      
      float x = (R+0.25*k)*cos(theta) + dx;
      float y = (R+0.25*k)*sin(theta) + dy;
      
      float mr = 1.5;
      
      float sw = pow(map((float)noise.eval(9+k+5*cos(theta),5*sin(theta),mr*cos(TWO_PI*t),mr*sin(TWO_PI*t)),-1,1,0,1),2.0)*3+0.5;
      
      strokeWeight(sw);
      
      stroke(255,30);
      point(x,y);
    }
  }
  
  pop();
}