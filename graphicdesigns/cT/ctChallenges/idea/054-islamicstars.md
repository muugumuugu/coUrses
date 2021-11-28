grid of polygons in contact with each other.
Hankins
	two rays emerging from midpoint tiles.
		or maybe seperate the rays from each other by a distance delta.
# OOP

## Polygon
### attributes
* array of edges.
* vertices array.
### methods
* show
	* hide later
	* show all the edges
* add vertex
	make an edge between last added vertex and this new vector.
	add the vertex to the array
	add the array to the edges array
* close
	make an edge bw the last to the first vertex

* spawnhankins
	calls hankinspawn for each edge
## Edge
### attributes
* beginning pt a
* ending pt b
* hankin1
* hankin2

### methods
* show
* hankinspawn
	* find midpt.
	* generate a vector form midpt(+delta/2?) to edge1, rotate it by theta1
	* generate a vector form midpt(-delta/2?) to edge2, rotate it by theta2
	* assign these to the hankin properties.
	* find ends(e) : loop thru all edges

* find ends(otheredge)
	hankin1.findends(oe.h1)
	hankin2.findends(oe.h1)
	hankin1.findends(oe.h2)
	hankin2.findends(oe.h2)
## Hankins
### atributes
* starting point of ray :a
* direction of ray: v
* end pt
* temp end pt : b= a+v
### methods
* show
[
find all intersections
minimize the sum of length of hankins.
]
* findends
	use coordinate geometry.
	if dist sum is less than prev dist sum assign current intersection to the end
	also also. if polygon in question is regular, length of hankin is predetermined by law of sines and internal angle as a function of theta


```
var polys = [];

var angle = 75;
var delta = 10;

var deltaSlider;
var angleSlider;

function setup() {
  createCanvas(400, 400);
  //angleMode(DEGREES);
  background(51);
  deltaSlider = createSlider(0, 25, 10);
  angleSlider = createSlider(0, 90, 75);

  var inc = 100;
  for (var x = 0; x < width; x += inc) {
    for (var y = 0; y < height; y += inc) {
      var poly = new Polygon();
      poly.addVertex(x, y);
      poly.addVertex(x + inc, y);
      poly.addVertex(x + inc, y + inc);
      poly.addVertex(x, y + inc);
      poly.close();
      polys.push(poly);
    }
  }
}

function draw() {
  background(51);
  angle = angleSlider.value();
  delta = deltaSlider.value();
  //console.log(angle, delta);
  for (var i = 0; i < polys.length; i++) {
    polys[i].hankin();
    polys[i].show();
  }
}
//
function Polygon() {
  this.vertices = [];
  this.edges = [];

  this.addVertex = function(x, y) {
    var a = createVector(x, y);
    var total = this.vertices.length;
    if (total > 0) {
      var prev = this.vertices[total - 1];
      var edge = new Edge(prev, a);
      this.edges.push(edge);
    }
    this.vertices.push(a);
  };

  this.close = function() {
    var total = this.vertices.length;
    var last = this.vertices[total - 1];
    var first = this.vertices[0];
    var edge = new Edge(last, first);
    this.edges.push(edge);
  };

  this.hankin = function() {
    for (var i = 0; i < this.edges.length; i++) {
      this.edges[i].hankin();
    }

    for (var i = 0; i < this.edges.length; i++) {
      for (var j = 0; j < this.edges.length; j++) {
        if (i !== j) {
          this.edges[i].findEnds(this.edges[j]);
        }
      }
    }
  };

  this.show = function() {
    for (var i = 0; i < this.edges.length; i++) {
      this.edges[i].show();
    }
  };
}
//
function Edge(a, b) {
  this.a = a;
  this.b = b;
  this.h1;
  this.h2;

  this.show = function() {
    stroke(255, 50);
    //line(this.a.x, this.a.y, this.b.x, this.b.y);
    this.h1.show();
    this.h2.show();
  };

  this.hankin = function() {
    var mid = p5.Vector.add(this.a, this.b);
    mid.mult(0.5);

    var v1 = p5.Vector.sub(this.a, mid);
    var v2 = p5.Vector.sub(this.b, mid);
    var offset1 = mid;
    var offset2 = mid;
    if (delta > 0) {
      v1.setMag(delta);
      v2.setMag(delta);
      offset1 = p5.Vector.add(mid, v2);
      offset2 = p5.Vector.add(mid, v1);
    }
    v1.normalize();
    v2.normalize();

    v1.rotate(radians(-angle));
    v2.rotate(radians(angle));

    this.h1 = new Hankin(offset1, v1);
    this.h2 = new Hankin(offset2, v2);
    //OR
    /*
    // Calculate interior angle
    var interior = ((sides - 2) * PI) / sides;
    // Law of sines right here!
    var alpha = interior * 0.5;
    var beta = PI - radians(angle) - alpha;
    var hlen = (elen * sin(alpha)) / sin(beta);
    v1.setMag(hlen);
    v2.setMag(hlen);
    this.h1 = new Hankin(offset1, v1);
    this.h2 = new Hankin(offset2, v2);
    */
  };

  this.findEnds = function(edge) {
    this.h1.findEnd(edge.h1);
    this.h1.findEnd(edge.h2);
    this.h2.findEnd(edge.h1);
    this.h2.findEnd(edge.h2);
  };
}
//
function Hankin(a, v) {
  this.a = a;
  this.v = v;
  this.b = p5.Vector.add(a, v);
  this.end;
  this.prevD;

  this.show = function() {
    stroke(255, 0, 255);
    line(this.a.x, this.a.y, this.end.x, this.end.y);
  };

  this.findEnd = function(other) {
    // line line intersection???
    // this.a, this.v  (P1, P2-P1)
    // other.a, other.v (P3, P4-P3)
    var den = other.v.y * this.v.x - other.v.x * this.v.y;
    if (!den) {
      return;
    }
    var numa =
      other.v.x * (this.a.y - other.a.y) - other.v.y * (this.a.x - other.a.x);
    var numb =
      this.v.x * (this.a.y - other.a.y) - this.v.y * (this.a.x - other.a.x);
    var ua = numa / den;
    var ub = numb / den;
    var x = this.a.x + ua * this.v.x;
    var y = this.a.y + ua * this.v.y;

    if (ua > 0 && ub > 0) {
      var candidate = createVector(x, y);
      var d1 = p5.Vector.dist(candidate, this.a);
      var d2 = p5.Vector.dist(candidate, other.a);
      var d = d1 + d2;
      var diff = abs(d1 - d2);
      if (diff < 0.001) {
        if (!this.end) {
          this.end = candidate;
          this.prevD = d;
        } else if (d < this.prevD) {
          this.prevD = d;
          this.end = candidate;
        }
      }
    }
  };
}
```