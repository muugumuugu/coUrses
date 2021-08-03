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
int numFrames = 80;        
float shutterAngle = .8;

boolean recording = true;

OpenSimplexNoise noise;

void setup(){
  size(500,500);
  result = new int[width*height][3];
  
  noiseDetail(1);
  
  noise = new OpenSimplexNoise();
}

int N = 75;
int n = 100;
float l = 250;
float scl = 0.01;
float r = 0.5;

void draw_(){
  background(0);
  
  noStroke();
  stroke(255);
  strokeWeight(2);
  
  for(int i=0;i<N;i++){
    float y = map(i,0,N-1,0,height);
    
    fill(255*(i%2));
    fill(0);
    
    beginShape();
    vertex(-1,height+10);
    for(int j=0;j<n;j++){
      float x = map(j,0,n-1,-1,width);
      
      float intensity = ease(constrain(map(dist(x,y,width/2,height/2),0,0.5*width,1,0),0,1),2.0);
      
      float yy = y + intensity*l*(float)noise.eval(100*y+scl*x,10+r*cos(TWO_PI*t + 0.05*i),10+r*sin(TWO_PI*t + 0.05*i));
      
      vertex(x,yy);
    }
    vertex(width,height+10);
    endShape();
  }
  
}