// Plane folding
// Copyright by tsulej 2014
// click mouse to change drawing
float step ;
Folds f1,f2;

int[] folds1 = new int[8]; 
int[] folds2 = new int[8];
 
public void setup() {
  size(600,600,P2D);
  
  colorMode(RGB,255);
  
  noStroke();
  step = 0.2f*0.25f / (2.0f*width);
  textAlign(LEFT,TOP);
  initialize();
} 

float start;
boolean go = true;
boolean dosinusoidal1 = true;
boolean dosinusoidal2 = true;

int npatch = 7;

class Patch{
  float cx = random(-2,2);
  float cy = random(-2,2);
  
  float lx = 0.57*pow(random(0,1),2.0);
  //float ly = 0.17*pow(random(0,1),2.0);
  float ly = lx;
  
  int m = floor(random(50,75));
  
  void show(float par){
    for(int i=0;i<m;i++){
      for(int j=0;j<m;j++){
        float xx = map(i,0,m,cx-lx,cx+lx);
        float yy = map(j,0,m,cy-ly,cy+ly);
        
        drawme(xx,yy,par);
      }
    }
  }
}

Patch[] parray = new Patch[npatch];

public void mouseClicked() {
  go = false;
  initialize();
  go = true;
}

int fnumber1, fnumber2;
int nameSeed;
int iCurve = 0;

float alphaMax = 3;

float SIGMA, RR, GG, BB;

int curPatch = 0;

public void initialize() {
  for(int i=0;i<npatch;i++){
    parray[i] = new Patch();
  }
  f1 = new Folds();
  f2 = new Folds();
  iCurve = 0;
  iFrame = 0;
  curPatch = 0;
  SIGMA = random(5,25);
  RR = random(100,300);
  GG = random(100,300);
  BB = random(100,300);
  //RR = random(-50,200);
  //GG = random(-50,200);
  //BB = random(-50,200);
  fill(255,30);
  stroke(255,alphaMax);
  background(0);
  nameSeed = PApplet.parseInt(random(10000000));
  dosinusoidal1 = random(0,1)<0.5f?true:false;
  dosinusoidal2 = random(0,1)<0.5f?true:false;
  float nb = 6.99f;
  fnumber1 = (int)floor(random(3,nb));
  for(int i=0;i<fnumber1;i++) {
      folds1[i]=(int)floor(random(1,21.99f));
  }
  fnumber2 = (int)floor(random(3,nb));
  for(int i=0;i<fnumber2;i++) {
      folds2[i]=(int)floor(random(1,21.99f));
  }
  println(constructName());
}

public String constructName() {
    String r1 = "point -> ";
    for(int n = fnumber1-1;n>=0;n--) {
      r1 += f1.getNamebyNo(folds1[n]) + " -> ";
    }
    if(dosinusoidal1) r1+= "sinusoidal -> ";
    
    String r2 = "point -> ";
    for(int n = fnumber2-1;n>=0;n--) {
      r2 += f2.getNamebyNo(folds2[n]) + " -> ";
    }
    if(dosinusoidal1) r2+= "sinusoidal -> ";
    
    return r1 + "point" + " and " + r2 + "point";
}

int numberOfCurves = 25;
int iFrame = 0;
int numFrames = 45;



public void draw() { 

  if(go) {
    if(iCurve == 0){
      background(0);
      //randomSeed(1);
    }
    
    float t = 1.0f*iFrame/numFrames;
    float j = map(iCurve+t,0,numberOfCurves,-3.0f,3.0f);
    //float s = alphaMax*pow(sin(PI*(iCurve+t)/numberOfCurves),2.0);
    float s = alphaMax;
    
    float rr = RR + SIGMA*randomGaussian();
    float gg = GG + SIGMA*randomGaussian();
    float bb = BB + SIGMA*randomGaussian();
    
    stroke(255,s);
    //stroke(rr,gg,bb,s);
    
    /*
    for(float i=-3.0f;i<=3.0f;i+=step)
      drawme(i,j);
    */
    
    int K = 30;
    
    for(int k=0;k<K;k++){
      randomSeed(1);
      float par = map(k+map(iFrame,0,numFrames,0,1),0,K,0,1);
      parray[curPatch].show(par);
    }
    
    curPatch++;
    iCurve++;
    
    //println(iCurve+"/"+numberOfCurves);
    println("patch ", iCurve+"/"+npatch);
    
    //println(j);

    if(curPatch == npatch) {
      iFrame++;
      iCurve = 0;
      curPatch = 0;
      
      println("frame ",iFrame+"/"+numFrames);
     
       //saveFrame("image"+nameSeed+".png");
       //saveFrame("fr###.gif");
       saveFrame("fr"+String.format("%03d", iFrame-1)+".gif");
       
       //if(iFrame < numFrames) background(0);
     
     if(iFrame == numFrames){
       go = false;
       println("finished");
     }
    }
  }
}


