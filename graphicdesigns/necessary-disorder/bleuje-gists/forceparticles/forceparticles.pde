class Center{
  /*
  float rad = height/3*sqrt(random(1));
  float theta = random(TWO_PI);
  float x = width/2 + rad*cos(theta);
  float y = height/2 + rad*sin(theta);*/
  float x = random(width);
  float y = random(height);
  
  float rot = random(-10,0);
  float repulse = random(-2,2);
  
  void show(){
    stroke(255,0,0);
    strokeWeight(3);
    point(x,y);
  }
}

float DT = 0.1;
float slowdown = 0.9;

class Particle{
  float x = random(width/2-150,width/2+150);
  float y = random(height/2-150,height/2+150);
  float vx = 0;
  float vy = 0;
  
  float red = random(100,230);
  float green = random(200,255);
  float blue = random(230,255);
  
  float sz = random(1,1);
  
  void update(){
    PVector res = field(x,y);
    vx += DT*res.x;
    vy += DT*res.y;
    vx *= slowdown;
    vy *= slowdown;
    x += DT*vx;
    y += DT*vy;
  }
  
  void show(){
    stroke(red,green,blue,100);
    stroke(255,25);
    //stroke(0,100);
    strokeWeight(sz);
    point(x,y);
  }
}

int N = 60;

int NPart = 25000;

Center[] array = new Center[N];

Particle[] array2 = new Particle[NPart];

PVector field(float x,float y){
  
  float amount = 20;
  
  float sumx = 0;
  float sumy = 0;
  for(int i = 0;i<N;i++){
    float distance = dist(x,y,array[i].x,array[i].y);
    float intensity = constrain(map(distance,0,width,1,0),0,1);
    intensity = pow(intensity,20);
    float nx = (x - array[i].x)/distance;
    float ny = (y - array[i].y)/distance;
    
    sumx += (array[i].rot*ny + array[i].repulse*nx)*intensity*amount;
    sumy += (-array[i].rot*nx + array[i].repulse*ny)*intensity*amount;
  }
  return new PVector(sumx,sumy);
}


void setup(){
  size(1500,1000);
  background(0);
  
  for(int i=0;i<N;i++){
    array[i] = new Center();
  }
  for(int i=0;i<NPart;i++){
    array2[i] = new Particle();
  }
}

void draw(){
  for(int i=0;i<NPart;i++){
    array2[i].update();
  }
  for(int i=0;i<NPart;i++){
    array2[i].show();
  }
  
  println(frameCount);
  if(frameCount==150){
    saveFrame("k###.png");
    stop();
    println("finished");
  }
  
}