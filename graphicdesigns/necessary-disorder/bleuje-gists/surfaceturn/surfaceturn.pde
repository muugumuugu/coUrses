// Processing code by Etienne JACOB
// motion blur template by beesandbombs
// opensimplexnoise code in another tab might be necessary
// --> code here : https://gist.github.com/Bleuje/fce86ef35b66c4a2b6a469b27163591e

// Warning : this code just shows how a gif was made, it's not intended to be pedagogical, show good coding practices or be clever

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

int samplesPerFrame = 4;
int numFrames = 80;        
float shutterAngle = .8;

boolean recording = true;

OpenSimplexNoise noise;

int n1 = 18;

int n2 = 200;

int N = 30;

int K = n2/N;

float smth = 250;

float rmin = 70;

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

int nturns = 3;

PVector position2(float p,float q,int l){
    float pp = map(p,0,1,-3.0*width,0.6*width);
    float theta = TWO_PI*1.9*pow(p,2.0);
    float R = 180;
    float y = pp;
    float theta1 = TWO_PI*(l-2*t)/nturns;
    float theta2 = TWO_PI*(l+1-2*t)/nturns;
    float x1 = R*cos(theta1+theta);
    float x2 = R*cos(theta2+theta);
    float z1 = R*sin(theta1+theta);
    float z2 = R*sin(theta2+theta);
    float z = 2500*pow(1-p,3.0)-180+1*lerp(z1,z2,q);
    //float z = softplus(-pp,200)-400*pow(3*(q-0.5),2.0)-500*abs(q-0.5);
    float x = lerp(x1,x2,q);
    
    return new PVector(x,y,z);
}

color[] colorArray = new int[]{#4CB5F5, #B7B8B6, #34675C, #B3C100};
color[] colorArray2 = new int[]{#021C1E, #004445, #2C7873, #6FB98F};
color[] colorArray3 = new int[]{#F52549, #FA6475, #FFD64D, #9BC01C};
//color[] colorArray = new int[]{#00293C, #1E656D, #F1F3CE, #F62A00};
//color[] colorArray = new int[]{#262F34, #F1D3BC, #F34A4A, #615049};

class Thing{
  float seed = random(10,1000);
  
  int i,j;
  
  Thing(int i_,int j_){
    i = i_;
    j = j_;
  }

  float coladd(float p){
    return 500*pow(map((float)noise.eval(2*seed+change*p,0),-1,1,0,1),7.0);
  }
  
  float displacementI = 20;
  
  PVector displacement(float p){
    return new PVector(dx(p),dy(p),dz(p));
  }
  
  float change = 1.0;
  
  float dx(float p){
    return displacementI*(float)noise.eval(3*seed+change*p,0);
  }
  
  float dy(float p){
    return displacementI*(float)noise.eval(4*seed+change*p,0);
  }
  
  float dz(float p){
    return displacementI*(float)noise.eval(5*seed+change*p,0)/4;
  }
  
  float dr(float p){
    return ((float)noise.eval(6*seed+2*change*p,0)+1)/2;
  }
  
  void show(){
    for(int l=0;l<nturns;l++){
      for(int k=0;k<=K;k++){
        float q = 1.0*i/n1;
        float ind = j+(k+t)*N;
        
        float p0 = map(ind+0.5,0,n2,-1,1);
        float p1 = map(ind,0,n2,-1,1);
        float p2 = map(ind+1,0,n2,-1,1);
        
        float q0 = 1.0*(i+0.5)/n1;
        float q1 = 1.0*(i)/n1;
        float q2 = 1.0*(i+1)/n1;
        
        PVector v0 = position2(p0,q0,l).add(displacement(p0).mult(2.0*sin(PI*q0)));
        PVector v1 = position2(p1,q1,l);
        PVector v2 = position2(p2,q1,l);
        PVector v3 = position2(p2,q2,l);
        PVector v4 = position2(p1,q2,l);
  
        float f = constrain(2.0*p0,0,1);
        
        stroke(f*(i==0||i==n1-1?200:(10+coladd(p0))));
        fill(0);
        strokeWeight(1.3);
        
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
        
        float ff = (1.25-p0)*(1.5+1.8*pow(map(sin(TWO_PI*(2*p0+1*t)),-1,1,0,1),2.0));
        //ff = 1;
        
        noStroke();
        fill(255);
        push();
        translate(v0.x,v0.y,v0.z);
        //sphere(dr(p0));
        float rad = 10.5*dr(p0)*ff*(f+1)/2;
        ellipse(0,0,rad,rad);
        push();
        rotateX(HALF_PI);
        ellipse(0,0,rad,rad);
        rotateY(HALF_PI);
        ellipse(0,0,rad,rad);
        pop();
        rotateY(HALF_PI);
        ellipse(0,0,rad,rad);
        rotateX(HALF_PI);
        ellipse(0,0,rad,rad);
        pop();
      }
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
  
  translate(width/2,-40+height/2,-0.0*width);
  
  rotateZ(0*0.15*HALF_PI);
  
  rotateX(1.7);
  
  //translate(100,0,-20);
  
  translate(0,0,-150);
  
  
  for(int k=0;k<n1*N;k++){
    array[k].show();
  }

  pop();
}