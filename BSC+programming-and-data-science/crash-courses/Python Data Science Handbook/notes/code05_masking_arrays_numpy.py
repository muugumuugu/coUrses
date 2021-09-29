import numpy as np
import pandas as pd
#--
import matplotlib.pyplot as plt
import seaborn; seaborn.set()  # set plot styles
#=====================================================
# use pandas to extract rainfall inches as a NumPy array
rainfall = pd.read_csv('data/Seattle2014.csv')['PRCP'].values
inches = rainfall / 254.0  # 1/10mm -> inches
print(inches.shape)
plt.hist(inches, 40)
#plt.show()
#==========================
#numpy implements comparison operators such as < , > etc , as element-wise ufuncs
#result of these comparison operators is always an array with a Boolean data ty
x = np.array([1, 2, 3, 4, 5])
print('x')
print(x)
print('x<3')
print(x<3)
# as its a ufuncm,element-wise comparison of two arrays, & including compound expressions is also possible
print('2x==x^2')
print((2 * x) == (x ** 2))
#=============================
print('_'*100)
#Working with Boolean Arrays
rng = np.random.RandomState(0)#seed
x = rng.randint(10, size=(3, 4))
#To count the number of True entries in a Boolean array
print(x)
print('#x<6')
print(np.count_nonzero(x < 6))
#Another way to get at this information is to use np.sum; in this case, False is interpreted as 0, and True is interpreted as 1:
#benefit -->like with other NumPy aggregation functions, this summation can be done along rows or columns as well:
#-----------
#quickly checking whether *any* or *all* the values are true
print("are there any values greater than 8?")
print(np.any(x > 8))
# along a particular axis
print("are all values in each row less than 8?")
print(np.all(x < 8, axis=1))

"""
Python has built-in sum(), any(), and all() functions.
These have a different syntax than the NumPy versions,
and in particular will fail or produce unintended results when used on multidimensional arrays.
"""
#=========================================
#masks
"""
bitwise logic ops
& 	np.bitwise_and 		| 	np.bitwise_or
^ 	np.bitwise_xor 		~ 	np.bitwise_not
"""
print("# of days with rain less than four inches and greater than one inch?")
#aggregates computed directly on Boolean arrays
print(np.sum((inches > 0.5) & (inches < 1)))
#---------------------------
#using Boolean arrays as masks, to select particular subsets of the data themselves
#to get array of all values in the array that are less than, say, 5:
print('x')
print(x)
# set conditional boolean array
condition_index=x < 5
print(condition_index)
print('masked array')
print(x[condition_index])
#-----summarizing a subset
print('_' *100)
# construct a mask of all rainy days
rainy = (inches > 0)

# construct a mask of all summer days (June 21st is the 172nd day)
days = np.arange(365)
summer = (days > 172) & (days < 262)

print("Median precip on rainy days in 2014 (inches):   ",
      np.median(inches[rainy]))
print("Median precip on summer days in 2014 (inches):  ",
      np.median(inches[summer]))
print("Maximum precip on summer days in 2014 (inches): ",
      np.max(inches[summer]))
print("Median precip on non-summer rainy days (inches):",
      np.median(inches[rainy & ~summer]))
print('_' *100)
#==================================================
# AND vs &
# and/or perform a single Boolean evaluation on an entire object,
# while & and | perform multiple Boolean evaluations on the content (the individual bits or bytes) of an object.
# For Boolean NumPy arrays, the latter is nearly always the desired operation.





























#EOF