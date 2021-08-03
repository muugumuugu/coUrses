// Processing source code
// slit scan by @etiennejcb, put frames in the data folder

void prepareData()
{
  for (int i = 0; i < numInputFrames; i++) {
    println(filenames[i]);
    allFrames[i] = loadImage(filenames[i]);
  }
  
  println("Data loaded.");
}

float offset(float i, float j)
{
  return -dist(i,j,width/2,height/2)/(1.3*width);
  //return -(i+j)/(1.7*width);
  //return 1.0*atan2(j-height/2,i-width/2)/TWO_PI;
}

void draw() {
  println("Doing frame " + frameCount + " / " + numFrames);
  
  float t = 1.0*(frameCount-1)/numFrames;
  
  for(int i=0;i<width;i++)
  {
    for(int j=0;j<height;j++)
    {
      float off = t+offset(i,j);
      int ind = floor(0.999999*numInputFrames*((12345+off)%1));
      color col = allFrames[ind].get(i,j);
      set(i,j,col);
    }
  }
  
  saveFrame("fr###.gif");
  
  if(frameCount==numFrames)
  {
    println("Done.");
    stop();
  }
}

//////////////////////////////////////////////////////////////////////////////
int numFrames = 100;
int numInputFrames;

String[] filenames;

PImage [] allFrames;

void setup(){
  size(600,600,P3D);
  
  // we'll have a look in the data folder
  java.io.File folder = new java.io.File(dataPath(""));
   
  // list the files in the data folder
  filenames = folder.list();
   
  // get and display the number of files
  println(filenames.length + " files in data directory");
  
  numInputFrames = filenames.length;
  
  numFrames = numInputFrames;
  
  allFrames = new PImage[numInputFrames];
  
  prepareData();
}