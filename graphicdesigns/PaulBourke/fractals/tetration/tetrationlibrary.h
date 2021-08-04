
typedef struct {
	double x,y;
	double r,t;
} COMPLEX;

COMPLEX ComplexPower(COMPLEX,COMPLEX);
COMPLEX ComplexTetration(COMPLEX,int);
COMPLEX ComplexTetration2(COMPLEX,int);
void Complex2Polar(COMPLEX *);
void Complex2Cart(COMPLEX *);
double ComplexModulus(COMPLEX);

double RealTetration(double,int);

