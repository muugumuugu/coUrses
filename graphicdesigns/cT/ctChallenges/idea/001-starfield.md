int n=800;
class Star{
  float x,y,z;
  float prevZ;
  Star(){
    x=random(-width/2,width/2);
    y=random(-height/2,height/2);
    z=random(1,width/2);//depth
    prevZ=z;
  }
  void show(){

    //perspective
    float sx=map(x/(z),0,1,0,width/2);
    float sy=map(y/(z),0,1,0,height/2);
    float r= map(z,0,width/2,8,0.2);
    fill(255,map(z,1,width/2,255,0));

    //streak
    float px=map(x/(prevZ),0,1,0,width/2);
    float py=map(y/(prevZ),0,1,0,height/2);
    stroke(255);
    line(sx,sy,px,py);
    //draw
    noStroke();
    ellipse(sx,sy,r,r);
  }
  void update(){
    prevZ=z;
    z-=10;//closer to the screen;
    if (z<1){
      x=random(-width/2,width/2);
      y=random(-height/2,height/2);
      z=random(1,width/2);//depth
      prevZ=z;
    }//reuse star object
  }
}
Star[] stars=new Star[n];
void setup(){
  size(600,600);
  for (int i=0; i<n;i++){
    stars[i]=new Star();
  }
}

void draw(){
  background(0);
  translate(width/2,height/2);
  for (int i=0; i<n;i++){

    stars[i].update();
    stars[i].show();
  }
}