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
int numFrames = 100;        
float shutterAngle = .2;

boolean recording = true;

OpenSimplexNoise noise;

int n = 8;

float border = 60;

class Thing{
  float x;
  float y;
  
  int m1;
  int m2 = 3;
  float g;
  
  float r = 0.4*width/n;
  
  Thing(int i, int j){
    x = map(i, 0, n-1, border, width-border);
    y = map(j, n-1, 0, border, height-border);
    
    m1 = 1 + 1*i;
    g = pow(1.2,j);
  }
  
  void show(){
    //blendMode(EXCLUSION);
    //fill(255);
    //stroke(255);
    noStroke();
    push();
    translate(x, y);
    rotate(-HALF_PI/3);
    for(int k=0;k<m1;k++){
      push();
      rotate((k+1)*TWO_PI/m2*ease(t, g));
      float rr = map(k, m1-1+0.001, 0, r/m1, r);
      fill(255*((k+1)%2));
      beginShape();
      for(int l=0;l<m2;l++){
        float theta = TWO_PI*l/m2;
        vertex(rr*cos(theta), rr*sin(theta));
      }
      endShape();
      pop();
    }
    pop();
  }
}

Thing[] array = new Thing[n*n];

void setup(){
  size(500,500);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  int k = 0;
  
  for(int i=0;i<n;i++){
    for(int j=0;j<n;j++){
      array[k] = new Thing(i, j);
      k++;
    }
  }
  
}

void draw_(){
  background(0);
  for(int k=0;k<n*n;k++){
    array[k].show();
  }
}