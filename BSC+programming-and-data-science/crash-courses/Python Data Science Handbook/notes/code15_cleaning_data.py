# data source
# !curl -O https://raw.githubusercontent.com/jakevdp/data-USstates/master/state-population.csv
# !curl -O https://raw.githubusercontent.com/jakevdp/data-USstates/master/state-areas.csv
# !curl -O https://raw.githubusercontent.com/jakevdp/data-USstates/master/state-abbrevs.csv
import pandas as pd
import numpy as np
#----------------------------------------------------------------------------
pop = pd.read_csv('data/state-population.csv')
areas = pd.read_csv('data/state-areas.csv')
abbrevs = pd.read_csv('data/state-abbrevs.csv')

print(pop.head())
print(areas.head())
print(abbrevs.head())
#-----------------------------------------------------------------
# task : rank US states and territories by their 2010 population density
#---------------------------------------------------------
# STEP 1
# many-to-one merge that will give us the full state name within the population
merged = pd.merge(pop, abbrevs, how='outer',  left_on='state/region', right_on='abbreviation')
merged = merged.drop('abbreviation', 1) # drop duplicate info
print(merged.head())
# STEP 2
#check for mismatches/missing data
print ('-'*100)
print(merged.isnull().any())
# find the missing info
print(merged[merged['population'].isnull()].head()) # maybe coz of no data prior to 2000
print(merged.loc[merged['state'].isnull(), 'state/region'].unique())
# problem -- >
#population data includes entries for Puerto Rico (PR) and the United States as a whole (USA), while these entries do not appear in the state abbreviation key
# STEP 3 FIll data
merged.loc[merged['state/region'] == 'PR', 'state'] = 'Puerto Rico'
merged.loc[merged['state/region'] == 'USA', 'state'] = 'United States'
#dbl check
print(merged.isnull().any())
print ('-'*100)
#==============================================================
#merge with area info
final = pd.merge(merged, areas, on='state', how='left')
print(final.head())
print ('-'*10)
# missing check
print(final.isnull().any())
print(final['state'][final['area (sq. mi)'].isnull()].unique()) # USA --> not required for our state analysis
final.dropna(inplace=True)
#=================================================
# using primed data
# find required subset
data2010 = final.query("year == 2010 & ages == 'total'")
# reorder
data2010.set_index('state', inplace=True)
# form new db of output
density = data2010['population'] / data2010['area (sq. mi)']
density.sort_values(ascending=False, inplace=True)
print ('-'*10)
print(density.head())# top 5