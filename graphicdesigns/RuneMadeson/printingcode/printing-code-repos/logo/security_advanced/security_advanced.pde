int radius = 250;
int numDots = 12;

void setup() 
{
  size(1280, 800);
  background(255);
  smooth();
  
  translate(width / 2, height / 2);
  
  int dotDegree = 360 / numDots;
  
  // draw guiding dots
  /*noStroke();
  fill(100);
  for(int i = 0; i < numDots; i++)
  {
    float x = sin(radians(i * dotDegree)) * radius;
    float y = cos(radians(i * dotDegree)) * radius;
    ellipse(x, y, 5, 5); 
  }*/
  
  // now draw lines between them
  stroke(0);
  strokeWeight(5);
  
  noFill();
  int startDot = int(random(numDots));
  int endDot = randomDotOnOppositeSide(startDot);
  
  for(int i = 0; i < numDots; i++)
  {
     float startX = sin(radians(startDot * dotDegree)) * radius;
     float startY = cos(radians(startDot * dotDegree)) * radius;
     
     float endX = sin(radians(endDot * dotDegree)) * radius;
     float endY = cos(radians(endDot * dotDegree)) * radius;
     
     line(startX, startY, endX, endY);

     startDot = endDot;
     endDot = randomDotOnOppositeSide(startDot);
  }
}

int randomDotOnOppositeSide(int curDot)
{
  // how many dots from either side can we choose?
  int range = 3;
  int opposite = (curDot + (numDots / 2)) % 12;
  return int(random(opposite - range, opposite + range));
}

