# problem -track data about states from two different years.
import pandas as pd
import numpy as np
#------------------------------------
# way 1 simply use Python tuples as keys
index = [('California', 2000), ('California', 2010),
         ('New York', 2000), ('New York', 2010),
         ('Texas', 2000), ('Texas', 2010)]
populations = [33871648, 37253956,
               18976457, 19378102,
               20851820, 25145561]
pop = pd.Series(populations, index=index)
print(pop)
#With this indexing scheme, we can index or slice the series based on this multiple index
print(pop[('California', 2010):('Texas', 2000)])
# but if you need to select all values from 2010,
print(pop[[i for i in pop.index if i[1] == 2010]])# slow and messy
#------------------------------------
# way 2 Pandas multi index
print('-' *100)
index = pd.MultiIndex.from_tuples(index)
print(index)
"""
multiple levels of indexing–in levels == > array of indexings components, that is one array for each domain of the tuple,
as well as multiple labels for each data point which encode these levels # mapping function to correlate tuples with each other.
eg -->
MultiIndex(levels=[['California', 'New York', 'Texas'], [2000, 2010]],labels=[[0, 0, 1, 1, 2, 2], [0, 1, 0, 1, 0, 1]])
"""
pop = pop.reindex(index)
print(pop) # blank entry indicates same value as line above it


#--------------------------------
# to access all data for which the second index is 2010, use the Pandas slicing notation:
print(pop[:,2010])# result is a singly indexed array
print('-'*100)
#-----------------------------
# we can store the same data using a simple DataFrame
#with index and column labels.
# Pandas is built with this equivalence in mind
# unstack() method --> quickly convert a multiply indexed Series into a conventionally indexed DataFrame
pop_df = pop.unstack()
print(pop_df)
#DATA FRAME multi-level-index
# use multi-indexing to represent two-dimensional data within a one-dimensional Series,
# then use it to represent data of three or more dimensions in a Series or DataFrame
# Each extra level in a multi-index represents an extra dimension of data
# example --> adding another column of demographic data
pop_df = pd.DataFrame({'total': pop, 'under18': [9267089, 9284094, 4687374, 4318033, 5906301, 6879014]})
print(pop_df)
# use ufuncs with multiindex
f_u18 = pop_df['under18'] / pop_df['total'] #compute the fraction of people under 18 by year
print(f_u18.unstack()) # make a df
#===============================================================
print('_'*100)
# CREATING a multi index
df = pd.DataFrame(np.random.rand(4, 2), index=[['a', 'a', 'b', 'b'], [1, 2, 1, 2]], columns=['data1', 'data2'])#simply pass a list of two or more index arrays to the constructor.
print(df)
#---------------------
data = {('California', 2000): 33871648,
        ('California', 2010): 37253956,
        ('Texas', 2000): 20851820,
        ('Texas', 2010): 25145561,
        ('New York', 2000): 18976457,
        ('New York', 2010): 19378102}
print(pd.Series(data)) # pass a dictionary with appropriate tuples as keys, Pandas will automatically recognize this and use a MultiIndex by default
#--------------------------------------
# MultiIndex constructors
print(pd.MultiIndex.from_arrays([['a', 'a', 'b', 'b'], [1, 2, 1, 2]])) # from a simple list of arrays giving the index values within each leve
print(pd.MultiIndex.from_tuples([('a', 1), ('a', 2), ('b', 1), ('b', 2)]))#from list of tuples giving the multiple index values of each point:
print(pd.MultiIndex.from_product([['a', 'b'], [1, 2]]))#from a Cartesian product of single indice
print(pd.MultiIndex(levels=[['a', 'b'], [1, 2]],codes=[[0, 0, 1, 1], [0, 1, 0, 1]]))# dictionary # codes ==> older versions-- labels
#=============================
# nameing the levels of the MultiIndex.
# by passing the names argument to any MultiIndex constructors,
#or by setting the names attribute of the index after construction
pop.index.names = ['state', 'year']
print(pop)
#=======================
print('_'*100)
# multi index for COLUMNS
#---------
# hierarchical indices and columns
index = pd.MultiIndex.from_product([[2013, 2014], [1, 2]],names=['year', 'visit'])
columns = pd.MultiIndex.from_product([['Bob', 'Guido', 'Sue'], ['HR', 'Temp']],names=['subject', 'type'])
# mock some data
data = np.round(np.random.randn(4, 6), 1)
data[:, ::2] *= 10
data += 37
# create the DataFrame
health_data = pd.DataFrame(data, index=index, columns=columns)
print(health_data)
# access a table using the column multiindex
print('-'*50)
print(health_data['Guido'])
#================================================
print('_'*100)
#Indexing and sliCing
print(pop['California', 2000])# getting single elements by indexing with multiple terms
# partial indexings
print(pop['California']) # retuens Series, with the lower-level indices maintained:
# partial slicing is available with sorted multiindex
print(pop.loc['California':'New York'])
print(pop[:, 2000]) # partial slicing on lower levels by passing an empty slice in the first index

#================================================
print('_'*100)
# multipe-indexed- dfs
# columns are primary in a DataFrame, and the syntax used for multiply indexed Series applies to the columns
print(health_data['Guido', 'HR'])
# using indexers
print(health_data.iloc[:2, :2])# an array-like view of the underlying two-dimensional data
print(health_data.loc[:, ('Bob', 'HR')])#each individual index in loc or iloc can be passed a tuple of multiple indices
# slicing with tuples
idx = pd.IndexSlice
print(health_data.loc[idx[:, 1], idx[:, 'HR']]) # needs multi index to be sorted

#===========================================
print('-'*100)
# sort multiply indexed data
index = pd.MultiIndex.from_product([['a', 'c', 'b'], [1, 2]])
data = pd.Series(np.random.rand(6), index=index)
data.index.names = ['char', 'int']
print(data)
print('---')
data=data.sort_index()
print(data)

#===============================
#stacking
print('_'*100)
print('lvl1')
print(pop.unstack(level=0))
print('lvl2')
print(print(pop.unstack(level=1)))
print(pop.unstack().stack()) # opposite, cancelling effects

# =====================
# rearrange hierarchical data --> turn the index labels into columns
pop_flat = pop.reset_index(name='population')
print(pop_flat)
# flat input to multi indexed df
pop_hierc=pop_flat.set_index(['state', 'year'])
print(pop_hierc)


#===========================================
#aggregates in heirachal data
print(data_mean.mean(axis=1, level='type'))





































#EOF