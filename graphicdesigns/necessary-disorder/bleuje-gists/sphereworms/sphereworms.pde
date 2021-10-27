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
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

int n = 6000;

class Star{
  float sz = random(0.75,2);
  
  float r = 0.26*width*pow(random(1),0.08);
  float theta = random(TWO_PI);
  
  float x = r*cos(theta);
  float y = r*sin(theta);
  
  //float x = random(-width/2,width/2);
  //float y = random(-height/2,height/2);
  
  //float l = map(pow(sin(PI*map(constrain(dist(x,y,0,0),0.1*width,0.5*width),0.1*width,0.5*width,0.0001,0.9999)),2.0),0,1,11,22);
  //float l = 5+12*pow(sin(PI*map(y,-height/2,height/2,0.00001,0.99999)),1.5);
  float l = map(r,0,0.26*width,35,10);
  
  
  //float seed = 4*noise(123+0.008*x,123+0.008*y);
  //float offset = 3*noise(1234+0.008*x,1234+0.008*y);
  
  float offset = random(1);
  float seed = random(10,1000);
  
  void show(){
    for(int k=0;k<25;k++){
      float p = (t+0.005*k+offset)%1;
      
      //float alpha = 255*pow(sin(PI*p),1.0);
      float alpha = 30;
      
      //float ff = 0.5+5*pow(map(r,0,0.3*width,1,0),2.5);
      float ff = 1;
      
      float dx = 0.7*ff*l*(float)noise.eval(seed+0.02*l*cos(TWO_PI*p),0.02*l*sin(TWO_PI*p));
      float dy = 0.7*ff*l*(float)noise.eval(2*seed+0.02*l*cos(TWO_PI*p),0.02*l*sin(TWO_PI*p));
      
      float mr = 2.0;
      
      float f = 0.6+(0.5+(float)noise.eval(3*seed+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t))/2);
      
      strokeWeight(f*sz);
      stroke(255,alpha);
      
      point(x+dx,y+dy);
    }
  }
}

Star[] array = new Star[n];


void setup(){
  size(540,540,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Star();
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
  
  pop();
}