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
int numFrames = 210;        
float shutterAngle = .8;

boolean recording = true;

OpenSimplexNoise noise;

float margin = 100;

class Wall{
  float x1,y1,x2,y2;
  
  float nx,ny;
  
  boolean border = false;
  
  float d;
  
  Wall(){
    float dmax = 80;
    
    x1 = random(margin+dmax,width-margin-dmax);
    y1 = random(margin+dmax,height-margin-dmax);
    
    //float theta = random(TWO_PI);
    float theta = floor(random(4))*TWO_PI/4 + random(-0.1,0.1);;
    
    d = random(dmax/3,dmax);
    
    x2 = x1 + d*cos(theta);
    y2 = y1 + d*sin(theta);
    
    nx = cos(theta+HALF_PI);
    ny = sin(theta+HALF_PI);
  }
  
  Wall(float x1_,float y1_, float x2_,float y2_,boolean type){
    border = type;
    x1 = x1_;
    y1 = y1_;
    x2 = x2_;
    y2 = y2_;
    
    d = dist(x1,y1,x2,y2);
    
    PVector n = (new PVector(x2-x1,y2-y1)).rotate(HALF_PI).normalize();
    
    nx = n.x;
    ny = n.y;
  }
  
  void show(){
    stroke(255,border?255:200);
    strokeWeight(2.3);
    
    line(x1,y1,x2,y2);
  }
  
  boolean collide(float ax,float ay,float cx,float cy){
    PVector u = new PVector(ax-x1,ay-y1);
    PVector v = new PVector(cx-x1,cy-y1);
    PVector n = (new PVector(nx,ny)).normalize();
    boolean sidechange = ((u.dot(n)*v.dot(n))<0) || (false&&v.dot(n)==0);
    PVector n2 = (new PVector(x2-x1,y2-y1)).normalize();
    boolean onsegment = (u.dot(n2)>=0) && (u.dot(n2)<=d);
    
    return sidechange&&onsegment;
  }
  
  PVector updatev(float vx,float vy){
    PVector v = new PVector(vx,vy);
    PVector n = new PVector(nx,ny);
    PVector u = n.mult(v.dot(n));
    PVector w = v.sub(u);
    
    PVector v2 = w.sub(u);
    
    return v2;
  }
}

int nw = 20;

ArrayList<Wall> warray = new ArrayList<Wall>();

class Thing{
  float x0,y0,v0,theta0;
  
  ArrayList<PVector> traj = new ArrayList<PVector>();
  
  float dt = 0.2;
  
  int nsteps = 55000*4;
  
  Thing(float theta,float x,float y){
    x0 = x;
    y0 = y;
    
    theta0 = theta;
    v0 = 1.0;
    
    computeTraj();
  }
  
  Thing(){
    x0 = random(margin,width-margin);
    y0 = random(margin,height-margin);
    
    theta0 = random(TWO_PI);
    v0 = 1.0;
    
    computeTraj();
  }
  
  void computeTraj(){
    float x = x0;
    float y = y0;
    
    float vx = v0*cos(theta0);
    float vy = v0*sin(theta0);
    
    traj.add(new PVector(x,y));
    for(int i=0;i<nsteps;i++){
      float X = x + dt*vx;
      float Y = y + dt*vy;
      
      boolean coll = false;
      
      for(Wall w : warray){
        if(w.collide(x,y,X,Y)){
          coll = true;
          PVector v2 = w.updatev(vx,vy);
          vx = v2.x;
          vy = v2.y;
          break;
        }
      }
      if(!coll){
        x = X;
        y = Y;
      }
      traj.add(new PVector(x,y));
    }
  }
  
  int K = 60;
  
  void show(){
    strokeWeight(4.0);
    stroke(255);
    
    point(x0,y0);
    point(traj.get(nsteps).x,traj.get(nsteps).y);
    
    strokeWeight(1.5);
    
    /* DRAW TRAJECTORY
    
    
    for(int i=0;i<=nsteps;i+=3){
      float x = traj.get(i).x;
      float y = traj.get(i).y;
      
      stroke(255,15);
      
      point(x,y);
    }*/
    
    int N = 30;
    
    for(int j=0;j<N;j++){
      for(int i=0;i<K;i++){
        float p = map((i+t+0.06*j/N)%K,0,K,0,1);
        float pp = lerp(p,ease(p,2.0),0.5);
        float loc = nsteps*pp*0.99999;
        int ind1 = floor(loc);
        int ind2 = ind1+1;
        float interp = loc - ind1;
        
        float xx = lerp(traj.get(ind1).x,traj.get(ind2).x,interp);
        float yy = lerp(traj.get(ind1).y,traj.get(ind2).y,interp);
        
        stroke(255,150);
        strokeWeight(0.5+5.0*j/N);
        
        point(xx,yy);
      }
    }
  }
}

int n = 1;

Thing[] array = new Thing[n];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<nw;i++){
    warray.add(new Wall());
  }
  
  warray.add(new Wall(margin,margin,width-margin,margin,true));
  warray.add(new Wall(margin,margin,margin,height-margin,true));
  warray.add(new Wall(width-margin,height-margin,width-margin,margin,true));
  warray.add(new Wall(width-margin,height-margin,margin,height-margin,true));
  
  for(int i=0;i<n;i++){
    //array[i] = new Thing(0.01*i-0.5,width/4,3*height/4);
    array[i] = new Thing();
  }
}

void draw_(){
  background(0);
  push();
  
  for(Wall w : warray){
    w.show();
  }
  
  for(int i=0;i<n;i++){
    array[i].show();
  }

  pop();
}