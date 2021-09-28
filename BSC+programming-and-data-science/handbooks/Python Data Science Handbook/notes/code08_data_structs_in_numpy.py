import numpy as np
#assosiative arrays
#--------------------------------------------------------------------
# Use a compound data type for structured arrays
data = np.zeros(4, dtype={'names':('name', 'age', 'weight'),
                          'formats':('U10', 'i8', 'f8')}) # equiv to 'formats':((np.str_, 10), int, np.float32)})
# tuple way
#np.dtype([('name', 'S10'), ('age', 'i4'), ('weight', 'f8')])
#
#'U10'--> Unicode string of maximum length 10
#'i4' --> 8-byte (i.e., 64 bit) integer
#'f8' --> 4-byte (i.e., 32 bit) float
"""
'b' 		Byte 					np.dtype('b')
'i' 		Signed integer 			np.dtype('i4')  == np.int32
'u' 		Unsigned integer 		np.dtype('u1')  == np.uint8
'f' 		Floating point 			np.dtype('f8')  == np.int64
'c' 		Complex floating point 	np.dtype('c16') == np.complex128
'S', 'a' 	String 					np.dtype('S5')
'U' 		Unicode string 			np.dtype('U')   == np.str_
'V' 		Raw data (void) 		np.dtype('V')   == np.void
"""
print(data.dtype)
#arrays:
name = ['Alice', 'Bob', 'Cathy', 'Doug']
age = [25, 45, 37, 19]
weight = [55.0, 85.5, 68.0, 61.5]
#assosiate the arrays:
data['name'] = name
data['age'] = age
data['weight'] = weight
print(data)
#---------------------------------------------------------
#xompound types
tp = np.dtype([('id', 'i8'), ('mat', 'f8', (3, 3))])
X = np.zeros(1, dtype=tp)
print(X[0])
print(X['mat'][0])
#=============================================================================================================
# np.recarray
# almost identical to the structured array
# additional feature: fields can be accessed as attributes rather than as dictionary keys
# for json compliant dot notation
# some extra overhead involved in accessing the field
data_rec = data.view(np.recarray)
print(data_rec.name)