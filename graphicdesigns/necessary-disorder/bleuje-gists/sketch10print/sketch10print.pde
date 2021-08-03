OpenSimplexNoise noise;

void setup(){
  size(500,500);
  
  noise = new OpenSimplexNoise();
}

int spacing = 15;
int numFrames = 100;
float R = 0.5;
float scale = 0.01;

void draw(){
  float t = (1.0*frameCount/numFrames)%1;
  
  background(0);
  stroke(255);
  for(int x = 0;x<width;x+=spacing){
    for(int y = 0;y<height;y+=spacing){
      float ns = (float)noise.eval(scale*x,scale*y,R*cos(TWO_PI*t),R*sin(TWO_PI*t));
      if(ns<0){
        line(x,y,x+spacing,y+spacing);
      } else {
        line(x,y+spacing,x+spacing,y);
      }
    }
  }
  if(frameCount<=numFrames){
    saveFrame("fr###.png");
  }
  if(frameCount==numFrames){
    println("finished");
    //stop();
  }
}