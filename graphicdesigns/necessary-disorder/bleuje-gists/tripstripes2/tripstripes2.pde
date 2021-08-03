OpenSimplexNoise noise;

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
int numFrames = 150;        
float shutterAngle = .7;

boolean recording = true;

void setup(){
  size(500,500,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
}

float scale = 0.75;

float x(float p){
  return 0.5*width*(float)noise.eval(scale*cos(TWO_PI*p),scale*sin(TWO_PI*p));
}

float y(float p){
  return 0.5*width*(float)noise.eval(100+scale*cos(TWO_PI*p),scale*sin(TWO_PI*p));
}

int n = 60;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  /*
  float xx = x(t);
  float yy = y(t);
  stroke(255);
  line(xx,yy,width/2,width/2);
  line(xx,yy,-width/2,width/2);
  line(xx,yy,-width/2,-width/2);
  line(xx,yy,width/2,-width/2);
  */
  
  float fact = 0.35;
  
  scale(1.1);
  
  
  for(int i=-10*n;i<n;i++){
    
    float power = 6.5;
    
    float ii = max(i+17*2*t,0);
    
    float interp = pow(1.0*(ii)/n,power);
    float interp2 = pow(1.0*(ii+1)/n,power);
    
    float ph = fact*ii/n;
    float xx = x(t+ph);
    float yy = y(t+ph);
    
    float x1 = lerp(xx,width/2,interp);
    float y1 = lerp(yy,width/2,interp);
    
    float x2 = lerp(xx,-width/2,interp);
    float y2 = lerp(yy,width/2,interp);
    
    float x3 = lerp(xx,-width/2,interp);
    float y3 = lerp(yy,-width/2,interp);
    
    float x4 = lerp(xx,width/2,interp);
    float y4 = lerp(yy,-width/2,interp);
    
    float x1_2 = lerp(xx,width/2,interp2);
    float y1_2 = lerp(yy,width/2,interp2);
    
    float x2_2 = lerp(xx,-width/2,interp2);
    float y2_2 = lerp(yy,width/2,interp2);
    
    float x3_2 = lerp(xx,-width/2,interp2);
    float y3_2 = lerp(yy,-width/2,interp2);
    
    float x4_2 = lerp(xx,width/2,interp2);
    float y4_2 = lerp(yy,-width/2,interp2);
    
    //stroke(255*(i%2));
    noStroke();
    fill(255*((i+10000)%2));
    
    beginShape();
    vertex(x1,y1);
    vertex(x1_2,y1_2);
    vertex(x2_2,y2_2);
    vertex(x2,y2);
    endShape();
    
    beginShape();
    vertex(x2,y2);
    vertex(x2_2,y2_2);
    vertex(x3_2,y3_2);
    vertex(x3,y3);
    endShape();
    
    beginShape();
    vertex(x3,y3);
    vertex(x3_2,y3_2);
    vertex(x4_2,y4_2);
    vertex(x4,y4);
    endShape();
    
    beginShape();
    vertex(x4,y4);
    vertex(x4_2,y4_2);
    vertex(x1_2,y1_2);
    vertex(x1,y1);
    endShape();
  }
  
  
  pop();
}