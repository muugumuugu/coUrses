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
int numFrames = 60;        
float shutterAngle = .6;

boolean recording = true;

//OpenSimplexNoise noise;


void setup(){
  size(500,500,P3D);
  result = new int[width*height][3];
  
  //noise = new OpenSimplexNoise();
  
  for(int k=0;k<NMAX;k++){
    iteration();
    println(n);
  }
  
}

float size = 0.4;

int n = 0;

int NMAX = 1000;

class Circle{
  boolean growing = true;
  
  float x;
  float y;
  
  float r;
  
  float growth = 0.5;
  
  int id;
  
  int type = floor(random(2));
  
  int nVert = floor(random(4,8));
  
  int nVert2 = max(3,min(nVert,floor(random(3,nVert+1))));
  
  float sign = 2*floor(random(2)) - 1;
  
  int skip = floor(random(2,4));
  
  float sw = random(1,3);
  
  float offset = random(1);
  
  int nSin = floor(random(2,10));
  
  int nPoints = floor(random(25,75));
  
  float thetaSin = random(TWO_PI);
  
  Circle(int i){
    id = i;
    boolean ok = false;
    while(!ok){
      float rPos = size*width*sqrt(random(1));
      float thetaPos = random(TWO_PI);
      
      float xx = rPos*cos(thetaPos);
      float yy = rPos*sin(thetaPos);
      
      if(!inside(xx,yy,id)){
        x = xx;
        y = yy;
        ok = true;
        r = 0;
      }
    }
  }
  
  void grow(){
    if(growing) r += growth;
  }
  
  void show(){
    noFill();
    stroke(255);
    ellipse(x,y,2*r,2*r);
  }
  
  void show2(){
    //float t = (1.0*frameCount/numFrames)%1;
    
    float tt = (t+offset)%1;
    
    strokeWeight(sw);
    /*
    if(type == 2){
      float rr = map(sin(TWO_PI*tt),-1,1,1,r);
      
      //fill(255);
      noFill();
      ellipse(x,y,2*rr,2*rr);
    }*/
    
    if(type == 1 || type == 0){
      //fill(255);
      noFill();
      stroke(255,200);
      

      push();
      translate(x,y);
      rotate(thetaSin);
      for(int k=0;k<=nPoints;k++){
        float xx = map(k,0,nPoints,-r,r);
        float ttt = xx/r;
        float yy = r*sqrt(1-ttt*ttt)*sin(TWO_PI*(ttt*nSin+tt*(1+skip/3)));
        point(xx,yy);
      }

      pop();
      
    }
    /*
    if(type == 3 || type == 4){
      //fill(255);
      noFill();
      stroke(255);
      
      //beginShape();
      for(int k=0;k<nVert;k++){
        float xx = x + r*cos(sign*TWO_PI*((k+skip*tt)/nVert));
        float yy = y + r*sin(sign*TWO_PI*((k+skip*tt)/nVert));
        //vertex(xx,yy);
        
        strokeWeight(sw);
        line(xx,yy,x,y);
        
        //strokeWeight(2);
        //point(xx,yy);
      }
      //endShape(CLOSE);
    }
    if(type == 3){
      //fill(255);
      noFill();
      stroke(255);
      
      beginShape();
      for(int k=0;k<nVert2;k++){
        float xx = x + r*cos(sign*TWO_PI*(1.0*k/nVert+tt));
        float yy = y + r*sin(sign*TWO_PI*(1.0*k/nVert+tt));
        vertex(xx,yy);
        
        line(xx,yy,x,y);
      }
      endShape(CLOSE);
    }*/
  }
}

Circle[] array = new Circle[NMAX];

boolean inside(float x,float y,int id){
  for(int i=0;i<n;i++){
    if(i!=id && dist(x,y,array[i].x,array[i].y)<=array[i].r+1){
      return true;
    }
  }
  return false;
}

void stopGrowth(){
  for(int i=0;i<n;i++){
    for(int j=0;j<i;j++){
      if(dist(array[j].x,array[j].y,array[i].x,array[i].y)<=array[i].r+array[j].r+1){
        array[i].growing = false;
        array[j].growing = false;
      }
    }
  }
}


void addCircle(){
  if(n<NMAX){
    n++;
    array[n-1] = new Circle(n-1);
  }
}

void iteration(){
  
  addCircle();
  
  
  for(int i=0;i<n;i++){
    array[i].grow();
  }
  
  stopGrowth();
}

void draw_(){
  push();
  background(0);
  
  translate(width/2,height/2);
  
  for(int i=0;i<n;i++){
    array[i].show2();
  }
  pop();
}