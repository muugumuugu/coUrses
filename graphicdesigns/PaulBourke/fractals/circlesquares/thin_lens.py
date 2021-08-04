from Numeric import exp, zeros
from math import atan2
from bmp import bmp_output

#------------------------------------------------------------------------------#
#                                  constants                                   #
#------------------------------------------------------------------------------#

pic_size = 256                   # width of the input image in pixels
pic_shape = (pic_size, pic_size)
window_size = 10.                # width of the input image in mm
dx = window_size/pic_size        # pixels per mm, spatial resolution

def arg_matrix(mat):
  """Generates a matrix that has the angle of the complex-valued matrix."""
  angle_matrix = zeros(mat.shape, 'd')
  for y in range(mat.shape[0]):
    for x in range(mat.shape[1]):
      angle_matrix[y,x] = atan2(mat[y,x].imag, mat[y,x].real)
  return angle_matrix

#------------------------------------------------------------------------------#
#                              thin lens operator                              #
#------------------------------------------------------------------------------#

k = 100.
lens = zeros(pic_shape, 'D')
for y in range(lens.shape[0]):
  for x in range(lens.shape[1]):
    lens[y,x] = \
      exp(k*(0-1j)*((dx*(x-pic_size/2.))**2+(dx*(y-pic_size/2.))**2))

#------------------------------------------------------------------------------#
#                                 main method                                  #
#------------------------------------------------------------------------------#
if __name__ == "__main__":
  bmp_output(lens.real, "lens.bmp")
  bmp_output(arg_matrix(lens), "lens_arg.bmp")
