function Walker(){
  this.thick=2;
  this.pos=createVector(random(width),random(height));
  this.vel;
  this.show=function(){
    fill(255,128);
    ellipse(this.pos.x,this.pos.y,this.thick*2,this.thick*2);
  }
  this.walk=function(){
    this.vel=createVector(random(-this.thick,this.thick),random(-this.thick,this.thick));
    this.pos.add(this.vel);
    this.pos.x=(this.pos.x+width)%width;
    this.pos.y=(this.pos.y+height)%height;
    return this.pos;
  }
}