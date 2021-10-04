import numexpr
import pandas as pd
import numpy as np
#============================================
rng = np.random.RandomState(42)
x = rng.rand(1000000)
y = rng.rand(1000000)
# numpy is slower for compund statement as it allocates arrays for each step
mask = (x > 0.5) & (y < 0.5)
mask_=numexpr.evaluate('(x > 0.5) & (y < 0.5)')# direct access to c functions, no array wise memory allocation --> effiicient
print(np.allclose(mask,mask_))# checks if values are equal within a given tolerance
# similarly for pandas,
df1, df2, df3, df4, df5 = (pd.DataFrame(rng.randint(0, 1000, (100, 3))) for i in range(5))
print(pd.eval('df1 + df2 + df3 + df4')) # is faster than df1 + df2 + df3 + df4
# eval is a wrapper of numexpr.evaluate for dataframes and series
"""
pd.eval() supports all comparison operators too, including chained expressions:
"""

# result = (df1 < 0.5) & (df2 < 0.5) | (df3 < df4)
result = pd.eval('(df1 < 0.5) & (df2 < 0.5) | (df3 < df4)')
print(result)
# df.eval computes the statement columnwise
df = pd.DataFrame(rng.rand(1000, 3), columns=['A', 'B', 'C'])
print(df.head())
# pd.eval("(df.A + df.B) / (df.C - 1)")
print(df.eval('(A + B) / (C - 1)')) # syntax sugae for columwise evals
# can also assign to a column
df.eval('D = (A + B) / C', inplace=True)# if not existing, new will be created
print(df.head())
#---------------------------------
# if the computation/comparison etc involves the colums, use query
# df[(df.A < 0.5) & (df.B < 0.5)] can be computed by -->
# pd.eval('df[(df.A < 0.5) & (df.B < 0.5)]') which is the same as
print(df.query('A < 0.5 and B < 0.5'))
"""
using local variables with query/eval strings-->
prefix with '@'
"""
Cmean = df['C'].mean()
result1 = df[(df.A < Cmean) & (df.B < Cmean)]
result2 = df.query('A < @Cmean and B < @Cmean')
print(np.allclose(result1, result2))# returns true on equality within computational error range