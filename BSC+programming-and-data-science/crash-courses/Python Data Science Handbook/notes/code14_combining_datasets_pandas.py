import pandas as pd
import numpy as np
#==============================
#building a matrix like df
def make_df(cols, ind):
    """Quickly make a DataFrame"""
    data = {c: [str(c) + str(i) for i in ind]
            for c in cols}
    return pd.DataFrame(data, ind)
#-----------------
# example DataFrame
make_df('ABC', range(3))
#----------
#quick class that allows us to display multiple DataFrames side by side.
class display(object):
    """Display HTML representation of multiple objects"""
    template = """<div style="float: left; padding: 10px;"> <p style='font-family:"Courier New", Courier, monospace'>{0}</p>{1} </div>"""
    def __init__(self, *args):
        self.args = args
    def _repr_html_(self):
        return '\n'.join(self.template.format(a, eval(a)._repr_html_()) for a in self.args)
    def __repr__(self):
        return '\n\n'.join(a + '\n' + repr(eval(a))for a in self.args)
#......................................................................................................
# Concatenation
#similar to numpy
x = [[1, 2],
     [3, 4]]
print(x)
print(np.concatenate([x, x], axis=1))
"""
the pandas wrap over concatenate:
pd.concat(
			objs, axis=0,
			join='outer',
			ignore_index=False,
			keys=None, levels=None,
			names=None, verify_integrity=False,
			copy=True
		)
also, pandas concatenation preserves indices, even if the result will have duplicate indices
"""
ser1 = pd.Series(['A', 'B', 'C'], index=[1, 2, 3])
ser2 = pd.Series(['D', 'E', 'F'], index=[4, 5, 6])
print(pd.concat([ser1, ser2]))
df1 = make_df('AB', [1, 2])
df2 = make_df('AB', [3, 4])
print(pd.concat([df1, df2])) # by defaulr row-wise within the DataFrame (i.e., axis=0).
df3 = make_df('AB', [0, 1])
df4 = make_df('CD', [0, 1])
print(display('df3', 'df4', "pd.concat([df3, df4], axis=1)"))
# duplicate index
x = make_df('AB', [0, 1])
y = make_df('AB', [2, 3])
y.index = x.index  # make duplicate indices
print(display('x', 'y', 'pd.concat([x, y])')) # repeated index, valid but error creating -->
# foolproof unique indexing
try:
    pd.concat([x, y], verify_integrity=True)
except ValueError as e:
    print("ValueError:", e)
# if index doesnt matter, create a new integer index for the resulting series by using ignore_index flag
print(pd.concat([x, y], ignore_index=True))
# use the keys option to specify a label for the data sources
#the result will be a hierarchically indexed series containing the data
print(pd.concat([x, y], keys=['x', 'y']))
#================================================================================
print('-'*100)
# performing Joins
df5 = make_df('ABC', [1, 2])
df6 = make_df('BCD', [3, 4])
# some shared , some different sets of column name
print(display('df5', 'df6', 'pd.concat([df5, df6])')) # column set  is union of columns
# by defaulr join is a union of the input columns (join='outer'),
# can set it to ntersection of the columns using join='inner':
print(pd.concat([df5, df6], join='inner'))
dtemp=pd.concat([df5, df6])
join_axes=df5.index
print(dtemp.reindex(join_axes))# specify the columns to keep in the join using  a list of index objs
#==============================================================
#MERGE
print('-'*100)
#1to1
df1 = pd.DataFrame({'employee': ['Bob', 'Jake', 'Lisa', 'Sue'], 'group': ['Accounting', 'Engineering', 'Engineering', 'HR']})
df2 = pd.DataFrame({'employee': ['Lisa', 'Bob', 'Jake', 'Sue'], 'hire_date': [2004, 2008, 2012, 2014]})
print(df1)
print(df2)
df3=pd.merge(df1,df2) # automatically joins using the common column as a key
print(df3)
#many to 1
#one of the  key columns contains duplicate entries
df4 = pd.DataFrame({'group': ['Accounting', 'Engineering', 'HR'], 'supervisor': ['Carly', 'Guido', 'Steve']})
print(pd.merge(df3,df4)) # preserve those duplicate entries as appropriate






















#OF