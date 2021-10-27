class Center{
  float x = random(width);
  float y = random(height);
  
  float rot = random(-10,10);
  
  void show(){
    stroke(255,0,0);
    strokeWeight(3);
    point(x,y);
  }
}

int N = 30;

Center[] array = new Center[N];

PVector field(float x,float y){
  
  float amount = 7;
  
  float sumx = 0;
  float sumy = 0;
  for(int i = 0;i<N;i++){
    float distance = dist(x,y,array[i].x,array[i].y);
    float intensity = constrain(map(distance,0,width,1,0),0,1);
    intensity = pow(intensity,12);
    float nx = (x - array[i].x)/distance;
    float ny = (y - array[i].y)/distance;
    
    sumx += array[i].rot*amount*ny*intensity;
    sumy -= array[i].rot*amount*nx*intensity;
  }
  return new PVector(sumx,sumy);
}


void setup(){
  size(500,500);
  
  for(int i=0;i<N;i++){
    array[i] = new Center();
  }
}

void draw(){
  background(0);
  for(int i=0;i<N;i++){
    array[i].show();
  }
  
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
  }
  
}