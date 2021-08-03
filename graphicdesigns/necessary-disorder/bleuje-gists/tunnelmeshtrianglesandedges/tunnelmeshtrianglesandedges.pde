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

float softplus(float q,float p){
  float qq = q+p;
  if(qq<=0){
    return 0;
  }
  if(qq>=2*p){
    return qq-p;
  }
  return 1/(4*p)*qq*qq;
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

int samplesPerFrame = 7;
int numFrames = 50;        
float shutterAngle = 0.7;

boolean recording = true;

OpenSimplexNoise noise;

class Dot{
  float r = random(400,600);
  float theta = random(TWO_PI);
  
  float x = r*cos(theta);
  float y = r*sin(theta);
  
  float offset = random(1);
  
  int rd = floor(random(100000));
  
  PVector pos(float p){
    p = (p+1*offset)%1;
    
    float z = map(p,0,1,-7000,2000);
    
    float rot = 2.0*p;
    
    float xx = x*cos(rot) - y*sin(rot);
    float yy = x*sin(rot) + y*cos(rot);
    
    return new PVector(xx+18000*pow(1-p,5.0)-150,yy,z);
  }
}

int K = 6;

class Dot2{
  Dot ref;
  int num;
  
  Dot2(Dot d,int num_){
    num = num_;
    ref = d;
  }
  
  PVector pos(float p){
    float q = map(num+p,0,K,0,1);
    return ref.pos(q);
  }
  
  float sz = random(1,5);
  
  void show(float p){
    PVector v = pos(p);
    
    push();
    translate(v.x,v.y,v.z);
    fill(10);
    noStroke();
    sphere(sz);
    pop();
  }
}

float DMAX = 350;

class Edge{
  Dot2 d1,d2;
  
  Edge(Dot2 d1_,Dot2 d2_){
    d1 = d1_;
    d2 = d2_;
  }
  
  void show(float p){
    PVector pos1 = d1.pos(p);
    PVector pos2 = d2.pos(p);
    
    float d = dist(pos1.x,pos1.y,pos1.z,pos2.x,pos2.y,pos2.z);
    
    if(d<=1.7*DMAX){
      stroke(10);
      strokeWeight(map(d,0,1.7*DMAX,1,0));
      line(pos1.x,pos1.y,pos1.z,pos2.x,pos2.y,pos2.z);
    }
  }
}

boolean closeDots(Dot2 d1,Dot2 d2){
  PVector pos1 = d1.pos(0);
  PVector pos2 = d2.pos(0);
  float dist1 = dist(pos1.x,pos1.y,pos1.z,pos2.x,pos2.y,pos2.z);
  PVector pos3 = d1.pos(1);
  PVector pos4 = d2.pos(1);
  float dist2 = dist(pos3.x,pos3.y,pos3.z,pos4.x,pos4.y,pos4.z);
  return (dist1<=2.5*DMAX)||(dist2<=2.5*DMAX);
}

color [] colorArray = {#f74415,#5d5d5d,#a0c334,#e5d429};

class Triangle{
  Dot2 d1,d2,d3;
  
  int type;
  
  Triangle(Dot2 d1_,Dot2 d2_,Dot2 d3_){
    d1 = d1_;
    d2 = d2_;
    d3 = d3_;
    
    type = (d1.ref.rd+d2.ref.rd+d3.ref.rd)%4;
  }
  
  void show(float p){
    PVector pos1 = d1.pos(p);
    PVector pos2 = d2.pos(p);
    PVector pos3 = d3.pos(p);
    float dist1 = dist(pos1.x,pos1.y,pos1.z,pos2.x,pos2.y,pos2.z);
    float dist2 = dist(pos3.x,pos3.y,pos3.z,pos2.x,pos2.y,pos2.z);
    float dist3 = dist(pos1.x,pos1.y,pos1.z,pos3.x,pos3.y,pos3.z);
    
    PVector sum = new PVector(0,0,0);
    sum.add(pos1).add(pos2).add(pos3).mult(1.0/3);
    
    if(max(max(dist1,dist3),dist2)<=DMAX){
      //stroke(15);
      stroke(255);
      strokeWeight(0.7);
      //fill(colorArray[type]);
      fill(15);
      float interp = map(max(max(dist1,dist3),dist2),0,DMAX,0,1);
      interp = pow(interp,6.5);
      
      PVector v1 = pos1.copy().lerp(sum,interp);
      PVector v2 = pos2.copy().lerp(sum,interp);
      PVector v3 = pos3.copy().lerp(sum,interp);
      
      beginShape();
      vertex(v1.x,v1.y,v1.z);
      vertex(v2.x,v2.y,v2.z);
      vertex(v3.x,v3.y,v3.z);
      endShape(CLOSE);
      
      strokeWeight(2.1*(1-interp));
      stroke(10);
      line(pos1.x,pos1.y,pos1.z,v1.x,v1.y,v1.z);
      line(pos2.x,pos2.y,pos2.z,v2.x,v2.y,v2.z);
      line(pos3.x,pos3.y,pos3.z,v3.x,v3.y,v3.z);
    }
  }
}


int n = 70;

Dot[] array = new Dot[n];

Dot2[] array2 = new Dot2[n*K];

ArrayList<Triangle> array4 = new ArrayList<Triangle>();

ArrayList<Edge> array3 = new ArrayList<Edge>();

boolean closeDotsTriangle(Dot2 d1,Dot2 d2,Dot2 d3){
    PVector pos1 = d1.pos(0);
    PVector pos2 = d2.pos(0);
    PVector pos3 = d3.pos(0);
    float dist1 = dist(pos1.x,pos1.y,pos1.z,pos2.x,pos2.y,pos2.z);
    float dist2 = dist(pos3.x,pos3.y,pos3.z,pos2.x,pos2.y,pos2.z);
    float dist3 = dist(pos1.x,pos1.y,pos1.z,pos3.x,pos3.y,pos3.z);
    
    float m1 = max(max(dist1,dist3),dist2);
    
    pos1 = d1.pos(1);
    pos2 = d2.pos(1);
    pos3 = d3.pos(1);
    dist1 = dist(pos1.x,pos1.y,pos1.z,pos2.x,pos2.y,pos2.z);
    dist2 = dist(pos3.x,pos3.y,pos3.z,pos2.x,pos2.y,pos2.z);
    dist3 = dist(pos1.x,pos1.y,pos1.z,pos3.x,pos3.y,pos3.z);
    
    float m2 = max(max(dist1,dist3),dist2);
    
    return min(m1,m2)<=1.3*DMAX;
}

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Dot();
  }
  
  for(int i=0;i<n;i++){
    for(int j=0;j<K;j++){
      array2[i*K+j] = new Dot2(array[i],j);
    }
  }
  
  for(int i=0;i<n*K;i++){
    for(int j=0;j<i;j++){
      if(closeDots(array2[i],array2[j])){
        array3.add(new Edge(array2[i],array2[j]));
      }
    }
  }
  
  for(int i=0;i<n*K;i++){
    for(int j=0;j<i;j++){
      for(int k=0;k<j;k++){
        if(closeDotsTriangle(array2[i],array2[j],array2[k])){
          array4.add(new Triangle(array2[i],array2[j],array2[k]));
        }
      }
    }
  }
}

void draw_(){
  background(240);
  push();
  translate(width/2,height/2);
  
  for(Triangle tr : array4){
    tr.show(t);
  }
  
  for(Edge e : array3){
    e.show(t);
  }
  
  for(int i=0;i<n*K;i++){
    array2[i].show(t);
  }
  
  //filter(INVERT);

  pop();
}