int[][] result;
float t, c;

float ease(float p) {
  return 3*p*p - 2*p*p*p;
}

float ease(float p, float g) {
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

float mn = .5*sqrt(3), ia = atan(sqrt(.5));

void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popStyle();
  popMatrix();
}

void draw() {

  if (!recording) {
    t = mouseX*1.0/width;
    c = mouseY*1.0/height;
    if (mousePressed)
      println(c);
    draw_();
  } else {
    for (int i=0; i<width*height; i++)
      for (int a=0; a<3; a++)
        result[i][a] = 0;

    c = 0;
    for (int sa=0; sa<samplesPerFrame; sa++) {
      t = map(frameCount-1 + sa*shutterAngle/samplesPerFrame, 0, numFrames, 0, 1);
      draw_();
      loadPixels();
      for (int i=0; i<pixels.length; i++) {
        result[i][0] += pixels[i] >> 16 & 0xff;
        result[i][1] += pixels[i] >> 8 & 0xff;
        result[i][2] += pixels[i] & 0xff;
      }
    }

    loadPixels();
    for (int i=0; i<pixels.length; i++)
      pixels[i] = 0xff << 24 | 
        int(result[i][0]*1.0/samplesPerFrame) << 16 | 
        int(result[i][1]*1.0/samplesPerFrame) << 8 | 
        int(result[i][2]*1.0/samplesPerFrame);
    updatePixels();

    saveFrame("fr###.png");
    println(frameCount,"/",numFrames);
    if (frameCount==numFrames)
      exit();
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 4;
int numFrames = 40;        
float shutterAngle = .6;

boolean recording = true;

//OpenSimplexNoise noise;


void setup(){
  size(700,700,P3D);
  result = new int[width*height][3];
  
  //noise = new OpenSimplexNoise();
  
}

float col(float x,float y){
  int nx = 10;
  int ny = 10;
  int xx = floor(x/nx+8*t);
  int yy = floor(y/ny-2*t);
  return 255*((xx+yy+50000)%2);
}

float mrad = 1.0;

PVector distortion(float x,float y){
  
  float y2 = map(y,-3*sz,3*sz,0,1);
  
  
  
  float xx = 100/(abs(x + 0.25*sin(TWO_PI*(y2-t)))+0.5);
  //float yy = 400/(abs(y)+1.85) + 3*cos(TWO_PI*(0.02*xx-1*t));
  //float yy = 400/(abs(y)+1.85) + 5*cos(TWO_PI*(0.2*x + 0.1*y -1*t));
  float yy = 10*y + 5*cos(TWO_PI*(0.2*x + 0.1*y -1*t));
  //xx += + 3*cos(TWO_PI*(0.02*yy-1*t));
  
  return new PVector(xx,yy);
}

float sz = 3.0;

void draw_(){
  for(int i=0;i<=width;i++){
    for(int j=0;j<=height;j++){
      float xx = map(i,0,width,-sz,sz);
      float yy = map(j,0,height,-3*sz,3*sz);
      PVector d = distortion(xx,yy);
      float mycol = col(d.x,d.y);
      stroke(mycol);
      point(i,j);
    }
  }
  //stroke(255);
  //line(0,height/2,width,height/2);
  //line(width/2,0,width/2,height);
}