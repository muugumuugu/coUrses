float DT = 0.01;

float D = 0.001;

float DX = 10.0;

float delta = 12;

float lerp_back = 0.05;

int n = 200;
int K = 20;


int m = 30;
int iDot = 0;


int numFrames = 150;

float [][] tarray = new float[n][K];
float [][] tarray2 = new float[n][K];

float [] initial_values = new float[K];

void set_array(float f,int k){
  for(int i=0;i<n;i++){
    tarray[i][k] = f;
  }
}



class Dot{
  float cx = random(-0.3*width,0.3*width);
  float cy = random(-0.3*height,0.3*height);
  
  float r = random(0.02*width,0.15*width);
  
  float offset = random(1);
  
  float sz = 4;
  
  float dot_time = random(10,50);
  
  void show(float t){
    stroke(255);
    strokeWeight(1);
    fill(255);
    ellipse(x(t),y(t),sz,sz);
  }
  
  float x(float t){
    float tt = (t+offset)%1;
    return cx + r*cos(TWO_PI*tt);
  }
  
  float y(float t){
    float tt = (t+offset)%1;
    return cy + r*sin(TWO_PI*tt);
  }
}

Dot[] dotarray = new Dot[m];

void show(int k){
  noFill();
  stroke(255,200);
  
  for(int i=0;i<n;i++){
    float theta = map(i,0,n,0,TWO_PI);
    float r = tarray[i][k];
    float x = r*cos(theta);
    float y = r*sin(theta);
    float sz = map(r,width/2,0,5,1);
    strokeWeight(sz);
    point(x,y);
  }
}

void update(int k){
  float t = (1.0*(frameCount-1)/numFrames)%1;
  
  for(int i=0;i<n;i++){
    if(mousePressed){
      float theta = map(i,0,n,0,TWO_PI);
      float r = tarray[i][k];
      float x = r*cos(theta);
      float y = r*sin(theta);
      float d = dist(x,y,mouseX-width/2,mouseY-height/2);
      float R = dist(0,0,mouseX-width/2,mouseY-height/2);
      float fact = exp(-d/delta);
      tarray[i][k] = lerp(tarray[i][k],R,fact);
    }
    
    
    for(int j=0;j<m;j++){
      Dot dt = dotarray[j];
      float theta = map(i,0,n,0,TWO_PI);
      float r = tarray[i][k];
      float x = r*cos(theta);
      float y = r*sin(theta);
      float d = dist(x,y,dt.x(t),dt.y(t));
      float R = dist(0,0,dt.x(t),dt.y(t));
      float fact = exp(-d/delta);
      tarray[i][k] = lerp(tarray[i][k],R,fact);
    }
  }

  
  for(int i=0;i<n;i++){
    tarray2[i][k] = tarray[i][k] + DT*D/DX*(tarray[(i-1+1337)%n][k] - 2*tarray[i][k] + tarray[(i+1)%n][k]);
    tarray2[i][k] = lerp(tarray2[i][k], initial_values[k],lerp_back);
  }
  
  for(int i=0;i<n;i++){
    tarray[i][k] = tarray2[i][k];
  }
}

void setup(){
  size(500,500,P3D);
  
  for(int k=0;k<K;k++){
    float h = map(k,0,K-1,5,width/2-40);
    initial_values[k] = h;
    set_array(h,k);
  }
  
  for(int i=0;i<m;i++){
    dotarray[i] = new Dot();
  }
}

void draw(){
  float t = (1.0*(frameCount-1)/numFrames)%1;
  
  background(0);
  
  translate(width/2,height/2);
  
  
  
  for(int k=0;k<K;k++){
    update(k);
    show(k);
  }
  
  for(int i=0;i<m;i++){
    dotarray[i].show(t);
  }
  
  if(frameCount>numFrames){
    saveFrame("fr###.png");
    
    println(frameCount-numFrames,"/",numFrames);
    
    if(frameCount==2*numFrames){
      println("finished");
      stop();
    }
  }
}