   #declare RSEED = seed(2111);
   #declare DIM = 10;
   #declare i = -DIM;
   #while (i < DIM+1)
      #declare j = -DIM;
      #while (j < DIM+1)
         object {
            oneunit
            #if (rand(RSEED) < 0.5)
               rotate <0,0,90>
            #end
            #if (rand(RSEED) < 0.5)
               scale <-1,1,1>
            #end
            #if (rand(RSEED) < 0.5)
               scale <1,-1,1>
            #end
            translate <i,j,0>
         }  
         #declare j = j + 1; 
      #end     
      #declare i = i + 1;
   #end     

