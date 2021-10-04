# !curl -O http://openrecipes.s3.amazonaws.com/recipeitems-latest.json.gz
# !gunzip recipeitems-latest.json.gz
import numpy as np
import pandas as pd
from io import StringIO # pandas cannot read simple string from 1.1.0 onward
#------------------------------
# Woeking with raw real- world data
try:
	recipes = pd.read_json('recipeitems-latest.json')
except ValueError as e:
	print("ValueError:", e)
# trailing data--> each line is a json object, not whole file :(
with open('recipeitems-latest.json') as f:
	data = (line.strip() for line in f)
	# Reformat so each line is the element of a list
	data_json = "[{0}]".format(','.join(data))
# read the result as a JSON
recipes = pd.read_json(StringIO(data_json))
print(recipes.shape)# yesssssssssssssssssssss
#see what the data looks like
print(recipes.iloc[0])
#checkout one column
print(recipes.ingredients.str.len().describe())
# make a recipe recommandor
spice_list = ['salt', 'pepper', 'oregano', 'sage', 'parsley', 'rosemary', 'tarragon', 'thyme', 'paprika', 'cumin']
import re
spice_df = pd.DataFrame(dict((spice, recipes.ingredients.str.contains(spice, re.IGNORECASE)) for spice in spice_list))
print(spice_df.head())
# now its easy  to find a recipe that uses parsley & paprika
selection = spice_df.query('parsley & paprika')
len(selection)
print(recipes.name[selection.index])