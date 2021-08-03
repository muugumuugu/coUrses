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

int samplesPerFrame = 6;
int numFrames = 50;        
float shutterAngle = .9;

boolean recording = true;

float w = 300;

PVector surface(float p, float theta,float off)
{
  float p2 = map(p,0,1,-750,1350);
  float z = softplus(-p2,w)-off;
  float r = 600 + softplus(p2,w) - off;
  r *= pow(p,2.0);
  
  float x = r*cos(theta);
  float y = r*sin(theta);
  
  return new PVector(x,y,z);
}

void draw_surface(float off)
{
  push();
  
  int m1 = 60;
  int m2 = 50;
  
  stroke(255);
  fill(0);
  //strokeWeight(2.0);
  noStroke();
  
  for(int i=0;i<m1;i++){
    beginShape(TRIANGLE_STRIP);
    for(int j=0;j<=m2;j++){
      float theta1 = map(i+t,0,m1,0,TWO_PI);
      float theta2 = map(i+1+t,0,m1,0,TWO_PI);
      
      float p = map(j+3*t+0.05*random(1),0,m2,0,1);
      
      PVector v1 = surface(p,theta1,off);
      PVector v2 = surface(p,theta2,off);
      
      vertex(v1.x,v1.y,v1.z);
      vertex(v2.x,v2.y,v2.z);
    }
    endShape();
  }
  pop();
}

void drawBlock(float p, PVector pos, PVector v1, PVector v2,float angle,float swf, float L)
{
  push();
  translate(pos.x,pos.y,pos.z);
  
  float l1 = L;
  float l2 = 70.0*pow(p,3.2);
  float h = 4.0;
  
  PVector v3 = v1.copy().cross(v2);
  
  PVector V1 = v1.copy().mult(cos(angle)).add(v3.copy().mult(sin(angle)));
  PVector V2 = v2;
  PVector V3 = v1.copy().mult(-sin(angle)).add(v3.copy().mult(cos(angle)));
  
  PVector v000 = V1.copy().mult(l1/2).add(V2.copy().mult(l2/2)).add(V3.copy().mult(h/2));
  PVector v100 = V1.copy().mult(-l1/2).add(V2.copy().mult(l2/2)).add(V3.copy().mult(h/2));
  PVector v010 = V1.copy().mult(l1/2).add(V2.copy().mult(-l2/2)).add(V3.copy().mult(h/2));
  PVector v110 = V1.copy().mult(-l1/2).add(V2.copy().mult(-l2/2)).add(V3.copy().mult(h/2));
  PVector v001 = V1.copy().mult(l1/2).add(V2.copy().mult(l2/2)).add(V3.copy().mult(-h/2));
  PVector v101 = V1.copy().mult(-l1/2).add(V2.copy().mult(l2/2)).add(V3.copy().mult(-h/2));
  PVector v011 = V1.copy().mult(l1/2).add(V2.copy().mult(-l2/2)).add(V3.copy().mult(-h/2));
  PVector v111 = V1.copy().mult(-l1/2).add(V2.copy().mult(-l2/2)).add(V3.copy().mult(-h/2));
  
  stroke(255);
  strokeWeight(1.7*swf);
  fill(0);
  
  beginShape();
  vertex(v000.x,v000.y,v000.z);
  vertex(v100.x,v100.y,v100.z);
  vertex(v110.x,v110.y,v110.z);
  vertex(v010.x,v010.y,v010.z);
  endShape(CLOSE);
  
  beginShape();
  vertex(v001.x,v001.y,v001.z);
  vertex(v101.x,v101.y,v101.z);
  vertex(v111.x,v111.y,v111.z);
  vertex(v011.x,v011.y,v011.z);
  endShape(CLOSE);
  
  beginShape();
  vertex(v000.x,v000.y,v000.z);
  vertex(v100.x,v100.y,v100.z);
  vertex(v101.x,v101.y,v101.z);
  vertex(v001.x,v001.y,v001.z);
  endShape(CLOSE);
  
  beginShape();
  vertex(v000.x,v000.y,v000.z);
  vertex(v010.x,v010.y,v010.z);
  vertex(v011.x,v011.y,v011.z);
  vertex(v001.x,v001.y,v001.z);
  endShape(CLOSE);
  
  beginShape();
  vertex(v010.x,v010.y,v010.z);
  vertex(v110.x,v110.y,v110.z);
  vertex(v111.x,v111.y,v111.z);
  vertex(v011.x,v011.y,v011.z);
  endShape(CLOSE);
  
  beginShape();
  vertex(v100.x,v100.y,v100.z);
  vertex(v110.x,v110.y,v110.z);
  vertex(v111.x,v111.y,v111.z);
  vertex(v101.x,v101.y,v101.z);
  endShape(CLOSE);
  
  pop();
}

int N1 = 130;
int N2 = 2;

class Thing
{
  int K = 29;
  int m = 30;
  
  float sz = random(2,10);
  
  float offset = random(1);
  
  float theta0 = random(TWO_PI);
  
  float col = random(170,300);
  
  float swf = pow(random(1),2.0)+0.5; // unused
  
  Thing(int ind1,int ind2)
  {
    theta0 = map(ind1,0,N1,0,TWO_PI);
    offset = 1.0*ind2/K/N2;
  }
  
  void show(float p)
  {
    
    float offset2 = -t + 100 + 11.5*p - 0*4*theta0/TWO_PI + 1.3*sin(3*theta0+0.75);
    float aux = offset2 - floor(offset2);
    offset2 = floor(offset2) + ease(aux,3.0);
    
    float theta = theta0 + 0.8*p;
    
    PVector pos = surface(p,theta,0);
    PVector v1 = (surface(p+0.001,theta,0).sub(pos)).normalize();
    PVector v2 = (surface(p,theta+0.01,0).sub(pos)).normalize();
    
    PVector u = surface(p+0.98/N2/K,theta,0).sub(pos);
    float L = u.mag();
    
    drawBlock(p,pos,v1,v2,PI*offset2,1.0,L);
  }
  
  void show()
  {
    for(int i=0;i<K;i++)
    {
      float p = map(i+1-t,0,K,0,1);
      p = (p+offset)%1;
      show(p);
    }
  }
}

Thing[] array = new Thing[N1*N2];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  int k = 0;
  for(int i=0;i<N1;i++){
    for(int j=0;j<N2;j++){
      array[k] = new Thing(i,j);
      k++;
    }
  }
}

void draw_(){
  background(0);
  push();
  
  translate(width/2+ random(-1,1)*0.4,height/2-150 + random(-1,1)*0.4,+ random(-1,1)*0.4);
  
  rotateX(0.6*HALF_PI);
  
  draw_surface(15);
  
  for(int i=0;i<N1*N2;i++)
  {
    array[i].show();
  }
  
  pop();
}