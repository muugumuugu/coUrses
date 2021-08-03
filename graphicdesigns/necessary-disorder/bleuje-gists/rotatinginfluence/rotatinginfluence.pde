float delta = 20;

float lerp_back = 0.09;

float fact2 = 0.8;

int n = 750;
int K = 20;


int m = 10;
int iDot = 0;

int iterations = 3;


int numFrames = 250;

float [][] tarray = new float[n][K];
float [][] tarray2 = new float[n][K];

float [] initial_values = new float[K];

void set_array(float f,int k){
  for(int i=0;i<n;i++){
    tarray[i][k] = f;
  }
}



class Dot{
  float sp = 0.28;
  
  float cx = 0;
  float cy = 0;
  
  float r;
  
  float sz = 3;
  
  float sign = 1;
  
  float speed;
  
  Dot(int i){
    r = map(i,m-1,0,0.04*width,0.25*width);
    speed = i+1;
  }
  
  void show(float t){
    pushMatrix();
    translate(0,0,2);
    stroke(255);
    strokeWeight(1);
    fill(255);
    ellipse(x(t),y(t),sz,sz);
    popMatrix();
  }
  
  float x(float t){
    float tt = (t+0)%1;
    return cx + r*cos(speed*sign*TWO_PI*tt);
  }
  
  float y(float t){
    float tt = (t+0)%1;
    return cy + r*sin(speed*sign*TWO_PI*tt);
  }
}

Dot[] dotarray = new Dot[m];

void show(int k){
  noFill();
  stroke(255,40);
  
  for(int i=0;i<n;i++){
    float theta = map(i,0,n,0,TWO_PI);
    float r = tarray[i][k];
    float x = r*cos(theta);
    float y = r*sin(theta);
    float sz = map(r,width/2,0,3,1);
    strokeWeight(sz);
    point(x,y);
  }
}

void update(int k){
  float t = (1.0*(frameCount-1)/numFrames)%1;
  
  for(int i=0;i<n;i++){
    for(int j=m-1;j>=0;j--){
      Dot dt = dotarray[j];
      float theta = map(i,0,n,0,TWO_PI);
      float r = tarray[i][k];
      float x = r*cos(theta);
      float y = r*sin(theta);
      float d = dist(x,y,dt.x(t),dt.y(t));
      float R = dist(0,0,dt.x(t),dt.y(t));
      float fact = exp(-d*d/(delta*delta));
      //float fact = exp(-d/delta);
      tarray[i][k] = lerp(tarray[i][k],R,fact*fact2);
    }
  }

  
  for(int i=0;i<n;i++){
    tarray[i][k] = lerp(tarray[i][k], initial_values[k],lerp_back);
  }
}

//OpenSimplexNoise noise;

void setup(){
  size(500,500,P3D);
  
  for(int k=0;k<K;k++){
    float h = map(k,0,K-1,5,0.25*width);
    initial_values[k] = h;
    set_array(h,k);
  }
  
  for(int i=0;i<m;i++){
    dotarray[i] = new Dot(i);
  }
  
  //noise = new OpenSimplexNoise();
}

void draw(){
  float t = (1.0*(frameCount-1)/numFrames)%1;
  
  background(0);
  
  translate(width/2,height/2);
  
  rotate(-HALF_PI);
  
  
  
  for(int k=0;k<K;k++){
    update(k);
    show(k);
  }
  
  for(int i=0;i<m;i++){
    dotarray[i].show(t);
  }
  
  if(frameCount>(iterations-1)*numFrames){
    saveFrame("fr###.png");
    
    println(frameCount-(iterations-1)*numFrames,"/",numFrames);
    
    if(frameCount==iterations*numFrames){
      println("finished");
      stop();
    }
  }
}