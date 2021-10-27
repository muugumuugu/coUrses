// Plane folding
// Copyright by tsulej 2014
// click mouse to change drawing
float step ;
Folds f1,f2;

int[] folds1 = new int[8]; 
int[] folds2 = new int[8];
 
void setup() {
  size(800, 800);
  colorMode(RGB,255);
  smooth();
  noStroke();
  step = 0.5*0.25 / (2.0*width);
  textAlign(LEFT,TOP);
  initialize();
} 

float start;
boolean go = true;
boolean dosinusoidal1 = true;
boolean dosinusoidal2 = true;

void mouseClicked() {
  go = false;
  initialize();
  go = true;
}

int fnumber1, fnumber2;
int nameSeed;
int iCurve = 0;

float alphaMax = 5;

void initialize() {
  f1 = new Folds();
  f2 = new Folds();
  iCurve = 0;
  iFrame = 0;
  fill(255,30);
  stroke(255,alphaMax);
  background(0);
  nameSeed = int(random(10000000));
  dosinusoidal1 = random(0,1)<0.5?true:false;
  dosinusoidal2 = random(0,1)<0.5?true:false;
  float nb = 4.99;
  fnumber1 = (int)floor(random(3,nb));
  for(int i=0;i<fnumber1;i++) {
      folds1[i]=(int)floor(random(1,21.99));
  }
  fnumber2 = (int)floor(random(3,nb));
  for(int i=0;i<fnumber2;i++) {
      folds2[i]=(int)floor(random(1,21.99));
  }
  println(constructName());
}

