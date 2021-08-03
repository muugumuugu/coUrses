class MagneticField {
  ArrayList<Moment> mmts = new ArrayList<Moment>(); // magnetic moments in the field

  void addmmt(float mx,float my,float posx,float posy) {
    mmts.add(new Moment(posx, posy, mx,my));
  }

  PVector getValue(float x,float y) {
    PVector v = new PVector(0,0);
    for (Moment mm : mmts) {
      PVector r = new PVector(x,y).sub(mm.pos).mult(0.01);
      float rmag = r.mag();
      PVector v1 = PVector.mult(r, 3 * mm.m.dot(r) / pow(rmag,5));
      PVector v2 = PVector.mult(mm.m, -pow(rmag,-3));
      v.add(v1); v.add(v2);
    }
    return v;
  }
}

class Moment{
  PVector pos; // position in the field
  PVector m; // its moment vector

  Moment(float posx, float posy, float mx, float my) {
    this.pos = new PVector(posx, posy);
    this.m = new PVector(mx, my);
  }
}

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
int numFrames = 15;        
float shutterAngle = .8;

boolean recording = true;


float DT = 0.1;

class Path{
  /*
  float rad = height/2*sqrt(random(1));
  float theta = random(TWO_PI);
  float x = width/2 + rad*cos(theta);
  float y = height/2 + rad*sin(theta);*/
  float x = random(width);
  float y = random(height);
  
  ArrayList<PVector> positions = new ArrayList<PVector>();
  
  float red = random(100,230);
  float green = random(200,255);
  float blue = random(230,255);
  
  float sz = random(1,1);
  
  int npart = 5;
  
  float t_off = random(1);
  
  Path(){
    positions.add(new PVector(x,y));
  }
  
  void update(){
    PVector res = field(x,y);
    x += DT*res.x;
    y += DT*res.y;
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

int N = 100;

int NPart = 20000;

Path[] array2 = new Path[NPart];

PVector field(float x,float y){
  float amount = 10;
  return myfield.getValue(x,y).mult(amount);
}

void path_step(){
  for(int i=0;i<NPart;i++){
    array2[i].update();
  }
}

int nsteps = 30;

MagneticField myfield;

void setup(){
  size(500,800,P3D);
  result = new int[width*height][3];
  background(0);
  
  MagneticField myfield = new MagneticField();
  
  for(int i=0;i<N;i++){
    float bb = 2.1;
    float x = random(bb*border,width-bb*border);
    float y = random(bb*border,height-bb*border);
    float mx = random(10);
    float my = random(10);
    myfield.addmmt(x,y,mx,my);
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
  /*
  for(int i=0;i<NPart;i++){
    array2[i].show();
  }*/
  for(int i=0;i<NPart;i++){
    array2[i].show2();
  }
  

  noFill();
  stroke(255);
  strokeWeight(1);
  rect(border,border,width-2*border,height-2*border);
}