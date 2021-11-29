set of complex numbers p for which
	fₚ(z) = z² + p
	does not diverge when iterated from 0
	i.e the sequence fₚ(0),fₚ(fₚ(0)),... remains bounded
Select some Infinity
Also Select some infinty for number of iterations to check.
Establish a Zoom Level by fixing range of complex vals.





```
void setup() {
  size(640, 480);
  colorMode(RGB, 1);
}
void draw() {
	background(255);
	float w = 5;// 1/zoom
	float h = (w * height) / width;
	float xmin = -w/2,ymin = -h/2;
	int maxiterations = 100;
	float xmax = xmin + w, ymax = ymin + h;
	float dx = (xmax - xmin) / (width), dy = (ymax - ymin) / (height);
	loadPixels();
	float y = ymin;
	for (int j = 0; j < height; j++) {
		float x = xmin;
		for (int i = 0; i < width; i++) {
			// Now we test, as we iterate z = z^2 + cm does z tend towards infinity?
			float a = x,b = y;
			int n = 0;
			while (n < maxiterations) {
				float aa = a * a, bb = b * b, twoab = 2.0 * a * b;
				a = aa - bb + x;
				b = twoab + y;
				// Infinty in our finite world is simple, let's just consider it 16
				if (a*a + b*b > 16.0) {break;}// bail out
				n++;
			}
			// We color each pixel based on how long it takes to get to infinity
			if (n == maxiterations) {pixels[i+j*width] = color(0);}// If we never got there, let's pick the color black
			else {pixels[i+j*width] = color(sqrt(float(n) / maxiterations));}
			x += dx;
		}
		y += dy;
	}
  updatePixels();
}
```