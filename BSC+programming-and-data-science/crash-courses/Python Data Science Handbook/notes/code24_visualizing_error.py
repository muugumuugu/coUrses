import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
from sklearn.gaussian_process import GaussianProcessRegressor
plt.style.use('seaborn-whitegrid')
#-----------------------------------------------
# plotting accuracy range the +- error in accuracy of a recorded val.

x = np.linspace(0, 10, 50)
dy = 0.8
y = np.sin(x) + dy * np.random.randn(50)
plt.errorbar(x, y, yerr=dy, fmt='.k');
plt.show()
#more styling
plt.errorbar(x, y, yerr=dy, fmt='o', color='black',ecolor='lightgray', elinewidth=3, capsize=0);
plt.show()
#==============================================
# error on continous variables
"""
combine plt.plot and plt.fill_between
perform Gaussian process regression
"""
# define the model and draw some data
model = lambda x: x * np.sin(x)
xdata = np.array([1, 3, 5, 6, 8])
ydata = model(xdata)
# Compute the Gaussian process fit
# Compute the Gaussian process fit
gp = GaussianProcessRegressor()
gp.fit(xdata[:, np.newaxis], ydata)
xfit = np.linspace(0, 10, 1000)
yfit, y_std = gp.predict(xfit[:, np.newaxis], return_std=True)
dyfit = 2 * y_std  # 2*sigma ~ 95% confidence region

# now we have xfit, yfit, and dyfit, which sample the continuous fit to the data.
# could pass these to the plt.errorbar
# but  don't really want to plot 1,000 points with 1,000 errorbars.
# use the plt.fill_between function with a light color to visualize this continuous error:
# Visualize the result

plt.plot(xdata, ydata, 'or')
plt.plot(xfit, yfit, '-', color='gray')
plt.fill_between(xfit, yfit - dyfit, yfit + dyfit,  color='gray', alpha=0.2) # like p5js begin shape using curve vertex.
plt.xlim(0, 10)
plt.show()
#EOF