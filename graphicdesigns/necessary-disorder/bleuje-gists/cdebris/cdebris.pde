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

int samplesPerFrame = 5;
int numFrames = 90;        
float shutterAngle = .9;

boolean recording = true;

OpenSimplexNoise noise;

//color [] colorArray = {#fcf9ea,#badfdb,#f8a978,#ffc5a1};
color [] colorArray = {#f7f7f7,#5d5d5d,#a0c334,#e5d429};

class Thing{
  
  int [] permutation = new int[4];
  
  Thing(){
    for(int i=0;i<4;i++){
      permutation[i] = i;
    }
    
    for(int i=3;i>=0;i--){
      int j = floor(random(i+1));
      int aux = permutation[i];
      permutation[i] = permutation[j];
      permutation[j] = aux;
    }
  }
  
  int m = 25;
  
  void draw_thing(float r,float rw, float h,float theta,float thetaw){
    
    noStroke();
    
    fill(colorArray[permutation[0]]);
    beginShape(TRIANGLE_STRIP);
    for(int i=0;i<=m;i++){
      float th = theta + map(i,0,m,-thetaw/2,thetaw/2);
      
      float x = (r-rw/2)*cos(th);
      float y = (r-rw/2)*sin(th);
      
      vertex(x,y,h/2);
      vertex(x,y,-h/2);
    }
    endShape();
    
    fill(colorArray[permutation[0]]);
    beginShape(TRIANGLE_STRIP);
    for(int i=0;i<=m;i++){
      float th = theta + map(i,0,m,-thetaw/2,thetaw/2);
      
      float x = (r+rw/2)*cos(th);
      float y = (r+rw/2)*sin(th);
      
      vertex(x,y,h/2);
      vertex(x,y,-h/2);
    }
    endShape();
    
    fill(colorArray[permutation[1]]);
    beginShape(TRIANGLE_STRIP);
    for(int i=0;i<=m;i++){
      float th = theta + map(i,0,m,-thetaw/2,thetaw/2);
      
      float x1 = (r-rw/2)*cos(th);
      float y1 = (r-rw/2)*sin(th);
      float x2 = (r+rw/2)*cos(th);
      float y2 = (r+rw/2)*sin(th);
      
      vertex(x1,y1,h/2);
      vertex(x2,y2,h/2);
    }
    endShape();
    
    fill(colorArray[permutation[1]]);
    beginShape(TRIANGLE_STRIP);
    for(int i=0;i<=m;i++){
      float th = theta + map(i,0,m,-thetaw/2,thetaw/2);
      
      float x1 = (r-rw/2)*cos(th);
      float y1 = (r-rw/2)*sin(th);
      float x2 = (r+rw/2)*cos(th);
      float y2 = (r+rw/2)*sin(th);
      
      vertex(x1,y1,-h/2);
      vertex(x2,y2,-h/2);
    }
    endShape();
    
    fill(colorArray[permutation[2]]);
    beginShape(TRIANGLE_STRIP);
    float th = theta-thetaw/2;
    
    float x = (r-rw/2)*cos(th);
    float y = (r-rw/2)*sin(th);
    
    vertex(x,y,h/2);
    vertex(x,y,-h/2);
    
    x = (r+rw/2)*cos(th);
    y = (r+rw/2)*sin(th);
    
    vertex(x,y,h/2);
    vertex(x,y,-h/2);
    endShape();
    
    fill(colorArray[permutation[2]]);
    beginShape(TRIANGLE_STRIP);
    th = theta+thetaw/2;
    
    x = (r-rw/2)*cos(th);
    y = (r-rw/2)*sin(th);
    
    vertex(x,y,h/2);
    vertex(x,y,-h/2);
    
    x = (r+rw/2)*cos(th);
    y = (r+rw/2)*sin(th);
    
    vertex(x,y,h/2);
    vertex(x,y,-h/2);
    endShape();
  }
  /*
  float L = 200;
  float x = random(-L,L);
  float y = random(-L,L);*/
  
  float R = random(70,300);
  float theta = random(TWO_PI);
  float x = R*cos(theta);
  float y = R*sin(theta);
  
  float offset = random(1);
  
  int K = 9;
  
  void show(){
    for(int i=0;i<K;i++){
      float p = map((t+offset)%1+i,0,K,0,1);
      show(p);
    }
  }
  
  void show(float p){
    float z = map(p,0,1,-4900,500);
    float X = 1.3*p*R*cos(theta);
    float Y = 1.3*p*R*sin(theta);
  
    push();
    translate(X,Y,z);
    
    float rx = rotx(p);
    float ry = roty(p);
    float rz = rotz(p);
    
    float rp = rad(p);
    
    float theta = theta(p);
    
    rotateX(rx);
    rotateY(ry);
    rotateZ(rz);
    
    draw_thing(rp,rp/2,h(p),theta,1.0*p*radw(p));
    
    pop();
  }
  
  float seed = random(10,1000);
  
  float r0x = random(TWO_PI)-PI;
  float r0y = random(TWO_PI)-PI;
  float r0z = random(TWO_PI)-PI;
  
  float rotx(float p){
   return r0x+3*(float)noise.eval(seed + 3.0*p,0); 
  }
  
  float roty(float p){
   return r0y+3*(float)noise.eval(2*seed + 3.0*p,0); 
  }
  
  float rotz(float p){
   return r0z+3*(float)noise.eval(3*seed + 3.0*p,0);  
  }
  
  float theta(float p){
   return 5*(float)noise.eval(4*seed + 5.0*p,0); 
  }
  
  float rad(float p){
   return map((float)noise.eval(5*seed + 2.0*p,0),-1,1,10,50); 
  }
  /*
  float rad(float p){
   return pow(map((float)noise.eval(5*seed + 2.0*p,0),-1,1,0,1),1.7)*70; 
  }
  */
  float radw(float p){
   return map((float)noise.eval(6*seed + 10.0*p,0),-1,1,0,TWO_PI); 
  }
  
  float h(float p){
   return pow(map((float)noise.eval(6*seed + 4.0*p,0),-1,1,0,1),2.5)*50; 
  }
}

int n = 100;

Thing[] array = new Thing[n];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Thing();
  }
}

void draw_(){
  background(255);
  push();
  translate(width/2,height/2);
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
  pop();
}