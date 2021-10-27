class Center{
  /*
  float rad = height/3*sqrt(random(1));
  float theta = random(TWO_PI);
  float x = width/2 + rad*cos(theta);
  float y = height/2 + rad*sin(theta);*/
  float x = random(width);
  float y = random(height);
  
  float rot = random(-10,0);
  float repulse = random(-7,2);
  
  void show(){
    stroke(255,0,0);
    strokeWeight(3);
    point(x,y);
  }
}

float DT = 0.02;

class Particle{
  /*
  float rad = height/2*sqrt(random(1));
  float theta = random(TWO_PI);
  float x = width/2 + rad*cos(theta);
  float y = height/2 + rad*sin(theta);*/
    float x = random(width);
  float y = random(height);
  
  float red = random(0,255);
  float green = random(150,255);
  float blue = random(220,255);
  
  float sz = random(1,1);
  
  void update(){
    PVector res = field(x,y);
    x += DT*res.x;
    y += DT*res.y;
  }
  
  void show(){
    //stroke(red,green,blue,100);
    stroke(255,50);
    strokeWeight(sz);
    point(x,y);
  }
}

int N = 50;

int NPart = 15000;

Center[] array = new Center[N];

Particle[] array2 = new Particle[NPart];

PVector field(float x,float y){
  
  float amount = 7;
  
  float sumx = 0;
  float sumy = 0;
  for(int i = 0;i<N;i++){
    float distance = dist(x,y,array[i].x,array[i].y);
    float intensity = constrain(map(distance,0,width,1,0),0,1);
    intensity = pow(intensity,10);
    float nx = (x - array[i].x)/distance;
    float ny = (y - array[i].y)/distance;
    
    sumx += (array[i].rot*ny + array[i].repulse*nx)*intensity*amount;
    sumy += (-array[i].rot*nx + array[i].repulse*ny)*intensity*amount;
  }
  return new PVector(sumx,sumy);
}


void setup(){
  size(1200,800);
  background(0);
  
  for(int i=0;i<N;i++){
    array[i] = new Center();
  }
  for(int i=0;i<NPart;i++){
    array2[i] = new Particle();
  }
}

void draw(){
  //background(0);
  /*
  for(int i=0;i<N;i++){
    array[i].show();
  }*/
  
  for(int i=0;i<NPart;i++){
    array2[i].update();
  }
  for(int i=0;i<NPart;i++){
    array2[i].show();
  }/*
  for(int i=0;i<NPart;i++){
    if(random(20)>19) array2[i] = new Particle();
  }*/
  
  /*
  
 int ni = 35;
  
  for(int i=0;i<ni;i++){
    for(int j=0;j<ni;j++){
      float x = map(i,0,ni-1,0,width);
      float y = map(j,0,ni-1,0,height);
      PVector res = field(x,y);
      
      stroke(255);
      strokeWeight(1);
      line(x,y,x+res.x,y+res.y);
    }
  }*/
  
  /*if(frameCount%10==0){
    saveFrame("fr###.png");
  }*/
  if(frameCount==100){
    saveFrame("f###.png");
    stop();
    println("finished");
  }
  
}