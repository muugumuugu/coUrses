// OpenSimplexNoise code to put in another tab :
// https://gist.github.com/Bleuje/fce86ef35b66c4a2b6a469b27163591e


// GIF Loop
// Daniel Shiffman
// https://thecodingtrain.com/CodingChallenges/135-gif-loop.html
// https://youtu.be/nBKwCCtWlUg

// ffmpeg -f image2 -framerate 30 -i gif-%3d.png loop.gif

int totalFrames = 240;
int counter = 0;
boolean record = true;
float a = 0;

class Particle {

  NoiseLooper xnoise;
  NoiseLooper ynoise;
  NoiseLooper dnoise;
  NoiseLooper rnoise;
  NoiseLooper gnoise;
  NoiseLooper bnoise;

  Particle() {
    xnoise = new NoiseLooper(0.5, -width, width);
    ynoise = new NoiseLooper(0.5, -height, height);
    dnoise = new NoiseLooper(2, 1, 50);
    rnoise = new NoiseLooper(10, 150, 255);
    gnoise = new NoiseLooper(10, 0, 255);
    bnoise = new NoiseLooper(10, 150, 255);
  }

  void render(float percent) {
    noStroke();
    a = percent * TWO_PI;
    float x1 = xnoise.value(a);
    float y1 = ynoise.value(a);
    float d = dnoise.value(a);
    float r = rnoise.value(a);
    float g = gnoise.value(a);
    float b = bnoise.value(a);
    fill(r, g, b, 200);

    ellipse(x1, y1, d, d);
  }
}

Particle[] particles = new Particle[200];

OpenSimplexNoise noise;

void setup() {
  size(400, 400);
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle();
  }
  
  noise = new OpenSimplexNoise();
}

void draw() {
  float percent = 0;
  if (record) {
    percent = float(counter) / totalFrames;
  } else {
    percent = float(counter % totalFrames) / totalFrames;
  }
  render(percent);
  if (record) {
    saveFrame("output/fr###.gif");
    if (counter == totalFrames-1) {
      exit();
    }
  }
  counter++;
}

void render(float percent) {
  background(0);
  translate(width/2, height/2);
  for (Particle p : particles) {
    p.render(percent);
  }
}

class NoiseLooper {
  float spread;
  float min, max;
  int seed;
  
  float offset = random(TWO_PI);
  
  NoiseLooper(float spread, float min, float max) {
    this.seed = int(random(10000));
    this.spread = spread;
    this.min = min;
    this.max = max;
  }

  float value(float angle) {
    noiseSeed(seed);
    float xoff = map(cos(angle), -1, 1, 0, spread);
    float yoff = map(sin(angle), -1, 1, 0, spread);
    //float n = noise(xoff,yoff);
    //return map(n, 0, 1, min, max);
    float n = (float)noise.eval(seed + xoff,yoff); // returns a value between -1 and 1, seed needs to be quite small or it bugs
    return map(n, -1, 1, min, max);
  }
}