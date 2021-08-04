extern CYLINDER thecylinder;
extern CONE thecone;
extern CIRCLE thecircle;
extern PLANE theplane;
extern PARABOLA theparabola;
extern RECTONICAL therectonical;

extern WindowPtr outwindow;
extern PicHandle inpicture;

pascal void CYLINDERline(p2)
Point p2;
{
	short sx,sy;
	short mu,incr;
	Rect r;
	double x,y,theta,radius,dx,dy,dh,dv,length;
	Point p,p1;
	
	GetPen(&p1);
	
	/* Determine the centre of the window */
	r = outwindow->portRect;
	ClipRect(&r);
	sx = (r.right + r.left) / 2;
	sy = (r.bottom + r.top) / 2;
	
	/* Determine the bounds of the image being transformed */
	r = (*inpicture)->picFrame;
	dx = (thecylinder.theta1 - thecylinder.theta2) / (double)(r.right  - r.left);
	dy = (thecylinder.r1     - thecylinder.r2    ) / (double)(r.bottom - r.top );
	
	/*
		Calculate the length of the line and hence the resolution
		at which to draw it
	*/
	dh = p2.h - p1.h;
	dv = p2.v - p1.v;
	length = sqrt(dh*dh + dv*dv);
	if (length <= 3)
		incr = 1;
	else if (length < 10)
		incr = 3;
	else if (length < 100)
		incr = 15;
	else
		incr = 30;
	
	for (mu=0;mu<=incr;mu++) {
		x = p1.h + mu * dh / incr - r.left;
		y = p1.v + mu * dv / incr - r.top;
		theta  = x * dx + thecylinder.theta2;
		radius = y * dy + thecylinder.r2;
		
		p.h = sx + (short)(radius * cos(theta*DTOR));
		p.v = sy - (short)(radius * sin(theta*DTOR));
		if (mu == 0)
			MoveTo(p.h,p.v);
		else
			StdLine(p);
	}
}

pascal void CONEline(p2)
Point p2;
{
	short sx,sy;
	short mu,incr;
	Rect r;
	double x,y,theta,dx,dy,cx,cy,dh,dv,length;
	double radius,rnew,ra,slope;
	Point p,p1;
	
	GetPen(&p1);
	
	/* Determine the centre of the window */
	r = outwindow->portRect;
	ClipRect(&r);
	sx = (r.right + r.left) / 2;
	sy = (r.bottom + r.top) / 2;
	
	/* Determine the bounds of the image being transformed */
	r = (*inpicture)->picFrame;
	dx = (r.right - r.left) / 2.0;
	dy = (r.bottom - r.top) / 2.0;
	cx = (r.right + r.left) / 2.0;
	cy = (r.bottom + r.top) / 2.0;
	ra = sqrt(dx*dx + dy*dy);
	slope = (thecone.r1 - thecone.r2) / ra;
	
	/*
		Calculate the length of the line and hence the resolution
		at which to draw it
	*/
	dh = p2.h - p1.h;
	dv = p2.v - p1.v;
	length = sqrt(dh*dh + dv*dv);
	if (length <= 3)
		incr = 1;
	else if (length < 10)
		incr = 3;
	else if (length < 100)
		incr = 15;
	else
		incr = 30;
	
	for (mu=0;mu<=incr;mu++) {
		x = p1.h + (mu * dh) / incr - cx;
		y = p1.v + (mu * dv) / incr - cy;
		theta  = myarctan(x,y);
		radius = sqrt(x*x + y*y);
		rnew = slope * radius + thecone.r2;
		
		p.h = sx + (short)(rnew * cos(theta));
		p.v = sy + (short)(rnew * sin(theta));
		if (mu == 0)
			MoveTo(p.h,p.v);
		else
			StdLine(p);
	}
}

