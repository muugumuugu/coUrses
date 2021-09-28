#series  --> numpy array + python dictionary
import pandas as pd
data = pd.Series([0.25, 0.5, 0.75, 1.0], index=['a', 'b', 'c', 'd'])
print(data)
print(data['b']);# can also be assigned a value this way.
print('a' in data)
print(data.keys())
print(data.items())
# series builds on this dictionary-like interface and provides array-style item selection via the same basic mechanisms as NumPy arrays – that is, slices, masking, and fancy indexing
# slicing by implicit integer index
#when slicing with an explicit index the final index is included in the slice,
print(data[0:2])
# slicing by explicit index
#when slicing with an implicit index the final index is excluded from the slice.
print(data['a':'c'])
"""
if your Series has an explicit integer index,
an indexing operation such as data[1] will use the explicit indices,
while a slicing operation like data[1:3] will use the implicit Python-style index.
"""
print('-'*100)
data = pd.Series(['a', 'b', 'c'], index=[1, 3, 5])
print(data)
# to prevent confusion
# there are special indexer attributes that explicitly expose certain indexing schemes.
#loc attribute allows indexing and slicing that always references the explicit index:
print(data.loc[1])
#iloc attribute allows indexing and slicing that always references the implicit Python-style index:
print(data.iloc[1])
#ix, is a hybrid of the two, and for Series objects is equivalent to standard []-based indexing
#=================================================
print('_'*100)
#consider  DataFrame as a dictionary of related Series objects.
area = pd.Series({'California': 423967, 'Texas': 695662,
                  'New York': 141297, 'Florida': 170312,
                  'Illinois': 149995})
pop = pd.Series({'California': 38332521, 'Texas': 26448193,
                 'New York': 19651127, 'Florida': 19552860,
                 'Illinois': 12882135})
data = pd.DataFrame({'area':area, 'pop':pop})
print(data)
#The individual Series that make up the columns of the DataFrame can be accessed via dictionary-style indexing of the column name/ or by json dot notation
data['density'] = data['pop'] / data['area'] # modyfing like a dictionary
#----------------------------
print('-'*100)
print(data)
#DataFrame as an enhanced two-dimensional array
print(data.values)# as a 2d matrix of raw values
print(data.T) #transposed
"""
passing a single index to an array accesses a row
but
and passing a single "index" to a DataFrame accesses a column
"""
"""
using iloc/(loc) indexer,
we can index the underlying array as if it is a simple NumPy array
using the implicit(explict) Python-style index,
but the DataFrame index and column labels are maintained in the result:
"""

# indexing refers to columns, slicing refers to rows
# direct masking operations are also interpreted row-wise rather than column-wise