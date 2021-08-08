import toxi.geom.*;
import toxi.color.*;
import toxi.color.theory.*;
import toxi.util.datatypes.*;

void setup()
{
  size(800, 600);
  smooth();
  background(255);
  colorMode(HSB, 1, 1, 1);
  noStroke();

  // load image
  PImage bruce = loadImage("bruce.jpg");
  bruce.loadPixels();

  // create a histogram that uses 1/20 of the pixels as a sample, with a color tolerance of 30%
  Histogram bruceHistogram = Histogram.newFromARGBArray(bruce.pixels, bruce.pixels.length/50, 0.3, true);

  // now get an arraylist of all the entries in the histogram. Each entry has 2 properties: 
  // 1. a TColor that you get by calling getColor() (see the loop)
  // 2. a frequency float that tells you how many times the color is in the image. Get it by calling getFrequency()
  ArrayList<HistEntry> bruceEntries = (ArrayList) bruceHistogram.getEntries();

  translate((width/2) - (bruce.width/2), (height/2) - (bruce.height/2));

  // loop through image and update pixels
  for(int x = 0; x < bruce.width; x++)
  {
    for(int y = 0; y < bruce.height; y++)
    {
      int index = x + y * bruce.width;
      TColor pixelColor = TColor.newARGB(bruce.pixels[index]);
      
      // loop through the list and get the closest color to this pixel
      TColor closestColor = TColor.newHSV(0, 0, 0);
      float minDistance = 1;
      
      for(int i = 0; i < bruceEntries.size(); i++)
      {
        float thisDistance = pixelColor.distanceToHSV(bruceEntries.get(i).getColor());
        if(thisDistance < minDistance)
        {
          minDistance = thisDistance;
          closestColor = bruceEntries.get(i).getColor();
        }
      }

      // set pixel with hsb values 
      bruce.pixels[index] = color(closestColor.toARGB());
    }
  }

  bruce.updatePixels();
  image(bruce, 0, 0);
}