public void drawme(float x, float y, float par) {
  PVector p = new PVector(x,y);
  
  PVector n1 = new PVector(0,0);

  switch(fnumber1) { 
    case 1:
      n1.add( f1.getFoldbyNo(folds1[0],p,1) );
      break;
    case 2:
      n1.add( f1.getFoldbyNo(folds1[0], f1.getFoldbyNo(folds1[1],p,1), 1) );  
      break;
    case 3:
     n1.add( f1.getFoldbyNo(folds1[0], f1.getFoldbyNo(folds1[1],f1.getFoldbyNo(folds1[2],p,1),1), 1) );  
     break;
    case 4:
     n1.add( f1.getFoldbyNo(folds1[0], f1.getFoldbyNo(folds1[1],f1.getFoldbyNo(folds1[2],f1.getFoldbyNo(folds1[3],p,1),1),1), 1) );  
     break;
    case 5:
      n1.add( f1.getFoldbyNo(folds1[0], f1.getFoldbyNo(folds1[1],f1.getFoldbyNo(folds1[2],f1.getFoldbyNo(folds1[3],f1.getFoldbyNo(folds1[4],p,1),1),1),1), 1) );
      break;
    case 6:
      n1.add( f1.getFoldbyNo(folds1[0], f1.getFoldbyNo(folds1[1],f1.getFoldbyNo(folds1[2],f1.getFoldbyNo(folds1[3],f1.getFoldbyNo(folds1[4],f1.getFoldbyNo(folds1[5],p,1),1),1),1),1), 1) );  
      break;
    case 7:
     n1.add( f1.getFoldbyNo(folds1[0], f1.getFoldbyNo(folds1[1],f1.getFoldbyNo(folds1[2],f1.getFoldbyNo(folds1[3],f1.getFoldbyNo(folds1[4],f1.getFoldbyNo(folds1[5],f1.getFoldbyNo(folds1[6],p,1),1),1),1),1),1), 1) );    
     break;
    case 8:
     n1.add( f1.getFoldbyNo(folds1[0], f1.getFoldbyNo(folds1[1],f1.getFoldbyNo(folds1[2],f1.getFoldbyNo(folds1[3],f1.getFoldbyNo(folds1[4],f1.getFoldbyNo(folds1[5],f1.getFoldbyNo(folds1[6],f1.getFoldbyNo(folds1[7],p,1),1),1),1),1),1),1), 1) );  
     break;
  }
  
  //n1.add( f1.realgaussian(p,0.00005)); 
  if(dosinusoidal1)
    n1 = f1.sinusoidal(n1,1);
    
    
    PVector n2 = new PVector(0,0);

  switch(fnumber2) { 
    case 1:
      n2.add( f2.getFoldbyNo(folds2[0],p,1) );
      break;
    case 2:
      n2.add( f2.getFoldbyNo(folds2[0], f2.getFoldbyNo(folds2[1],p,1), 1) );  
      break;
    case 3:
     n2.add( f2.getFoldbyNo(folds2[0], f2.getFoldbyNo(folds2[1],f2.getFoldbyNo(folds2[2],p,1),1), 1) );  
     break;
    case 4:
     n2.add( f2.getFoldbyNo(folds2[0], f2.getFoldbyNo(folds2[1],f2.getFoldbyNo(folds2[2],f2.getFoldbyNo(folds2[3],p,1),1),1), 1) );  
     break;
    case 5:
      n2.add( f2.getFoldbyNo(folds2[0], f2.getFoldbyNo(folds2[1],f2.getFoldbyNo(folds2[2],f2.getFoldbyNo(folds2[3],f2.getFoldbyNo(folds2[4],p,1),1),1),1), 1) );
      break;
    case 6:
      n2.add( f2.getFoldbyNo(folds2[0], f2.getFoldbyNo(folds2[1],f2.getFoldbyNo(folds2[2],f2.getFoldbyNo(folds2[3],f2.getFoldbyNo(folds2[4],f2.getFoldbyNo(folds2[5],p,1),1),1),1),1), 1) );  
      break;
    case 7:
     n2.add( f2.getFoldbyNo(folds2[0], f2.getFoldbyNo(folds2[1],f2.getFoldbyNo(folds2[2],f2.getFoldbyNo(folds2[3],f2.getFoldbyNo(folds2[4],f2.getFoldbyNo(folds2[5],f2.getFoldbyNo(folds2[6],p,1),1),1),1),1),1), 1) );    
     break;
    case 8:
     n2.add( f2.getFoldbyNo(folds2[0], f2.getFoldbyNo(folds2[1],f2.getFoldbyNo(folds2[2],f2.getFoldbyNo(folds2[3],f2.getFoldbyNo(folds2[4],f2.getFoldbyNo(folds2[5],f2.getFoldbyNo(folds2[6],f2.getFoldbyNo(folds2[7],p,1),1),1),1),1),1),1), 1) );  
     break;
  }
  
  //n2.add( f2.realgaussian(p,0.00005)); 
  if(dosinusoidal2)
    n2 = f2.sinusoidal(n2,1);
    
  //f1.draw(n1);
  draw3D(n1,n2,par);
  //f.draw(p);
}
 
