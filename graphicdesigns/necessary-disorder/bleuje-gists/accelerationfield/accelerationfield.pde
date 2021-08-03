// Field example
PVector field(float x,float y){
  float ns = 20*noise(0.01*x,0.01*y);
  return new PVector(1.0*cos(ns),1.0*sin(ns));
}

/*
// Flow field
float dt = 0.1;

class Particle{
  float x = random(width);
  float y = random(height);
  
  void update(){
    PVector f = field(x,y);
    x += dt*f.x;
    y += dt*f.y;
  }
  
  void show(){
    point(x,y);
  }
}*/

// Acceleration field
float dt = 0.1;
float coeff = 0.99; // to avoid particles going too fast

class Particle{
  float x = random(width);
  float y = random(height);
  
  float vx = 0;
  float vy = 0;
  
  void update(){
    PVector f = field(x,y);
    vx += dt*f.x;
    vy += dt*f.y;
    
    vx *= coeff; // to avoid particles going too fast
    vy *= coeff; // to avoid particles going too fast
    
    x += dt*vx;
    y += dt*vy;
  }
  
  void show(){
    point(x,y);
  }
}

int N = 10000;

Particle[] array = new Particle[N];

void setup(){
  size(500,500);
  for(int i=0;i<N;i++){
    array[i] = new Particle();
  }
  background(0);
}

void draw(){
  stroke(255,25);
  for(int i=0;i<N;i++){
    array[i].show();
  }
  for(int i=0;i<N;i++){
    array[i].update();
  }
}