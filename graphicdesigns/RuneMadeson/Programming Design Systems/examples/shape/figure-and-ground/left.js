function setup() {

  createCanvas(600, 450);
  background(240);

  const rectSize = height * 0.15;

  noStroke();
  fill(40);
  rect(rectSize, rectSize, rectSize, rectSize);

  noLoop();
}
