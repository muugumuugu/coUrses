function setup()
{
  createCanvas(450, 600);

  const margin = height / 20;
  const allWidth = width - 4 * margin;
  const allHeight = height - 5 * margin;
  const moduleWidth = allWidth / 3;
  const moduleHeight = allHeight / 4;

  background(240);
  noStroke();

  translate(margin, margin)

  fill(30, 50, 50);
  rect(0, 0, 2 * moduleWidth + margin, margin);

  fill(120, 155, 155);
  rect(2 * (moduleWidth + margin), 0, moduleWidth, moduleHeight - margin);

  translate(0, moduleHeight + margin);
  fill(75, 185, 165);

  rect(0, 0, moduleWidth, moduleHeight + margin);
  rect(moduleWidth + margin, 2 * margin, moduleWidth, moduleHeight + margin);
  rect(2 * (moduleWidth + margin), 0, moduleWidth, moduleHeight + margin);

  translate(0, moduleHeight + 2 * margin);
  rect(0, 0, moduleWidth, moduleHeight + margin);
  rect(moduleWidth + margin, 2 * margin, moduleWidth, moduleHeight + margin);
  rect(2 * (moduleWidth + margin), 0, moduleWidth, moduleHeight + margin);

  noLoop();
}
