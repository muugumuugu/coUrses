var w;


function setup() {
  createCanvas(800,800);
  background(51);
  w=new Walker();
}

function draw() {
  w.walk();
  w.show();
}
