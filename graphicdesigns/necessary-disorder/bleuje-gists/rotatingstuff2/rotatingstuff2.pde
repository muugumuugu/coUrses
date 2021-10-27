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

int samplesPerFrame = 5;
int numFrames = 75;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

float SEED;

float R = 160;

float dr(float p,float off){
  float l = ease(sin(PI*p),0.5);
  return 1*70*(float)noise.eval(SEED+2*cos(TWO_PI*p),2*sin(TWO_PI*p),off/3);
}

float dtheta(float p,float off){
  float l = ease(sin(PI*p),0.5);
  return 0.02*PI*(float)noise.eval(2*SEED+1*cos(TWO_PI*p),1*sin(TWO_PI*p),off);
}

float px(float p,float off){
  //float l = ease(sin(PI*p),1.5);
  float theta = TWO_PI*p+dtheta(p,off);
  float r = R+dr(p,off)*1+5*off*1;
  return r*cos(theta);
}

float py(float p,float off){
  //float l = ease(sin(PI*p),1.5);
  float theta = TWO_PI*p+dtheta(p,off);
  float r = R+dr(p,off)*1+5*off*1;
  return r*sin(theta);
}

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  SEED = random(10,1000);
}

int m = 5000;
int m2 = 600;

int K = 12;

int ncircle = 200;

void drawCircle(){
  stroke(255,150);
  for(int i=0;i<ncircle;i++){
    strokeWeight(1.5+(i%2));
    float theta = TWO_PI*i/ncircle;
    point(R*cos(theta),R*sin(theta));
  }
  
  for(int i=0;i<n;i++){
    strokeWeight(4.0);
    stroke(255);
    float theta = TWO_PI*(i+t)/n;
    point(R*cos(theta),R*sin(theta));
  }
}

void drawThing(float tt){
  for(int k=0;k<K;k++){
    for(int i=0;i<m2;i++){
      float p = (100 + tt - 0.25*i/m2)%1;
      float l = ease(sin(PI*p),0.5);
      //float d = 800*pow(1.0*i/m2,1.8);
      //float dx = 1000*pow(1.0*i/m2,1.8);
      float f = 1-pow(1.0*i/m2,1.8);
      float xx = px(p,0.3*k)*f;
      float yy = py(p,0.3*k)*f;
      
      /*
      if(i==0){
        float theta = tt*TWO_PI;
        stroke(255,100);
        strokeWeight(1);
        push();
        translate(0,0,-1);
        line(xx,yy,R*cos(theta),R*sin(theta));
        pop();
      }*/
      
      stroke(255,(i==0?255:8+25*l));
      strokeWeight((i==0?6.5:4.5)*noise(10*k)*(1-1.0*i/m2));
      point(xx,yy);
    }
  }
}

int n = 7;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  rotate(HALF_PI);
  
  /*
  for(int k=0;k<K;k++){
    strokeWeight(1.5);
    for(int i=0;i<m;i++){
      float p = 1.0*i/m;
      float l = ease(sin(PI*p),0.5);
      stroke(255,10+30*l);
      point(px(p,0.4*k),py(p,0.4*k));
    }
  }*/
  
  //drawCircle();
  
  for(int i=0;i<n;i++){
    drawThing(t/n+1.0*i/n);
  }
  
  pop();
}