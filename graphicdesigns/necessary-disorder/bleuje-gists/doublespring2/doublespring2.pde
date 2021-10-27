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
int numFrames = 400;        
float shutterAngle = .6f;

boolean recording = true;

//OpenSimplexNoise noise;

PVector spring_force(float ax,float ay,float bx,float by,float k,float l0){
    float xx = ax - bx;
    float yy = ay - by;
    
    float d = dist(xx,yy,0,0);
    
    float nx = xx/d;
    float ny = yy/d;
    
    float f = k*(d - l0);
    
    float fx = f*nx;
    float fy = f*ny;
    
    return new PVector(fx,fy);
}

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

void draw_connection(float x,float y,float x_,float y_){
  for(int i=0;i<n;i++){
    stroke(255);
    strokeWeight(1);
    /*line(springarray[i].x,springarray[i].y,x,y);
    */
    float xx = x_ - x;
    float yy = y_ - y;
    
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
      
      float xxx = lerp(x_,x,p);
      float yyy = lerp(y_,y,p);
      
      int k = 5;
      
      float l = 10;
      
      //xxx += 25*ny*sin(TWO_PI*p*k);
      //yyy += -25*nx*sin(TWO_PI*p*k);
      xxx += l*ny*triangular(p*k);
      yyy += -l*nx*triangular(p*k);
      
      vertex(xxx,yyy);
      
    }
    endShape();
  }
}

// Time step
float DT = 0.01f;
// Number of steps
int nsteps = 30000;

class Thing{
  
  float theta1_start = -random(0,PI);
  float theta2_start = -random(0,PI);
  
  float theta1 = theta1_start;
  float theta2 = theta2_start;
  
  float r1 = 100;
  float r2 = 100;
  
  
  float x1 = r1*cos(theta1);
  float y1 = r1*sin(theta1);
  float vx1 = 0.0;
  float vy1 = 0.0;
  
  float x2 = x1 + r2*cos(theta2);
  float y2 = y1 + r2*sin(theta2);
  float vx2 = 0.0;
  float vy2 = 0.0;
  
  float x1_i = x1;
  float y1_i = y1;
  float x2_i = x2;
  float y2_i = y2;
  
  float k1 = 1.0;
  float k2 = 1.0;
  
  float l0_1 = 50.0;
  float l0_2 = 50.0;
  
  float mass1 = 10.0;
  float mass2 = 10.0;
  
  float g = 1.0;
  
  
  ArrayList<PVector> positions1 = new ArrayList<PVector>();
  ArrayList<PVector> positions2 = new ArrayList<PVector>();
  
  Thing(){
    positions1.add(new PVector(x1,y1));
    positions2.add(new PVector(x2,y2));
  }
  
  void update(){
    PVector res1 = new PVector(0,0);
    res1.add(spring_force(0,0,x1,y1,k1,l0_1));
    res1.add(spring_force(x2,y2,x1,y1,k2,l0_2));
    res1.add(new PVector(0,mass1*g));
    PVector res2 = new PVector(0,0);
    res2.add(spring_force(x1,y1,x2,y2,k2,l0_2));
    res2.add(new PVector(0,mass2*g));
    
    //float coeff = 7.0f;
    //res1.add(new PVector(-coeff*vx1,-coeff*vy1));
    
    vx1 += DT*res1.x/mass1;
    vy1 += DT*res1.y/mass1;
    x1 += DT*vx1;
    y1 += DT*vy1;
    positions1.add(new PVector(x1,y1));
    
    vx2 += DT*res2.x/mass2;
    vy2 += DT*res2.y/mass2;
    x2 += DT*vx2;
    y2 += DT*vy2;
    positions2.add(new PVector(x2,y2));
  }
  
  void compute_path(){
    for(int i=0;i<nsteps;i++){
      update();
    }
  }
  
  void show(float tt){
    
    int len = positions1.size();
    
    // Particle location calculated by linear interpolation from the computed positions
    float loc = 0.9999f*len*tt;
    int i1 = floor(loc);
    int i2 = i1+1;
    float interp = loc - floor(loc);
    
    float xx1 = lerp(positions1.get(i1).x,positions1.get(i2).x,interp);
    float yy1 = lerp(positions1.get(i1).y,positions1.get(i2).y,interp);
    
    float xx2 = lerp(positions2.get(i1).x,positions2.get(i2).x,interp);
    float yy2 = lerp(positions2.get(i1).y,positions2.get(i2).y,interp);
    

    float alpha = 255;
    
    float interp2 = max(0,map(tt,0.9,1,0,1));
    
    interp2 = ease(interp2,2.0);
    
    xx1 = lerp(xx1,x1_i,interp2);
    yy1 = lerp(yy1,y1_i,interp2);
    
    xx2 = lerp(xx2,x2_i,interp2);
    yy2 = lerp(yy2,y2_i,interp2);
    
    int ii = 0;
    
    stroke(255,0,0,255*(1-interp2));
    strokeWeight(1);
    noFill();
    
    beginShape();
    vertex(x1_i,y1_i);
    while(ii<loc){
      vertex(positions1.get(ii).x,positions1.get(ii).y);
      ii++;
    }
    endShape();
    
    ii = 0;
    
    stroke(0,255,0,255*(1-interp2));
    strokeWeight(1);
    noFill();
    
    beginShape();
    vertex(x2_i,y2_i);
    while(ii<loc){
      vertex(positions2.get(ii).x,positions2.get(ii).y);
      ii++;
    }
    endShape();
    
    stroke(255);
    strokeWeight(2);
    fill(0);
    ellipse(0,0,20,20);
    
    stroke(255,200*pow(interp2,0.5));
    strokeWeight(2+2*pow(interp2,0.5));
    line(xx1,yy1,x1_i,y1_i);
    
    stroke(255,200*pow(interp2,0.5));
    strokeWeight(2+2*pow(interp2,0.5));
    line(xx2,yy2,x2_i,y2_i);
    
    stroke(255,200*pow(interp2,0.5));
    fill(0,255*pow(interp2,0.5));
    strokeWeight(1.5);
    ellipse(x1_i,y1_i,7,7);
    
    stroke(255,200*pow(interp2,0.5));
    fill(0,255*pow(interp2,0.5));
    strokeWeight(1.5);
    ellipse(x2_i,y2_i,7,7);
    
    stroke(255,alpha);
    strokeWeight(1);
    fill(255,255);
    ellipse(xx1,yy1,10,10);
    ellipse(xx2,yy2,10,10);
    draw_connection(0,0,xx1,yy1);
    draw_connection(xx1,yy1,xx2,yy2);
  }
}

Thing tg;

void setup(){
  size(500,500,P3D);
  
  result = new int[width*height][3];
  
  //noise = new OpenSimplexNoise();
  
  tg = new Thing();
  
  tg.compute_path();
  
  strokeCap(ROUND);
}

int n = 5;

void draw_(){
  background(0);
  push();
  translate(width/2,0.5*height);
  
  tg.show(t);
  
  pop();
}