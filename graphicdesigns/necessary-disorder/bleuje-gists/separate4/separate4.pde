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
int numFrames = 300;        
float shutterAngle = .8;

boolean recording = true;

OpenSimplexNoise noise;

int n = 20;

float border = 100;

float div = 75;

class Star{
  float theta = random(TWO_PI);
  float rad = random(1);
  int next_id = floor(random(n));
  float off = random(0.3);
  float sz = random(3);
  float ni = random(1000);
  float ddx = random(-div,div);
  float ddy = random(-div,div);
}

float mr = 1.0;

class Center{
  float x = random(border,width-border);
  float y = random(border,height-border);
  
  float r = random(10,80);
  
  float delay = random(0.2);
  
  float seed = random(10,1000);
  
  ArrayList<Star> stars = new ArrayList<Star>();
  
  int m = 10 + floor(random(55));
  
  Center(int k){
    for(int i=0;i<m;i++){
      stars.add(new Star());
    }
    x = 200*cos(TWO_PI*k/n);
    y = 200*sin(TWO_PI*k/n);
  }
  
  float x(){
    return x + 10*(float)noise.eval(seed+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
  }
  
  float y(){
    return y + 10*(float)noise.eval(2*seed+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
  }
  
  void show(){
    float tt = constrain(t-delay,0,1);
    for(Star s : stars){
      float rr = r*s.rad;
      float dx = rr*cos(s.theta)+10*(float)noise.eval(seed+s.ni+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
      float dy = rr*sin(s.theta)+10*(float)noise.eval(2*seed+2*s.ni+mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
      float p = ease(constrain(4*tt,0,1),2.0);
      if(p<0.999){
        float xx = lerp(x(),x()+dx,p);
        float yy = lerp(y(),y()+dy,p);
        strokeWeight(s.sz);
        stroke(255,255);
        point(xx,yy);
      } else {
        float p2 = ease(constrain(map(t,0.25+delay,1-s.off-0.05,0,1),0,1),2.0);
        float xx = lerp(x()+dx,array[s.next_id].x(),p2);
        float yy = lerp(y()+dy,array[s.next_id].y(),p2);
        xx = lerp(xx,xx+s.ddx*(float)noise.eval(seed+3*s.ni+2*mr*cos(TWO_PI*t),2*mr*sin(TWO_PI*t)),sin(PI*p2));
        yy = lerp(yy,yy+s.ddy*(float)noise.eval(2*seed+4*s.ni+2*mr*cos(TWO_PI*t),2*mr*sin(TWO_PI*t)),sin(PI*p2));
        strokeWeight(s.sz);
        stroke(255,255);
        point(xx,yy);
      }
    }
  }
}

Center[] array = new Center[n];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Center(i);
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