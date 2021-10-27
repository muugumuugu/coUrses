float ease(float p, float g) {
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

int n = 20;

float sp = 25;

float t;

int numFrames = 200;
int iterations = 3;

float mr1 = 1.1;

float DT = 0.1;

float EPS = 0.00000001;

float DAMPING = 0.95;

PVector spring_force(float ax,float ay,float bx,float by,float k){
    float xx = ax - bx;
    float yy = ay - by;
    
    float d = dist(xx,yy,0,0);
    
    float nx = xx/(d+EPS);
    float ny = yy/(d+EPS);
    
    float f = k*d;
    
    float fx = f*nx;
    float fy = f*ny;
    
    return new PVector(fx,fy);
}

float px(){
  return 200*(float)noise.eval(5111 + mr1*cos(TWO_PI*t),mr1*sin(TWO_PI*t));
}

float py(){
  return 200*(float)noise.eval(5131 + mr1*cos(TWO_PI*t),mr1*sin(TWO_PI*t));
}

float mr2 = 1.1;

float sz(){
  float os = ((float)noise.eval(5331 + mr2*cos(TWO_PI*t),mr2*sin(TWO_PI*t))+1)/2;
  os = 20*pow(os,4.0);
  return 2+os;
}

class Dot{
  float x,x0;
  float y,y0;
  
  float vx = 0;
  float vy = 0;
  
  float k = 10.0;
  
  Dot(int i,int j){
    x = map(i,0,n-1,sp-width/2,width/2-sp);
    y = map(j,0,n-1,sp-height/2,height/2-sp);
    
    x0 = x;
    y0 = y;
  }
  
  void update(){
    float d = dist(px(),py(),x,y);
    float delta = 10*sz();
    
    float intensity = 15*exp(-d*d/(delta*delta));
    //float interp = 15*exp(-d/delta);
    
    PVector res = spring_force(px(),py(),x,y,intensity);
    res.add(spring_force(x0,y0,x,y,k));

    vx += DT*res.x;
    vy += DT*res.y;
    
    vx *= DAMPING;
    vy *= DAMPING;

    x += DT*vx;
    y += DT*vy;
  }
}

int m = 10;

void draw_connection(Dot d1, Dot d2){
  for(int i=0;i<=m;i++){
    float p = 1.0*i/m;
    float x = lerp(d1.x,d2.x,p);
    float y = lerp(d1.y,d2.y,p);
    stroke(255,175);
    strokeWeight(2);
    point(x,y);
  }
}

Dot [][] array = new Dot[n][n];

OpenSimplexNoise noise;

void setup(){
  size(500,500,P3D);
  
  for(int i=0;i<n;i++){
    for(int j=0;j<n;j++){
      array[i][j] = new Dot(i,j);
    }
  }
  
  noise = new OpenSimplexNoise();
}

void draw(){
  t = (1.0*(frameCount - 1)/numFrames)%1;
  
  background(0);
  pushMatrix();
  translate(width/2,height/2);
  
  scale(0.7);
  
  for(int i=0;i<n;i++){
    for(int j=0;j<n;j++){
      array[i][j].update();
    }
  }
  
  for(int i=0;i<n-1;i++){
    for(int j=0;j<n-1;j++){
      Dot d1 = array[i][j];
      Dot d2 = array[i+1][j];
      Dot d3 = array[i][j+1];
      draw_connection(d1,d2);
      draw_connection(d1,d3);
    }
  }
  
  for(int i=0;i<n-1;i++){
      Dot d1 = array[n-1][i];
      Dot d2 = array[n-1][i+1];
      Dot d3 = array[i][n-1];
      Dot d4 = array[i+1][n-1];
      draw_connection(d1,d2);
      draw_connection(d3,d4);
  }
  
  rectMode(CENTER);
  
  stroke(255);
  fill(255,150);
  strokeWeight(1.5);
  float rad = pow(sz(),1.1)*1.5;

  rect(px(),py(),rad,rad);
  
  popMatrix();
  
  if(frameCount>(iterations-1)*numFrames){
    saveFrame("fr###.png");
    
    println(frameCount-(iterations-1)*numFrames,"/",numFrames);
    
    if(frameCount==iterations*numFrames){
      println("finished");
      stop();
    }
  }
}