/** A 2D POINTB FROMED BY FLOATS **/

public class Point2Df {
	public float x,y;
	/** Creates a new instance of Point2Df */
	public Point2Df() {
	}
}
 
 
/** METHODS TO CALCULATE THE AREA AND CENTROID OF A POLYGON
    INSERT THEM INTO THE CORRESPONDING CLASS **/
public double SignedPolygonArea(Point[] polygon,int N)
{
	Polygon P;
	int i,j;
	double area = 0;

	for (i=0;i<N;i++) {
		j = (i + 1) % N;
		area += polygon[i].x * polygon[j].y;
		area -= polygon[i].y * polygon[j].x;
	}
	area /= 2.0;

   return(area);
	//return(area < 0 ? -area : area); for unsigned
}
 
 
/* CENTROID */

public Point2Df PolygonCenterOfMass(Point[] polygon,int N)
{
	float cx=0,cy=0;
	float A=(float)SignedPolygonArea(polygon,N);
	Point2Df res=new Point2Df();
	int i,j;

	float factor=0;
	for (i=0;i<N;i++) {
		j = (i + 1) % N;
		factor=(polygon[i].x*polygon[j].y-polygon[j].x*polygon[i].y);
		cx+=(polygon[i].x+polygon[j].x)*factor;
		cy+=(polygon[i].y+polygon[j].y)*factor;
	}
	A*=6.0f;
	factor=1/A;
	cx*=factor;
	cy*=factor;
	res.x=cx;
	res.y=cy;
	return res;
}

