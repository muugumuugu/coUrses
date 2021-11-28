# cell object

## attributes
* position vector
	initiate:randomly / maybe according to parent + some random
* gene: color (from parent).
* radius
* lifespan?
* generation?
* age


## methods
* move
	* steering behaviour?
	* random.
* show
	* circle(pos;r)
	* alpha according to generation?
* grow?
* split
	* remove current from list of all living cells (splicing)
	* do so on mousepress/ lifespan = criteria
		* to detect mousepressed handle.
		* check via mousex and mousey being in bounds.
	* make 2 new cells with r = r/2, age=0.
	* add children to list of living cells.
