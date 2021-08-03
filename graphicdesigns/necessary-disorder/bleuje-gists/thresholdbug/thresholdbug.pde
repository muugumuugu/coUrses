OpenSimplexNoise noise;
 
void setup(){
  size(500,500);
  background(0);
  stroke(255);
  noFill();
 
  noise = new OpenSimplexNoise();
}
 
void draw(){
  background(0);
  float scale = 0.02;
 
  loadPixels();
  for(int x = 0; x<width;x++){
    for(int y = 0; y<height;y++){
      boolean b = (float)noise.eval(scale*x,scale*y)>0;
      float col = b?255:0;
      pixels[x + width*y] = color(col);
    }
  }
  updatePixels();
 
  saveFrame("tuto3.jpg");
}
