# Quick Sort's Recursive Algorithm
## loop end condition
start ≥ end
## partition
* pick a pivot:
	take end, easiest. // Lomuto scheme
* put everything below pivot to the left, and other's to the right.
	start pivotindex at start
	compare everything on the pivot to get its final position.
		just count no of els lower, and add 1 to get the index.
		perform some swaps
			swap with val at position= current val of pivot index. if lesser.
	call quick sort on the left and right parts.



```
// Sorts a (portion of an) array, divides it into partitions, then sorts those
algorithm quicksort(A, lo, hi) is
  if lo >= 0 && hi >= 0 && lo < hi then
    p := partition(A, lo, hi)
    quicksort(A, lo, p) // Note: the pivot is now included
    quicksort(A, p + 1, hi)

// Divides array into two partitions
algorithm partition(A, lo, hi) is
  // Pivot value
  pivot := A[ floor((hi + lo) / 2) ] // The value in the middle of the array

  // Left index
  i := lo - 1

  // Right index
  j := hi + 1

  loop forever
    // Move the left index to the right at least once and while the element at
    // the left index is less than the pivot
    do i := i + 1 while A[i] < pivot

    // Move the right index to the left at least once and while the element at
    // the right index is greater than the pivot
    do j := j - 1 while A[j] > pivot

    // If the indices crossed, return
    if i ≥ j then return j

    // Swap the elements at the left and right indices
    swap A[i] with A[j]
//The entire array is sorted by:
quicksort(A, 0, length(A) - 1).
```