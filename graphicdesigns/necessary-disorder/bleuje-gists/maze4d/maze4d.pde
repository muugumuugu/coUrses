// Processing code by Etienne JACOB
// motion blur template by beesandbombs
// opensimplexnoise code in another tab might be necessary
// --> code here : https://gist.github.com/Bleuje/fce86ef35b66c4a2b6a469b27163591e


int[][] result;
float t, c;

float ease(float p) {
  return 3*p*p - 2*p*p*p;
}

float ease(float p, float g) {
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

float mn = .5*sqrt(3), ia = atan(sqrt(.5));

void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popStyle();
  popMatrix();
}

void draw() {

  if (!recording) {
    t = mouseX*1.0/width;
    c = mouseY*1.0/height;
    if (mousePressed)
      println(c);
    draw_();
  } else {
    for (int i=0; i<width*height; i++)
      for (int a=0; a<3; a++)
        result[i][a] = 0;

    c = 0;
    for (int sa=0; sa<samplesPerFrame; sa++) {
      t = map(frameCount-1 + sa*shutterAngle/samplesPerFrame, 0, numFrames, 0, 1);
      draw_();
      loadPixels();
      for (int i=0; i<pixels.length; i++) {
        result[i][0] += pixels[i] >> 16 & 0xff;
        result[i][1] += pixels[i] >> 8 & 0xff;
        result[i][2] += pixels[i] & 0xff;
      }
    }

    loadPixels();
    for (int i=0; i<pixels.length; i++)
      pixels[i] = 0xff << 24 | 
        int(result[i][0]*1.0/samplesPerFrame) << 16 | 
        int(result[i][1]*1.0/samplesPerFrame) << 8 | 
        int(result[i][2]*1.0/samplesPerFrame);
    updatePixels();

    saveFrame("fr###.gif");
    println(frameCount,"/",numFrames);
    if (frameCount==numFrames)
      exit();
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 5;
int numFrames = 100;        
float shutterAngle = .6;

boolean recording = false;

OpenSimplexNoise noise;

class Delta{
  int[] permutation;
  
  int n;
  int dim;
  
  Delta(int dim_){
    dim = dim_;
    n = 2*dim_;
    permutation = new int[n];
    for(int i=0;i<n;i++){
      permutation[i] = i;
    }
    for(int i=0; i<n-1; i++){
        int j = i+int(random(n-i));
        int aux = permutation[i];
        permutation[i] = permutation[j];
        permutation[j] = aux;
    }
  }
  
  PVector eval(int i){
    i = (i+1234)%n;
    return new PVector(permutation[i]/2,permutation[i]%2);
  }
}

class Maze{
  int n1,n2,n3,n4;
  
  int N1,N2,N3,N4;
  
  int startI, startJ, startK, startL;
  int endI, endJ, endK, endL;
  
  boolean[][][][] dig;
  boolean[][][][] wasHere;
  boolean[][][][] correctPath;
  
  Maze(int n1_,int n2_,int n3_,int n4_){
    n1 = n1_;
    n2 = n2_;
    n3 = n3_;
    n4 = n4_;
    N1 = 2*n1+3;
    N2 = 2*n2+3;
    N3 = 2*n3+3;
    N4 = 2*n4+3;
    dig = new boolean[N1][N2][N3][N4];
    wasHere = new boolean[N1][N2][N3][N4];
    correctPath = new boolean[N1][N2][N3][N4];
    
    startI = 2;
    startJ = 2;
    startK = 2;
    startL = 2;
    
    endI = 2*n1;
    endJ = 2*n2;
    endK = 2*n3;
    endL = 2*n4;
    
    for(int i=0;i<N1;i++){
      for(int j=0;j<N2;j++){
        for(int k=0;k<N3;k++){
          for(int l=0;l<N4;l++){
            dig[i][j][k][l] = false;
            wasHere[i][j][k][l] = false;
            correctPath[i][j][k][l] = false;
          }
        }
      }
    }
    
    for(int i=0;i<N1;i++){
      for(int j=0;j<N2;j++){
        for(int k=0;k<N3;k++){
          dig[i][j][k][0] = true;
          dig[i][j][k][N4-1] = true;
        }
      }
    }
    for(int i=0;i<N1;i++){
      for(int j=0;j<N2;j++){
        for(int k=0;k<N4;k++){
          dig[i][j][0][k] = true;
          dig[i][j][N3-1][k] = true;
        }
      }
    }
    for(int i=0;i<N1;i++){
      for(int j=0;j<N3;j++){
        for(int k=0;k<N4;k++){
          dig[i][0][j][k] = true;
          dig[i][N2-1][j][k] = true;
        }
      }
    }
    for(int i=0;i<N2;i++){
      for(int j=0;j<N3;j++){
        for(int k=0;k<N4;k++){
          dig[0][i][j][k] = true;
          dig[N1-1][i][j][k] = true;
        }
      }
    }
  }
  
  void dig_dfs(int i,int j, int k, int l){
    Delta d = new Delta(4);
    for(int a=0;a<d.n;a++){
      PVector ev = d.eval(a);
      if(ev.x==0){
        int ii = i+int(2*(2*ev.y-1));
        int jj = j;
        int kk = k;
        int ll = l;
        if(!dig[ii][jj][kk][ll]){
          dig[ii][jj][kk][ll] = true;
          dig[(ii+i)/2][(jj+j)/2][(kk+k)/2][(ll+l)/2] = true;
          dig_dfs(ii,jj,kk,ll);
        }
      }
      if(ev.x==1){
        int ii = i;
        int jj = j+int(2*(2*ev.y-1));
        int kk = k;
        int ll = l;
        if(!dig[ii][jj][kk][ll]){
          dig[ii][jj][kk][ll] = true;
          dig[(ii+i)/2][(jj+j)/2][(kk+k)/2][(ll+l)/2] = true;
          dig_dfs(ii,jj,kk,ll);
        }
      }
      if(ev.x==2){
        int ii = i;
        int jj = j;
        int kk = k+int(2*(2*ev.y-1));
        int ll = l;
        if(!dig[ii][jj][kk][ll]){
          dig[ii][jj][kk][ll] = true;
          dig[(ii+i)/2][(jj+j)/2][(kk+k)/2][(ll+l)/2] = true;
          dig_dfs(ii,jj,kk,ll);
        }
      }
      if(ev.x==3){
        int ii = i;
        int jj = j;
        int kk = k;
        int ll = l+int(2*(2*ev.y-1));
        if(!dig[ii][jj][kk][ll]){
          dig[ii][jj][kk][ll] = true;
          dig[(ii+i)/2][(jj+j)/2][(kk+k)/2][(ll+l)/2] = true;
          dig_dfs(ii,jj,kk,ll);
        }
      }
    }
  }
  
  void solve(){
    boolean res = recursiveSolve(startI, startJ, startK, startL);
    return;
  }
  
  boolean recursiveSolve(int i, int j,int k,int l) {
      if (i == endI && j == endJ && k == endK && l == endL){
        correctPath[i][j][k][l] = true;
        return true;
      }
      if (!dig[i][j][k][l] || wasHere[i][j][k][l]) return false;  

      wasHere[i][j][k][l] = true;
      if (recursiveSolve(i-1, j,k,l)){
          correctPath[i][j][k][l] = true;
          return true;
      }
      if (recursiveSolve(i+1, j,k,l)){
          correctPath[i][j][k][l] = true;
          return true;
      }
      if (recursiveSolve(i, j,k-1,l)){
          correctPath[i][j][k][l] = true;
          return true;
      }
      if (recursiveSolve(i, j,k+1,l)){
          correctPath[i][j][k][l] = true;
          return true;
      }
      if (recursiveSolve(i, j-1,k,l)){
          correctPath[i][j][k][l] = true;
          return true;
      }
      if (recursiveSolve(i, j+1,k,l)){
          correctPath[i][j][k][l] = true;
          return true;
      }
      if (recursiveSolve(i, j,k,l-1)){
          correctPath[i][j][k][l] = true;
          return true;
      }
      if (recursiveSolve(i, j,k,l+1)){
          correctPath[i][j][k][l] = true;
          return true;
      }
      return false;
  }
  
  void show(float x,float y,float step){
    for(int k=2;k<=N3-2;k+=2){
      for(int l=2;l<=N4-2;l+=2){
        for(int i=1;i<N1-1;i++){
          for(int j=1;j<N2-1;j++){
            if(dig[i][j][k][l]){
              float xx = x + (i + (N1-2)*(k/2 - 1))*step;
              float yy = y + (j + (N2-2)*(l/2 - 1))*step;
              
              rectMode(CENTER);
              fill(255,130);
              strokeWeight(1);
              stroke(255,80);
              
              rect(xx,yy,2.3*step,2.3*step);
            }
          }
        }
        for(int i=1;i<N1-1;i++){
          for(int j=1;j<N2-1;j++){
            if(dig[i][j][k][l]){
              float xx = x + (i + (N1-2)*(k/2 - 1))*step;
              float yy = y + (j + (N2-2)*(l/2 - 1))*step;
              
              rectMode(CENTER);
              fill(0);
              strokeWeight(1);
              stroke(0);
              
              rect(xx,yy,1.75*step,1.75*step);
            }
          }
        }
        for(int i=1;i<N1-1;i++){
          for(int j=1;j<N2-1;j++){
            if(correctPath[i][j][k][l]){
              float xx = x + (i + (N1-2)*(k/2 - 1))*step;
              float yy = y + (j + (N2-2)*(l/2 - 1))*step;
              
              rectMode(CENTER);
              fill(0,200,0);
              strokeWeight(1);
              stroke(0,200,0);
              
              rect(xx,yy,1.75*step,1.75*step);
            }
          }
        }
        // very stupid loop incoming !
        for(int i=1;i<N1-1;i++){
          for(int j=1;j<N2-1;j++){
            if((i==startI&&j==startJ&&k==startK&&l==startL)||(i==endI&&j==endJ&&k==endK&&l==endL)){
              float xx = x + (i + (N1-2)*(k/2 - 1))*step;
              float yy = y + (j + (N2-2)*(l/2 - 1))*step;
              
              rectMode(CENTER);
              fill(0,0,200);
              strokeWeight(1);
              stroke(0,0,200);
              
              rect(xx,yy,1.75*step,1.75*step);
            }
          }
        }
        for(int i=1;i<N1-1;i++){
          for(int j=1;j<N2-1;j++){
            if(dig[i][j][k][l]){
              float xx = x + (i + (N1-2)*(k/2 - 1))*step;
              float yy = y + (j + (N2-2)*(l/2 - 1))*step;
              
              if(dig[i][j][k-1][l]){
                draw_left_arrow(xx,yy,step,correctPath[i][j][k-1][l]);
              }
              if(dig[i][j][k+1][l]){
                draw_right_arrow(xx,yy,step,correctPath[i][j][k+1][l]);
              }
              if(dig[i][j][k][l-1]){
                draw_up_arrow(xx,yy,step,correctPath[i][j][k][l-1]);
              }
              if(dig[i][j][k][l+1]){
                draw_down_arrow(xx,yy,step,correctPath[i][j][k][l+1]);
              }
            }
          }
        }
      }
    }
  }
}

void draw_arrow(float x,float y,float step,float rot,boolean b){
  push();
  translate(x,y);
  rotate(rot);
  
  if(!b){
    noFill();
    stroke(255,255,255,180);
    strokeWeight(2);
  } else {
    stroke(255,0,0,200);
    strokeWeight(3);
  }
  
  beginShape();
  vertex(0.55*step,0.3*step);
  vertex(0.75*step,0*step);
  vertex(0.55*step,-0.3*step);
  endShape(CLOSE);
  
  pop();
}

void draw_left_arrow(float x,float y,float step,boolean b){
  draw_arrow(x,y,step,PI,b);
}
void draw_right_arrow(float x,float y,float step,boolean b){
  draw_arrow(x,y,step,0,b);
}
void draw_up_arrow(float x,float y,float step,boolean b){
  draw_arrow(x,y,step,-HALF_PI,b);
}
void draw_down_arrow(float x,float y,float step,boolean b){
  draw_arrow(x,y,step,HALF_PI,b);
}

Maze M;

void setup(){
  size(600,600,P2D);
  result = new int[width*height][3];
  
  noise = new OpenSimplexNoise();
  
  M = new Maze(6,6,3,3);
  
  M.dig_dfs(2,2,2,2);
  
  M.solve();
  
  background(0);
  
  M.show(15,15,14);
  
  saveFrame("fr"+floor(random(100000))+".png");
}

void draw_(){
  //background(0);
  push();
  
  pop();
}