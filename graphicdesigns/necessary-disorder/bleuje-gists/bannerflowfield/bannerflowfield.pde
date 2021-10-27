//Processing code by @etiennejcb

//time step
float DT = 0.007;

int NParticle = 10000;

class Particle{
  // start position
  float x = random(width);
  float y = random(height);
  
  float sw = random(0,2.7);
  
  void update(){
    PVector res = field(x,y);
    x += DT*res.x;
    y += DT*res.y;
  }
  
  void show(){
    strokeWeight(sw);
    stroke(255,50);
    point(x,y);
  }
}

Particle[] array2 = new Particle[NParticle];

int border = 50;

class Center{
  float bb = -1.0;
  float x = random(bb*border,width-bb*border);
  float y = random(bb*border,height-bb*border);
  
  /// how the centers makes particles rotate around it
  //float rot = random(-10,10);
  float rot = (random(1)>0.5?-10:10);
  /// how the centers attracts or repulses particles
  float repulse = random(-7,3);
  
  void show(){
    stroke(255,0,0);
    strokeWeight(3);
    point(x,y);
  }
}

// Number of centers
int NCenter = 1000;

Center[] array = new Center[NCenter];

PVector field(float x,float y){
  
  float amount = 7;
  
  float sumx = 0;
  float sumy = 0;
  for(int i = 0;i<NCenter;i++){
    float distance = dist(x,y,array[i].x,array[i].y);
    
    float intensity = constrain(map(distance,0,width,1,0),0,1);
    intensity = pow(intensity,20);// this is to make the effect of the center vanish with the distance from it
    // with 15 instead of 25 for example, the effect will go further
    
    // defining the normalized vector from the center to the (x,y) location
    float nx = (x - array[i].x)/distance;
    float ny = (y - array[i].y)/distance;
    
    sumx += (array[i].rot*ny + array[i].repulse*nx)*intensity*amount;
    sumy += (-array[i].rot*nx + array[i].repulse*ny)*intensity*amount;
  }
  return new PVector(sumx,sumy);
}

void setup(){
  size(1000,1000);
  
  for(int i=0;i<NParticle;i++){
    array2[i] = new Particle();
  }
  
  for(int i=0;i<NCenter;i++){
    array[i] = new Center();
  }
  
  background(0);
}

int numFrames = 200;

void draw(){
  
  for(int i=0;i<NParticle;i++){
    array2[i].show();
  }
  for(int i=0;i<NParticle;i++){
    array2[i].update();
  }
  
  println(frameCount+"/"+numFrames);
  
  if(frameCount>=numFrames){
    saveFrame("image"+floor(random(100000))+".png");
    println("finished");
    stop();
  }

}