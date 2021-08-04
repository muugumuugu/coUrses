-(int) findIntersectionOfCircle: (Circle *)c1 circle:(Circle *)c2 sol1:(CGPoint *)sol1 sol2:(CGPoint *)sol2 
{
	//Calculate distance between centres of circle
	float d =[MathsFunctions calcDistance:c1.centre end:c2.centre];
	float c1r = [c1 radius];
	float c2r = [c2 radius];
	float m = c1r + c2r;
	float n = c1r - c2r;
	
	if (n < 0)
		n = n * -1;
	
	//No solns
	if ( d > m )
		return 0;
	
	//Circle are contained within each other
	if ( d < n )
		return 0;
	
	//Circles are the same
	if ( d == 0 && c1r == c2r )
		return -1;
	
	//Solve for a
	float a = ( c1r * c1r - c2r * c2r + d * d ) / (2 * d);
	
	//Solve for h
	float h = sqrt( c1r * c1r - a * a );
	
	//Calculate point p, where the line through the circle intersection points crosses the line between the circle centers.  
	CGPoint p;
	
	p.x = c1.centre.x + ( a / d ) * ( c2.centre.x -c1.centre.x );
	p.y = c1.centre.y + ( a / d ) * ( c2.centre.y -c1.centre.y );
	
	//1 soln , circles are touching
	if ( d == c1r + c2r ) {
		*sol1 = p;
		return 1;
	}
	//2solns	
	CGPoint p1;
	CGPoint p2;
	
	p1.x = p.x + ( h / d ) * ( c2.centre.y - c1.centre.y );
	p1.y = p.y - ( h / d ) * ( c2.centre.x - c1.centre.x );
	
	p2.x = p.x - ( h / d ) * ( c2.centre.y - c1.centre.y );
	p2.y = p.y + ( h / d ) * ( c2.centre.x - c1.centre.x );
	
	*sol1 = p1;
	*sol2 = p2;
	
	return 2;	
}
