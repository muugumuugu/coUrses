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
int numFrames = 400;        
float shutterAngle = 1.0;

boolean recording = true;

//OpenSimplexNoise noise;

int n = 1;

int m = 100;

int N = 30;

float border = 125;

float spacing = 50;

class Thing{
  float x0 = random(border, width-border);
  float y0 = random(border, height-border);
  
  float offset = 0;
  
  float seed = random(10000);
  
  ArrayList<PVector> positions = new ArrayList<PVector>();
  ArrayList<Float> sizes = new ArrayList<Float>();
  
  Thing(){
    float x = x0;
    float y = y0;
    
    x = spacing*floor(1.0*x/spacing)+0.5*spacing;
    y = spacing*floor(1.0*y/spacing)+0.5*spacing;
    
    positions.add(new PVector(x, y));
    sizes.add(0.0);
    
    for(int i=0;i<m;i++){
      float jump = random(spacing,150);
      //float jump = constrain(map((float)noise.eval(seed + 2.0*i/m,0),-0.5,0.5,25,120),10,120);
      int k = floor(random(0,4));
      //int k = floor(random(0,8));
      
      if(k==0){
        x += jump;
      }
      if(k==1){
        x -= jump;
      }
      if(k==2){
        y += jump;
      }
      if(k==3){
        y -= jump;
      }
      if(k==4){
        x += jump;
        y += jump;
      }
      if(k==5){
        x -= jump;
        y += jump;
      }
      if(k==6){
        x += jump;
        y -= jump;
      }
      if(k==7){
        x -= jump;
        y -= jump;
      }
      if(x>width-border){
        x -= 2*jump;
      }
      if(x<border){
        x += 2*jump;
      }
      if(y>height-border){
        y -= 2*jump;
      }
      if(y<border){
        y += 2*jump;
      }
      
      x = spacing*floor(1.0*x/spacing)+0.5*spacing;
      y = spacing*floor(1.0*y/spacing)+0.5*spacing;
      
      positions.add(new PVector(x, y));
      if(i==m-1){
        sizes.add(0.0);
      } else {
        sizes.add(random(1,3));
      }
    }
  }
  
  void show0(){
    stroke(255,150);
    noFill();
    strokeWeight(1);
    beginShape();
    for(int i=0;i<=m;i++){
      PVector res = positions.get(i);
      vertex(res.x, res.y);
    }
    endShape();
  }
  
   void show(){
    stroke(255);
    
    float tt = (t+offset)%1;
    
    for(int i=0;i<N;i++){
      float pos = 0.999*(i+tt)/N*m;
      float pos2 = floor(pos) + ease(pos-floor(pos),4.0);
      float interp = pos2 - floor(pos2);
      int i1 = floor(pos2);
      int i2 = i1+1;
      PVector res1 = positions.get(i1);
      PVector res2 = positions.get(i2);
      Float sz1 = sizes.get(i1);
      Float sz2 = sizes.get(i2);
      float xx = lerp(res1.x, res2.x, interp);
      float yy = lerp(res1.y, res2.y, interp);
      float sz = lerp(sz1, sz2, interp);
      strokeWeight(sz);
      point(xx,yy);
      noFill();
      stroke(255);
      strokeWeight(sz/2);
      ellipse(xx,yy,3*sz,3*sz);
    }
    
    for(int i=0;i<N;i++){
      float pos = 0.999*(i+tt)/N*m;
      float pos2 = floor(pos) + ease(pos-floor(pos),4.0);
      float interp = pos2 - floor(pos2);
      int i1 = floor(pos2);
      int i2 = i1+1;
      PVector res1 = positions.get(i1);
      PVector res2 = positions.get(i2);
      Float sz1 = sizes.get(i1);
      Float sz2 = sizes.get(i2);
      float xxi = lerp(res1.x, res2.x, interp);
      float yyi = lerp(res1.y, res2.y, interp);
      float szi = lerp(sz1, sz2, interp);
      for(int j=i+1;j<N;j++){
        pos = 0.999*(j+tt)/N*m;
        pos2 = floor(pos) + ease(pos-floor(pos),4.0);
        interp = pos2 - floor(pos2);
        i1 = floor(pos2);
        i2 = i1+1;
        res1 = positions.get(i1);
        res2 = positions.get(i2);
        sz1 = sizes.get(i1);
        sz2 = sizes.get(i2);
        float xxj = lerp(res1.x, res2.x, interp);
        float yyj = lerp(res1.y, res2.y, interp);
        float szj = lerp(sz1, sz2, interp);
        strokeWeight(1);
        float coef = 1-constrain(dist(xxi,yyi,xxj,yyj)/80,0,1);
        stroke(255,1000*coef*szi*szj/4/4);
        line(xxi,yyi,xxj,yyj);
      }
    }
  }
}

Thing[] array = new Thing[n];

void setup(){
  size(600,600,P2D);
  result = new int[width*height][3];
  
  //noise = new OpenSimplexNoise();
  
  
  for(int i=0;i<n;i++){
    array[i] = new Thing();
  }
  
}

void draw_(){
  background(0);
  push();
  
  
  for(int i=0;i<n;i++){
    array[i].show();
  }
  
  pop();

}