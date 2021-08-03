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
int numFrames = 50;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;


void setup(){
  size(600,800,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
}

int n = 85;

int m = 1500;

int border = 100;

float mr = 0.7;

void draw_(){
  background(0);
  
  stroke(255,120);
  strokeWeight(1.5);
  
  for(int i=0;i<n;i++){
    float x = map(i,0,n-1,border,width-border);
    for(int j=0;j<=m;j++){
      float p = 1.0*j/m;
      float y = map(p,0,1,border,height-border);
      
      float offset = map(i,0,n-1,0,1)+0.2*(float)noise.eval(0.1*x,mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
      //float pp = constrain(2*p-offset,0.01,0.99);
      float pp = constrain(2*p-offset,0,1);
      
      float intensity1 = pow(sin(PI*pp),1.5);
      
      float intensity2 = pow(ease(map(sin(TWO_PI*5*i/(n-1)-HALF_PI),-1,1,0,1),2.0),2.0);
      
      float part = 1.5;
      
      float rad = 1.2;
      
      float dx = 70*intensity1*intensity2*(float)noise.eval(0+0.05*x,rad*cos(TWO_PI*(part*p+t)),rad*sin(TWO_PI*(part*p+t)));
      float dy = 70*intensity1*intensity2*(float)noise.eval(100+0.05*x,rad*cos(TWO_PI*(part*p+t)),rad*sin(TWO_PI*(part*p+t)));
      
      point(x+dx,y+dy);
    }
  }

}