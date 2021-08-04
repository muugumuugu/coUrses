/*
	Collection of routines in support of arithmetic on SHM space
	An attempt has been made to make this library self contained,
	that is, it doesn't need external support other than provided
	by standard C ennvironments. Almost all arithmetic is done on
	long ints which are assumed to be at least 4 bytes.
	Paul Bourke
*/

/*
   Return the digit of a base 10 number if it were represented in base 7
	For example: dec 7 = hex 10, first digit is 0, second digit 1
*/
long HexDigit(long b10,long digit)
{
   long b7;

   switch (digit) {
   case  1: b7 = (b10 % 7L);                       break;
   case  2: b7 = (b10 % 49L) / 7L;                 break;
   case  3: b7 = (b10 % 343L) / 49L;               break;
   case  4: b7 = (b10 % 2401L) / 343L;             break;
   case  5: b7 = (b10 % 16807L) / 2401L;           break;
   case  6: b7 = (b10 % 117649L) / 16807L;         break;
   case  7: b7 = (b10 % 823543L) / 117649L;        break;
   case  8: b7 = (b10 % 5764801L) / 823543L;       break;
   case  9: b7 = (b10 % 40353607L) / 5764801L;     break;
   case 10: b7 = (b10 % 282475249L) / 40353607L;   break;
   case 11: b7 = (b10 % 1977326743L) / 282475249L; break;
	default: b7 = 0;
   }

   return(b7);
}

/*
	Return a power of seven, 7^n, where 0 <= n <= 11
	This also gives the number of hexagons in a particular SHM.
	For exaple, a 7^4 SHM has 2401 hexagons.
*/
long HexPower(long n)
{
	long sevens[12] = {1L,7L,49L,343L,2401L,16807L,117649L,
        823534L,5764801L,40353607L,282475249L,1977326743L};

	if (n >= 0 && n <= 11)
		return(sevens[n]);
	else
		return(0);
}

/*
   Determine x-y coordinates in hexagnal space
	This formulation uses a hexagon lying "flat" the distance
   from the center to a vertex is 1. The hexagon of address
	0 is centered at the origin
             +------+         -
            /        \        |
           /          \       |
          +     +      +    sqrt(3)
           \          /       |
            \        /        |
             +------+         -
          |- 1 -|
	Constants used in the code
   	1.04719755119659775        = 60 degrees
   	0.713724378944765631       = atan(sqrt(3)/2)
   	3.141592653589793238462643 = pi
   	1.7320508075688772935      = sqrt(3)
   	4.5826593560436152626      = sqrt(21)
   	2.2913296780218076313      = sqrt(21) / 2
   	2.6457513110645905905      = sqrt(7)
*/
void HexCoord(long b10,double *X,double *Y)
{
   long i;
   double radius,theta;

   *X = 0;
   *Y = 0;
   radius = 1.7320508075688772935;
   for (i=1;i<12;i++) {
      if (i > 1)
         radius *= 2.6457513110645905905;
      if (HexDigit(b10,i) != 0) {
         theta = 3.141592653589793238462643
               + (i - 1) * 0.713724378944765631
               + (HexDigit(b10,i) - 1) * 1.04719755119659775;
         *X += (radius * sin(theta));
         *Y += (radius * cos(theta));
      }
   }
}

/*
   Add two number together in hex space
   a and b are given as decimal numbers.
	Normally this would act as a circular addition.
	Straight addition can be performed by using a large resol value, eg: 10.
*/
long HexAdd(long a10,long b10,long resol)
{
   long addtable[7][7] =
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
   ta = a10;
   tb = b10;
   for (i=0;i<12;i++) {
      da[i] = ta % 7;
      db[i] = tb % 7;
      ta /= 7;
      tb /= 7;
      total[i] = 0;
   }

   /* Do the addition */
   for (i=0;i<12;i++) {
      t = addtable[da[i]][db[i]];
      total[i] = t % 10;
      carry = t / 10;
      for (j=i+1;j<12;j++) {
         if (carry <= 0)
            break;
         t = addtable[da[j]][carry];
         da[j] = t % 10;
         carry = t / 10;
      }
   }

   /* Calculate the sum */
   for (i=0;i<12;i++)
      sum += (total[i] * sevens[i]);
   return(sum % sevens[resol]);
}

