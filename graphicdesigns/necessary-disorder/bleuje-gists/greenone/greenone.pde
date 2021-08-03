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
int numFrames = 90;        
float shutterAngle = .8;

boolean recording = true;

OpenSimplexNoise noise;

class Digit{
  int nd = 2+floor(25*pow(random(0,1),5.0));
  
  ArrayList<Integer> digits = new ArrayList<Integer>();
  ArrayList<Float> digittime = new ArrayList<Float>();
  
  float tm = 0;
  
  Digit(){
    digittime.add(0.0);
    for(int i=0;i<nd;i++){
      digits.add(floor(random(0,50)));
      float tmp = random(1,10);
      tm += tmp;
      digittime.add(tm);
    }
  }
  
  float offset = random(1);
  
  int res(float p){
    p = (p+1324+offset)%1;
    int res = 0;
    int i = 0;
    while(digittime.get(i)/tm<=p){
      res = digits.get(i);
      i++;
    }
    return res;
  }
}

class Column{
  //float x = random(0,width);
  float x = width/2 + 85*randomGaussian();
  
  int m = floor(random(20,80));
  
  Digit[] digitarray = new Digit[m];
  
  float sz = floor(random(0,11)) + map(m,0,40,0,12);
  
  Column(int k){
    for(int i=0;i<m;i++){
      digitarray[i] = new Digit();
    }
    x = map(k,0,n-1,0*width,1.0*width);
  }
  
  float offset0 = random(1);
  float factor = 0.01+0.04*pow(random(0,1),0.75);
  float up = random(20,170);
  
  int repetition = floor(random(1,2.5))*1+0;
  
  void show(){
    for(int i=0;i<m;i++){
      float offset = (1000+m*factor*pow(1.0*i/m,1.0) + offset0 - repetition*t)%1;
      textSize(floor(sz));
      //println(offset);
      float val = 255*pow(offset,2.5);
      fill(val,255,val,val);
      float y = map(i,0,m,-100,height+100) + up*offset;
      
      int ch = digitarray[i].res(t);
      
      char[] chars = Character.toChars(700+ch);
      
      String chs = new String(chars);
      
      text(chs, x, y);
    }
  }
}

int n = 50;

Column[] array = new Column[n];

void setup(){
  size(600,600,P3D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  for(int i=0;i<n;i++){
    array[i] = new Column(i);
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