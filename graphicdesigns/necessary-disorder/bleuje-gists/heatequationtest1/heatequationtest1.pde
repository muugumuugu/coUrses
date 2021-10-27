float DT = 0.5;

float D = 1.0;

float DX = 1.0;

int n = 50;
int K = 18;

float [][] tarray = new float[n][K];
float [][] tarray2 = new float[n][K];

float [] initial_values = new float[K];

void set_array(float f,int k){
  for(int i=0;i<n;i++){
    tarray[i][k] = f;
  }
}

int m = 100;
int iDot = 0;

class Dot{
  float x = random(100,width-100);
  float y = random(25,height-25);
  
  float t0 = frameCount;
  
  float sz = random(5,10);
  
  float dot_time = random(10,50);
  
  void show(){
    float alpha = constrain(map(frameCount,t0,t0+dot_time,255,0),0,255);
    stroke(255,alpha);
    strokeWeight(sz);
    point(x,y);
  }
  
  float effect(){
    return constrain(map(frameCount,t0,t0+dot_time,1,0),0,1);
  }
}

Dot[] dotarray = new Dot[m];

void show(int k){
  noFill();
  stroke(255,100);
  strokeWeight(1.5);
  beginShape();
  for(int i=0;i<n;i++){
    float x = map(i,0,n-1,0,width);
    float y = tarray[i][k];
    vertex(x,y);
  }
  endShape();
}

int numFrames = 350;
int endFrames = 100;


void update(int k){
  for(int i=1;i<n-1;i++){
    if(mousePressed){
      float x = map(i,0,n-1,0,width);
      float fact = exp(-abs(x-mouseX)/10);
      tarray[i][k] = lerp(tarray[i][k],mouseY,fact);
    }
    
    for(int j=0;j<min(iDot,m);j++){
      Dot dt = dotarray[j];
      float x = map(i,0,n-1,0,width);
      float fact = exp(-abs(dt.x-x)/10);
      tarray[i][k] = lerp(tarray[i][k],dt.y,fact*dt.effect());
    }
  }

  
  for(int i=1;i<n-1;i++){
    if(frameCount>=numFrames-endFrames){
      float p = map(frameCount,numFrames-endFrames,numFrames,0,1);
      tarray[i][k] = lerp(tarray[i][k],initial_values[k],pow(p,10.0));
    }
    
    // finite differences !
    tarray2[i][k] = tarray[i][k] + DT*D/DX*(tarray[i-1][k] - 2*tarray[i][k] + tarray[i+1][k]);
  }
  
  for(int i=1;i<n-1;i++){
    tarray[i][k] = tarray2[i][k];
  }
}

void setup(){
  size(500,500);
  
  for(int k=0;k<K;k++){
    float h = map(k,0,K-1,100,height-100);
    initial_values[k] = h;
    set_array(h,k);
  }
}

void draw(){
  background(0);
  
  if(random(1)<0.05 && frameCount<=numFrames-endFrames){
    dotarray[iDot%m] = new Dot();
    println(iDot);
    iDot++;
  }
  
  for(int k=0;k<K;k++){
    update(k);
    show(k);
  }
  
  for(int i=0;i<min(iDot,m);i++){
    dotarray[i].show();
  }
  
  saveFrame("fr###.png");
  
  println(frameCount,"/",numFrames);
  
  if(frameCount==numFrames){
    println("finished");
    stop();
  }
}