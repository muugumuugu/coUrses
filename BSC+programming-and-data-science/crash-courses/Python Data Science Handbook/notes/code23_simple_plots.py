import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
from sklearn.datasets import load_iris
iris = load_iris()
features = iris.data.T #data
#--------------------------------
x = np.linspace(0, 10, 100)
#=======================================
plt.style.use('seaborn-whitegrid')# the aesthetic : color schemes etc
# create a empty figure

fig = plt.figure()
ax = plt.axes()
x = np.linspace(0, 10, 1000)
"""
ax.plot(x, np.sin(x));
plt.plot(x, np.sin(x));
"""
# specify x and y range
plt.xlim(-1, 11)
plt.ylim(-1.5, 1.5);
"""
or compactly
plt.axis([-1, 11, -1.5, 1.5]); # custom range
plt.axis('tight'); # bounds around plot
plt.axis('equal'); # maintain aspect ratio
"""
# to get multiple lines simply call the plot function multiple times
#style them all
plt.plot(x, np.sin(x - 0),color='blue')        # specify color by name
plt.plot(x, np.sin(x - 1),'--g')         # short color code (rgbcmyk) + linestyle
plt.plot(x, np.sin(x - 2), color='0.75',linestyle='-.')        # Grayscale between 0 and 1
plt.plot(x, np.sin(x - 3), color='#FFDD44', linestyle='dotted')     # Hex code (RRGGBB from 00 to FF)
plt.plot(x, np.sin(x - 4), color=(1.0,0.2,0.3)) # RGB tuple, values 0 to 1
plt.plot(x, np.sin(x - 5), color='chartreuse' ,label="char"); # all HTML color names supported # label it
plt.legend();# show labels's styling
plt.xlabel("X AXISSSSS")
plt.title("GRAPH TITLE")
plt.show()
"""
plt to fig/ax oop:
	plt.xlabel() → ax.set_xlabel()
    plt.ylabel() → ax.set_ylabel()
    plt.xlim() → ax.set_xlim()
    plt.ylim() → ax.set_ylim()
    plt.title() → ax.set_title()
"""
rng = np.random.RandomState(0)
for marker in ['o', '.', ',', 'x', '+', 'v', '^', '<', '>', 's', 'd']:
    plt.plot(rng.rand(5), rng.rand(5), marker,  label="marker='{0}'".format(marker))
plt.legend(numpoints=1)
plt.xlim(0, 1.8); #scatter plot
plt.show()
#=====================
# styling the marker
x = np.linspace(0, 10, 30)
y = np.sin(x)
plt.plot(x, y, '-p', color='gray', markersize=15, linewidth=4, markerfacecolor='white', markeredgecolor='gray', markeredgewidth=2)
plt.show()

#=======================
# using plt.scatter
# it can create plots where each individual point has a different styling
# slightly overhead compared to plot
rng = np.random.RandomState(0)
x = rng.randn(100)
y = rng.randn(100)
colors = rng.rand(100)
sizes = 1000 * rng.rand(100)
plt.scatter(x, y, c=colors, s=sizes, alpha=0.3,  cmap='viridis')
plt.colorbar();  # show color scale -- auto mapped , useul for multi-dimensional data
plt.show()
#==============================
#EXAMPLE
plt.scatter(features[0], features[1], alpha=0.2,
            s=100*features[3], c=iris.target, cmap='viridis')
plt.xlabel(iris.feature_names[0])
plt.ylabel(iris.feature_names[1]);
plt.show()
#============================
























#EOF