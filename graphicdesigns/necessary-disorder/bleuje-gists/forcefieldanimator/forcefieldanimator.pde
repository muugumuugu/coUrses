//--------------------------------------------------------------------------//
// Force field animator by Etienne Jacob (www.necessary-disorder.tumblr.com)//
// Processing code (https://processing.org)                                 //
// Saves frames, then you must use something else to make the GIF           //
//--------------------------------------------------------------------------//
/// This code starts with the rendering system I took from @beesandbombs
/// (it also contains some useful functions and stuff)
/// You don't have to understand it
/// Just know that it does an average on many drawings to get a motion blur effect
/// from drawings parametrized by the global variable t going from 0 to 1

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
    
    if(invert_colors){
      filter(INVERT);
    }

    saveFrame("fr###.png");
    println(frameCount,"/",numFrames);
    if (frameCount==numFrames)
      exit();
  }
}

/// END OF THE RENDERING SYSTEM
//////////////////////////////////////////////////////////////////////////////

// Number of drawings used to render each final frame with motion blur
int samplesPerFrame = 4;
// Total number of frames in the gif
int numFrames = 20;
// Kind of the time interval used for each frame in the motion blur
float shutterAngle = .8;
// If you put this to false you will control time with mouse and no pictures will be saved
boolean recording = true;

///////////////////////////////////////////////////
/// various parameters to control the aesthetic

// This one is quite explicit
boolean use_white_rectangle = true;
// Border margin
int border = 50;
// Inverting colors or not
boolean invert_colors = false;
// Maximum point size
float maximimum_point_size = 1;

/////////////////////////////////////////////////
/// FORCE FIELD ANIMATION ALGORITHM

// Time step
float DT = 0.05;
// slowdown coefficient on speed
float slowdown = 0.98;
// Number of steps
int nsteps = 500;
// Number of particles per path
int number_of_particles_per_path = 40;
// Number of paths
int NPath = 3000;
// The total number of particles will be NPath*number_of_particles_per_path

/// A class to define paths particles take
class Path{
  // start position
  float x = random(width);
  float y = random(height);
  
  // initial speed
  float vx = 0;
  float vy = 0;
  
  ArrayList<PVector> positions = new ArrayList<PVector>();
  
  // point size
  float sz = random(1,maximimum_point_size);
  
  // Nunmber of particles per path
  int npart = number_of_particles_per_path;
  
  // offset so that particles don't appear at the same time for each path
  float t_off = random(1);
  
  Path(){
    positions.add(new PVector(x,y));
  }
  
  void update(){
    PVector res = field(x,y);
    vx += DT*res.x;
    vy += DT*res.y;
    vx *= slowdown;
    vy *= slowdown;
    x += DT*vx;
    y += DT*vy;
    positions.add(new PVector(x,y));
  }
  
  void show(){
    
    strokeWeight(sz);
    
    float tt = (t+t_off)%1;
    
    int len = positions.size();
    
    for(int i=0;i<npart;i++){
      // Particle location calculated by linear interpolation from the computed positions
      float loc = constrain(map(i+tt,0,npart,0,len-1),0,len-1-0.001);;
      int i1 = floor(loc);
      int i2 = i1+1;
      float interp = loc - floor(loc);
      float xx = lerp(positions.get(i1).x,positions.get(i2).x,interp);
      float yy = lerp(positions.get(i1).y,positions.get(i2).y,interp);
      
      float fact = 1;
      if(use_white_rectangle && (xx<border||xx>width-border||yy<border||yy>height-border)) fact = 0;
      
      // This is to make particles appear and disappear gradually
      float alpha = fact*255*pow(sin(PI*loc/(len-1)),0.25);
      
      stroke(255,alpha);
      
      point(xx,yy);
    }
  }
}

Path[] array2 = new Path[NPath];

void path_step(){
  for(int i=0;i<NPath;i++){
    array2[i].update();
  }
}

//////////////////////////////////////
/// Definition of the force field
/// here it uses a function computed with Centers but you can use any PVector field(float x,float y) function you like

class Center{
  float bb = 2.1;
  float x = random(bb*border,width-bb*border);
  float y = random(bb*border,height-bb*border);
  
  /// how the centers makes particles rotate around it
  float rot = random(-10,10);
  /// how the centers attracts or repulse particles
  float repulse = random(-10,0);
  
  void show(){
    stroke(255,0,0);
    strokeWeight(3);
    point(x,y);
  }
}

// Number of centers
int NCenter = 100;

Center[] array = new Center[NCenter];

PVector field(float x,float y){
  
  float amount = 25;
  
  float sumx = 0;
  float sumy = 0;
  for(int i = 0;i<NCenter;i++){
    float distance = dist(x,y,array[i].x,array[i].y);
    
    float intensity = constrain(map(distance,0,width,1,0),0,1);
    intensity = pow(intensity,20);// this is to make the effect of the center vanish with the distance from it
    // with 15 instead of 25 for example, the effect will go further
    
    // defining the normlized vector from the center to the (x,y) location
    float nx = (x - array[i].x)/distance;
    float ny = (y - array[i].y)/distance;
    
    sumx += (array[i].rot*ny + array[i].repulse*nx)*intensity*amount;
    sumy += (-array[i].rot*nx + array[i].repulse*ny)*intensity*amount;
  }
  return new PVector(sumx+0,sumy+15);//+25 and -25 are a bias to move the particles even when they are far from centers
}


////////////////////
/// SETUP AND DRAW_


void setup(){
  /// drawing size
  size(600,800);
  
  /// Initialization of the array used to render frames
  result = new int[width*height][3];
  
  /// Initialization of Centers to define the flow field
  for(int i=0;i<NCenter;i++){
    array[i] = new Center();
  }
  /// Initialization of Paths
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

  for(int i=0;i<NPath;i++){
    array2[i].show();
  }
  
  if(use_white_rectangle){
    noFill();
    stroke(255);
    strokeWeight(1);
    rect(border,border,width-2*border,height-2*border);
  }
}