pascal void CIRCLEline(p2)
Point p2;
{
	short sx,sy;
	short mu,incr;
	Rect r;
	double x,y,xx,yy,dx,dy,cx,cy,dh,dv,length,radius;
	double theta,degrees,specialangle;
	Point p,p1;
	
	GetPen(&p1);
	
	/* Determine the centre of the window */
	r = outwindow->portRect;
	ClipRect(&r);
	sx = (r.right + r.left) / 2;
	sy = (r.bottom + r.top) / 2;
	
	/* Determine the bounds of the image being transformed */
	r = (*inpicture)->picFrame;
	dx = (r.right - r.left) / 2.0;
	dy = (r.bottom - r.top) / 2.0;
	cx = (r.right + r.left) / 2.0;
	cy = (r.bottom + r.top) / 2.0;
	
	/*
		Calculate the length of the line and hence the resolution
		at which to draw it
	*/
	dh = p2.h - p1.h;
	dv = p2.v - p1.v;
	length = sqrt(dh*dh + dv*dv);
	if (length <= 3)
		incr = 1;
	else if (length < 10)
		incr = 3;
	else if (length < 100)
		incr = 15;
	else
		incr = 30;
	
	for (mu=0;mu<=incr;mu++) {
		x = p1.h + (mu * dh) / incr - cx;
		y = p1.v + (mu * dv) / incr - cy;
		theta  = myarctan(x,y);
		degrees = theta * RTOD;
		radius = sqrt(x*x + y*y);
		
		specialangle = myarctan(dx,dy) * RTOD;
		if (degrees < - 180 + specialangle) {
			xx = x * thecircle.rx * ABS(cos(theta) / dx);
			yy = y * thecircle.ry * ABS(cos(theta) / dx);
		} else if (degrees < -specialangle) {
			xx = x * thecircle.rx * ABS(sin(theta) / dy);
			yy = y * thecircle.ry * ABS(sin(theta) / dy);
		} else if (degrees < specialangle) {
			xx = x * thecircle.rx * ABS(cos(theta) / dx);
			yy = y * thecircle.ry * ABS(cos(theta) / dx);
		} else if (degrees < 180 - specialangle) {
			xx = x * thecircle.rx * ABS(sin(theta) / dy);
			yy = y * thecircle.ry * ABS(sin(theta) / dy);
		} else {
			xx = x * thecircle.rx * ABS(cos(theta) / dx);
			yy = y * thecircle.ry * ABS(cos(theta) / dx);
		}
				
		p.h = sx + (short)xx;
		p.v = sy + (short)yy;
		if (mu == 0)
			MoveTo(p.h,p.v);
		else
			StdLine(p);
	}
}

pascal void PLANEline(p2)
Point p2;
{
	short sx,sy,mu,incr;
	Point p,p1;
	Rect r;
	double length,dh,dv,dx,dy,cx,cy;
	double mux,muy;
	double x,y,x1,y1,x2,y2,x3,y3,x4,y4,mu1,mu2;
	
	GetPen(&p1);
	
	/* Determine the centre of the window */
	r = outwindow->portRect;
	ClipRect(&r);
	sx = (r.right + r.left) / 2;
	sy = (r.bottom + r.top) / 2;
	
	/* Determine the bounds of the image being transformed */
	r = (*inpicture)->picFrame;
	dx = (r.right - r.left) / 2.0;
	dy = (r.bottom - r.top) / 2.0;
	cx = (r.right + r.left) / 2.0;
	cy = (r.bottom + r.top) / 2.0;
	
	/*
		Calculate the length of the line and hence the resolution
		at which to draw it
	*/
	dh = p2.h - p1.h;
	dv = p2.v - p1.v;
	length = sqrt(dh*dh + dv*dv);
	if (length <= 3)
		incr = 1;
	else if (length < 10)
		incr = 3;
	else if (length < 100)
		incr = 15;
	else
		incr = 30;

	for (mu=0;mu<=incr;mu++) {
		x = p1.h + mu * dh / incr - r.left;
		y = p1.v + mu * dv / incr - r.top;

		mux = (x - r.left) / (double)(r.right - r.left);
		muy = (y - r.bottom) / (double)(r.top - r.bottom);
	
		x1 = theplane.p1.h + mux * (theplane.p4.h - theplane.p1.h);
		y1 = theplane.p1.v + mux * (theplane.p4.v - theplane.p1.v);
		
		x2 = theplane.p2.h + mux * (theplane.p3.h - theplane.p2.h);
		y2 = theplane.p2.v + mux * (theplane.p3.v - theplane.p2.v);
		
		x3 = theplane.p1.h + muy * (theplane.p2.h - theplane.p1.h);
		y3 = theplane.p1.v + muy * (theplane.p2.v - theplane.p1.v);
		
		x4 = theplane.p4.h + muy * (theplane.p3.h - theplane.p4.h);
		y4 = theplane.p4.v + muy * (theplane.p3.v - theplane.p4.v);
	
		if (!lineintersect(x1,y1,x2,y2,x3,y3,x4,y4,&mu1,&mu2))
			return;
	
		p.h = x1 + mu1 * (x2 - x1);
		p.v = y1 + mu1 * (y2 - y1);
		
		if (mu == 0)
			MoveTo(p.h,p.v);
		else 
			StdLine(p);
	}
}

