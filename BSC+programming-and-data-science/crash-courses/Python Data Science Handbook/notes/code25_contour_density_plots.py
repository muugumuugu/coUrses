import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
from sklearn.gaussian_process import GaussianProcessRegressor
plt.style.use('seaborn-whitegrid')
#-----------------------------------------------
# display three-dimensional data in two dimensions using contours or color-coded regions
#-----------------------------------------------
def f(x, y):
    return np.sin(x) ** 10 + np.cos(10 + y * x) * np.cos(x)
x = np.linspace(0, 5, 50)
y = np.linspace(0, 5, 40)

X, Y = np.meshgrid(x, y) # makes  a  2d grid , from 1d array
Z = f(X, Y)
plt.contour(X, Y, Z, colors='black'); # takes grids as input
plt.show()# single color -->negative values are represented by dashed lines, and positive values by solid lines
plt.contour(X, Y, Z, 20, cmap='RdGy'); # 20 equally spaced intervals, colormap Red-Gray
plt.colorbar() # the legend
plt.show()
#filled countour
#-----
#discrete colors
plt.contourf(X, Y, Z, 20, cmap='RdGy')
plt.colorbar();
plt.show()
#continous fill
plt.imshow(Z, extent=[0, 5, 0, 5], origin='lower',cmap='RdGy')
"""
doesn't accept an x and y grid, manually specify the extent [xmin, xmax, ymin, ymax] of the image on the plot.
uses img definition and has top-left origin by default.
automatically adjusts the axis aspect ratio to match the input data
"""
plt.colorbar()
plt.show()

#---------------------------
#combined plots
contours = plt.contour(X, Y, Z, 3, colors='black')
plt.clabel(contours, inline=True, fontsize=8) #overplot countours with labels on the countour plot
plt.imshow(Z, extent=[0, 5, 0, 5], origin='lower',  cmap='RdGy', alpha=0.5)
plt.colorbar();
plt.show()
















#EOF