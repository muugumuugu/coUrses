import numpy as np
#--------------------------------
np.random.seed(0)# for consistency
#-----------------------------
values = np.random.randint(1, 10, size=5)
print(values)
print(1.0 / values)
#NumPy provides a convenient interface into C/C++ kind of statically typed, compiled routine (vectorized operation)
#This can be accomplished by simply performing an operation on the array, which will then be applied to each element.
#This vectorized approach is designed to push the loop into the compiled layer that underlies NumPy, leading to much faster execution.
print(np.arange(5) / np.arange(1, 6))
#Vectorized operations in NumPy are implemented via ufuncs,
#main purpose is to quickly execute repeated operations on values in NumPy arrays.
#Ufuncs are extremely flexible –  an operation between a scalar and an array,  can also operate between two arrays:
x = np.arange(9).reshape((3, 3))
print(2 ** x)
#on multi D array, in one go
print('-'*100)
#----------------------
#Array arithmetic
x = np.arange(4)
print("x      =", x)
print("x + 5  =", x + 5)
print("x - 5  =", x - 5)
print("x * 2  =", x * 2)
print("x / 2  =", x / 2) # floating point division
print("x // 2 =", x // 2)
print("-x     =", -x)
print("x ** 2 =", x ** 2)
print("x % 2  =", x % 2)
#-------------------
print('-'*100)
x = np.array([-2, -1, 0, 1, 2])
abs(x)
#gives mag of complex no if that is the datatype
x = np.array([3 - 4j, 4 - 3j, 2 + 0j, 0 + 1j])
np.abs(x)
#======================================
#trigo
theta = np.linspace(0, np.pi, 3)#equally space 3 numbers bw 0 and pi
print("theta      = ", theta)
print("sin(theta) = ", np.sin(theta))
print("cos(theta) = ", np.cos(theta))
print("tan(theta) = ", np.tan(theta))
x = [-1, 0, 1]
print("x         = ", x)
print("arcsin(x) = ", np.arcsin(x))
print("arccos(x) = ", np.arccos(x))
print("arctan(x) = ", np.arctan(x))
#_-----------------------------------
#small number precision functions
x = [0, 0.001, 0.01, 0.1]
print("exp(x) - 1 =", np.expm1(x))
print("log(1 + x) =", np.log1p(x))
#=============================
#obscure functions
from scipy import special
# Gamma functions (generalized factorials) and related functions
x = [1, 5, 10]
print("gamma(x)     =", special.gamma(x))
print("ln|gamma(x)| =", special.gammaln(x))
print("beta(x, 2)   =", special.beta(x, 2))

# Error function (integral of Gaussian)
# its complement, and its inverse
x = np.array([0, 0.3, 0.7, 1.0])
print("erf(x)  =", special.erf(x))
print("erfc(x) =", special.erfc(x))
print("erfinv(x) =", special.erfinv(x))
#================================================
#specifying output
#For large calculations, it is sometimes useful to be able to specify the array where the result of the calculation will be stored.
#Rather than creating a temporary array, this can be used to write computation results directly to the memory location where you'd like them to be.
# For all ufuncs, this can be done using the out argument of the function:
x = np.arange(5)
y = np.empty(5)
np.multiply(x, 10, out=y)
print(y)
#with array view
y = np.zeros(10)
np.power(2, x, out=y[::2])#write the results of a computation to every other element of a specified array:
print(y)
#==============================================
# aggregates
#use the reduce method of any ufunc.
#reduce repeatedly applies a given operation to the elements of an array until only a single result remains.
x = np.arange(1, 6)
print(x)
print(np.add.reduce(x))
#store intermediate results
print(np.add.accumulate(x))
#compute the output of all pairs of two different inputs using the outer method.
#multiplication table:
print(np.multiply.outer(x, x)) # add.outer,subtract.outer , etc.
big_array = np.random.rand(1000000)
print(np.min(big_array))
#multi -dimensional
M = np.random.random((3, 4))
print(M)
#whole array
M.sum()
#Aggregation functions take an additional argument specifying the axis along which the aggregate is computed.
M.min(axis=0) #find the minimum value within each column by specifying axis=0:


"""
np.sum			np.nansum 			Compute sum of elements
np.prod 		np.nanprod 			Compute product of elements
np.mean 		np.nanmean 			Compute mean of elements
np.std 			np.nanstd 			Compute standard deviation
np.var 			np.nanvar 			Compute variance
np.min 			np.nanmin 			Find minimum value
np.max 			np.nanmax 			Find maximum value
np.argmin 		np.nanargmin 		Find index of minimum value
np.argmax 		np.nanargmax 		Find index of maximum value
np.median 		np.nanmedian 		Compute median of elements
np.percentile 	np.nanpercentile 	Compute rank-based statistics of elements
np.any		 	N/A 				Evaluate whether any elements are true
np.all 			N/A 				Evaluate whether all elements are true
"""


























#ef