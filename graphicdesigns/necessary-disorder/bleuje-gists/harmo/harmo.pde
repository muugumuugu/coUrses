void setup(){
  size(500,500);
  background(0);
}


float a1 = 1.0,a2 = 1.2,a3 = 1.0,a4 = 1.5;
float d1 = 0.00002,d2 = 0.00002,d3 = 0.0005,d4 = 0.00002;
float f1 = 1,f2 = 2, f3 = 3.2,f4 = 4.1;
float p1 = 0,p2 = 0,p3 = 0,p4 = 0;

float F = 5;
float N = 2000;

void draw(){
  stroke(255,20);
  float tt = F*frameCount;
  for(int i=0;i<N;i++){
    float t = map(i,0,N,tt,tt+F);
    float xx = a1*exp(-d1*t)*sin(f1*t  +  p1)  + a2*exp(-d2*t)*sin(f2*t  +  p2);
    float yy = a3*exp(-d3*t)*sin(f3*t  +  p3)  + a4*exp(-d4*t)*sin(f4*t  +  p4);
    float x = map(xx,-3,3,0,width);
    float y = map(yy,-3,3,0,height);
    point(x,y);
    //println(x,y);
  }
  if(frameCount == 1000){
    stop();
    saveFrame("frame###.png");
  }
}