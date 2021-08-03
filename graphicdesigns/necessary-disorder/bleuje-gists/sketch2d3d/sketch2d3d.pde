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
int numFrames = 300;        
float shutterAngle = 1.3;

boolean recording = true;

//OpenSimplexNoise noise;


void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  //noise = new OpenSimplexNoise();
  
  ortho();
  
  rectMode(CENTER);
}

float l = 150;

void drawCube(float r1, float r2, float r3){
  push();
  rotateX(r1);
  rotateY(r2);
  rotateZ(r3);
  
  float ts = constrain(2*t,0,1);
  
  float easing = 2.5;
  
  float t1 = ease(constrain(3*ts,0,1),easing);
  float t2 = ease(constrain(3*ts-1,0,1),easing);
  float t3 = ease(constrain(3*ts-2,0,1),easing);
  
  rotateX(0.5*t1*PI);
  rotateY(0.5*t2*PI);
  rotateZ(0.5*t3*PI);
  
  push();
  
  fill(0.8*255);
  
  translate(0,0,l/2);
  rect(0,0,l,l);
  translate(0,0,-l);
  rect(0,0,l,l);
  
  pop();
  
  
  push();
  rotateY(HALF_PI);
  
  fill(0.6*255);
  
  translate(0,0,l/2);
  rect(0,0,l,l);
  translate(0,0,-l);
  rect(0,0,l,l);
  
  pop();
  
  push();
  rotateX(HALF_PI);
  
  fill(1*255);
  
  translate(0,0,l/2);
  rect(0,0,l,l);
  translate(0,0,-l);
  rect(0,0,l,l);
  
  pop();
  
  pop();
}

void drawHexagonPart(float col, int i){
  float r = 0.82*l;
  
  fill(col);
  stroke(0.2*255);
  float theta1 = TWO_PI*(-0.5-0-2*i)/6;
  float theta2 = TWO_PI*(-0.5-1-2*i)/6;
  float theta3 = TWO_PI*(-0.5-2-2*i)/6;
  
  float x1 = r*cos(theta1);
  float y1 = r*sin(theta1);
  float x2 = r*cos(theta2);
  float y2 = r*sin(theta2);
  float x3 = r*cos(theta3);
  float y3 = r*sin(theta3);
  
  beginShape();
  vertex(x1,y1);
  vertex(x2,y2);
  vertex(x3,y3);
  vertex(0,0);
  endShape();
}

float depth = 30;

void drawHexagon(){
  push();
  translate(0,0,0.5*depth);
  drawHexagonPart(255,0);
  drawHexagonPart(0.8*255,1);
  drawHexagonPart(0.6*255,2);
  pop();
  
  float r = 0.82*l;
  
  fill(0.4*255);
  stroke(0.2*255);
  beginShape(TRIANGLE_STRIP);
  for(int k=0;k<=6;k++){
    float theta = TWO_PI*(0.5+k)/6;
    float x = r*cos(theta);
    float y = r*sin(theta);
    vertex(x,y,-0.5*depth);
    vertex(x,y,0.5*depth);
  }
  endShape();
  
  push();
  translate(0,0,-0.5*depth);
  drawHexagonPart(255,0);
  drawHexagonPart(0.8*255,1);
  drawHexagonPart(0.6*255,2);
  pop();
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  strokeWeight(1.8);
  
  if(t<0.5){
    stroke(0.2*255);
    drawCube(-ia,0.25*PI,0*PI);
  } else {
    float rot = 3*ease(constrain(2*t-1,0,1),2.0)*PI;
    push();
    rotateY(rot);
    drawHexagon();
    pop();
  }
  pop();
}