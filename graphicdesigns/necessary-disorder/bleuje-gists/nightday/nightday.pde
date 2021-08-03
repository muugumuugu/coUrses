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
int numFrames = 100;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;


void setup(){
  size(500,500,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
}

int K = 1;

int n = 7;

int nn = 8*n;

float sz = 20;

float l = 150;

void draw_(){
  float background_color = 255*ease(map(sin(K*TWO_PI*t),-1,1,0,1),2.0);
  background(background_color);
  
  push();
  translate(width/2,height/2);
  
  noFill();
  
  strokeWeight(2);
  for(int j=-19;j<=10;j++){
    if(abs(j)>3){
      for(int i=0;i<nn;i++){
        float theta1,theta2;
        float tt = (t+0.25)%1;
        if(j%2==0){
          theta1 = 1.0*TWO_PI*(i+2*tt)/nn;
          theta2 = 1.0*TWO_PI*(i+1+2*tt)/nn;
        } else {
          theta1 = 1.0*TWO_PI*(i-2*tt)/nn;
          theta2 = 1.0*TWO_PI*(i+1-2*tt)/nn;
        }
        float ll = map(j,0,1,l,l+8);
        
        stroke(255*(i%2));
        line(ll*cos(theta1),ll*sin(theta1),ll*cos(theta2),ll*sin(theta2));
      }
    }
  }
  
  noStroke();
  for(int i=0;i<n;i++){
    float theta = 1.0*TWO_PI*(i+t)/n;
    
    push();
    translate(l*cos(theta),l*sin(theta),5);
    
    rotate(-theta*3);
    
    //float sz2 = map((float)noise.eval(2*cos(theta),2*sin(theta)),-1,1,sz,3*sz);
    float sz2 = 2.1*sz;
    
    fill(255);
    arc(0,0,sz2,sz2,0,PI);
    fill(0);
    arc(0,0,sz2,sz2,PI,TWO_PI);
    pop();
    
  }
  
  pop();

}