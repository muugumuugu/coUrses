# colors
* raindrops: rgb(138,43,226)
* bg: rgb(30,30,50)

# drop object
* attributes
	* float xposition
		* initialize to random location across width of screen
	* float yposition
		* initialize to random location above screen
	* float dropsize
		* random size of drop
	* float yspeed
* methods
	* fall
		* update yposition with yspeed
		* update yspeed with gravity
		* wrap around the screen/ reset to a random location above the screen.
		* splash if yposition = bottom of screen
	* show
		* say as lines of length dropsize at xpos,ypos.
		* maybe map size to alpha.

# make an array of drops and update all of theme in each frame.