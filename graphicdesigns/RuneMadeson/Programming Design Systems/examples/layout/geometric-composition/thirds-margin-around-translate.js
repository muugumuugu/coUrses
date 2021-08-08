function setup()
{
  createCanvas(450, 600);

  const margin = height / 20;
  const imgWidth = width - 2 * margin;
  const allHeight = height - 4 * margin;
  const imgHeight = allHeight / 3;

  background(240);
  noStroke();

  // Move down to the position of the first image and draw it
  translate(margin, margin);
  fill(75, 185, 165);
  rect(0, 0, imgWidth, imgHeight);

  // Move down to the second image position and draw it
  translate(0, margin + imgHeight);
  fill(120, 155, 155);
  rect(0, 0, imgWidth, imgHeight);

  // Move down to the last image position and draw it
  translate(0, margin + imgHeight);
  fill(30, 50, 50);
  rect(0, 0, imgWidth, imgHeight);

  noLoop();
}
