int[][] result;
float t, c;

float ease(float p) {
  return 3*p*p - 2*p*p*p;
}

float ease(float p, float g) {
  if (p < 0.5f) 
    return 0.5f * pow(2*p, g);
  else
    return 1 - 0.5f * pow(2*(1 - p), g);
}

float mn = .5f*sqrt(3), ia = atan(sqrt(.5f));

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
    t = mouseX*1.0f/width;
    c = mouseY*1.0f/height;
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
        PApplet.parseInt(result[i][0]*1.0f/samplesPerFrame) << 16 | 
        PApplet.parseInt(result[i][1]*1.0f/samplesPerFrame) << 8 | 
        PApplet.parseInt(result[i][2]*1.0f/samplesPerFrame);
    updatePixels();

    saveFrame("fr###.png");
    println(frameCount,"/",numFrames);
    if (frameCount==numFrames)
      exit();
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 5;
int numFrames = 200;        
float shutterAngle = .6f;

boolean recording = true;

//OpenSimplexNoise noise;

int n = 6;

class Spring{
  float x;
  float y;
  
  float k = 1.0f;
  float l0 = 75;
  
  Spring(float x_,float y_){
    x = x_;
    y = y_;
  }
  
  void show(){
    stroke(255);
    strokeWeight(5);
    point(x,y);
    noFill();
    strokeWeight(1);
    stroke(255,150);
    ellipse(x,y,22,22);
  }
}

Spring[] springarray = new Spring[n];

PVector total_force(float x,float y){
  float sumx = 0;
  float sumy = 0;
  for(int i=0;i<n;i++){
    float xx = springarray[i].x - x;
    float yy = springarray[i].y - y;
    
    float d = dist(xx,yy,0,0);
    
    float nx = xx/d;
    float ny = yy/d;
    
    float f = springarray[i].k*(d - springarray[i].l0);
    
    float fx = f*nx;
    float fy = f*ny;
    
    sumx += fx;
    sumy += fy;
  }
  return new PVector(sumx,sumy);
}

int n2 = 1;

// Time step
float DT = 0.2f;
// Number of steps
int nsteps = 500;

float part = 0.8;

class Thing{
  float x = random(-0.3f*width,0.3f*width);
  float y = random(-0.3f*height,0);
  
  float x0 = x;
  float y0 = y;
  
  float vx = 4*random(-10,10);
  float vy = 2*random(-10,10);
  
  float mass = 100.0f;
  
  ArrayList<PVector> positions = new ArrayList<PVector>();
  
  Thing(float x0_,float y0_,float vx0_,float vy0_){
    x = x0_;
    y = y0_;
    vx = vx0_;
    vy = vy0_;
    
    x0 = x;
    y0 = y;
    
    positions.add(new PVector(x,y));
  }
  
  Thing(){
    positions.add(new PVector(x,y));
  }
  
  void update(){
    PVector res = total_force(x,y);
    res.add(new PVector(0,mass*5));
    float coeff = 7.0f;
    res.add(new PVector(-coeff*vx,-coeff*vy));
    vx += DT*res.x/mass;
    vy += DT*res.y/mass;
    x += DT*vx;
    y += DT*vy;
    positions.add(new PVector(x,y));
  }
  
  void compute_path(){
    for(int i=0;i<nsteps;i++){
      update();
    }
  }
  
  void show(){
    
    int len = positions.size();
    
    // Particle location calculated by linear interpolation from the computed positions
    float loc = 0.9999f*len*t;
    int i1 = floor(loc);
    int i2 = i1+1;
    float interp = loc - floor(loc);
    float xx = lerp(positions.get(i1).x,positions.get(i2).x,interp);
    float yy = lerp(positions.get(i1).y,positions.get(i2).y,interp);
    
    // This is to make particles appear and disappear gradually
    float alpha = 255;
    
    float interp2 = max(0,map(t,0.8,1,0,1));
    
    interp2 = ease(interp2,2.0);
    
    xx = lerp(xx,x0,interp2);
    yy = lerp(yy,y0,interp2);
    
    stroke(255*pow(interp2,0.5),200);
    strokeWeight(2+2*pow(interp2,0.5));
    line(xx,yy,x0,y0);
    
    stroke(255,alpha);
    strokeWeight(1);
    fill(255,255);
    ellipse(xx,yy,10,10);
    line(xx,yy,xx,yy+40);
    rectMode(CENTER);
    rect(xx,yy+40,15,15);
    
    draw_connections(xx,yy);
  }
}

Thing[] thingarray = new Thing[n2];

float triangular(float q){
  q = (q+10000)%1;
  if(q<0.25f){
    return 4*q;
  } else if(q<0.75f){
    return 2-4*q;
  } else {
    return 4*q-4;
  }
}

void draw_connections(float x,float y){
  for(int i=0;i<n;i++){
    stroke(255);
    strokeWeight(1);
    /*line(springarray[i].x,springarray[i].y,x,y);
    */
    float xx = springarray[i].x - x;
    float yy = springarray[i].y - y;
    
    float d = dist(xx,yy,0,0);
    
    float nx = xx/d;
    float ny = yy/d;
    
    stroke(255,150);
    strokeWeight(1);
    noFill();
    
    int m = 250;
    beginShape();
    for(int j=0;j<m;j++){
      float p = 1.0f*j/m;
      
      float xxx = lerp(springarray[i].x,x,p);
      float yyy = lerp(springarray[i].y,y,p);
      
      int k = 7;
      
      float l = 15;
      
      //xxx += 25*ny*sin(TWO_PI*p*k);
      //yyy += -25*nx*sin(TWO_PI*p*k);
      xxx += l*ny*triangular(p*k);
      yyy += -l*nx*triangular(p*k);
      
      vertex(xxx,yyy);
      
    }
    endShape();
  }
}

Thing tg;

void setup(){
  size(500,500,P3D);
  
  result = new int[width*height][3];
  
  //noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    float theta = TWO_PI*i/n;
    float r = 0.3f*width;
    float x = r*cos(theta);
    float y = r*sin(theta);
    
    springarray[i] = new Spring(x,y);
  }
  
  tg = new Thing();
  
  tg.compute_path();
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  for(int i=0;i<n;i++){
    springarray[i].show();
  }
  
  tg.show();
  
  pop();
}