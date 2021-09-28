import numpy as np
import pandas as pd
#==========================================
#SERIES
#A Pandas Series is a one-dimensional array of indexed data
data = pd.Series([0.25, 0.5, 0.75, 1.0])
# wraps both a sequence of values and a sequence of indices, which we can access with the values and index attributes.
print(data.values) # numpy arr
print(data.index) # pd.Index object
# Series <--> numpyarray : diff
"""
while the Numpy Array has an implicitly defined integer index used to access the values,
the Pandas Series has an explicitly defined index associated with the values.
"""
#explicit index definition gives the Series object additional capabilities.
#For example, the index need not be an integer, but can consist of values of any desired type.
data = pd.Series([0.25, 0.5, 0.75, 1.0], index=['a', 'b', 'e', 'd']) # non sequential strings for item access
#bit like a specialization of a Python dictionary, but supports slicing using these indices.
#=====================================
#Constructing A Series
"""
pd.Series(data, index=index)
"""
s1=pd.Series([2, 4, 6])# data can be a list or NumPy array, in which case index defaults to an integer sequence:
s2=pd.Series(5, index=[100, 200, 300])# data can be a scalar, which is repeated to fill the specified index:
s3=pd.Series({2:'a', 1:'b', 3:'c'})# data can be a dictionary, in which index defaults to the sorted dictionary keys:
#the index can be explicitly set if a different result is preferred, now the series will be populated only with the explicitly identified keys.
s4=pd.Series({2:'a', 1:'b', 3:'c'}, index=[3, 2])
#===========================================================
#DATAFRAME
"""
If a Series is an analog of a one-dimensional array with flexible indices,
a DataFrame is an analog of a two-dimensional array with both flexible row indices and flexible column names.
"""
"""
DataFrame as a sequence of aligned Series objects.
aligned means that they share the same index.
"""
area_dict = {'California': 423967, 'Texas': 695662, 'New York': 141297,'Florida': 170312, 'Illinois': 149995}
area = pd.Series(area_dict)
population_dict = {'California': 38332521,'Texas': 26448193,'New York': 19651127,'Florida': 19552860,'Illinois': 12882135}
population = pd.Series(population_dict)
states = pd.DataFrame({'population': population,'area': area})
print(states)
#Like the Series object, the DataFrame has an index attribute that gives access to the index labels:
print(states.index)# row labels
print(states.columns)# col labels index object
"""
in a two-dimesnional NumPy array, data[0] will return the first row.
For a DataFrame, data['col0'] will return the first column.
Because of this, it is probably better to think about DataFrames as generalized dictionaries rather than generalized array
"""
# Data to Dataframe
# list of dicts
print(pd.DataFrame([{'a': 1, 'b': 2}, {'b': 3, 'c': 4}]))#if some keys in the dictionary are missing, Pandas will fill them in with NaN (i.e., "not a number") values:
# collection series to Df
print(pd.DataFrame(population, columns=['population']))
print(pd.DataFrame({'population': population,'area': area}))
# from a two-dimensional array of data, we can create a DataFrame with any specified column and index names.
# If omitted, an integer index will be used for each:
print(pd.DataFrame(np.random.rand(3, 2),
             columns=['foo', 'bar'],
             index=['a', 'b', 'c']))
#pandas <==> structured numpy array
A = np.zeros(3, dtype=[('A', 'i8'), ('B', 'f8')])
print(A)
P=pd.DataFrame(A)
print(P)
#=====================================================================
#Pandas Index Object
"""
Index object is an interesting structure in itself,
and it can be thought of either as an immutable array or as an ordered set
(technically a multi-set, as Index objects may contain repeated values).
"""
print('-'*100)
ind = pd.Index([2, 3, 5, 7, 11])
print(ind)
#standard Python indexing notation , as well as numpy array methods are both available to indexes
#only difference is ommutability.
print(ind[::2])
print(ind.size, ind.shape, ind.ndim, ind.dtype)
#==========================================
#pd objects are designed to facilitate operations such as joins across datasets, which depend on many aspects of set arithmetic.
# The Index object follows many of the conventions used by Python's built-in set data structure,
# so that unions, intersections, differences, and other combinations can be computed in a familiar way
print('-'*100)
indA = pd.Index([1, 3, 5, 7, 9])
indB = pd.Index([2, 3, 5, 7, 11])
print(indA)
print(indB)
print(indA & indB)  # intersection
print(indA | indB)  # union
print(indA ^ indB)  # symmetric difference





































#EOF