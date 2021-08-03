// code by Etienne Jacob (www.necessary-disorder.tumblr.com)
// uses openSimplex noise

float ease(float p, float g) {
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

int n = 20;

float sp = 75;

float lerp_back = 0.015;

float t;

int numFrames = 250;
int iterations = 3;

float mr1 = 1.5;

float px(){
  return 200*(float)noise.eval(2113 + mr1*cos(TWO_PI*t),mr1*sin(TWO_PI*t));
}

float py(){
  return 200*(float)noise.eval(1133 + mr1*cos(TWO_PI*t),mr1*sin(TWO_PI*t));
}

float mr2 = 0.9;

float sz(){
  float os = ((float)noise.eval(1337 + mr2*cos(TWO_PI*t),mr2*sin(TWO_PI*t))+1)/2;
  os = 45*pow(os,5.0);
  return 2+os;
}

class Dot{
  float x,x0;
  float y,y0;
  
  Dot(int i,int j){
    x = map(i,0,n-1,sp-width/2,width/2-sp);
    y = map(j,0,n-1,sp-height/2,height/2-sp);
    
    x0 = x;
    y0 = y;
  }
  
  void update(){
    float d = dist(px(),py(),x,y);
    float delta = 5*pow(sz(),1.1);
    //float interp = exp(-d*d/(delta*delta));
    float interp = 0.3*exp(-d/delta);
    x = lerp(x,px(),interp);
    y = lerp(y,py(),interp);
    
    x = lerp(x,x0,lerp_back);
    y = lerp(y,y0,lerp_back);
  }
}

int m = 4;

void draw_connection(Dot d1, Dot d2){
  for(int i=0;i<=m;i++){
    float p = 1.0*i/m;
    float x = lerp(d1.x,d2.x,p);
    float y = lerp(d1.y,d2.y,p);
    stroke(255,75);
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
  for(int i=0;i<n;i++){
    for(int j=0;j<n;j++){
      array[i][j].update();
    }
  }
  
  /*
  for(int i=0;i<n;i++){
    for(int j=0;j<n;j++){
      stroke(255,75);
      strokeWeight(3);
      point(array[i][j].x,array[i][j].y);
    }
  }
  */
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
  
  
  stroke(255);
  strokeWeight(pow(sz(),1.1)*1.5);
  point(px(),py());
  
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