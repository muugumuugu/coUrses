// by Etienne JACOB
// motion blur template by beesandbombs
// needs opensimplexnoise code in another tab
// --> code here : https://gist.github.com/Bleuje/fce86ef35b66c4a2b6a469b27163591e


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

    saveFrame("fr###.gif");
    println(frameCount,"/",numFrames);
    if (frameCount==numFrames)
      exit();
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 5;
int numFrames = 40;        
float shutterAngle = 1.3;

boolean recording = true;

OpenSimplexNoise noise;

int n = 70;
int K = 20;
int m = K*5;
int T = 3;

float softplus(float q,float p){
  return log(p+exp(q));
}

float change(float i){
  //println('i',i);
  float p = 1.0*(i+n)/(2*n);
  //println('p',p);
  float pp = pow(p,1);
  //println("res",2*n*pp - n);
  return (i<=n?2*n*pp - n:i);
}

/*
void drawCircle(int i){
  //float dtheta = 0.05*(float)noise.eval(0.1*(i+T*t+0.5),0);
  //float dtheta = 0*(i+T*t)*0.02 + 0.1*sin(TWO_PI*t);
  float dtheta = t*8*TWO_PI/m;
  float r1 = 3*map(softplus(change(i+T*t),1),0,n,0,width);
  float r2 = 3*map(softplus(change(i+1+T*t),1),0,n,0,width);
  float z1 = -pow(150/softplus(change(i+T*t),1),1.0);
  float z2 = -pow(150/softplus(change(i+1+T*t),1),1.0);
  //float z1 = -150/softplus(atan(i+T*t),1);
  //float z2 = -150/softplus(atan(i+1+T*t),1);
  //float col = (i%T==0?255:15);
  //fill(col);
  //stroke(col);
  
  beginShape(TRIANGLE_STRIP);
  for(int j=0;j<=m;j++){
    float theta = TWO_PI*j/m;
    float x1 = r1*cos(theta+dtheta);
    float y1 = r1*sin(theta+dtheta);
    float x2 = r2*cos(theta+dtheta);
    float y2 = r2*sin(theta+dtheta);
    
    float col = 240;

    if((i+j)%2==0){
      col = 25;
    }
    vertex(x1,y1,z1);
    vertex(x2,y2,z2);
    fill(col);
    stroke(col);
    noStroke();
    
    vertex(x1,y1,z1);
    vertex(x2,y2,z2);
  }
  endShape();
}
*/

float rmin = 120;

void drawCircle(int i){
  //float dtheta = 0.05*(float)noise.eval(0.1*(i+T*t+0.5),0);
  //float dtheta = 0*(i+T*t)*0.02 + 0.1*sin(TWO_PI*t);
  float dtheta = t*4*TWO_PI/m;
  float r1 = map(softplus(change(i-T*t),0.2),0,n,rmin,3*width);
  float r2 = map(softplus(change(i+1-T*t),0.2),0,n,rmin,3*width);
  float z1 = -10*softplus(change(-(i-T*t)),0.2);
  float z2 = -10*softplus(change(-(i+1-T*t)),0.2);
  //float z1 = -150/softplus(atan(i+T*t),1);
  //float z2 = -150/softplus(atan(i+1+T*t),1);
  //float col = (i%T==0?255:15);
  //fill(col);
  //stroke(col);
  
  beginShape(TRIANGLE_STRIP);
  for(int j=0;j<=m;j++){
    float theta = TWO_PI*j/m;
    float x1 = r1*cos(theta+dtheta);
    float y1 = r1*sin(theta+dtheta);
    float x2 = r2*cos(theta+dtheta);
    float y2 = r2*sin(theta+dtheta);
    
    float col = 240;

    if((i+j)%2==0){
      col = 25;
    }
    vertex(x1,y1,z1);
    vertex(x2,y2,z2);
    fill(col);
    stroke(col);
    noStroke();
    
    vertex(x1,y1,z1);
    vertex(x2,y2,z2);
  }
  endShape();
}

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2,0.25*width);
  
  rotateX(0.9);
  
  translate(0,-100);
  //rotateX(0.5);
  
  for(int i=-n;i<n;i++){
    drawCircle(i);
  }
  
  pop();
}