float nextGaussian = 0;
boolean haveNextGaussian = false;

/*
float randomGaussian() {
  if(haveNextGaussian) {
    haveNextGaussian = false;
    return nextGaussian;
  } else {
    float v1,v2,s;
    do {
      v1 = 2 * random() - 1;
      v2 = 2 * random() - 1;
      s = v1 * v1 + v2 * v2;
    } while (s >=1 || s == 0);
     
    float mult = sqrt(-2 * log(s) / s);
    nextGaussian = v2 * mult;
    haveNextGaussian = true;
    return v1 * mult;
  }
}*/

class Folds {
  int screenl, screenr;
  int middle;
  float ymin;
  float ymax;
  float xmin;
  float xmax;
  boolean crop = true;
  
  Folds() {
    float middle = width/2;
    float size = 0.95f * middle;
    screenl = (int)(-size + middle);
    screenr =(int)(size + middle);
    ymin = -3.5f;
    ymax = 3.5f;
    xmin = -3.5f;
    xmax = 3.5f;
    
    precalc();
  }
  
  public PVector getFoldbyNo(int no, PVector p, float weight) {
      switch(no) {
          case 1: return sinusoidal(p,weight); 
          case 2: return butterfly(p,weight); 
          case 3: return wedgejulia(p,weight);
          case 4: return rotate(p,weight); 
          case 5: return cross(p,weight); 
          case 6: return pdj(p,weight); 
          case 7: return fan2(p,weight); 
          case 8: return rings2(p,weight); 
          case 9: return heart(p,weight); 
          case 10: return ex(p,weight); 
          case 11: return popcorn(p,weight);
          case 12: return waves(p,weight); 
          case 13: return polar(p,weight); 
          case 14: return horseshoe(p,weight); 
          case 15: return curl(p,weight); 
          case 16: return scry(p,weight);
          case 17: return rectangles(p,weight);
          case 18: return julian(p,weight);
          case 19: return juliascope(p,weight);
          case 20: return twintrian(p,weight);
          case 21: return lines(p,weight);
          default: return p;
      }
  }
  
