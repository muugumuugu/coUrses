// Processing code by Etienne JACOB
// motion blur template by beesandbombs
// opensimplexnoise code in another tab might be necessary
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

int samplesPerFrame = 5;
int numFrames = 52;        
float shutterAngle = .9;

boolean recording = true;

OpenSimplexNoise noise;

int n1 = 30;

int n2 = 104;

int N = 8;

int K = n2/N;

float R = 300;

float Z = 3000;

PVector position(float r,float p,float theta){
  float turn = 2.1*p;
  return new PVector(r*cos(theta+turn),r*sin(theta+turn)-pow((1-p),2.0)*2100+280,-Z*(1-p)-250);
}

class Thing{
  float seed = random(10,1000);
  
  //float offset = random(-0.5,1.65);
  float offset = 0.4+0.8*randomGaussian();
  
  int i,j;
  
  float dist = random(800,1200);
  
  Thing(int i_,int j_){
    i = i_;
    j = j_;
  }
  
  float col = 300*pow(random(1),5.0);
  
  float r(float p){
    return R - 50-400*pow(map((float)noise.eval(seed+2.0*p,0),-1,1,0,1),2.0);
  }
  
  float param(float p){
    return pow(1-constrain(3*p-offset,0,1),3.3);
  }
  
  float added_color(float p){
    return 900*pow(map((float)noise.eval(2*seed+2.5*p,0),-1,1,0,1),5.0);
  }
  
  void show(){
    for(int k=0;k<K;k++){
      float ind = j+(k+t)*N;
      
      float minv = -0.75;
      float maxv = 1.3;
      
      float p0 = map(ind+0.5,0,n2,minv,maxv);
      float p1 = map(ind,0,n2,minv,maxv);
      float p2 = map(ind+1,0,n2,minv,maxv);
      
      float theta0 = TWO_PI*(i+0.5)/n1;
      float theta1 = TWO_PI*(i)/n1;
      float theta2 = TWO_PI*(i+1)/n1;
      
      float q = param(p0);
      float d = dist*param(p0);
      
      PVector v0 = position(r(p0)+d,p0,theta0);
      PVector v1 = position(R+d,p1,theta1);
      PVector v2 = position(R+d,p2,theta1);
      PVector v3 = position(R+d,p2,theta2);
      PVector v4 = position(R+d,p1,theta2);
      
      float addlerp = 0.05;
      
      v1.lerp(v0,constrain(q+addlerp,0,1));
      v2.lerp(v0,constrain(q+addlerp,0,1));
      v3.lerp(v0,constrain(q+addlerp,0,1));
      v4.lerp(v0,constrain(q+addlerp,0,1));

      stroke((80+1.0*added_color(p0))*(1-q));
      fill(0);
      strokeWeight(1.25);
      
      beginShape();
      vertex(v0.x,v0.y,v0.z);
      vertex(v1.x,v1.y,v1.z);
      vertex(v2.x,v2.y,v2.z);
      endShape(CLOSE);
      
      beginShape();
      vertex(v0.x,v0.y,v0.z);
      vertex(v3.x,v3.y,v3.z);
      vertex(v2.x,v2.y,v2.z);
      endShape(CLOSE);
      
      beginShape();
      vertex(v0.x,v0.y,v0.z);
      vertex(v3.x,v3.y,v3.z);
      vertex(v4.x,v4.y,v4.z);
      endShape(CLOSE);
      
      beginShape();
      vertex(v0.x,v0.y,v0.z);
      vertex(v1.x,v1.y,v1.z);
      vertex(v4.x,v4.y,v4.z);
      endShape(CLOSE);
      
      fill(238*(1*(1-q)-0));
      
      beginShape();
      vertex(v1.x,v1.y,v1.z);
      vertex(v2.x,v2.y,v2.z);
      vertex(v3.x,v3.y,v3.z);
      vertex(v4.x,v4.y,v4.z);
      endShape(CLOSE);
    }
  }
}

Thing[] array = new Thing[n1*N];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  int k=0;
  for(int i=0;i<n1;i++){
    for(int j=0;j<N;j++){
      array[k] = new Thing(i,j);
      k++;
    }
  }
}

void draw_(){
  background(0);
  push();
  translate(width/2,height/2);
  
  rotateZ(-0.5*HALF_PI);
  
  translate(0,200,0);
  
  for(int k=0;k<n1*N;k++){
    array[k].show();
  }
  
  pop();
}