/*
   Same as HexAdd() except a and b are given in base 7
*/
long HexAdd_b7(long a7,long b7,long resol)
{
   return(HexAdd(Hex2Dec(a7),Hex2Dec(b7),resol));
}

/*
   Multiply in hex space
   a and b are given as decimal numbers
	Normally this perfosm a circular multiply. For a straight
	multiply choose a large value of resol. Note there is a limit
	to the size of a straight multiply as the result must be less
	that base 12, thus the operands must be less that base 7.
*/
long HexMul(long a10,long b10,long resol)
{
   long i,j,k,t,carry,ta,tb;
   long da[12],db[12];
   long total[12];
   long sum = 0;
   long sums[12];       /* Partial sums in decimal */

   long multable[7][7] =
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
   ta = a10;
   tb = b10;
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
            total[k] = multable[db[i]][da[j]];
      }

      for (j=0;j<resol;j++)
         sums[i] += (total[j] * sevens[j]);
   }

   /* Add up all the partial sums */
   for (i=0;i<resol;i++)
      sum = HexAdd(sum,sums[i],resol);

   return(sum % sevens[resol]);
}

/*
   Same as HexMul() except a and b are given in base 7
*/
long HexMul_b7(long a7,long b7,long resol)
{
   return(HexMul(Hex2Dec(a7),Hex2Dec(b7),resol));
}

/*
	Shift left (whichway == 1) or right (whichway = 2) circular
	a number of times
	Can be done with multiplications but this is often much faster
*/
long HexShift(long a10, int whichway, int howmany, long resol)
{
	int i;
	long ans;
   long sevens[12] = {1L,7L,49L,343L,2401L,16807L,117649L,
        823534L,5764801L,40353607L,282475249L,1977326743L};

	resol--;
	if (resol < 0)
		return(0);
	ans = a10;
	for (i=0;i<howmany;i++) {
		switch (whichway) {
		case 1:
			ans = 7 * (ans % sevens[resol]) + ans / sevens[resol];
			break;
		case 2:
			ans = ans / 7 + (ans % 7) * sevens[resol];
			break;
		}
	}
	return(ans);
}

/*
   Convert a decimal number into hex digits
*/
long Dec2Hex(long a10)
{
   long hex,ten;

   hex = 0;
   ten = 1;
   while (a10 > 0) {
      hex += ten * (a10 % 7);
      ten *= 10;
      a10 /= 7;
   }

   return(hex);
}

/*
   Convert hex digits into a decimal
*/
long Hex2Dec(long a7)
{
   long dec,seven;

   dec = 0;
   seven = 1;
   while (a7 > 0) {
      dec += seven * (a7 % 10);
      seven *= 7;
      a7 /= 10;
   }

   return(dec);
}

/*
	Return TRUE if a cell is on an even column (row)
*/
long HexEven(long dec)
{
	int hindex;
	double x,y;

	HexCoord(dec,&x,&y);
	hindex = rint(ABS(x) / 1.5);
	if (hindex % 2 == 0)
		return(TRUE);
	else
		return(FALSE);
}

/*
   Return TRUE if a cell is on the left semicircle
	Cells at x=0 are on the left if above 0
	0 and cells below 0 are on the right
*/
long HexLeft(long dec)
{
   double x,y;

   HexCoord(dec,&x,&y);
   if (x < -0.1)
      return(TRUE);
	else if (x > 0.1)
		return(FALSE);
	else if (y > 0.1)
		return(TRUE);
   else
      return(FALSE);
}

/*
   Perform a reflection of an SHM address a (in decimal)
   about either 'x' or 'y' axis. For a particular base not
   all addresses will have a reflected counterpart, this
   routine returns -1 in those cases.
   Note: this is VERY inefficient, do it once for a reflection table
*/
long HexReflect(long a10,long base,int axis)
{
   long i;
   double d,dmin = 1e32;
   long amin = -1;
   double x,y,cx,cy;

   HexCoord(a10,&cx,&cy);
   for (i=0;i<HexPower(base);i++) {
      HexCoord(i,&x,&y);
      if (axis == 'x' || axis == 'X')
         y = -y;
      else
         x = -x;
      d = (x - cx) * (x - cx) + (y - cy) * (y - cy);
      if (d < dmin) {
         dmin = d;
         amin = i;
      }
   }
   if (dmin <= 1)
      return(amin);
   else
      return(-1);
}

