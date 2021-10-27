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
int numFrames = 60;        
float shutterAngle = 0.7;

boolean recording = true;

OpenSimplexNoise noise;


void setup(){
  size(540,540,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
}

int m = 80;
int k = 30;
int kk = 30;
int turns = 5;

void draw_(){
  background(0);
  push();
  
  translate(width/2,height/2);
  
  rotate(HALF_PI);
  
  stroke(255,75);
  //fill(255);
  noFill();
  
  for(int i=0;i<m;i++){
    float p = 1.0*(i+1-t)/m;
    float q = ease(min(min(15*p,1.0),2*(1-p)),1.5);
    
    float theta = turns*TWO_PI*pow(p,0.5);
    float r = 1.0*width/2*pow(p,0.5);
    float x = r*cos(theta);
    float y = r*sin(theta);
    
    float sw = map((float)noise.eval(100*p,0),-1,1,0.75,2.75);
    
    strokeWeight(sw);
    
    push();
    translate(x,y);
    
    rotate(-10*TWO_PI*p);
    
    for(int ii=1;ii<=kk;ii++){
      beginShape();
      for(int j=0;j<k;j++){
        float th = TWO_PI*j/k;
        
        float rad = 1.2;
        
        float rr = q*20*ii/kk*map((float)noise.eval(rad*cos(th),rad*sin(th),250*p,0.3*ii),-1,1,0.5,1.5);
        float xx = rr*cos(th);
        float yy = rr*sin(th);
        
        vertex(xx,yy);
      }
      endShape(CLOSE);
    }
    
    pop();
  }
  
  pop();
}