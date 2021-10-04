import numpy as np
import pandas as pd
#------------------------------
"""
vectorization of operations simplifies the syntax of operating on arrays of data: we no longer have to worry about the size or shape of the array
Numpy provides vectorization, but only for numeric data
"""
data = ['peter', 'Paul', None, 'MARY', 'gUIDO']
names = pd.Series(data)
names.str.capitalize()# skips over empty vals
"""
available through str attribute of pd objects

len() 	lower() 	translate() 	islower()
ljust() 	upper() 	startswith() 	isupper()
rjust() 	find() 	endswith() 	isnumeric()
center() 	rfind() 	isalnum() 	isdecimal()
zfill() 	index() 	isalpha() 	split()
strip() 	rindex() 	isdigit() 	rsplit()
rstrip() 	capitalize() 	isspace() 	partition()
lstrip() 	swapcase() 	istitle() 	rpartition()
"""

"""
vectorized regex methods
match() 	Call re.match() on each element, returning a boolean.
extract() 	Call re.match() on each element, returning matched groups as strings.
findall() 	Call re.findall() on each element
replace() 	Replace occurrences of pattern with some other string
contains() 	Call re.search() on each element, returning a boolean
count() 	Count occurrences of pattern
split() 	Equivalent to str.split(), but accepts regexps
rsplit() 	Equivalent to str.rsplit(), but accepts regexps
"""

"""
get() 	Index each element
slice() 	Slice each element
slice_replace() 	Replace slice in each element with passed value
cat() 	Concatenate strings
repeat() 	Repeat values
normalize() 	Return Unicode form of string
pad() 	Add whitespace to left, right, or both sides of strings
wrap() 	Split long strings into lines with length less than a given width
join() 	Join strings in each element of the Series with passed separator
get_dummies() 	extract dummy variables as a dataframe
"""
#The get() and slice() operations, in particular, enable vectorized element access from each array
# df.str.slice(0, 3) is equivalent to df.str[0:3]

monte = pd.Series(['Graham Chapman', 'John Cleese', 'Terry Gilliam', 'Eric Idle', 'Terry Jones', 'Michael Palin'])
print(monte.str[0:3])

# when your data has a column containing some sort of coded indicator
full_monte = pd.DataFrame({'name': monte,'info': ['B|C|D', 'B|D', 'A|C','B|D', 'B|C', 'B|C|D']})
# get_dummies() routine lets you quickly split-out these indicator variables into a DataFrame
print(full_monte['info'].str.get_dummies('|'))












































#EOF
