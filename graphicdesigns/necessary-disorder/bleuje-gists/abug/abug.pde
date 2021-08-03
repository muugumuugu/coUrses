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
int numFrames = 40;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

int n = 25;

int m = 3500;

void draw_curve(float q){
  
  q = pow(q,4.0);
  
  int m2 = 1 + floor(q*m);
  
  stroke(255,75);
  strokeWeight(2);
  
  float r = width*q;

  for(int i=0;i<m2;i++){
    float p = 1.0*i/m2;
    
    float x = r*cos(TWO_PI*p);
    float y = r*sin(TWO_PI*p);
    
    float rad = 7.0*sin(PI*q);
    
    float dx = 50*(float)noise.eval(rad*cos(TWO_PI*p),rad*sin(TWO_PI*p),0.5*q);
    float dy = 50*(float)noise.eval(10+q*rad*cos(TWO_PI*p),rad*sin(TWO_PI*p),0.5*q);
    
    float sw = (1+5*q)*map((float)noise.eval(20+2*rad*cos(TWO_PI*p),2*rad*sin(TWO_PI*p),1.0*q),-1,1,0.25,3.0);
    strokeWeight(sw);
    
    point(x+dx,y+dy);
  }
}

void setup(){
  size(540,540,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
}

void draw_(){
  push();
  background(0);
  translate(width/2,0.6*height);
  
  for(int i=0;i<n;i++){
    float q = 1.0*(i+t)/n;
    draw_curve(q);
  }
  
  pop();

}