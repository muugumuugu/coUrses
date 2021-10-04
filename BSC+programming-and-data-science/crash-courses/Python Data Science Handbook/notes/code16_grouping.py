import numpy as np
import pandas as pd
rng = np.random.RandomState(42)#seed
#----------------------------------------------------------------
# data source
import seaborn as sns
planets = sns.load_dataset('planets')
planets.shape
#----------------------------------------------------------------
# DataFrame, by default the aggregates return results within each column
df = pd.DataFrame({'A': rng.rand(5), 'B': rng.rand(5)})
print(df)
print(df.mean()) # default axis="rows"
print(df.mean(axis='columns')) # within each row
#------------------------------------------------
# summarizing data
# convenience method describe()
# computes several common aggregates for each column
print(planets.dropna().describe())
"""
all available agrregates
---
count() 			Total number of items
first(), last() 	First and last item
mean(), median() 	Mean and median
min(), max() 		Minimum and maximum
std(), var() 		Standard deviation and variance
mad() 				Mean absolute deviation
prod() 				Product of all items
sum() 				Sum of all items
"""
# GROUP BY
"""
split -> apply -> combine
    masking : 		The split step involves breaking up and grouping a DataFrame depending on the value of the specified key.
    aggregation:	The apply step involves computing some function, usually an aggregate, transformation, or filtering, within the individual groups.
    merging:		The combine step merges the results of these operations into an output array.
"""
print('-'*100)
df = pd.DataFrame({'key': ['A', 'B', 'C', 'A', 'B', 'C'],'data': range(6)}, columns=['key', 'data'])
print(df)
print(df.groupby('key').sum())
print('-'*100)
#GroupBy object supports column indexing
print(planets.groupby('method')['orbital_period'].median())
#===============================
# geoup as iterator
for (method, group) in planets.groupby('method'):
	print("{0:30s} shape={1}".format(method, group.shape))
# dispatching df / series functions
print(planets.groupby('method')['year'].describe().unstack())
#=========================================
#apply/transforma
rng = np.random.RandomState(0)
df = pd.DataFrame({'key': ['A', 'B', 'C', 'A', 'B', 'C'],
                   'data1': range(6),
                   'data2': rng.randint(0, 10, 6)},
                   columns = ['key', 'data1', 'data2'])
# AGGREGATE in one swoop
print(df.groupby('key').aggregate(['min', np.median, max]))
# APPLY to one column
print(df.groupby('key').aggregate({'data1': 'min', 'data2': 'max'}))
#=========
#FILTER
def filter_func(x):
    return x['data2'].std() > 4

print(df.groupby('key').filter(filter_func))
#========================
#transformation , need not return reduced result like aggregation
print(df.groupby('key').transform(lambda x: x - x.mean())) # example- centering data

#====================
#apply a custom method
def norm_by_data2(x):
    # x is a DataFrame of group values
    x['data1'] /= x['data2'].sum()
    return x
print(df.groupby('key').apply(norm_by_data2))



#==========================
# grouping selected indices.
L = [0, 1, 0, 1, 2, 0] # array of length  =  df's length, item @ each indice corresponds to  which group to put the row at that indice into
print(df)
print(df.groupby(L).sum())
# grouping using mapping
df2 = df.set_index('key')
mapping = {'A': 'vowel', 'B': 'consonant', 'C': 'consonant'}
print(df2)
print(df2.groupby(mapping).sum())
# mapping using python functions
print(df2.groupby(str.lower).mean())






























#EOF