typedef struct {					/* Definition of cylindrical anamorphism */
	short theta1,theta2;
	short r1,r2;
} CYLINDER;

typedef struct {					/* Definition of conical anamorphism	*/
	short r1,r2;
} CONE;

typedef struct {					/* Definition of circular anamorphism	*/
	double rx,ry;
} CIRCLE;

typedef struct {					/* Definition of planar anamorphism		*/
	Point p1,p2,p3,p4;
} PLANE;

typedef struct {					/* Definition of parabolic anamorphism		*/
	double a,b;
} PARABOLA;

typedef struct {					/* Definition of rectonical anamorphism		*/
	double x1,x2;
	double y1,y2;
} RECTONICAL;

