# iso surface
> color = func(pos) //say hue, or brightness

# the meta func
+ choose closest Blob blob
+ or loop thru all and aggreagte the colors as a sum - gluey balls
+ func(pos)=g(blob.radius)/dist(pos,blob.pos)
+ say g=100*r // more for glow

# Blob Object
## attributes
+ radius = random?
+ velocity = random
+ position
## methods
+ show // debug
+ move
	+ pos+=vel
	+ bounce of edges