  public String getNamebyNo(int no) {
      switch(no) {
          case 1: return "sinusoidal"; 
          case 2: return "butterfly"; 
          case 3: return "wedgejulia";
          case 4: return "rotate"; 
          case 5: return "cross"; 
          case 6: return "pdj"; 
          case 7: return "fan2"; 
          case 8: return "rings2"; 
          case 9: return "heart"; 
          case 10: return "ex"; 
          case 11: return "popcorn";
          case 12: return "waves"; 
          case 13: return "polar"; 
          case 14: return "horseshoe"; 
          case 15: return "curl"; 
          case 16: return "scry";
          case 17: return "rectangles";
          case 18: return "julian";
          case 19: return "juliascope";
          case 20: return "twintrian";
          case 21: return "lines";
          default: return "none";
      }
  }
  
   float lines_scale = random(0.03f,0.4f);
   boolean lines_squared = random(0,1) < 0.5f ? true : false;
  
   public PVector lines(PVector p, float weight) {
    float r;
    if(lines_squared) r=0.5f*sq(randomGaussian());
      else r=0.25f*randomGaussian();
    float y = lines_scale * (floor(p.y/lines_scale) - 0.5f + r);
    
    return new PVector(weight * p.x, weight * y);      
  }
  
    float twintrian_weight = random(0.4f,1);
    
  public PVector twintrian(PVector p, float weight) {
    float a = random(0,1) * twintrian_weight * p.mag();
    float sa = sin(a);
    float cla = cos(a) + log(sq(sa));
    if(cla<-30) cla = -30;
    
    return new PVector(weight * 0.8f * p.x * cla, weight * 0.8f * p.x * (cla - sa * PI));
  } 
    
  float julian_power = random(0,1)<0.5f? (int)random(4,10) : -(int)random(4,10);
  float julian_dist = random(0.5f,3.0f);
  float julian_cpower, julian_abspower;
  
  public PVector julian(PVector p, float weight) {
    float a = (atan2(p.y,p.x) + TWO_PI * floor(julian_abspower * random(0,1)))/julian_power;
    float r = weight * 2.0f * pow(sq(p.x)+sq(p.y),julian_cpower);
    return new PVector(r*cos(a),r*sin(a));
  }

  float juliascope_power = random(0,1)<0.5f? (int)random(4,10) : -(int)random(4,10);
  float juliascope_dist = random(0.5f,2.0f);
  float juliascope_cpower, juliascope_abspower;
  
  public PVector juliascope(PVector p, float weight) {
    int rnd = (int)(juliascope_abspower * random(0,1));
    float a;
    if(rnd % 2 == 0)
      a = (2 * PI * rnd +atan2(p.y,p.x))/juliascope_power;
     else
      a = (2 * PI * rnd -atan2(p.y,p.x))/juliascope_power;
    float r = weight * 2.0f * pow(sq(p.x)+sq(p.y),juliascope_cpower);
    return new PVector(r*cos(a),r*sin(a));
  }

  
    float rectangles_x = random(0.1f,1);
  float rectangles_y = random(0.1f,1);
  
  public PVector rectangles(PVector p, float weight) {
    float x = weight * ((2 * floor(p.x/rectangles_x) + 1)* rectangles_x - p.x);
    float y = weight * ((2 * floor(p.y/rectangles_y) + 1)* rectangles_y - p.y);
    
    return new PVector(x,y);
  }
  
    float scry_weight = random(0.4f,1);

  public PVector scry(PVector p, float weight) {
    float r2 = sq(p.x)*sq(p.y);
    float r = 3.0f / (p.mag() * (r2 + 1.0f/scry_weight));
    float x = weight * r * p.x;
    float y = weight * r * p.y;
    return new PVector(x,y);
  }
  
    float fan2_x = random(-1,1);
  float fan2_y = random(2,7);
  float fan2_dx, fan2_dx2;
  
  public PVector fan2(PVector p, float weight) {
    float r = weight * 0.8f * p.mag();
    float theta = atan2(p.x,p.y);
    float t = theta + fan2_y - floor((theta + fan2_y) / fan2_dx) * fan2_dx;
    float ang;
    if(t > fan2_dx2)
      ang = theta - fan2_dx2;
     else
      ang = theta + fan2_dx2;
    
    return new PVector(r * sin(ang), r * cos(ang));
  }
  
    float pdj_a = random(-3.0f,3.0f);
  float pdj_b = random(-3.0f,3.0f);
  float pdj_c = random(-3.0f,3.0f);
  float pdj_d = random(-3.0f,3.0f);
  
