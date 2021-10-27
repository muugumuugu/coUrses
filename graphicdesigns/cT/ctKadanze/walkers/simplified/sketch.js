var w;


function setup() {
  createCanvas(200,200);
  background(51);
  w=new Walker();
}

function draw() {
  w.walk();
  w.show();
}

