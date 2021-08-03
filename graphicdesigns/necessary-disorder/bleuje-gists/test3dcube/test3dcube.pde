void setup(){
  size(700,700,P3D);
  rectMode(CENTER);
}

float l = 250;

void drawCube(float x, float y, float z){
  pushMatrix();
  translate(x,y,z);
  rotateX(0.01*mouseY);
  rotateY(0.01*mouseX);
  
  pushMatrix();
  
  fill(0,0,255);
  
  translate(0,0,l/2);
  rect(0,0,l,l);
  translate(0,0,-l);
  rect(0,0,l,l);
  
  popMatrix();
  
  
  pushMatrix();
  rotateY(HALF_PI);
  
  fill(255,0,0);
  
  translate(0,0,l/2);
  rect(0,0,l,l);
  translate(0,0,-l);
  rect(0,0,l,l);
  
  popMatrix();
  
  pushMatrix();
  rotateX(HALF_PI);
  
  fill(0,255,0);
  
  translate(0,0,l/2);
  rect(0,0,l,l);
  translate(0,0,-l);
  rect(0,0,l,l);
  
  popMatrix();
  
  popMatrix();
}

void draw(){
  background(0);
  translate(width/2,height/2);
  
  stroke(255);
  strokeWeight(15);
  noFill();
  
  pushMatrix();
  drawCube(0,0,0);
  popMatrix();
}