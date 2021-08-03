import toxi.color.*;
import toxi.util.datatypes.*;

int rectSize = 150;
int spacing = 30;

void setup() 
{
  size(1280, 800);
  background(255);
  smooth();
  noStroke();
  colorMode(HSB, 1, 1, 1);
  
  // create a color list
  ColorList colors = new ColorList();
  
  // put some colors into it
  colors.add( TColor.newHSV(0, 1, 1) );
  colors.add( NamedColor.BLANCHEDALMOND.copy() );
  colors.add( NamedColor.CORAL.copy() );
  colors.add( NamedColor.PLUM.copy() );
  colors.add( NamedColor.LIME.copy() );
  colors.add( NamedColor.PERU.copy() );
  
  // theres a lot of functions you can call that changes all the colors in the list
  //colors.adjustBrightness(0.2);
  //colors.adjustSaturation(0.2);
  //colors.complement(); // switch all colors to their complements
  //colors.rotateRYB(90); // rotate all colors around the RYB wheel
  
  // loop through and draw the colors
  translate(100, 100);
  drawColors(colors);
  
  // sort all colors and draw them again
  translate(0, rectSize + spacing);
  colors.sort();
  drawColors(colors);
  
  // get the darkest color
  translate(rectSize * 2 - spacing, rectSize + (spacing * 2));
  TColor darkest = colors.getDarkest();
  fill(darkest.hue(), darkest.saturation(), darkest.brightness());
  rect(0, 0, rectSize, rectSize);
  
  // get the lightest color
  translate(rectSize + spacing, 0);
  ReadonlyTColor lightest = colors.getLightest();
  fill(lightest.hue(), lightest.saturation(), lightest.brightness());
  rect(0, 0, rectSize, rectSize);

  // get average color
  translate(rectSize + spacing, 0);
  ReadonlyTColor average = colors.getAverage();
  fill(average.hue(), average.saturation(), average.brightness());
  rect(0, 0, rectSize, rectSize);  
}

void drawColors(ColorList colors)
{
  int xPos = 0;
  
  for(int i = 0; i < colors.size(); i++)
  {
    TColor c = colors.get(i);
    fill(c.hue(), c.saturation(), c.brightness());
    rect(xPos, 0, rectSize, rectSize);
    xPos += rectSize + spacing;
  }
}
