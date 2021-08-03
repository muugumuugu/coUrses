OpenSimplexNoise noise;

float R = 300;

float DT = 0.007;

float maximimum_point_size = 3;

class Path{
  // start position
  /*
  float x0 = (int(random(2))*2-1)*random(0.1,2);
  float y0 = (int(random(2))*2-1)*random(0.1,2);
  float z0 = (int(random(2))*2-1)*random(0.1,2);
  */
  float phi = random(-PI,PI);
  float theta = random(TWO_PI);
  float x0 = R*cos(phi)*cos(theta);
  float y0 = R*cos(phi)*sin(theta);
  float z0 = R*sin(phi);
  
  ArrayList<PVector> positions = new ArrayList<PVector>();
  
  // point size
  float sz = random(1,maximimum_point_size);
  
  float x,y,z;
  
  Path(){
    float mg = (new PVector(x0,y0,z0)).mag();
    PVector start = (new PVector(x0,y0,z0)).mult(R/mg);
    positions.add(start);
    x = start.x;
    y = start.y;
    z = start.z;
  }
  
  void step(){
    PVector res = field(x,y,z);
    x += DT*res.x;
    y += DT*res.y;
    z += DT*res.z;
    float mg = (new PVector(x,y,z)).mag();
    PVector res2 = (new PVector(x,y,z)).mult(R/mg);
    x = res2.x;
    y = res2.y;
    z = res2.z;
  }
  
  void show(){
    strokeWeight(sz);
    stroke(255,7);
    if(z>=0) point(x,y,z);
  }
}

PVector field(float x,float y,float z){
  float scl = 0.020;
  float amount = 100;
  return new PVector(amount*(float)noise.eval(seed+scl*x,scl*y,scl*z),amount*(float)noise.eval(seed+100+scl*x,scl*y,scl*z),amount*(float)noise.eval(seed+200+scl*x,scl*y,scl*z));
  //return new PVector(amount*(float)noise.eval(scl*x,scl*y,scl*z) + 20*sin(PI*(x+z)/50),30+30*sin(PI*((x+y)/70+2*x*x/R/R)),20 + 10*sin(PI*(y+z)/30));
}

int n = 6000;

float seed;

Path[] array2 = new Path[n];

void setup(){
  size(1200,1200,P3D);
  
  noise = new OpenSimplexNoise();
  
  seed = random(1000);
  
  for(int i=0;i<n;i++){
    array2[i] = new Path();
  }
  background(25);
}

int nsteps = 600;

void draw(){
  pushMatrix();
  translate(width/2,height/2);

  for(int i=0;i<n;i++){
    array2[i].show();
    array2[i].step();
  }
  
  fill(0);
  noStroke();
  //sphere(R-5);
  //ellipse(0,0,2*R,2*R);

  popMatrix();
  
  println(frameCount,'/',nsteps);
  
  if(frameCount>=nsteps){
    stop();
    println("finished");
    saveFrame("res"+str(floor(random(100000)))+".png");
  }
}