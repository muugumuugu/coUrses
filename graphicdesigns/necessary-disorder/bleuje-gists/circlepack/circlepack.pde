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
    if (frameCount==numFrames)
      exit();
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 7;
int numFrames = 50;        
float shutterAngle = .8;

boolean recording = true;

float growth_rate = 1;


class Circle{
  float x;
  float y;
  float r;
  
  boolean growing = true;
  
  float theta_off = random(TWO_PI);
  int rot = 2*floor(random(2))-1;
  
  Circle(float x_,float y_){
    x = x_;
    y = y_;
    r = 0;
  }
  
  void grow(){
    if(growing){
      r += growth_rate;
    }
  }
  
  void show(){
    noStroke();
    fill(255);/*
    stroke(255);
    noFill();*/
    arc(x, y, 2*r-1, 2*r-1, 0 + TWO_PI*t*rot + theta_off, PI + TWO_PI*t*rot + theta_off, CHORD);
  }
}

int nmax = 2000;

Circle[] array = new Circle[nmax];

int ncircle = 0;

void add_circle(){
  if(ncircle<nmax){
    boolean ok = false;
    float resx = 0;
    float resy = 0;
    while(!ok){
      boolean stop = false;
      
      float rad = width/3*sqrt(random(1));
      float theta = random(TWO_PI);
      float x = rad*cos(theta)+width/2;
      float y = rad*sin(theta)+height/2;
      for(int i=0;i<ncircle&&!stop;i++){
        float d = dist(x,y,array[i].x,array[i].y);
        if(d<=array[i].r){
          stop = true;
        }
      }
      if(!stop){
        resx = x;
        resy = y;
        ok = true;
      }
    }
    array[ncircle] = new Circle(resx,resy);
    ncircle++;
  }
}

void setup(){
  size(500,500,P3D);
  result = new int[width*height][3];
  while(ncircle<nmax){
     circle_pack_step();
  }
}

int nadd = 1;
int cnt = 0;

void circle_pack_step(){
  for(int i = 0;i<nadd;i++){
    add_circle();
  }
  
  for(int i=0;i<ncircle;i++){
    if(array[i].growing){
      boolean stop = false;
      for(int j=0;j<ncircle&&!stop;j++){
        if(i!=j){
          float d = dist(array[j].x,array[j].y,array[i].x,array[i].y);
          if(d<=array[i].r+array[j].r){
            stop = true;
          }
        }
      }
      if(stop){
        array[i].growing = false;
      }
    }
  }
  
  for(int i=0;i<ncircle;i++){
    array[i].grow();
  }
  
  cnt++;
  println(cnt);
}

void draw_(){
  background(0);
  //circle_pack_step();
  for(int i=0;i<ncircle;i++){
    array[i].show();
  }
}