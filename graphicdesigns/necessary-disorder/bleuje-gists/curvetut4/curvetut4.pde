int numFrames = 100;

OpenSimplexNoise noise;

void setup(){
  size(500,500,P3D);
  
  stroke(255);
  fill(255);
  
  noise = new OpenSimplexNoise();
}

float motion_radius = 2.5;
float x1(float t){
  float seed = 1337;
  return 0.25*width + 150*(float)noise.eval(seed + motion_radius*cos(TWO_PI*t),motion_radius*sin(TWO_PI*t));
}
float y1(float t){
  float seed = 1515;
  return 0.5*height + 150*(float)noise.eval(seed + motion_radius*cos(TWO_PI*t),motion_radius*sin(TWO_PI*t));
}

float x2(float t){
  return 0.75*width + 50*cos(2*TWO_PI*t);
}
float y2(float t){
  return 0.5*height + 50*sin(2*TWO_PI*t);
}

int m = 3000;

float delay_factor = 1.0;

void draw(){
  float t = 1.0*(frameCount - 1)/numFrames;
  
  background(0);
  
  ellipse(x1(t),y1(t),6,6);
  ellipse(x2(t),y2(t),6,6);
  
  pushStyle();
  strokeWeight(2);
  stroke(255,35);
  for(int i=0;i<=m;i++){
    float tt = 1.0*i/m;
    
    float x = lerp(x1(t - delay_factor*tt),x2(t - delay_factor*(1-tt)),tt);
    float y = lerp(y1(t - delay_factor*tt),y2(t - delay_factor*(1-tt)),tt);
    
    point(x,y);
  }
  popStyle();
  
  println("saving frame " + frameCount + "/" + numFrames);
  if(frameCount<=numFrames) saveFrame("fr###.png");
  if(frameCount == numFrames) stop();
}