/*-------------------------------------------------------------------------
   Add two number together in hex space
   a and b are given as decimal numbers.
   Normally this would act as a circular addition.
   Straight addition can be performed by using a large resol value, eg: 10.
*/
long HexAdd(long a,long b,long resol)
{
   long A[7][7] =
      { 0, 1, 2, 3, 4, 5, 6,
        1,63,15, 2, 0, 6,64,
        2,15,14,26, 3, 0, 1,
        3, 2,26,25,31, 4, 0,
        4, 0, 3,31,36,42, 5,
        5, 6, 0, 4,42,41,53,
        6,64, 1, 0, 5,53,52 };
   long sevens[12] = {1L,7L,49L,343L,2401L,16807L,117649L,
                       823534L,5764801L,40353607L,282475249L,1977326743L};
   long i,j,t,carry,ta,tb;
   long da[12],db[12];
   long total[12];
   long sum = 0;

   /* Load up the digits in the reverse order */
   ta = a;
   tb = b;
   for (i=0;i<12;i++) {
      da[i] = ta % 7;
      db[i] = tb % 7;
      ta /= 7;
      tb /= 7;
      total[i] = 0;
   }

   /* Do the addition */
   for (i=0;i<12;i++) {
      t = A[da[i]][db[i]];
      total[i] = t % 10;
      carry = t / 10;
      for (j=i+1;j<12;j++) {
         if (carry <= 0)
            break;
         t = A[da[j]][carry];
         da[j] = t % 10;
         carry = t / 10;
      }
   }

   /* Calculate the sum */
   for (i=0;i<12;i++)
      sum += (total[i] * sevens[i]);
   return(sum % sevens[resol]);
}

/*-------------------------------------------------------------------------
   Multiply in hex space
   a and b are given as decimal numbers
   Normally this perfosm a circular multiply. For a straight
   multiply choose a large value of resol. Note there is a limit
   to the size of a straight multiply as the result must be less
   that base 12, thus the operands must be less that base 7.
*/
long HexMul(long a,long b,long resol)
{
   long i,j,k,t,carry,ta,tb;
   long da[12],db[12];
   long total[12];
   long sum = 0;
   long sums[12];       /* Partial sums in decimal */

   long M[7][7] =
      {  0,0,0,0,0,0,0,
         0,1,2,3,4,5,6,
         0,2,3,4,5,6,1,
         0,3,4,5,6,1,2,
         0,4,5,6,1,2,3,
         0,5,6,1,2,3,4,
         0,6,1,2,3,4,5};
   long sevens[12] = {1L,7L,49L,343L,2401L,16807L,117649L,
                       823534L,5764801L,40353607L,282475249L,1977326743L};

   /*
      Shift a left (x10) and b right (/10) until the low digit of b isn't 0
   */
   ta = a;
   tb = b;
   while (tb != 0 && (tb % 7) == 0) {
      ta = 7 * (ta % sevens[resol-1]) + (ta / sevens[resol-1]);
      tb = tb / 7 + (tb % 7) * sevens[resol-1];
   }

   /* Load up the digits in the reverse order */
   for (i=0;i<12;i++) {
      da[i] = ta % 7;
      db[i] = tb % 7;
      ta /= 7;
      tb /= 7;
      sums[i] = 0;
   }

   /* Calculate the partial sums */
   for (i=0;i<resol;i++) {

      for (j=0;j<12;j++)
         total[j] = 0;

      for (j=0;j<resol;j++) {
         k = i + j;
         if (k < 12)
            total[k] = M[db[i]][da[j]];
      }

      for (j=0;j<resol;j++)
         sums[i] += (total[j] * sevens[j]);
   }

   /* Add up all the partial sums */
   for (i=0;i<resol;i++)
      sum = HexAdd(sum,sums[i],resol);

   return(sum % sevens[resol]);
}