String constructName() {
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

int numberOfCurves = 50;
int iFrame = 0;
int numFrames = 30;



void draw() { 

  if(go) {
    float t = 1.0*iFrame/numFrames;
    float j = map(iCurve+t,0,numberOfCurves,-3.0,3.0);
    //float s = alphaMax*pow(sin(PI*(iCurve+t)/numberOfCurves),2.0);
    float s = alphaMax;
    stroke(255,s);
    for(float i=-3.0;i<=3.0;i+=step)
      drawme(i,j);
    
    iCurve++;
    
    println(iCurve+"/"+numberOfCurves);
    
    //println(j);

    if(iCurve == numberOfCurves) {
      iFrame++;
      iCurve = 0;
      
      //println(iFrame+"/"+numFrames);
     
       saveFrame("image"+nameSeed+".png");
       
       //if(iFrame < numFrames) background(0);
     
     if(true){
       go = false;
       println("finished");
     }
    }
  }
}


void drawme(float x, float y) {
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
  draw3D(n1,n2);
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
    float size = 0.95 * middle;
    screenl = (int)(-size + middle);
    screenr =(int)(size + middle);
    ymin = -3.5;
    ymax = 3.5;
    xmin = -3.5;
    xmax = 3.5;
    
    precalc();
  }
  
  PVector getFoldbyNo(int no, PVector p, float weight) {
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
  
  String getNamebyNo(int no) {
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
  
   float lines_scale = random(0.03,0.4);
   boolean lines_squared = random(0,1) < 0.5 ? true : false;
  
   PVector lines(PVector p, float weight) {
    float r;
    if(lines_squared) r=0.5*sq(randomGaussian());
      else r=0.25*randomGaussian();
    float y = lines_scale * (floor(p.y/lines_scale) - 0.5 + r);
    
    return new PVector(weight * p.x, weight * y);      
  }
  
    float twintrian_weight = random(0.4,1);
    
  PVector twintrian(PVector p, float weight) {
    float a = random(0,1) * twintrian_weight * p.mag();
    float sa = sin(a);
    float cla = cos(a) + log(sq(sa));
    if(cla<-30) cla = -30;
    
    return new PVector(weight * 0.8 * p.x * cla, weight * 0.8 * p.x * (cla - sa * PI));
  } 
    
  float julian_power = random(0,1)<0.5? (int)random(4,10) : -(int)random(4,10);
  float julian_dist = random(0.5,3.0);
  float julian_cpower, julian_abspower;
  
  PVector julian(PVector p, float weight) {
    float a = (atan2(p.y,p.x) + TWO_PI * floor(julian_abspower * random(0,1)))/julian_power;
    float r = weight * 2.0 * pow(sq(p.x)+sq(p.y),julian_cpower);
    return new PVector(r*cos(a),r*sin(a));
  }

  float juliascope_power = random(0,1)<0.5? (int)random(4,10) : -(int)random(4,10);
  float juliascope_dist = random(0.5,2.0);
  float juliascope_cpower, juliascope_abspower;
  
  PVector juliascope(PVector p, float weight) {
    int rnd = (int)(juliascope_abspower * random(0,1));
    float a;
    if(rnd % 2 == 0)
      a = (2 * PI * rnd +atan2(p.y,p.x))/juliascope_power;
     else
      a = (2 * PI * rnd -atan2(p.y,p.x))/juliascope_power;
    float r = weight * 2.0 * pow(sq(p.x)+sq(p.y),juliascope_cpower);
    return new PVector(r*cos(a),r*sin(a));
  }

  
    float rectangles_x = random(0.1,1);
  float rectangles_y = random(0.1,1);
  
  PVector rectangles(PVector p, float weight) {
    float x = weight * ((2 * floor(p.x/rectangles_x) + 1)* rectangles_x - p.x);
    float y = weight * ((2 * floor(p.y/rectangles_y) + 1)* rectangles_y - p.y);
    
    return new PVector(x,y);
  }
  
    float scry_weight = random(0.4,1);

  PVector scry(PVector p, float weight) {
    float r2 = sq(p.x)*sq(p.y);
    float r = 3.0 / (p.mag() * (r2 + 1.0/scry_weight));
    float x = weight * r * p.x;
    float y = weight * r * p.y;
    return new PVector(x,y);
  }
  
    float fan2_x = random(-1,1);
  float fan2_y = random(2,7);
  float fan2_dx, fan2_dx2;
  
  PVector fan2(PVector p, float weight) {
    float r = weight * 0.8 * p.mag();
    float theta = atan2(p.x,p.y);
    float t = theta + fan2_y - floor((theta + fan2_y) / fan2_dx) * fan2_dx;
    float ang;
    if(t > fan2_dx2)
      ang = theta - fan2_dx2;
     else
      ang = theta + fan2_dx2;
    
    return new PVector(r * sin(ang), r * cos(ang));
  }
  
    float pdj_a = random(-3.0,3.0);
  float pdj_b = random(-3.0,3.0);
  float pdj_c = random(-3.0,3.0);
  float pdj_d = random(-3.0,3.0);
  
  PVector pdj(PVector p, float weight) {
    return new PVector( weight * 1.5 * (sin(pdj_a * p.y) - cos(pdj_b * p.x)),
                        weight * 1.5 * (sin(pdj_c * p.x) - cos(pdj_d * p.y)));
  }
  
  PVector sinusoidal(PVector p, float weight) {
      return new PVector(weight * 3.0 * sin(p.x),3.0 * sin(p.y));
  }
  
  PVector butterfly(PVector p, float weight) {
      float y2 = 2.0 * p.y;
      float r = weight * 1.3029400317411197908970256609023 * sqrt(abs(p.y * p.x) / (1e-10 + sq(p.x) + sq(y2)));
      return new PVector(r * p.x,r * y2); 
  }
  
  int wedgejulia_count = (int)random(2,7);
  float wedgejulia_angle =random(-3,3);
  int wedgejulia_power = random(0,1)<0.5?(int)random(2,7):-(int)random(2,7);
  float wedgejulia_dist = random(1,4);
  float wedgejulia_cf, wedgejulia_cn, wedgejulia_rN;
  
  PVector wedgejulia(PVector p, float weight) {
    float r = weight * pow(sq(p.x)+sq(p.y),wedgejulia_cn);
    int t_rnd = (int) ((wedgejulia_rN) * random(0,1));
    float a = (atan2(p.y,p.x) + TWO_PI * t_rnd) / wedgejulia_power;
    float c = floor((wedgejulia_count * a + PI) * (1/PI) * 0.5);
    a = a * wedgejulia_cf + c * wedgejulia_angle;
    
    return new PVector(r * cos(a), r * sin(a));
  }
  
  PVector rotate(PVector p, float angle) {
    float ca = cos(angle);
    float sa = sin(angle);
    return new PVector(ca * p.x - sa * p.y, sa * p.x + ca * p.y);
  }
  
  PVector realgaussian(PVector p, float weight) {
    float a = TWO_PI * random(0,1);
    float r = weight * 3.0 * randomGaussian();
    return new PVector(r*cos(a),r*sin(a));
  }
  
  PVector cross(PVector p, float weight) {
    float r = sqrt(1.0 / (sq(sq(p.x)-sq(p.y)))+1e-10);
    return new PVector(weight * 0.8 * p.x * r,weight * 0.8 * p.y * r);
  }
  
  float curl_c1 = random(0.1,0.7);
  float curl_c2 = random(0.1,0.7);
  
  PVector curl(PVector p, float weight) {
    float re = 1 + curl_c1 * p.x + curl_c2 * (sq(p.x)-sq(p.y));
    float im = curl_c1 * p.y + curl_c2 * 2 * p.x * p.y;
    float r = weight / (re * re + im * im);
    
    return new PVector(r * (p.x * re + p.y * im),r * (p.y * re - p.x * im));
  }
  
  float rings2_val = random(0.1,1.2);
  float rings2_val2; 
  
  PVector rings2(PVector p, float weight) {
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    float d = weight*(r - 2.0 * rings2_val2 * floor( (r+rings2_val2)/(2.0 * rings2_val2)) + r * (1.0 - rings2_val2) );
    //float d = weight*(2.0 - rings2_val2 * ((int) ((r / rings2_val2 + 1) / 2) * 2 / r + 1));
    return new PVector(d*sin(theta),d*cos(theta));
  }  
  
  PVector heart(PVector p, float weight) {
    float r = p.mag();
    float theta = atan2(p.y,p.x);
    float sinr = sin(r * theta);
    float cosr = cos(r * theta);
     
    return new PVector(weight * r * sinr, -r * weight * cosr); 
  }
  
   PVector ex(PVector p, float weight) {
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    float xsin = sin(theta + r);
    float ycos = cos(theta - r);
    float x = weight * 0.7 * r * xsin * xsin * xsin;
    float y = weight * 0.7 * r * ycos * ycos * ycos;
    return new PVector(x+y,x-y);
  }
  
  float popcorn_c = random(-0.8,0.8);
  float popcorn_f = random(-0.8,0.8);
  
  PVector popcorn(PVector p, float weight) {
    float x = p.x + popcorn_c * sin(tan(3.0 * p.y));
    float y = p.y + popcorn_f * sin(tan(3.0 * p.x));
        
    return new PVector(weight * 0.85 * x, weight * 0.85 * y);  
  }
  
  float waves_b = random(-0.8,0.8);
  float waves_e = random(-0.8,0.8);
  float waves_c = random(-0.8,0.8);
  float waves_f = random(-0.8,0.8);
  
  PVector waves(PVector p, float weight) {
    float x = p.x + waves_b * sin(p.y * (1.0 / (waves_c * waves_c) ));
    float y = p.y + waves_e * sin(p.x * (1.0 / (waves_f * waves_f) ));
        
    return new PVector(weight * x, weight * y);  
  }
  
  PVector horseshoe(PVector p, float weight) {
    float r = weight / (1.25 * (p.mag() + 1e-10));
    float x = r * ((p.x - p.y) * (p.x + p.y));
    float y = r * 2.0 * p.x * p.y;
    return new PVector(x,y);
  }
  
  PVector polar(PVector p, float weight) {
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    float x = theta / PI;
    float y = r - 2.0;
    return new PVector(weight * 1.5 * x, weight * 1.5 * y);
  }
  
  void draw(PVector p) {
    float i = map(p.x,xmin,xmax,screenl,screenr) + 0.5*randomGaussian();
    float j = map(p.y,ymin,ymax,screenl,screenr) + 0.5*randomGaussian();
    //ellipse(i,j,0.8,0.8);
    
    //ellipse(i,j,random(13)+0.75,random(13)+0.75);
    point(i,j);
  }
  
  void precalc() {
    wedgejulia_cf = 1.0 - 0.5 / PI * wedgejulia_angle * wedgejulia_count;
    wedgejulia_cn = wedgejulia_dist / wedgejulia_power / 2.0;
    wedgejulia_rN = abs(wedgejulia_power);
    rings2_val2 = rings2_val * rings2_val;
    fan2_dx = PI * fan2_x * fan2_x + 1e-10;
    fan2_dx2 = 0.5 * fan2_dx;
    julian_cpower = julian_dist/julian_power/2.0;
    julian_abspower = abs(julian_power);
    juliascope_cpower = juliascope_dist/juliascope_power/2.0;
    juliascope_abspower = abs(juliascope_power);
  }
}

void draw3D(PVector p1, PVector p2) {
    float middle = width/2;
    float size = 0.95 * middle;
    float screenl = (int)(-size + middle);
    float screenr =(int)(size + middle);
    float ymin = -3.5;
    float ymax = 3.5;
    float xmin = -3.5;
    float xmax = 3.5;
    
    PVector vec3d = new PVector(p1.x,p1.y+p2.x,p2.y);
    
    if(-vec3d.z+zdist>0){
    
      PVector proj = project(vec3d);
      
      float xx = proj.x + 0.5*randomGaussian();
      float yy = proj.y + 0.5*randomGaussian();

      strokeWeight(random(0,1)*2.5*proj.z);
      
      point(xx+width/2,yy+height/2);
    }
  }
  
float zdist = 0.15;
  
PVector project(PVector vec){
  float x = 70*vec.x/(-vec.z+zdist);
  float y = 70*vec.y/(-vec.z+zdist);
  return new PVector(x,y,1/(-vec.z+zdist));
}