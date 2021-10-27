let vertexAnchor;
let bezierControlPoint;
let bezierAnchor;

let lineSize;
let dotSize;

function setup()
{
  createCanvas(600, 450);
  frameRate(36);

  const w = width * 0.65;
  const h = height * 0.60;
  const x = (width/2) - (w/2);
  const y = (height/2) - (h/2);

  lineSize = width * 0.005;
  dotSize = width * 0.015;

  vertexAnchor = createVector(x, y+h);
  bezierAnchor = createVector(x+w, y+h);
  bezierControlPoint = createVector(x+(w/2), y);
}

function draw()
{
  background(240);

  const percent = frameCount % 100 / 100;

  // draw bezier line
  strokeWeight(lineSize);
  stroke(30);
  noFill();
  beginShape();
  vertex(vertexAnchor.x, vertexAnchor.y);
  quadraticVertex(bezierControlPoint.x, bezierControlPoint.y, bezierAnchor.x, bezierAnchor.y);
  endShape();

  // draw dots in between
  const pointBetween1 = drawDotBetween(vertexAnchor, bezierControlPoint, percent, '#E1B000', dotSize);
  const pointBetween2 = drawDotBetween(bezierControlPoint, bezierAnchor, percent, '#E1B000', dotSize);
  const pointBetween3 = drawDotBetween(pointBetween1, pointBetween2, percent, '#c64821', dotSize*1.5);

  // draw anchor points
  noStroke();
  fill('#E1B000');
  ellipse(vertexAnchor.x, vertexAnchor.y, dotSize, dotSize);
  ellipse(bezierAnchor.x, bezierAnchor.y, dotSize, dotSize);

  // draw control point
  noStroke();
  fill('#E1B000');
  ellipse(bezierControlPoint.x, bezierControlPoint.y, dotSize, dotSize);
}

function drawDotBetween(start, stop, percent, col, s)
{
  const pointBetween = p5.Vector.lerp(start, stop, percent);

  // draw line
  stroke('#FFDAA2');
  strokeWeight(lineSize/2);
  line(start.x, start.y, stop.x, stop.y);

  // draw dot
  noStroke();
  fill(col);
  ellipse(pointBetween.x, pointBetween.y, s, s);

  return pointBetween;
}
