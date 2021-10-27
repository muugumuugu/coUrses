// Processing code by Etienne JACOB
// motion blur template by beesandbombs
// opensimplexnoise code in another tab might be necessary
// --> code here : https://gist.github.com/Bleuje/fce86ef35b66c4a2b6a469b27163591e

// inspired by a tweet by Joanie Lemercier : https://twitter.com/JoanieLemercier/status/1146851204875661313
// also : related tutorial : https://necessarydisorder.wordpress.com/2019/02/20/distortion-or-smoke-effect-on-parametric-curves/

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

float softplus(float q,float p){
  float qq = q+p;
  if(qq<=0){
    return 0;
  }
  if(qq>=2*p){
    return qq-p;
  }
  return 1/(4*p)*qq*qq;
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

    saveFrame("fr###.gif");
    println(frameCount,"/",numFrames);
    if (frameCount==numFrames)
      exit();
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 3;
int numFrames = 40;        
float shutterAngle = 1.0;

boolean recording = true;

OpenSimplexNoise noise;


void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
}

int n = 300; // there will be (n+1)*(n+1) dots drawn

float margin = 100;

//function used to distort noise values
float pow2(float p,float q){
  return ((p>=0)?pow(p,q):-pow(-p,q));
}

void draw_(){
  background(0);
  push();
  
  for(int i=0;i<=n;i++){
    for(int j=0;j<=n;j++){
      // dot position before displacement
      float x = map(i,0,n,margin,width-margin);
      float y = map(j,0,n,margin,height-margin);
      
      float scl = 0.017; // scale of 2D noise variation. Larger value -> more variation
      float rad = 0.5; // radius to define the random periodic noise. Larger radius -> more variation in one period
      float amp = 80; // displacement amplitude
      
      // offset : essential value here but I also find it quite hard to explain 
      // this tutorial tries to explain it (see last section) : https://necessarydisorder.wordpress.com/2019/02/20/distortion-or-smoke-effect-on-parametric-curves/
      float offset = 0.02*dist(x,y,width/2,height/2);
      
      // displacement with random_periodic moving function with a radial offset and 2D variation -> 4D noise
      // noise is distorted with the pow2 function defined above
      float dx = amp*pow2((float)noise.eval(123 + rad*cos(TWO_PI*(t-offset)),rad*sin(TWO_PI*(t-offset)),scl*x,scl*y),2.0);
      float dy = amp*pow2((float)noise.eval(1234 + rad*cos(TWO_PI*(t-offset)),rad*sin(TWO_PI*(t-offset)),scl*x,scl*y),2.0);
      
      // noise used for more random texture
      stroke(255,50+100*noise(i,j));
      strokeWeight(1.0+1.0*noise(i,j));
      
      // we add displacement to dot position and draw
      point(x+dx,y+dy);
    }
  }
  
  pop();
}