#Broadcasting
#set of rules for applying binary ufuncs (e.g., addition, subtraction, multiplication, etc.) on arrays of different sizes.
import numpy as np
a = np.array([0, 1, 2])
print(a+5)
# almost as ifstretches or duplicates the value 5 into the array [5, 5, 5], and adds the results.
# this duplication of values does not actually take place, but it is a useful mental model for broadcasting
M = np.ones((3, 3))
print(M + a)#one-dimensional array a is stretched, or broadcast across the second dimension in order to match the shape of M.
#multi d broadcasting
a = np.arange(3)
b = np.arange(3)[:, np.newaxis]

print(a)
print(b)
print(a+b)# involves broadcasting both arrays
"""
Rules of Broadcasting

Broadcasting in NumPy follows a strict set of rules to determine the interaction between the two arrays:

    Rule 1: If the two arrays differ in their number of dimensions, the shape of the one with fewer dimensions is padded with ones on its leading (left) side.
    Rule 2: If the shape of the two arrays does not match in any dimension, the array with shape equal to 1 in that dimension is stretched to match the other shape.
    Rule 3: If in any dimension the sizes disagree and neither is equal to 1, an error is raised.
 """
#consider an operation on  two arrays. The shape of the arrays are
M = np.ones((2, 3))
a = np.arange(3)

M.shape = (2, 3)
a.shape = (3,)
#by rule 1 that the array a has fewer dimensions, so we pad it on the left with ones:
#M.shape -> (2, 3)
#a.shape -> (1, 3)
#
# rule 2, we now see that the first dimension disagrees, so we stretch this dimension to match:
#M.shape -> (2, 3)
#a.shape -> (2, 3)

# The shapes match,
#final shape will be (2, 3):
print('M')
print(M)
print('a')
print(a)
print('M+a')
print(M+a)