  public PVector pdj(PVector p, float weight) {
    return new PVector( weight * 1.5f * (sin(pdj_a * p.y) - cos(pdj_b * p.x)),
                        weight * 1.5f * (sin(pdj_c * p.x) - cos(pdj_d * p.y)));
  }
  
  public PVector sinusoidal(PVector p, float weight) {
      return new PVector(weight * 3.0f * sin(p.x),3.0f * sin(p.y));
  }
  
  public PVector butterfly(PVector p, float weight) {
      float y2 = 2.0f * p.y;
      float r = weight * 1.3029400317411197908970256609023f * sqrt(abs(p.y * p.x) / (1e-10f + sq(p.x) + sq(y2)));
      return new PVector(r * p.x,r * y2); 
  }
  
  int wedgejulia_count = (int)random(2,7);
  float wedgejulia_angle =random(-3,3);
  int wedgejulia_power = random(0,1)<0.5f?(int)random(2,7):-(int)random(2,7);
  float wedgejulia_dist = random(1,4);
  float wedgejulia_cf, wedgejulia_cn, wedgejulia_rN;
  
  public PVector wedgejulia(PVector p, float weight) {
    float r = weight * pow(sq(p.x)+sq(p.y),wedgejulia_cn);
    int t_rnd = (int) ((wedgejulia_rN) * random(0,1));
    float a = (atan2(p.y,p.x) + TWO_PI * t_rnd) / wedgejulia_power;
    float c = floor((wedgejulia_count * a + PI) * (1/PI) * 0.5f);
    a = a * wedgejulia_cf + c * wedgejulia_angle;
    
    return new PVector(r * cos(a), r * sin(a));
  }
  
  public PVector rotate(PVector p, float angle) {
    float ca = cos(angle);
    float sa = sin(angle);
    return new PVector(ca * p.x - sa * p.y, sa * p.x + ca * p.y);
  }
  
  public PVector realgaussian(PVector p, float weight) {
    float a = TWO_PI * random(0,1);
    float r = weight * 3.0f * randomGaussian();
    return new PVector(r*cos(a),r*sin(a));
  }
  
  public PVector cross(PVector p, float weight) {
    float r = sqrt(1.0f / (sq(sq(p.x)-sq(p.y)))+1e-10f);
    return new PVector(weight * 0.8f * p.x * r,weight * 0.8f * p.y * r);
  }
  
  float curl_c1 = random(0.1f,0.7f);
  float curl_c2 = random(0.1f,0.7f);
  
  public PVector curl(PVector p, float weight) {
    float re = 1 + curl_c1 * p.x + curl_c2 * (sq(p.x)-sq(p.y));
    float im = curl_c1 * p.y + curl_c2 * 2 * p.x * p.y;
    float r = weight / (re * re + im * im);
    
    return new PVector(r * (p.x * re + p.y * im),r * (p.y * re - p.x * im));
  }
  
  float rings2_val = random(0.1f,1.2f);
  float rings2_val2; 
  
  public PVector rings2(PVector p, float weight) {
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    float d = weight*(r - 2.0f * rings2_val2 * floor( (r+rings2_val2)/(2.0f * rings2_val2)) + r * (1.0f - rings2_val2) );
    //float d = weight*(2.0 - rings2_val2 * ((int) ((r / rings2_val2 + 1) / 2) * 2 / r + 1));
    return new PVector(d*sin(theta),d*cos(theta));
  }  
  
  public PVector heart(PVector p, float weight) {
    float r = p.mag();
    float theta = atan2(p.y,p.x);
    float sinr = sin(r * theta);
    float cosr = cos(r * theta);
     
    return new PVector(weight * r * sinr, -r * weight * cosr); 
  }
  
   public PVector ex(PVector p, float weight) {
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    float xsin = sin(theta + r);
    float ycos = cos(theta - r);
    float x = weight * 0.7f * r * xsin * xsin * xsin;
    float y = weight * 0.7f * r * ycos * ycos * ycos;
    return new PVector(x+y,x-y);
  }
  
  float popcorn_c = random(-0.8f,0.8f);
  float popcorn_f = random(-0.8f,0.8f);
  
