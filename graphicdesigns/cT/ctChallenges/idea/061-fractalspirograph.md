#
```
ArrayList<PVector> path;

float angle = 0;
int resolution = 80;

Orbit sun;
Orbit end;

void setup() {
  size(600, 600);
  path = new ArrayList<PVector>();
  sun = new Orbit(width/2, height/2, width/4, 0);
  Orbit next = sun;
  for (int i = 0; i < 10; i++) {
    next = next.addChild();
  }
  end = next;
}

void draw() {
  background(51);

  for (int i = 0; i < resolution; i++) {
    Orbit next = sun;
    while (next != null) {
      next.update();
      next = next.child;
    }
    path.add(new PVector(end.x, end.y));
  }

  Orbit next = sun;
  while (next != null) {
    next.show();
    next = next.child;
  }

  beginShape();
  stroke(255);
  noFill();
  for (PVector pos : path) {
    vertex(pos.x, pos.y);
  }
  endShape();
}
//----------------------
int k = -3;

class Orbit {
  float x;
  float y;
  float r;
  int n;
  Orbit parent;
  Orbit child;
  float speed;
  float angle;

  Orbit(float x_, float y_, float r_, int n_) {
    this(x_, y_, r_, n_, null);
  }

  Orbit(float x_, float y_, float r_, int n_, Orbit p) {
    x = x_;
    y = y_;
    r = r_;
    n = n_;
    speed = (radians(pow(k, n-1)))/resolution;
    parent = p;
    child = null;
    angle = -PI/2;
  }

  Orbit addChild() {
    float newr = r / 3.0;
    float newx = x + r + newr;
    float newy = y;
    child = new Orbit(newx, newy, newr, n+1, this);
    return child;
  }

  void update() {
    if (parent != null) {
      angle += speed;
      float rsum = r + parent.r;
      x = parent.x + rsum * cos(angle);
      y = parent.y + rsum * sin(angle);
    }
  }

  void show() {
    stroke(255, 100);
    strokeWeight(1);
    noFill();
    if (parent != null) {
      line(parent.x, parent.y, x, y);
    }
    ellipse(x, y, r*2, r*2);
  }
}
```