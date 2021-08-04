/*
   Recursive definition for tetration
*/
COMPLEX ComplexTetration(COMPLEX a,int n)
{
   COMPLEX b,unity = {1,0,1,0};

   if (n < 0) // Actually this is improper, tetration is only defined for n >= 0
      n = -n;
   if (n == 0) 
      return(unity);
   b = ComplexPower(a,ComplexTetration(a,n-1));

   return(b);
}

/*
   Iterative definition for tetration
*/
COMPLEX ComplexTetration2(COMPLEX a,int n)
{
   int i;
   COMPLEX b,unity = {1,0,1,0};

   if (n < 0) // Actually this is improper, tetration is only defined for n >= 0
      n = -n;
   if (n == 0)
      return(unity);

   b = a;
   for (i=0;i<n;i++) 
      b = ComplexPower(a,b);
   
   return(b);
}

/*
   Complex power of a complex number
*/
COMPLEX ComplexPower(COMPLEX w,COMPLEX z)
{
   COMPLEX d;
   
   d.r = pow(w.r,z.x) * exp(-z.y * w.t);
   d.t = z.y * log(w.r) + z.x * w.t;
   Complex2Cart(&d);

   return(d);
}

void Complex2Polar(COMPLEX *a)
{
   a->r = sqrt(a->x*a->x + a->y*a->y);
   a->t = atan2(a->y,a->x);
}
void Complex2Cart(COMPLEX *a)
{
   a->x = a->r * cos(a->t);
   a->y = a->r * sin(a->t);
}

/*
   Recursive definition for tetration
*/
double RealTetration(double a,int n)
{
   double b;

   if (n < 0) // Actually this is improper, tetration is only value for n >= 0
      n = -n;
   if (n == 0) 
      return(1);

   b = pow(a,RealTetration(a,n-1));

   return(b);
}

double ComplexModulus(COMPLEX z)
{
   double m;

   m = sqrt(z.x*z.x + z.y*z.y);

   return(m);
}

