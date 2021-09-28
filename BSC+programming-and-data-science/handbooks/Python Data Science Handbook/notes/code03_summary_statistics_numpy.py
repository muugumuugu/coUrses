import numpy as np
#--------------------------------
np.random.seed(0)# for consistency
#-----------------------------
import matplotlib.pyplot as plt
import seaborn; seaborn.set()  # set plot style
#-------------------
import pandas as pd
data = pd.read_csv('data/president_heights.csv')
heights = np.array(data['height(cm)'])# convert column to np array.
print(heights)
print("Mean height:       ", heights.mean())
print("Standard deviation:", heights.std())
print("Minimum height:    ", heights.min())
print("Maximum height:    ", heights.max())
print("25th percentile:   ", np.percentile(heights, 25))
print("Median:            ", np.median(heights))
print("75th percentile:   ", np.percentile(heights, 75))
plt.hist(heights)
plt.title('Height Distribution of US Presidents')
plt.xlabel('height (cm)')
plt.ylabel('number')
plt.show()
#-----------------------------------
print('-' * 100)
## centering an array
X = np.random.random((3, 3))
Xmean = X.mean(0)#aggregate across 1st dimension
X_centered = X - Xmean
print('X')
print(X)
print('X - centered around mean')
print(X_centered)
# check
X_centered.mean(0)## zero with machine precision .
#-----------------------------------
print('-' * 100)
#displaying images based on two-dimensional functions.
# If we want to define a function 𝑧=𝑓(𝑥,𝑦),
#broadcasting can be used to co# x and y have 50 steps from 0 to 5mpute the function across the grid:
x = np.linspace(0, 5, 50)
y = np.linspace(0, 5, 50)[:, np.newaxis]
z = np.sin(x) ** 10 + np.cos(10 + y * x) * np.cos(x)

plt.imshow(z, origin='lower', extent=[0, 5, 0, 5], cmap='viridis') #colormap=styling
plt.colorbar(); #label
plt.show()