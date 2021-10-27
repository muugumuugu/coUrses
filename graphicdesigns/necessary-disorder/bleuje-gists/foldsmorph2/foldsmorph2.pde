void setup() {
  size(500, 500);
  background(0);
  smooth(8);
  noFill();
  stroke(235, 15);
  strokeWeight(0.9);
 
  x1=y1=-3;
  x2=y2=3;
  y=y1;
  step=(x2-x1)/(2.321*width);
}

float x1, y1, x2, y2; // function domain
float step; // step within domain
float y;
 
int numFrames = 100;
 
void draw() {
  background(0);
  
  float t = 1.0*(frameCount-1)%numFrames/numFrames;
  
  for (float y=y1; y<=y2; y+=step) { // draw 20 lines at once
    for (float x=x1; x<=x2; x+=step) {
      drawVariation(x, y, t);
    }
  }
  
  println(t);
  saveFrame("frame####.png");
  if(frameCount==numFrames){
    println("finished");
    stop();
  }
}

float ease(float p, float g) {
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

float easing_coeff = 1.85;

float circle_coeff = 0.3;
 
void drawVariation(float x, float y,float t) {
  PVector v = new PVector(x,y);
  float amount = 1.0;
 
  PVector v1 = hyperbolic(v,amount);
  PVector v2 = julia(v,amount);
  PVector v3 = pdj(v,1.5*amount);
  
  PVector res;
  if(t<1.0/3){
    float tt = ease(3*t,easing_coeff);
     res = new PVector(lerp(lerp(v1.x,v2.x,tt),v3.x,-circle_coeff*sin(PI*tt)),lerp(lerp(v1.y,v2.y,tt),v3.y,-circle_coeff*sin(PI*tt)));
  } else if(t<2.0/3) {
    float tt = ease(3*t-1,easing_coeff);
    res = new PVector(lerp(lerp(v2.x,v3.x,tt),v1.x,-circle_coeff*sin(PI*tt)),lerp(lerp(v2.y,v3.y,tt),v1.y,-circle_coeff*sin(PI*tt)));
  } else {
    float tt = ease(3*t-2,easing_coeff);
    res = new PVector(lerp(lerp(v3.x,v1.x,tt),v2.x,-circle_coeff*sin(PI*tt)),lerp(lerp(v3.y,v1.y,tt),v2.y,-circle_coeff*sin(PI*tt)));
  }
 
  float xx = map(res.x+0.003*randomGaussian(), x1, x2, 20, width-20);
  float yy = map(res.y+0.003*randomGaussian(), y1, y2, 20, height-20);
  point(xx, yy);
}

PVector hyperbolic(PVector v, float amount) {
  float r = v.mag() + 1.0e-10;
  float theta = atan2(v.x, v.y);
  float x = amount * sin(theta) / r;
  float y = amount * cos(theta) * r;
  return new PVector(x, y);
}
 
PVector sinusoidal(PVector v, float amount) {
  return new PVector(amount * sin(v.x), amount * sin(v.y));
}

// parametrization P={pdj_a,pdj_b,pdj_c,pdj_d}
/*
float pdj_a = 0.1;
float pdj_b = 1.9;
float pdj_c = -0.8;
float pdj_d = -1.2;*/
float pdj_a = 0.1;
float pdj_b = 0.9;
float pdj_c = -0.4;
float pdj_d = -0.6;
PVector pdj(PVector v, float amount) {
  return new PVector( amount * (sin(pdj_a * v.y) - cos(pdj_b * v.x)),
                      amount * (sin(pdj_c * v.x) - cos(pdj_d * v.y)));
}

PVector julia(PVector v, float amount) {
  float r = amount * sqrt(v.mag());
  float theta = 0.5 * atan2(v.x, v.y) + (int)(2.0 * random(0, 1)) * PI;
  float x = r * cos(theta);
  float y = r * sin(theta);
  return new PVector(x, y);
}