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

int samplesPerFrame = 5;
int numFrames = 10;        
float shutterAngle = .8;

boolean recording = true;

class Center{
  /*
  float rad = height/3*sqrt(random(1));
  float theta = random(TWO_PI);
  float x = width/2 + rad*cos(theta);
  float y = height/2 + rad*sin(theta);*/
  float bb = 2.1;
  float x = random(bb*border,width-bb*border);
  float y = random(bb*border,height-bb*border);
  
  float rot = random(0,0);
  float repulse = random(2,2);
  
  void show(){
    stroke(255,0,0);
    strokeWeight(3);
    point(x,y);
  }
}

float DT = 0.2;

float slowdown = 0.95;

class Path{
  /*
  float rad = height/2*sqrt(random(1));
  float theta = random(TWO_PI);
  float x = width/2 + rad*cos(theta);
  float y = height/2 + rad*sin(theta);*/
  float x = random(width);
  float y = random(0);
  
  float vx = random(0,0);
  float vy = random(3,5);
  
  ArrayList<PVector> positions = new ArrayList<PVector>();
  
  float red = random(100,230);
  float green = random(200,255);
  float blue = random(230,255);
  
  float sz = random(1,3);
  
  int npart = 20;
  
  float t_off = random(1);
  
  Path(){
    positions.add(new PVector(x,y));
  }
  
  void update(){
    PVector res = field(x,y);
    vx += DT*res.x;
    vy += DT*res.y;
    vx *= slowdown;
    vy *= slowdown;
    x += DT*vx;
    y += DT*vy;
    positions.add(new PVector(x,y));
  }
  
  void show(){
    stroke(red,green,blue,100);
    //stroke(255,100);
    stroke(255,100);
    strokeWeight(sz);
    noFill();
    beginShape();
    for(int i = 0;i<positions.size();i++){
      vertex(positions.get(i).x,positions.get(i).y);
    }
    endShape();
  }
  void show2(){
    
    strokeWeight(sz);
    float tt = (t+t_off)%1;
    int len = positions.size();
    for(int i=0;i<npart;i++){
      float loc = constrain(map(i+tt,0,npart,0,len-1-0.01),0,len-1-0.001);;
      int i1 = floor(loc);
      int i2 = i1+1;
      float interp = loc - floor(loc);
      float xx = lerp(positions.get(i1).x,positions.get(i2).x,interp);
      float yy = lerp(positions.get(i1).y,positions.get(i2).y,interp);
      
      float fact = 1;
      if(xx<border||xx>width-border||yy<border||yy>height-border) fact = 0;
      
      float alpha = fact*255*pow(sin(PI*loc/(len-1)),0.25);
      
      stroke(255,alpha);
      
      point(xx,yy);
    }
  }
}

int border = 50;

int N = 60;

int NPart = 5000;

Center[] array = new Center[N];

Path[] array2 = new Path[NPart];

PVector field(float x,float y){
  
  float amount = 15;
  
  float sumx = 0;
  float sumy = 0;
  for(int i = 0;i<N;i++){
    float distance = dist(x,y,array[i].x,array[i].y);
    float intensity = constrain(map(distance,0,width,1,0),0,1);
    intensity = pow(intensity,35);
    float nx = (x - array[i].x)/distance;
    float ny = (y - array[i].y)/distance;
    
    sumx += (array[i].rot*ny + array[i].repulse*nx)*intensity*amount;
    sumy += (-array[i].rot*nx + array[i].repulse*ny)*intensity*amount;
  }
  return new PVector(sumx,sumy+15);
}

void path_step(){
  for(int i=0;i<NPart;i++){
    array2[i].update();
  }
}

int nsteps = 100;


void setup(){
  size(500,800,P3D);
  result = new int[width*height][3];
  background(0);
  
  for(int i=0;i<N;i++){
    array[i] = new Center();
  }
  for(int i=0;i<NPart;i++){
    array2[i] = new Path();
  }
  
  for(int i=0;i<nsteps;i++){
    println(i+1);
    path_step();
  }
}



void draw_(){
  background(0);
  
  for(int i=0;i<NPart;i++){
    array2[i].show2();
  }
  
  noFill();
  stroke(255);
  strokeWeight(1);
  rect(border,border,width-2*border,height-2*border);
}