import numpy as np
import matplotlib.pyplot as plt
import seaborn; seaborn.set() # Plot styling


#-------------------------
#BOG - shuffle till Sorted
def bogosort(x):
    while np.any(x[:-1] > x[1:]):
        np.random.shuffle(x)
    return x
#keep finding the mins
def selection_sort(x):
    for i in range(len(x)):
        swap = i + np.argmin(x[i:])
        (x[i], x[swap]) = (x[swap], x[i])
    return x
#----------------------------------------
# FAST SORTS
#np.sort : default --> quicksort algorithm, though mergesort and heapsort are also available
#returs a sorted version of the array without modifying the input
x = np.array([2, 1, 4, 3, 5])
print(x)
print(np.sort(x))
#np. argsort, instead returns the indices of the sorted elements:
i = np.argsort(x)
print(i)
#---------------------------
print('_'*100)
#MULTI DIMENSIONAL
rand = np.random.RandomState(42)
X = rand.randint(0, 10, (4, 6))
print(X)
# sort each row of X
print(np.sort(X, axis=1))#this treats each row or column as an independent array, and any relationships between the row or column values will be lost!
#-----------------------------
print('_'*100)
# getting k smallest nums to left and rest to right, in arbitrary order (poset partitioning)
print(np.partition(X, 2, axis=1))
#-------------------
print('_'*100)
#NEAREST neighbour
X = rand.rand(3, 2)
print(X)
plt.scatter(X[:, 0], X[:, 1], s=100)
plt.show()
dist_sq = np.sum((X[:, np.newaxis, :] - X[np.newaxis, :, :]) ** 2, axis=-1)#It's more convenient to write t.sum(axis=-1) than it is to write the equivalent t.sum(axis=t.ndim-1)
#this is a one liner for
"""
# for each pair of points, compute differences in their coordinates
differences = X[:, np.newaxis, :] - X[np.newaxis, :, :]
# square the coordinate differences
sq_differences = differences ** 2
# sum the coordinate differences to get the squared distance
dist_sq = sq_differences.sum(-1)
"""
#dbl check : look @diagonal of this matrix (i.e., the set of distances between each point and itself) is all zero:
print(dist_sq.diagonal())
#find the index
nearest = np.argsort(dist_sq, axis=1)
print(nearest)
#first column gives the numbers 0 through 3 in order: this is due to the fact that each point's closest neighbor is itself.
"""
done more work than we need to in this case.
If we're simply interested in the nearest 𝑘 neighbors
all we need is to partition each row so that the smallest 𝑘+1 squared distances come first
with larger distances filling the remaining positions of the array.
We can do this with the np.argpartition function:
"""
print('_'*100)
X = rand.rand(10, 2)
dist_sq = np.sum((X[:, np.newaxis, :] - X[np.newaxis, :, :]) ** 2, axis=-1)
print(X)
K = 2
nearest_partition = np.argpartition(dist_sq, K+1, axis=1)
plt.scatter(X[:, 0], X[:, 1], s=100)
print(nearest_partition)
# draw lines from each point to its two nearest neighbors
for i in range(X.shape[0]):
    for j in nearest_partition[i, :K+1]:
        # plot a line from X[i] to X[j]
        plt.plot(*zip(X[j], X[i]), color='black')# zip --> cartesion product. , * just opens the iterator.
plt.show()








































#EOF