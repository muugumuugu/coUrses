
# fancy idexing
# passing an array of indices to access multiple array elements at once
import numpy as np
import matplotlib.pyplot as plt
import seaborn; seaborn.set()  # for plot styling
#
rand = np.random.RandomState(42)
#----------------------
x = rand.randint(100, size=10)
print(x)
ind = [3, 7, 4]#access three different elements
print(ind)
print(x[ind])
print("-"*10)
# with fancy indexing, the shape of the result reflects the shape of the index arrays rather than the shape of the array being indexed
ind = np.array([[3, 7], [4, 5]])
print(x)
print(ind)
print(x[ind])#multi -dimnsion
print('_'*100)
X = np.arange(12).reshape((3, 4))
print("-"*10)
row = np.array([0, 1, 2])
col = np.array([2, 1, 3])
print("row,col")
print(row,col)
print(X)
print(X[row, col])
#first value in the result is X[0, 2], the second is X[1, 1], and the third is X[2, 3].
#The pairing of indices in fancy indexing follows all the broadcasting rules
print("-"*10)
print(X)
print(row[:, np.newaxis])
print(col)
print(row[:, np.newaxis] * col)# broadcasting rules ex
print(X[row[:, np.newaxis], col])#combine a column vector and a row vector within the indices, we get a two-dimensional result
#=======================
print('_'*100)
#Combining indexing methods
print(X)
print(X[2, [2, 0, 1]]) #simple+fancy
print(X[1:, [2, 0, 1]]) #slicing+fancy
mask = np.array([1, 0, 1, 0], dtype=bool)
print(X[row[:, np.newaxis], mask]) # mask+foncy
#====================
#Selecting Random Points
print('_'*100)
mean = [0, 0]
cov = [[1, 2],
       [2, 5]]
X = rand.multivariate_normal(mean, cov, 100) #controlled randomness - 2d normal distribution
#selecting 20 random points
#choosing 20 random indices with no repeats, and use these indices to select a portion of the original array:
indices = np.random.choice(X.shape[0], 20, replace=False)
print(indices)
selection = X[indices]  # fancy indexing here
#display
plt.scatter(X[:, 0], X[:, 1], alpha=0.5,s=10)
plt.scatter(selection[:, 0], selection[:, 1],alpha=0.8, s=50);
plt.show()
#---------------------------------
#modyfying data with foncy
x = np.arange(10)
i = np.array([2, 1, 8, 4])
x[i] = 99
print(x)
#-----------
print("-"*10)
# repeating indices leads to only last assignment taking place
# if it is required that a operation be repeated? use the at() method of ufuncs
i = [2, 3, 3, 4, 4, 4]
x = np.zeros(10)
print(x)
print(i)
np.add.at(x, i, 1)# does an in-place application of the given operator at the specified indices, similar-->reduceat
print(x)
#=======================
print('_'*100)
#Binning data
np.random.seed(42)
x = np.random.randn(100)
print('x:')
print(x)
# compute a histogram by hand
bins = np.linspace(-5, 5, 20)
counts = np.zeros_like(bins) #Return an array of zeros with the same shape and type as a given array.
# find the appropriate bin for each x
i = np.searchsorted(bins, x) #quicker search for pre-sorted data  ---> does the same thing as np.histogram , but more efficiently for smol dat, while np's method is efficient for bigdata
# add 1 to each of these bins
np.add.at(counts, i, 1)
# plot the results
plt.plot(bins, counts, linestyle='dotted')
plt.hist(x, bins, histtype='step')
plt.show()