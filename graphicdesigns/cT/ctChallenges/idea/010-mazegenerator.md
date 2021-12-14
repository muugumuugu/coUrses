# recursive algorithm
1. Given a current cell as a parameter,
2. Mark the current cell as visited
3. While the current cell has any unvisited neighbour cells
	1. Choose one of the unvisited neighbours
	2. Remove the wall between the current cell and the chosen cell
	3. Invoke the routine recursively for a chosen cell
which is invoked once for any initial cell in the area.

# cell object
## attributes
* i = column numbers
* j = row number
* wall mask array
	keeps track of wheteher or not ith wall is present.
* visited flag
	for DFS/BFS etc traversal

## methods
* show
	* draw walls individually using wall mask as conditionals
	* color based on visited status
* check neighbours
	* marching ahead
	* create unvisited ngbr array
	* choose random one of them and
		*remove the adjoinng wall by setting
			* the ith wall to false of the current,
			* and the complementary wall of the chosen cell.
		* flag as visited
		* push it to the stack
		* make it current.
	* if ngbr array empty,
		* pop an element from stack and make it current.
	* loop thru till all cells are flaged visited.
