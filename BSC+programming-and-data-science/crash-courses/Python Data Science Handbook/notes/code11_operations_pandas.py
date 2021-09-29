# any NumPy ufunc will work on Pandas Series and DataFrame objects
# but indexing will be preserved !!!!!!!!!!!!!!!!!!!!!!!
"""
for unary operations like negation and trigonometric functions,
pandas ufuncs will preserve index and column labels in the output,
and for binary operations such as addition and multiplication,
Pandas will automatically align indices when passing the objects to the ufunc.
This means that keeping the context of data and combining data
"""
import pandas as pd
import numpy as np
#----------------------------------------------
rng = np.random.RandomState(42)
ser = pd.Series(rng.randint(0, 10, 4))
print(ser)
df = pd.DataFrame(rng.randint(0, 10, (3, 4)),
                  columns=['A', 'B', 'C', 'D'])
print(df)
df_calc=np.sin(df * np.pi / 4) # return another (but index preserved) dataframe
print(df_calc)
#---------------------------
#column alignment
area = pd.Series({'Alaska': 1723337, 'Texas': 695662,
                  'California': 423967}, name='area')
population = pd.Series({'California': 38332521, 'Texas': 26448193,
                        'New York': 19651127}, name='population')
print(population / area )# (The resulting array contains the union of indices of the two input array as its index)
#Any item for which one or the other does not have an entry is marked with NaN, or "Not a Number," --> missing data marker
A = pd.Series([2, 4, 6], index=[0, 1, 2])
B = pd.Series([1, 3, 5], index=[1, 2, 3])
print(A.add(B,fill_value=0)) # equiv to  A + B, but missing values are filled with 0 instead of NaN
print('-'*100)
#-------------------------------
#alignment takes place for both columns and indices when performing operations on DataFrames:
A = pd.DataFrame(rng.randint(0, 20, (2, 2)),columns=list('AB'))
B = pd.DataFrame(rng.randint(0, 10, (3, 3)), columns=list('BAC'))
print(A)
print(B)
print(A+B)
fill = A.stack().mean() #mean of all vals
print(A.add(B, fill_value=fill))
#============================================================
#DataFrame/Series operations, by default operate row wise and preserve column indexing and alignment
A = rng.randint(10, size=(3, 4))
df = pd.DataFrame(A, columns=list('QRST'))
print(df)
print(df.subtract(df['R'], axis=0)) #specify which dimension-wise to operate