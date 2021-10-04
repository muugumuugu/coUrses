from dateutil import parser
from datetime import datetime
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn; seaborn.set()
#------------------------------------------
print('Manual')
print('-'*100)
date = parser.parse("4th of July, 2015")
print(date)
print('-'*100)
date = datetime(year=2015, month=7, day=5)#datetime objec
print(date)
print('-'*100)
print(date.strftime('%A'))#day if the week
#---------------------------
print('_'*100)
print('numpy')
print('-'*100)
# py date time objs --> inefficient ---> numpy typed array of time  --> can use vectorized functions on these
# datetime64 : encodes dates as 64 bit integers.
date = np.array('2015-07-04', dtype=np.datetime64)
print(date)
print('-'*100)
print(date + np.arange(12))
#=-----------------------
"""
trade-off between time resolution and maximum time span.
max span =2 ^64 times the resolution unit.
"""
print(np.datetime64('2015-07-04 12:59:59.50', 'ns'))# specifying units
"""
Y 	Year 			± 9.2e18 years 	[9.2e18 BC, 9.2e18 AD]
M 	Month 			± 7.6e17 years 	[7.6e17 BC, 7.6e17 AD]
W 	Week 			± 1.7e17 years 	[1.7e17 BC, 1.7e17 AD]
D 	Day 			± 2.5e16 years 	[2.5e16 BC, 2.5e16 AD]
h 	Hour 			± 1.0e15 years 	[1.0e15 BC, 1.0e15 AD]
m 	Minute		 	± 1.7e13 years 	[1.7e13 BC, 1.7e13 AD]
s 	Second			± 2.9e12 years 	[ 2.9e9 BC,  2.9e9 AD]
ms 	Millisecond 	± 2.9e9 years 	[ 2.9e6 BC,  2.9e6 AD]
us 	Microsecond 	± 2.9e6 years 	[290301 BC, 294241 AD]
ns 	Nanosecond 		± 292 years 	[  1678 AD,   2262 AD]
ps 	Picosecond 		± 106 days 		[  1969 AD,   1970 AD]
fs 	Femtosecond 	± 2.6 hours 	[  1969 AD,   1970 AD]
as 	Attosecond 		± 9.2 seconds 	[  1969 AD,   1970 AD]
"""
print('_'*100)
print('pandas')
"""
Pandas Time stamp
	wraps methods of datetime and dateutil
	and the efficient storage and vectorized interface of numpy.datetime64.
"""
date = pd.to_datetime("4th of July, 2015")
print(date)
print(date.strftime('%A'))
print(date + pd.to_timedelta(np.arange(12), 'D'))# returns a DateTimeIndex
#==================
print('_'*100)
#indexing by date-time
index = pd.DatetimeIndex(['2014-07-04', '2014-08-04', '2015-07-04', '2015-08-04'])
data = pd.Series([0, 1, 2, 3], index=index)
print(data['2015']) # date - wise slices and indexing
#======
print('_'*100)
# creating a datetimeindex
dates = pd.to_datetime([datetime(2015, 7, 3), '4th of July, 2015','2015-Jul-6', '07-07-2015', '20150708'])
print(dates)
# DatetimeIndex --> PeriodIndex
print(dates.to_period('D'))
#TimedeltaIndex --> differnece between two dates
print(dates - dates[0])
"""
range() for datetime
pd.date_range() for timestamps,
pd.period_range() for periods,
pd.timedelta_range() for time deltas
stepsize --> frequency code # by default freq='D' , ie 1 day
"""
print('-'*100)
print(pd.date_range('2015-07-03', '2015-07-10'))# end and start
print(pd.date_range('2015-07-03', periods=8, freq='H'))# start and length and step
print(pd.period_range('2015-07', periods=8, freq='M'))#period range
print(pd.timedelta_range(0, periods=10, freq='H'))#delta range
"""
Frequency Codes:
D 	Calendar day 	B 	Business day
W 	Weekly
M 	Month end 		BM 	Business month end
Q 	Quarter end 	BQ 	Business quarter end
A 	Year end 		BA 	Business year end
H 	Hours 			BH 	Business hours
T 	Minutes
S 	Seconds
L 	Milliseonds
U 	Microseconds
N 	nanoseconds
suffix S to mark at beginning
mark split points explicitly:
Q-FEB will split quarters from feb
W-SUN will consider Sunday to be DAY1 of thee week.
specifying custom intervals: combine frequency codes
2H30T
these codes are instances of pandas time series offsets
"""
print(pd.timedelta_range(0, periods=9, freq="2H30T"))
#
from pandas.tseries.offsets import BDay
print(pd.date_range('2015-07-01', periods=5, freq=BDay()))
#---------------------------------------------------------
#---------------------------------------------------------
# windowing
#---
from pandas_datareader import data #imports financial data from many sites
goog = data.DataReader('GOOG', start='2004', end='2016',  data_source='yahoo')
print(goog.head())
goog = goog['Close']
goog.plot()
plt.show()
# need for resampling at a higher or lower frequency
# resample --> aggregation
# asfreq --> selection
goog.plot(alpha=0.5, style='-')
# using freq codes, resampling  at the end of buisness years.
goog.resample('BA').mean().plot(style=':')# reports avg of prev year
goog.asfreq('BA').plot(style='--');# reports value at end of year
plt.legend(['input', 'resample', 'asfreq'],loc='upper left');
plt.show()
#------------------
#resampling leaves upsampled values empty by default, to fill:
fig, ax = plt.subplots(2, sharex=True)
data = goog.iloc[:10]

data.asfreq('D').plot(ax=ax[0], marker='o')

data.asfreq('D', method='bfill').plot(ax=ax[1], style='-o')
data.asfreq('D', method='ffill').plot(ax=ax[1], style='--o')
ax[1].legend(["back-fill", "forward-fill"]);
plt.show()
#===============================
#shifting of data in time
#OFFSETTING
"""
shift() shifts the data, while tshift() shifts the index.
the shift is specified in multiples of the frequency.
"""

fig, ax = plt.subplots(3, sharey=True)

# apply a frequency to the data
goog = goog.asfreq('D', method='pad')

goog.plot(ax=ax[0])
goog.shift(900).plot(ax=ax[1])
goog.tshift(900).plot(ax=ax[2])

# legends and annotations
local_max = pd.to_datetime('2007-11-05')
offset = pd.Timedelta(900, 'D')

ax[0].legend(['input'], loc=2)
ax[0].get_xticklabels()[2].set(weight='heavy', color='red')
ax[0].axvline(local_max, alpha=0.3, color='red')

ax[1].legend(['shift(900)'], loc=2)
ax[1].get_xticklabels()[2].set(weight='heavy', color='red')
ax[1].axvline(local_max + offset, alpha=0.3, color='red')

ax[2].legend(['tshift(900)'], loc=2)
ax[2].get_xticklabels()[1].set(weight='heavy', color='red')
ax[2].axvline(local_max + offset, alpha=0.3, color='red');
plt.show()

# useful for calculatig differences over time
ROI = 100 * (goog.tshift(-365) / goog - 1)
ROI.plot()
plt.ylabel('% Return on Investment');
plt.show()
"""
Aggregation using Rolling Windows <---> groupby

"""
rolling = goog.rolling(365, center=True)

data = pd.DataFrame({'input': goog, 'one-year rolling_mean': rolling.mean(),  'one-year rolling_std': rolling.std()})
ax = data.plot(style=['-', '--', ':'])
ax.lines[0].set_alpha(0.3)
plt.show()





































#EOF