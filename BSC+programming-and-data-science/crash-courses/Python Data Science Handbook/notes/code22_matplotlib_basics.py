import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
#--------------------------------
x = np.linspace(0, 10, 100)
#=======================================
plt.style.use('classic') # the aesthetic : color schemes etc
plt.show() # creates a tiny gui, and runs an event loop, collecting all figures in stack, and displaying them
"""
%matplotlib inline
for iPython/notebooks --> all matplot code cells are rendered into png views
"""
# fig.savefig('my_figure.png') # save a figure to local drive
"""
MATLAB-style tools are contained in the pyplot (plt) interface
this interface is stateful: it keeps track of the "current" figure and axes,
which are where all plt commands are applied.
check status:
	plt.gcf() (get current figure)
	plt.gca() (get current axes) routines.
"""
plt.figure()  # create a plot figure
# create the first of two panels and set current axis
plt.subplot(2, 1, 1) # (rows, columns, panel number)
plt.plot(x, np.sin(x))
# create the second panel and set current axis
plt.subplot(2, 1, 2)
plt.plot(x, np.cos(x));
plt.show()
"""
object-oriented interface the plotting functions are methods of explicit Figure and Axes objects
"""
# First create a grid of plots
# ax will be an array of two Axes objects
fig, ax = plt.subplots(2)

# Call plot() method on the appropriate object
ax[0].plot(x, np.sin(x))
ax[1].plot(x, np.cos(x));
plt.show()