  public PVector popcorn(PVector p, float weight) {
    float x = p.x + popcorn_c * sin(tan(3.0f * p.y));
    float y = p.y + popcorn_f * sin(tan(3.0f * p.x));
        
    return new PVector(weight * 0.85f * x, weight * 0.85f * y);  
  }
  
  float waves_b = random(-0.8f,0.8f);
  float waves_e = random(-0.8f,0.8f);
  float waves_c = random(-0.8f,0.8f);
  float waves_f = random(-0.8f,0.8f);
  
  public PVector waves(PVector p, float weight) {
    float x = p.x + waves_b * sin(p.y * (1.0f / (waves_c * waves_c) ));
    float y = p.y + waves_e * sin(p.x * (1.0f / (waves_f * waves_f) ));
        
    return new PVector(weight * x, weight * y);  
  }
  
  public PVector horseshoe(PVector p, float weight) {
    float r = weight / (1.25f * (p.mag() + 1e-10f));
    float x = r * ((p.x - p.y) * (p.x + p.y));
    float y = r * 2.0f * p.x * p.y;
    return new PVector(x,y);
  }
  
  public PVector polar(PVector p, float weight) {
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    float x = theta / PI;
    float y = r - 2.0f;
    return new PVector(weight * 1.5f * x, weight * 1.5f * y);
  }
  
  public void draw(PVector p) {
    float i = map(p.x,xmin,xmax,screenl,screenr) + 0.5f*randomGaussian();
    float j = map(p.y,ymin,ymax,screenl,screenr) + 0.5f*randomGaussian();
    //ellipse(i,j,0.8,0.8);
    
    //ellipse(i,j,random(13)+0.75,random(13)+0.75);
    point(i,j);
  }
  
  public void precalc() {
    wedgejulia_cf = 1.0f - 0.5f / PI * wedgejulia_angle * wedgejulia_count;
    wedgejulia_cn = wedgejulia_dist / wedgejulia_power / 2.0f;
    wedgejulia_rN = abs(wedgejulia_power);
    rings2_val2 = rings2_val * rings2_val;
    fan2_dx = PI * fan2_x * fan2_x + 1e-10f;
    fan2_dx2 = 0.5f * fan2_dx;
    julian_cpower = julian_dist/julian_power/2.0f;
    julian_abspower = abs(julian_power);
    juliascope_cpower = juliascope_dist/juliascope_power/2.0f;
    juliascope_abspower = abs(juliascope_power);
  }
}

public void draw3D(PVector p1, PVector p2, float par) {
    float middle = width/2;
    float size = 0.95f * middle;
    float screenl = (int)(-size + middle);
    float screenr =(int)(size + middle);
    float ymin = -3.5f;
    float ymax = 3.5f;
    float xmin = -3.5f;
    float xmax = 3.5f;
    
    PVector vec3d = new PVector(p1.x,p1.y+p2.x,p2.y);
    //PVector vec3d = new PVector(p1.x,p2.x,p1.y+p2.y);
    //vec3d.add(new PVector(0,0,map(iFrame,0,numFrames,0,1)));
    vec3d.add(new PVector(0,0,20*par-8));
    //vec3d.mult(par);
    //PVector vec3d = new PVector(p1.x,p2.x,0.25*PVector.angleBetween(p1,p2));
    //PVector vec3d = new PVector(p1.x+p2.y,p1.y+p2.x,PVector.angleBetween(p1,p2));
    //PVector vec3d = new PVector(p1.x+p2.y,p1.y+p2.x,sin(p1.heading()+p2.heading())-1.1);
    
    if(-vec3d.z+zdist>0){
    
      PVector proj = project(vec3d);
      
      float xx = proj.x + 0.5f*randomGaussian();
      float yy = proj.y + 0.5f*randomGaussian();

      strokeWeight(random(0,1)*2.5f*proj.z);
      stroke(255,30*sin(par));
      
      point(xx+width/2,yy+height/2);
    }
  }
  
float zdist = 0.45f;
  
public PVector project(PVector vec){
  float x = 60*vec.x/(-vec.z+zdist);
  float y = 60*vec.y/(-vec.z+zdist);
  return new PVector(x,y,1/(-vec.z+zdist));
}