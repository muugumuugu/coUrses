float ease(float p, float g) {
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

class Center{
  
  float rad = height/3*sqrt(random(1));
  float theta = random(TWO_PI);
  float x = width/2 + rad*cos(theta);
  float y = height/2 + rad*sin(theta);/*
  float x = random(width);
  float y = random(height);*/
  
  float fact = random(3,3);
  
  void show(){
    stroke(255,0,0);
    strokeWeight(3);
    point(x,y);
  }
}

int N = 35;

Center[] array = new Center[N];

float epsilon = 1e-4;

float field(float x,float y){
  
  float amount = 1500;
  
  float sum = 0;
  for(int i = 0;i<N;i++){
    float distance = dist(x,y,array[i].x,array[i].y);
    float intensity = 1/(distance+epsilon+15);
    
    sum += array[i].fact*intensity*amount;
  }
  return sum;
}


void setup(){
  size(500,500);
  background(0);
  
  for(int i=0;i<N;i++){
    array[i] = new Center();
  }
}

int numFrames = 15;

void draw(){
  background(0);
  
  float t = 1.0*frameCount/numFrames%1;
  
  for(int i=0;i<N;i++){
    array[i].show();
  }
  
  for(int i = 0;i<width;i++){
    for(int j=0;j<height;j++){
      float phase = 0.1*field(i,j);
      float col = ease(pow(map(sin(phase + TWO_PI*t),-1,1,0,1),1),5);
      col *= 255;
      stroke(col);
      point(i,j);
    }
  }
  
  /*
 int ni = 50;
  
  for(int i=0;i<ni;i++){
    for(int j=0;j<ni;j++){
      float x = map(i,0,ni-1,0,width);
      float y = map(j,0,ni-1,0,height);
      float res = field(x,y);
      
      stroke(res);
      strokeWeight(1);
      point(x,y);
    }
  }*/
  
  if(frameCount<=numFrames){
    saveFrame("fr###.png");
  }
  if(frameCount==numFrames){
    println("finished");
    stop();
  }
  /*
  if(frameCount==1000){
    saveFrame("e###.png");
    stop();
    println("finished");
  }
  */
}