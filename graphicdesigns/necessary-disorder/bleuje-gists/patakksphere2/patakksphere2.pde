// by Etienne JACOB
// motion blur template by beesandbombs
// needs opensimplexnoise code in another tab
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
int numFrames = 50;        
float shutterAngle = 1.0;

boolean recording = true;

OpenSimplexNoise noise;

float R = 150;

int NPath = 5000;

float maximimum_point_size = 2.5;

int number_of_particles_per_path = 2;

float DT = 0.02;

int nsteps = 200;

float seed;

class Path{
  // start position
  float x0 = (int(random(2))*2-1)*random(0.1,2);
  float y0 = (int(random(2))*2-1)*random(0.1,2);
  float z0 = (int(random(2))*2-1)*random(0.1,2);
  
  ArrayList<PVector> positions = new ArrayList<PVector>();
  
  // point size
  float sz = random(1,maximimum_point_size);
  
  // Nunmber of particles per path
  int npart = number_of_particles_per_path;
  
  // offset so that particles don't appear at the same time for each path
  float t_off = random(1);
  
  float x,y,z;
  
  Path(){
    float mg = (new PVector(x0,y0,z0)).mag();
    PVector start = (new PVector(x0,y0,z0)).mult(R/mg);
    positions.add(start);
    x = start.x;
    y = start.y;
    z = start.z;
  }
  
  void update(){
    PVector res = field(x,y,z);
    x += DT*res.x;
    y += DT*res.y;
    z += DT*res.z;
    float mg = (new PVector(x,y,z)).mag();
    PVector res2 = (new PVector(x,y,z)).mult(R/mg);
    x = res2.x;
    y = res2.y;
    z = res2.z;
    positions.add(res2);
  }
  
  void show(){
    
    strokeWeight(sz);
    
    float tt = (t+t_off)%1;
    
    int len = positions.size();
    
    for(int i=0;i<npart;i++){
      for(int j=0;j<=5;j++){
      // Particle location calculated by linear interpolation from the computed positions
      float loc = constrain(map(i+tt+j*0.025,0,npart,0,len-1),0,len-1-0.001);;
      int i1 = floor(loc);
      int i2 = i1+1;
      float interp = loc - floor(loc);
      float xx = lerp(positions.get(i1).x,positions.get(i2).x,interp);
      float yy = lerp(positions.get(i1).y,positions.get(i2).y,interp);
      float zz = lerp(positions.get(i1).z,positions.get(i2).z,interp);
      
      float mg = (new PVector(xx,yy,zz)).mag();
      PVector res = (new PVector(xx,yy,zz)).mult(R/mg);
      xx = res.x;
      yy = res.y;
      zz = res.z;
      
      float fact = 1;
      //if(use_white_rectangle && (xx<border||xx>width-border||yy<border||yy>height-border)) fact = 0;
      
      // This is to make particles appear and disappear gradually
      float alpha = fact*255*pow(sin(PI*loc/(len-1)),0.9);
      
      stroke(255,alpha);
      
      //println((new PVector(xx,yy,zz)).mag());
      
      point(xx,yy,zz);
      }
    }
  }
}

PVector field(float x,float y,float z){
  float scl = 0.013;
  float amount = 100;
  //return new PVector(amount*(float)noise.eval(scl*x,scl*y,scl*z),amount*(float)noise.eval(100+scl*x,scl*y,scl*z),amount*(float)noise.eval(200+scl*x,scl*y,scl*z));
  //return new PVector(amount*(float)noise.eval(scl*x,scl*y,scl*z) + 20*sin(PI*(x+z)/50),30+30*sin(PI*((x+y)/70+2*x*x/R/R)),20 + 10*sin(PI*(y+z)/30));
  return new PVector(amount*(float)noise.eval(seed+scl*x,scl*y,scl*z),amount*(float)noise.eval(seed+100+scl*x,scl*y,scl*z),amount*(float)noise.eval(seed+200+scl*x,scl*y,scl*z));
}

Path[] array2 = new Path[NPath];

void path_step(){
  for(int i=0;i<NPath;i++){
    array2[i].update();
  }
}

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
    
  seed = random(100);
  
  for(int i=0;i<NPath;i++){
    array2[i] = new Path();
  }

  
  /// Computation of Paths
  for(int i=0;i<nsteps;i++){
    println(i+1,"/",nsteps);
    path_step();
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);

  for(int i=0;i<NPath;i++){
    array2[i].show();
  }
  
  fill(0);
  noStroke();
  sphere(R-1);

  pop();
}