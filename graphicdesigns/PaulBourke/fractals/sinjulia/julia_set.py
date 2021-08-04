#------------------------------------------------------------------------------#
#                                   IMPORTS                                    #
#------------------------------------------------------------------------------#
import numpy, sys
from math import sqrt, pi
from cmath import sin, cos
from time import clock

#------------------------------------------------------------------------------#
#                                  CONSTANTS                                   #
#------------------------------------------------------------------------------#
scale = 6.0
center = (0.0 + 0.0j) # not tried yet
width = 2560
height = 1536
bailout = 4096

#------------------------------------------------------------------------------#
#                                  PGM STUFF                                   #
#------------------------------------------------------------------------------#
def write_pgm(data, fname):
  f = file(fname, "wb")
  f.write("P5\r\n")
  f.write("%d %d\r\n" % (width, height))
  f.write("65535\r\n")
  f.write(numpy.array(data, dtype='int16').tostring())
  f.close()

#------------------------------------------------------------------------------#
#                    QUADRATIC JULIA ITERATION AND BAILOUT                     #
#------------------------------------------------------------------------------#
# scales near 2 work best ...
# constants for the quadratic julia set
# c = 1j              # dentrite fractal
# c = -0.123 + 0.745j # douady's rabbit fractal
# c = -0.750 + 0j     # san marco fractal
# c = -0.391 - 0.587j # siegel disk fractal
# c = -0.7 - 0.3j     # NEAT cauliflower thingy
# c = -0.75 - 0.2j    # galaxies
# c = -0.75 + 0.15j   # groovy
# c = -0.7 + 0.35j    # frost
def quadratic_iteration(z):
  for i in range(128):
    if abs(z) > 2.0:
      break
    else:
      z = z**2 + c
  return i

#------------------------------------------------------------------------------#
#                       SIN JULIA ITERATION AND BAILOUT                        #
#------------------------------------------------------------------------------#
# scales around 10 work well
c = 1.0 + 0.1j          # electric christmas tree tops

def sin_iteration(z):
  for i in range(bailout):
    if abs(z.imag) > 50.0:
      break
    else:
      z = c*sin(z)
  return i

#------------------------------------------------------------------------------#
#                       COS JULIA ITERATION AND BAILOUT                        #
#------------------------------------------------------------------------------#
# c = 1.0 - 0.5j        # probably has good colors
# c = pi/2*(1.0 + 0.6j) # sort of cool - dendrites
# c = pi/2*(1.0 + 0.4j) # same deal
# c = pi/2*(2.0 + 0.25j)  # fuzzy spots
# c = pi/2*(1.5 + 0.05j)  # batlef

def cos_iteration(z):
  for i in range(bailout):
    if abs(z.imag) > 50.0:
      break
    else:
      z = c*cos(z)
  return i

#------------------------------------------------------------------------------#
#                               SET JULIA METHOD                               #
#------------------------------------------------------------------------------#
julia_iteration = sin_iteration

#------------------------------------------------------------------------------#
#                                 MAIN METHOD                                  #
#------------------------------------------------------------------------------#
if __name__ == "__main__":
  # get an idea of how long this took, this starts the clock
  clock()
  # to get an idea of the maximum color depth - you need the second largest
  # count, since the *first* largest count is always going to be those things
  # that are in the set.
  second_largest = 0
  max_count      = 0

  # To adjust the vector to be inside of a circle in the complex plane, radius
  # of 'scale' and centered on 'center' you need to adjust by the size of the
  # picture.
  factor = sqrt((width/2.)**2 + (height/2.)**2)

  # store your data, for later conversion to PGM
  data = []
  for h in range(height/2, -height/2, -1):
    for w in range(-width/2, width/2):
      # This transforms the w, h coordinates into a space centered on the
      # centroid of the rectangle.
      z = w/factor + (1.0j/factor)*h
      z = scale*(z + center)
      count = julia_iteration(z)
      max_count = max(max_count, count)
      if count < max_count:
        second_largest = max(second_largest, count)
      data.append(count)


  # Now, data contains the julia set as a list, convert this to two-byte
  # integer format and write to a file.
  write_pgm(data, "julia_fractal.pgm")
  sys.stderr.write("elapsed time: %.1f seconds\r\n" % clock())
  sys.stderr.write("second largest count: %d\r\n" % second_largest)
