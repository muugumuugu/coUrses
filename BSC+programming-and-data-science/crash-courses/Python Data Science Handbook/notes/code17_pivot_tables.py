import numpy as np
import pandas as pd
import seaborn as sns
titanic = sns.load_dataset('titanic')
import matplotlib as mpl
import matplotlib.pyplot as plt
sns.set()  # use Seaborn styles
#--------------------------------------------------------------
# two factor statistics
"""
eg -
want to  look at survival by both sex and class.
we group by class and gender, select survival,
apply a mean aggregate, combine the resulting groups,
and then unstack the hierarchical index to reveal the hidden multidimensionality
"""
print('MANUAL')
print(titanic.groupby(['sex', 'class'])['survived'].aggregate('mean').unstack())
# this is equivalent to using pandas pivot table
print('PANDAS PIVOT TABLE')
"""
DataFrame.pivot_table(
						data, values=None,
						index=None, columns=None,
						aggfunc='mean', # can pass a dictionary of columns as ey and aggn func as val
						fill_value=None,
						margins=False,#flag to total along colums
						dropna=True, margins_name='All')
"""
print(titanic.pivot_table('survived', index='sex', columns='class'))
# BINNING
age = pd.cut(titanic['age'], [0, 18, 80])
# Quantiles
fare = pd.qcut(titanic['fare'], 2)
# MULTI LEVEL PIVOT TABLES
print(titanic.pivot_table('survived', ['sex', age], 'class'))
print('-'*100)
print(titanic.pivot_table('survived', ['sex', age], [fare, 'class']))#4d aggregation
print('-'*100)
# specifying aggregation
titanic.pivot_table(index='sex', columns='class',aggfunc={'survived':sum, 'fare':'mean'})
print('-'*100)
titanic.pivot_table('survived', index='sex', columns='class', margins=True)
print('_'*100)
print('_'*100)
#-----------------------
#data source
# !curl -O https://raw.githubusercontent.com/jakevdp/data-CDCbirths/master/births.csv
births = pd.read_csv('data/births.csv')
print(births.head())
# add a column and group by it
births['decade'] = 10 * (births['year'] // 10)
births.pivot_table('births', index='decade', columns='gender', aggfunc='sum')
print(births.pivot_table('births', index='decade', columns='gender', aggfunc='sum'))
# M births outnumber female births --> visualize
#-----------------
births.pivot_table('births', index='year', columns='gender', aggfunc='sum').plot()
plt.ylabel('total births per year');
plt.show()
#-----------
#performing some stats
quartiles = np.percentile(births['births'], [25, 50, 75])
mu = quartiles[1]
sig = 0.74 * (quartiles[2] - quartiles[0])
births = births.query('(births > @mu - 5 * @sig) & (births < @mu + 5 * @sig)')
# set 'day' column to integer; it originally was a string due to nulls
births['day'] = births['day'].astype(int)
# create a datetime index from the year, month, day
births.index = pd.to_datetime(10000 * births.year +100 * births.month +births.day, format='%Y%m%d')
births['dayofweek'] = births.index.dayofweek
births.pivot_table('births', index='dayofweek',columns='decade', aggfunc='mean').plot()
plt.gca().set_xticklabels(['Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat', 'Sun'])
plt.ylabel('mean births by day');
plt.show()
# make a plot of births by day of the year
births_by_date = births.pivot_table('births', [births.index.month, births.index.day])
# turn these months and days into a date by associating them with a dummy year variable ,c hoose a leap year so February 29th is correctly handled.
births_by_date.index = [pd.datetime(2012, month, day) for (month, day) in births_by_date.index]
fig, ax = plt.subplots(figsize=(12, 4))
births_by_date.plot(ax=ax);
plt.show()
# beautiful trend of dips on christian holidays






























#EOF
