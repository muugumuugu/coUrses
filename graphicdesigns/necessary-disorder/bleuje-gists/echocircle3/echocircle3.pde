int[][] result;
float t, c;

public float ease(float p) {
  return 3*p*p - 2*p*p*p;
}

public float ease(float p, float g) {
  if (p < 0.5f) 
    return 0.5f * pow(2*p, g);
  else
    return 1 - 0.5f * pow(2*(1 - p), g);
}

float mn = .5f*sqrt(3), ia = atan(sqrt(.5f));

public void push() {
  pushMatrix();
  pushStyle();
}

public void pop() {
  popStyle();
  popMatrix();
}

public void draw() {

  if (!recording) {
    t = mouseX*1.0f/width;
    c = mouseY*1.0f/height;
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
        PApplet.parseInt(result[i][0]*1.0f/samplesPerFrame) << 16 | 
        PApplet.parseInt(result[i][1]*1.0f/samplesPerFrame) << 8 | 
        PApplet.parseInt(result[i][2]*1.0f/samplesPerFrame);
    updatePixels();

    saveFrame("fr###.png");
    println(frameCount,"/",numFrames);
    if (frameCount==numFrames)
      exit();
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 5;
int numFrames = 200;        
float shutterAngle = .6;

boolean recording = true;

OpenSimplexNoise noise;

float offset_rad = 100.0;

class Thing{
  float theta;
  
  float offset;
  
  float rmin = random(0,90);
  //float rmax = random(180,240);
  float rmax = 220;
  
  float alpha = pow(random(0.2f,1.0f),2.0f);
  
  float easing = 4.0f;
  
  float nsin = random(0,7);
  float ssin = random(0.01f,0.08f);
  
  float seed = 100+random(1000);
  
  float mr = 1.5f;
  float bs = 25;
  
  float size_center = random(0.1f,1);
  
  Thing(float th){
    theta = th;
    offset = 0.35f*noise(100+offset_rad*cos(theta),100+offset_rad*sin(theta));
  }
  
  void show(){
    
    int m2 = 200;
    
    for(int j=0;j<m2;j++){
      float p = 1.0f*j/m2;
      
      float tt = (t+offset+0.1f*p)%1;
      float r = map(ease(map(sin(TWO_PI*tt),-1,1,0,1),easing),0,1,rmin,rmax);
      
      float intensity2 = sin(PI*map(r,rmax,rmin,0,1));
      
      float sign;
      
      if(tt<0.25f||tt>0.75f){
        sign = 1;
      } else {
        sign = -1;
      }
      
      float thetap = intensity2*ssin*sin(TWO_PI*nsin*r/width+100*offset+sign*10*TWO_PI*t);
      
      float proximity = pow(map(r,rmax,rmin,0,1),3.0f);
      
      float x = r*cos(theta+thetap);
      float y = r*sin(theta+thetap);
      
      float x0 = x + bs*(float)noise.eval(seed + mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
      float y0 = y + bs*(float)noise.eval(2*seed + mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
      
      float xx = lerp(x,x0,proximity);
      float yy = lerp(y,y0,proximity);
      
      float intensity = sin(PI*p);
      
      float sw = 1.5f+3*pow(intensity,5.0f);
      
      sw = lerp(sw,sw*size_center,proximity);
      
      strokeWeight(sw);
      stroke(255,255*intensity*alpha);
      point(xx,yy);
    }
    
    int m3 = 20;
    
    for(int j=0;j<m3;j++){
      float p = 1.0f*j/m3;
      
      float tt = (t+offset+0.1f*p)%1;
      float r = map(ease(map(sin(TWO_PI*tt),-1,1,0,1),easing),0,1,rmin,rmax);
      
      float intensity2 = sin(PI*map(r,rmax,rmin,0,1));
      
      float sign;
      
      if(tt<0.25f||tt>0.75f){
        sign = 1;
      } else {
        sign = -1;
      }
      
      float thetap = intensity2*ssin*sin(TWO_PI*nsin*r/width+100*offset+sign*10*TWO_PI*t);
      
      float proximity = pow(map(r,rmax,rmin,0,1),3.0f);
      
      float x = r*cos(theta+thetap);
      float y = r*sin(theta+thetap);
      
      float x0 = x + bs*(float)noise.eval(seed + mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
      float y0 = y + bs*(float)noise.eval(2*seed + mr*cos(TWO_PI*t),mr*sin(TWO_PI*t));
      
      float xx = lerp(x,x0,proximity);
      float yy = lerp(y,y0,proximity);
      
      float intensity = sin(PI*p);
      
      float sw = 1.5f+6*pow(intensity,5.0f);
      
      sw = lerp(sw,sw*size_center,proximity);
      
      strokeWeight(sw);
      stroke(255,255*intensity*alpha);
      point(xx,yy);
    }
  }
}

int n = 50;

Thing[] array = new Thing[n];


void setup(){
  size(500,500,P3D);
  
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    
    array[i] = new Thing(1.0f*i*TWO_PI/n);
    println(array[i].theta);
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  for(int i=0;i<n;i++){
    array[i].show();
  }
  pop();
}