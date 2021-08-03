OpenSimplexNoise noise;

int numFrames = 100;

int margin = 50;

int m;

class Line{
  float lr;
  float scl;
  float h;
  
  Line(float lr_,float scl_, float h_){
    lr = lr_;
    scl = scl_;
    h = h_;
  }
}

ArrayList<Line> lines = new ArrayList<Line>();


void setup(){
  size(600,600);
  background(0);
  
  noise = new OpenSimplexNoise();
  
  float sumh = 0;
  while(true){
    float lr = 0.5*pow(random(0.5,2.0),2);
    float scl = 0.1*pow(random(0.4,2),2);
    float h = 100.0*pow(random(0.2,1),4.0);
    sumh += h;
    if(sumh>=height-2*margin){
      h -= sumh - (height-2*margin);
      lines.add(new Line(lr,scl,h));
      m++;
      break;
    }
    lines.add(new Line(lr,scl,h));
    m++;
  }
  
  println(m);
}

void draw(){
  blendMode(BLEND);
  background(15);
  
  float t = 1.0*(frameCount-1)%numFrames/numFrames;
  
  float sumh = 0;
  
  for(int j = 0;j<m;j++){
    for(int x = margin;x<width-margin;x++){
      float loop_radius = lines.get(j).lr;
      double ns = noise.eval(100*j+lines.get(j).scl*x,loop_radius*cos(TWO_PI*t),loop_radius*sin(TWO_PI*t));
      float col = constrain(map((float)ns,-0.05,0.05,0,255),0,255);
      stroke(col);
      line(x,margin+sumh,x,margin+lines.get(j).h+sumh);
    }
    sumh+=lines.get(j).h;
  }
  
  stroke(255);
  noFill();
  rect(margin,margin,width-2*margin,height-2*margin);
  
  blendMode(EXCLUSION);
  noStroke();
  fill(255);
  ellipse(width/2,height/2,0.7*width,0.7*width);
  
  if(frameCount<=numFrames){
    saveFrame("fr####.png");
  }
  if(frameCount==numFrames){
    println("finished");
  }
}