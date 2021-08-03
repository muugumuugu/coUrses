color[] result;

PImage img;

PVector field(float x,float y,float t){
  
  float amount = 100;
  
  float scl = 0.01;
  float scl2 = 0.005;
  
  PVector res = new PVector(amount*(noise(100+scl*x,100+scl*y)-0.5),4*amount*(noise(200+scl*x,200+scl*y)-0.5));
  
  //float offset = 3*noise(300+scl2*x,300+scl2*y);
  float offset = 0.03*y;
  
  res.mult(map(sin(TWO_PI*(t+offset)),-1,1,0,1));
  
  return res;
}

void setup() {
  img = loadImage("wilmawater2.jpg");
  size(800,480);
  
  result = new int[width*height];
}

int numFrames = 25;

void draw(){
  float t = 1.0*(frameCount-1)%numFrames/numFrames;
  println(t);
  
  image(img,0,0);
  
  loadPixels();
  for (int i=0; i<width; i++) {
    for(int j=0;j<height;j++){
      PVector res = field(i,j,t);
      int ii = constrain(floor(i + res.x),0,width-1);
      int jj = constrain(floor(j + res.y),0,height-1);
      result[i + width*j] = pixels[ii + width*jj];
    }
  }
  for (int i=0; i<width; i++) {
    for(int j=0;j<height;j++){
      pixels[i + width*j] = result[i + width*j];
    }
  }
  updatePixels();
  
  saveFrame("fr###.png");
  if(frameCount==numFrames){
    stop();
    println("finished");
  }
  
}