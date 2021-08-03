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
int numFrames = 50;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

int n = 17;

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
}

int m = 40;

int kk = 2;

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  for(int i=0;i<2*n;i++){
    for(int j=-1;j<1.25*n;j++){
      float cx = 0.85*(width*ease(map(i,0,2*n-1,0,1),2.0)-0.5*width);
      float cy = map(j+t,0,1.25*n-1,-height/2,height/2);
      
      push();
      translate(cx,cy);
      
      float c = ease(map(sin(TWO_PI*(1.5*cy/height+t)),-1,1,0,1),2.0);
      
      float mr = 0.3;
      
      float sw = map((float)noise.eval(0.01*cx,0.01*cy,mr*cos(TWO_PI*t),mr*sin(TWO_PI*t)),-1,1,1,2);
      
      fill(255*c);
      stroke(255,150);
      strokeWeight(sw);
      
      float l = 0.2+ease(map(sin(TWO_PI*(-5*dist(cx,cy,0,0)/width+t)),-1,1,0,1),2.0);
      
      beginShape();
      for(int k=0;k<m;k++){
        float theta = k*TWO_PI/m;
        
        float rad = 1.0*sin(PI*(cy+height/2)/height);
        
        float rr = l*10*map((float)noise.eval(100*noise(cx)+rad*cos(theta),rad*sin(theta),110*cy/height),-1,1,0.5,1.5)*sin(PI*map(cx,-width/2*0.85,width/2*0.85,0,1));
        float xx = rr*cos(theta);
        float yy = rr*sin(theta);
        
        vertex(xx,yy);
        //point(xx,yy);
      }
      endShape(CLOSE);
      pop();
    }
  }
  
  pop();
}