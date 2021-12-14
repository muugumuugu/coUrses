# ship object
## attributes
* x position
## methods
* show
* move(direction)
	this.x+=direction*stepsize
# alien object
## attributes
* x position(x,y)
* y position
## methods
* show
* move : auto
	* static class var = xdir, ydir
	* y+=ydir
	* reset ydir to 0
	* x+==xdir
	* if x hits wall
		* make ydir=1
		* xdir=-xdir.

# canon object(x)
## attributes
* x = ship.x @ firing time
* y
##methods
* move : auto
	this.y-=1;
* show
* hits-alien check(alien)
	d=distance (this,alien) - alien.r - this.r
# bind keypressed
	to ship.movefunctions
	ship.shootfunctions
		add drop to drops array at current x
# intersection checking
* for all aliens for all canons
* check if distance b/w this and otherobj ≤ this.r+ otherobj.r
* on true
	* flag the canon to delete it.
* kill the alien


# deletion loop
traverse backward and delete flagged canons

# winning check
* if aliens.y>height lose
* if aliens array's length = 0 WIN