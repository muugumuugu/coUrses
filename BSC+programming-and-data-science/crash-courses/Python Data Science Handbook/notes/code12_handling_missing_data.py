import pandas as pd
import numpy as np
# Detection
#-------------------------------------------------------------------
data = pd.Series([1, np.nan, 'hello', None])
print(data)
#-------------------------------------------------------------------
print(data.isnull()) # returns a mask
print(data[data.notnull()])
# removal of missing data columns in a series
print(data.dropna())
#-------------------------------------------
print('-'*100)
# dropping in a df
df = pd.DataFrame([[1,      np.nan, 2],
                   [2,      3,      5],
                   [np.nan, 4,      6]])
# by default, dropna() will drop all rows in which any null value is present:
print(df)
print(df.dropna())# indexing preserved
#selecting which dimension to drop
print(df.dropna(axis='columns')) #indexing preserved
# to prevent massive data truncation
# droprows or columns with all NA values, or a majority of NA values.
#This can be specified through the how or thresh parameters
# allow fine control of the number of nulls to allow through.
print('-'*100)
df[3]=np.nan
print(df)
print(df.dropna(axis='columns', how='all'))# default =rows, any
# thresh parameter lets you specify a minimum number of non-null values for the row/column to be kept:
print(df.dropna(axis='rows', thresh=3))
#=====================================================================
# FIlling Empty Values
print('_'*100)
data = pd.Series([1, np.nan, 2, None, 3], index=list('abcde'))
print(data)
#fill NA entries with a single value, such as zero
print(data.fillna(0))
#propagate the previous value forward
print(data.fillna(method='ffill')) # or back fill
# filling dfs
# options are similar,
# specify an axis along which the fills take place
print(df.fillna(method='ffill', axis=1))






















#EOF