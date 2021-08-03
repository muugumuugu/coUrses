OpenSimplexNoise noise;

void setup(){
  size(500,500);
  background(0);
  stroke(255);
  noFill();

  noise = new OpenSimplexNoise();
}

int numFrames = 75;

float radius = 1.0;

void draw(){
  float t = 1.0*frameCount/numFrames;

  background(0);
  float scale = 0.02;

  loadPixels();
  for(int x = 0; x<width;x++){
    for(int y = 0; y<height;y++){
      boolean b = (float)noise.eval(scale*x,scale*y,radius*cos(TWO_PI*t),radius*sin(TWO_PI*t)) > 0;
      float col = b?255:0;
      pixels[x + width*y] = color(col);
    }
  }
  updatePixels();

  println(t);

  if(frameCount<=numFrames){
    saveFrame("tuto2###.gif");
  }
  if(frameCount == numFrames){
    println("finished");
    stop();
  }
}