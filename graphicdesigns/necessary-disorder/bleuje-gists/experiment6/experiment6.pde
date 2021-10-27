int numFrames = 100;

PVector field(float x,float y){
  float amount = 2.5;
  float scale = 0.03;
  float radius = 0.45;
  double value1 = 400.0*noise.eval(scale*x,scale*y,radius*cos(TWO_PI*1.0*(frameCount-1)/numFrames),radius*sin(TWO_PI*1.0*(frameCount-1)/numFrames));
  double value2 = 400.0*noise.eval(1000+scale*x,scale*y,radius*cos(TWO_PI*1.0*(frameCount-1)/numFrames),radius*sin(TWO_PI*1.0*(frameCount-1)/numFrames));
  //int value2 = (int) Math.round(value);
  float parameter1 = (int) Math.round(value1)/100.0;
  float parameter2 = (int) Math.round(value2)/100.0;
  //if(random(100)<1) println(parameter);
  return new PVector(amount*parameter1,amount*parameter2);
}

OpenSimplexNoise noise;

void setup(){
  size(500,500);
  background(0);
  
  noise = new OpenSimplexNoise();
}

void draw(){
  background(0);
  for(float i = 150;i<=width-150;i+=5){
    for(float j=150;j<=height-150;j+=5){
      stroke(255,25);
      noFill();
      
      float x = i;
      float y = j;
      
      point(x,y);
      for(int k=0;k<200;k++){
        PVector res = field(x,y);
        res.mult(0.15);
        x += res.x;
        y += res.y;
        point(x,y);
      }
      
      point(x,y);
    }
  }
  
  
  println(frameCount);
  
  saveFrame("fr###.png");
  
  if(frameCount==numFrames){
    //saveFrame("a###.png");
    stop();
    println("finished");
  }
  
}