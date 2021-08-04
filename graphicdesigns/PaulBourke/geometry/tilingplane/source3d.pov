#declare RSEED = seed(2111);
#declare DIM = 6;
#declare i = -DIM;
#while (i < DIM+1)
   #declare j = -DIM;
   #while (j < DIM+1)
      #declare k = -DIM;
      #while (k < DIM+1)
         object {
            oneunit
            rotate <int(rand(RSEED)*4)*90,0,0>
            rotate <0,int(rand(RSEED)*4)*90,0>
            rotate <0,0,int(rand(RSEED)*4)*90>
            #if (rand(RSEED) < 0.5)
               scale <-1,1,1>
            #end
            #if (rand(RSEED) < 0.5)
               scale <1,-1,1>
            #end
            #if (rand(RSEED) < 0.5)
               scale <1,1,-1>
            #end
            translate <i,j,k>
         }
         #declare k = k + 1;
      #end
      #declare j = j + 1;
   #end
   #declare i = i + 1;
#end

