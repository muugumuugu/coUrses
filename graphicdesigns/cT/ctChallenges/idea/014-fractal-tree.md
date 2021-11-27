float rat1,rat2;
float theta1,theta2;

void setup(){
  size(800,800);
  theta1=PI/3;
  theta2=PI/6;
  rat1=0.6;
  rat2=0.7;

}



void draw(){
  background(0);
  stroke(255);
  float len=300;
  translate(width/2,height);
  branch(len);
}

void branch(float len){
  if (len<1) return;
  line(0,0,0,-len);
  translate(0,-len);
  pushMatrix();
  rotate(theta1);
  branch(len*rat1);
  popMatrix();
  pushMatrix();
  rotate(-theta2);
  branch(len*rat2);
  popMatrix();

}