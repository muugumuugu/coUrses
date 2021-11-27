* create a center origined canvas
* keep rotating along X axis
* draw the boxes
* Box object:
	* attributes
		* position vec3 : pos
		+ size :r
	* methods
		* show : box(r) @ pos,
		* chop it up : generate
			* split it into -1 to 1. for all axis.
			* make a new Box(r/3) at pos+ index*r', if mag(indxvec)>1.
			* return pointers to these Box objects

```
class Box {
  PVector pos;
  float r;

  Box(float x, float y, float z, float r_) {
    pos = new PVector(x, y, z);
    r = r_;
  }

  ArrayList<Box> generate() {
    ArrayList<Box> boxes = new ArrayList<Box>();
    for (int x = -1; x < 2; x++) {
      for (int y = -1; y < 2; y++) {
        for (int z = -1; z < 2; z++) {
          int sum = abs(x) + abs(y) + abs(z);
          float newR = r/3;
          if (sum > 1) {
            Box b = new Box(pos.x+x*newR, pos.y+ y*newR, pos.z+z*newR, newR);
            boxes.add(b);
          }
        }
      }
    }
    return boxes;
  }

  void show() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    noStroke();
    fill(255);
    box(r);
    popMatrix();
  }
}
float a = 0;

ArrayList<Box> sponge;
void setup() {
  size(400, 400, P3D);

  // An array of Box objects
  sponge = new ArrayList<Box>();

  // Star with one
  Box b = new Box(0, 0, 0, 200);
  sponge.add(b);
}
void mousePressed() {
  // Generate the next set of boxes
  ArrayList<Box> next = new ArrayList<Box>();
  for (Box b : sponge) {
    ArrayList<Box> newBoxes = b.generate();
    next.addAll(newBoxes);
  }
  sponge = next;
}

void draw() {
  background(51);
  stroke(255);
  noFill();
  lights();
  translate(width/2, height/2);
  rotateX(a);
  rotateY(a*0.4);
  rotateZ(a*0.1);
  // Show what you've got!
  for (Box b : sponge) {
    b.show();
  }
  a += 0.01;
}
```