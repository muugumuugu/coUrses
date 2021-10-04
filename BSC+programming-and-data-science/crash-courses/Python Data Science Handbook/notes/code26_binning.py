import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
plt.style.use('seaborn-whitegrid')
#-----------------------------------------------
data = np.random.randn(1000)
plt.hist(data);#basic
plt.show()
#-----------
# fine-tuning
plt.hist(data, bins=30, alpha=0.5, histtype='stepfilled', color='steelblue',edgecolor='none');
plt.show()
## multiple
kwargs = dict(histtype='stepfilled', alpha=0.3, bins=40)
x1 = np.random.normal(0, 0.8, 1000)
x2 = np.random.normal(-2, 1, 1000)
x3 = np.random.normal(3, 2, 1000)
plt.hist(x1, **kwargs)
plt.hist(x2, **kwargs)
plt.hist(x3, **kwargs)
plt.show()
# only computing the histogram
counts, bin_edges = np.histogram(data, bins=5)
print(counts)
#----------------------------------------
#2d histogram
mean = [0, 0]
cov = [[1, 1], [1, 2]]
x, y = np.random.multivariate_normal(mean, cov, 10000).T # multivariate Gaussian Distribution
plt.hist2d(x, y, bins=30, cmap='Blues')
cb = plt.colorbar()
cb.set_label('counts in bin')
plt.show()
"""
counts, xedges, yedges = np.histogram2d(x, y, bins=30)
"""
"""
higher dimensions
np.histogramdd
"""
# hex-tiles
# can specify weights for each point using arg "C" , and can change the output in each bin to any NumPy aggregate (mean of weights, standard deviation of weights, etc. using "reduce_C_function" arg).
plt.hexbin(x, y,bins='log', gridsize=30, cmap='Blues')
cb = plt.colorbar(label='count in bin')
plt.show()





























#EOF