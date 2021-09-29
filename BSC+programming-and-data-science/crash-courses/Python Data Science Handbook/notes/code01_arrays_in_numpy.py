import numpy as np
#np arrays are
#actual array, fixed datatype
np.random.seed(0)  # seed for reproducibility
# generating arrays
x=np.arange(10)# integer sequence, like range
print(x)
theta = np.linspace(0, np.pi, 3)#equally space 3 numbers bw 0 and pi
print(theta)
x1 = np.random.randint(10, size=6)  # One-dimensional array
x2 = np.random.randint(10, size=(3, 4))  # Two-dimensional array
x3 = np.random.randint(10, size=(3, 4, 5))  # Three-dimensional array
print("x3 ndim: ", x3.ndim)
print("x3 shape:", x3.shape)
print("x3 size: ", x3.size)
#
print("dtype:", x3.dtype)
print("itemsize:", x3.itemsize, "bytes")
print("nbytes:", x3.nbytes, "bytes")
##
#===========================================================
#Array Indexing
#------------
print(x1)
print(x1[0])
print(x1[-2])#reverse order
print(x2)
print(x2[2, 0])#multidimenional indexing
#indexing can also be used in assignment operations, but datatypes should be homogenous with the array
#slicing - used for accessing subbarrays, unlike lists, the slice  is inplace, not a duplicated memory buffer
#x[start:stop:step]
#no copy views
print(x)
print(x[5::-2]) # reversed every other from index 5
#Multi-dimensional slices work in the same way, with multiple slices separated by commas.
print(x2)
print(x2[::-1, ::-1])#reversing both subbarays
print(x2[:, 0])  # first column of x2
#=====================================================
#data manipulation thru subbarays
print('x2sub')
x2_sub = x2[:2, :2]
print(x2_sub)# by referrence
#Now if we modify this subarray, we'll see that the original array is changed
x2_sub[0, 0] = 99
print('x2sub')
print(x2_sub)
print('x2')
print(x2)
#====copying
x2_sub_copy = x2[:2, :2].copy()
#=================================================
#reshaping
grid = np.arange(1, 10).reshape((3, 3))
print(grid)
# reshape vs newaxis for transpose
x = np.array([1, 2, 3])
# column vector via reshape
print(x.reshape((3, 1)))
# via new axis
print(x[:, np.newaxis])
#================================================
#Concatenation and Splitting
x = np.array([1, 2, 3])
y = np.array([3, 2, 1])
z = [99, 99, 99]
print(np.concatenate([x, y, z]))
grid = np.array([[1, 2, 3],
                 [4, 5, 6]])
# concatenate along the second axis (zero-indexed)
np.concatenate([grid, grid], axis=1)
# clearer, verbose ways
# vertically stack the arrays
print(np.vstack([x, grid]))#hstack,dstack - vertical horizontal depth.
#=============================
#Splitting of arrays
#np.split
#pass a list of indices giving the split points:
x = [1, 2, 3, 99, 99, 3, 2, 1]
x1, x2, x3 = np.split(x, [3, 5])
print(x1, x2, x3)
#N -split points--> N+1 arrays
#--------------------clearer human ways
grid = np.arange(16).reshape((4, 4))
print('grid')
print(grid)
upper, lower = np.vsplit(grid, [2])# hsplit,dsplit
print(upper)
print(lower)
#------------------------------------