/*
   Find the "magnitude" of a hex address
	There 1288 vertical hexagons for a 7^8 SHM
*/
long HexMagnitude(long a10)
{
   long i,sum = 0,imin=0;
   double x,y,x1,y1,dx,dy;
   double dist0,dist,dmin = 1e32;

   HexCoord(a10,&x,&y);
   dist0 = sqrt(x * x + y * y);

   for (i=0;i<1288;i++) {
      HexCoord(sum,&x1,&y1);
		dist = dist0 - sqrt(x1 * x1 + y1 * y1);
      if (fabs(dist) < dmin) {
         dmin = dist;
			imin = sum;
      }
		if (dist + sqrt(3.0) < 0)
			break;
      sum = HexAdd(sum,1L,10);
   }
   return(imin);
}

/*
	Return the Euclidean distance between two addresses
*/
double HexDistance(long a1,long a2)
{
	double x1,y1,x2,y2,dx,dy;

	HexCoord(a1,&x1,&y1);
	HexCoord(a2,&x2,&y2);
	dx = x2 - x1;
	dy = y2 - y1;

	return(sqrt(dx*dx + dy*dy));
}

/*
	Return the euclidean angle between two addresses
*/
double HexAngle(long a1,long a2)
{
	double x1,y1,x2,y2,dx,dy;

   HexCoord(a1,&x1,&y1);
   HexCoord(a2,&x2,&y2);
   dx = x2 - x1;
   dy = y2 - y1;

	return(atan2(dy,dx));
}

/*
   "Find" the inverse of a hex multiplicative address
   Return 0 if an inverse doesn't exist
   VERY inefficient, use it to make a table!
*/
long HexInverse(long a10,long base,long basemax)
{
   long i;

   if (a10 <= 0)
      return(0);

   for (i=0;i<HexPower(basemax);i++) {
      if (HexMul(a10,i,base) == 1)
         return(i);
   }
   return(0);
}

/*
	Return the "next" sqrt of an address
	Since multiple square roots can exist for a particular base
	this routine is designed to be called multiple times until
	it returns -1 (no sqrt). On the first call "start" would be
	-1, on subsequent calls "start" would be one more than the
	last square root found.
	For example
      lastroot = -1;
      while ((lastroot = HexSqrt(i,lastroot+1,4)) >= 0)
         printf("%ld\t",lastroot);

*/
long HexSqrt(long a10,long start,long base)
{
	long i;

   i = start;
	while (i < HexPower(base)) {
      if (HexMul(i,i,base) == a10) 
         return(i);
		i++;
   }
	return(-1);
}

/*
	Complex powers
	This is based on a geometric interpretation, same radius, angle*power
	In particular power = 2 for square, power = 0.5 for squareroot
	In all cases the "closest" hex cell is returned.
	Return -1 of out of bounds
*/
long HexComplexPower(long a10,double power,long base)
{
	long j;
	double r,theta,x,y;

	HexCoord(a10,&x,&y);
   r = sqrt(x*x + y*y);
   theta = power * atan2(y,x);
   x = r * cos(theta);
   y = r * sin(theta);
   j = CoordHex(x,y,base+1);
	if (j < HexPower(base))
		return(j);
	else
		return(-1L);
}

/*
	Given a cartesian coordinate find the closest hex cell
	Very inefficient, does a linear search using HexCoord()
	Assumes you know the maximum range of your addresses
	Returns -1 if the closest is outside the SHM of 7^base
*/
long CoordHex(double x, double y, long base)
{
	long i,closest=-1;
	double cx,cy;
	double dx,dy,dist,mindist=1e32;

	for (i=0;i<HexPower(base);i++) {
		HexCoord(i,&cx,&cy);
		dx = cx - x;
		dy = cy - y;
		dist = dx*dx + dy*dy;
		if (dist < mindist) {
			mindist = dist;
			closest = i;
			if (mindist < 0.866)
				break;
		}	
	}
	if (mindist > 1)
		closest = -1;
	return(closest);
}

