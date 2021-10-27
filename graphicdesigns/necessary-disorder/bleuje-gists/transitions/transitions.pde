// Processing code by Etienne JACOB
// motion blur template by beesandbombs
// opensimplexnoise code in another tab might be necessary
// --> code here : https://gist.github.com/Bleuje/fce86ef35b66c4a2b6a469b27163591e


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

    saveFrame("fr###.gif");
    println(frameCount,"/",numFrames);
    if (frameCount==numFrames)
      exit();
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 5;
int numFrames = 250;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

float L=45;

float margin = 120;

class Transition{
  float startx,starty,endx,endy;
  float startsz,endsz;
  float easing;
  int type;
  
  Transition(float startx_, float starty_, float startsz_,int i){
    startx = startx_;
    starty = starty_;
    startsz = startsz_;
    
    float theta = map(floor(random(4)),0,4,0,TWO_PI);
    float l = L*floor(random(1,6))*(2*floor(random(2))-1);
    
    endx = startx + l*cos(theta);
    endy = starty + l*sin(theta);
    
    if(endx<margin){
      endx -= 2*(endx-startx);
    }
    if(endy<margin){
      endy -= 2*(endy-starty);
    }
    if(endx>width-margin){
      endx -= 2*(endx-startx);
    }
    if(endy>height-margin){
      endy -= 2*(endy-starty);
    }
    
    endsz = 2+floor(random(7));
    
    easing = random(2,4);
    
    if(i==0){
      startsz = 0;
    }
    if(i==n-1){
      endsz = 0;
    }
  }
  
  PVector pos(float p){
    p = ease(p,easing);
    return new PVector(lerp(startx,endx,p),lerp(starty,endy,p));
  }
  
  void show(float p){
    p = ease(p,easing);
    float x = lerp(startx,endx,p);
    float y = lerp(starty,endy,p);
    float sz = lerp(startsz,endsz,p);
    
    stroke(255,100);
    //strokeWeight(sz);
    strokeWeight(1);
    fill(255);
    
    ellipse(x,y,sz,sz);
  }
}

int n = 60;

int K = 23;

Transition[] array = new Transition[n];

void createTransitions(float x,float y){
  float sz = 0;
  for(int i=0;i<n;i++){
    Transition tr = new Transition(x,y,sz,i);
    array[i] = tr;
    x = tr.endx;
    y = tr.endy;
    sz = tr.endsz;
  }
}

PVector pos(int i){
  float ind0 = 0.99999*(i+t)*n/K;
  int ind = floor(ind0);
  float p = ind0-ind;
  return array[ind].pos(p);
}

void showStructure(){
  for(int i=0;i<K;i++){
    float ind0 = 0.99999*(i+t)*n/K;
    int ind = floor(ind0);
    float p = ind0-ind;
    array[ind].show(p);
  }
}

float area(PVector v1,PVector v2,PVector v3){
  return 0.5*abs((v1.x - v3.x)*(v2.y - v1.y) - (v1.x - v2.x)*(v3.y - v1.y));
}

int m = 400;

float C = 7.5;

void drawLine(PVector v1, PVector v2,float s,float limit){
  float q = constrain(map(s,0,C*L,1.5,0),0,1);
  float sz = 2*ease(q,2.0);
  
  strokeWeight(sz*min(1,limit));
  stroke(255,155*q*min(1,limit));
  /*
  for(int i=0;i<=m;i++){
    float p = 1.0*i/m;
    float xx = lerp(v1.x,v2.x,p);
    float yy = lerp(v1.y,v2.y,p);
    
    stroke(255,50);
    
    point(xx,yy);
  }*/
  line(v1.x,v1.y,v2.x,v2.y);
}

void drawTriangle(PVector v1, PVector v2, PVector v3, float s, float limit){
  float q = constrain(map(s,0,C*L,1.5,0),0,1);
  float sz = 2*ease(q,2.0);
  
  strokeWeight(1*sz*min(1,limit));
  //fill(255,155*q);
  //noStroke();
  fill(0,155*q*min(1,limit));
  stroke(255,155*q*min(1,limit));
  
  PVector mean = v1.copy();
  mean.add(v2).add(v3);
  mean.mult(1.0/3);
  
  for(int i=0;i<1;i++){
    float lp = 0.45+i*0.2;
    
    PVector v1bis = PVector.lerp(v1,mean,lp);
    PVector v2bis = PVector.lerp(v2,mean,lp);
    PVector v3bis = PVector.lerp(v3,mean,lp);
    
    beginShape();
    vertex(v1bis.x,v1bis.y);
    vertex(v2bis.x,v2bis.y);
    vertex(v3bis.x,v3bis.y);
    endShape(CLOSE);
  }
  
}

void setup(){
  size(600,600,P2D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  createTransitions(width/2,height/2);
}

void draw_(){
  background(0);
  push();
  
  
  
  for(int i=0;i<K;i++){
    for(int j=0;j<i;j++){
      for(int k=0;k<j;k++){
        PVector v1 = pos(i);
        PVector v2 = pos(j);
        PVector v3 = pos(k);
        
        float a = 0*area(v1,v2,v3);
        float perimeter = dist(v1.x,v1.y,v2.x,v2.y) + dist(v3.x,v3.y,v2.x,v2.y) + dist(v1.x,v1.y,v3.x,v3.y);
        
        float limit = min(K-(i+t),min(i+t,min(j+t,k+t)));
        
        if(a+perimeter<C*L){ 
          /*
          drawLine(v1,v2,a+perimeter,limit);
          drawLine(v2,v3,a+perimeter,limit);
          drawLine(v3,v1,a+perimeter,limit);*/
          drawTriangle(v1,v2,v3,a+perimeter,limit);
        }
      }
    }
  }
  
  showStructure();

  pop();
}