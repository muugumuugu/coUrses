* Snake Object
	* attributes
		* position
		* speed
		* tail length
		* tail : array of positions
	* function
		* update :
			* pos+=speed
			* loop: tail[i]=tail[i+1] if total==tail.length
			* tail[last]=this.positions
		* show : draw boxes of size s for snakes tail length. and its head
		* death check : if pos> constrain in any dimension . die and restart, loop thru the tail and if pos(head)=tail[i] pos then its a loop death.
		* eat(food position) : increase total, add a tail box & pick new food position if dist between food and self < size=s
* Bind global Keybindings
	* switch according to keycode, and change speed direction.
* random position picker for food.
```

```