pascal void PARABOLAline(p2)
Point p2;
{
	short sx,sy,mu,incr;
	Point p,p1;
	Rect r;
	double intersect,scale;
	double length,dh,dv,dx,dy,cx,cy;
	double x,y;
	
	GetPen(&p1);
	
	/* Determine the centre of the window */
	r = outwindow->portRect;
	ClipRect(&r);
	sx = (r.right + r.left) / 2;
	sy = (r.bottom + r.top) / 2;
	
	/* Determine the bounds of the image being transformed */
	r = (*inpicture)->picFrame;
	dx = (r.right - r.left) / 2.0;
	dy = (r.bottom - r.top) / 2.0;
	cx = (r.right + r.left) / 2.0;
	cy = (r.bottom + r.top) / 2.0;
	
	/*
		Calculate the length of the line and hence the resolution
		at which to draw it
	*/
	dh = p2.h - p1.h;
	dv = p2.v - p1.v;
	length = sqrt(dh*dh + dv*dv);
	if (length <= 3)
		incr = 1;
	else if (length < 10)
		incr = 3;
	else if (length < 100)
		incr = 15;
	else
		incr = 30;

	for (mu=0;mu<=incr;mu++) {
		x = p1.h + (mu * dh) / incr - cx;
		x *= (theparabola.b / dx);
		y = p1.v + (mu * dv) / incr - cy;
		
		intersect = y * theparabola.a / dy;
		scale = (y * sy / dy - intersect) / (theparabola.b * theparabola.b);
		
		p.h = sx + x;
		p.v = sy + scale * x * x + intersect;
		
		if (mu == 0)
			MoveTo(p.h,p.v);
		else 
			StdLine(p);
	}
}

pascal void RECTONICALline(p2)
Point p2;
{
	short sx,sy;
	short mu,incr;
	Rect r;
	double x,y,dx,dy,cx,cy,dh,dv,length,slopex,slopey;
	Point p,p1;
	
	GetPen(&p1);
	
	/* Determine the centre of the window */
	r = outwindow->portRect;
	ClipRect(&r);
	sx = (r.right + r.left) / 2;
	sy = (r.bottom + r.top) / 2;
	
	/* Determine the bounds of the image being transformed */
	r = (*inpicture)->picFrame;
	dx = (r.right - r.left) / 2.0;
	dy = (r.bottom - r.top) / 2.0;
	cx = (r.right + r.left) / 2.0;
	cy = (r.bottom + r.top) / 2.0;
	
	/*
		Calculate the length of the line and hence the resolution
		at which to draw it
	*/
	dh = p2.h - p1.h;
	dv = p2.v - p1.v;
	length = sqrt(dh*dh + dv*dv);
	if (length <= 3)
		incr = 1;
	else if (length < 10)
		incr = 3;
	else if (length < 100)
		incr = 15;
	else
		incr = 30;
	
	slopex = (therectonical.x2 - therectonical.x1) / dx;
	slopey = (therectonical.y2 - therectonical.y1) / dy;
	
	for (mu=0;mu<=incr;mu++) {
		x = p1.h + (mu * dh) / incr - cx;
		y = p1.v + (mu * dv) / incr - cy;
		
		if (x >= 0)
			p.h = sx + (short)(x * slopex + therectonical.x1);
		else
			p.h = sx + (short)((x + dx) * slopex - therectonical.x2);

		if (y >= 0)
			p.v = sy + (short)(y * slopey + therectonical.y1);
		else
			p.v = sy + (short)((y + dy) * slopey - therectonical.y2);
		
		if (mu == 0)
			MoveTo(p.h,p.v);
		else
			StdLine(p);
	}
}
