#!/usr/bin/env python
#==============================================================================
# logistic_map.py
#     This code is released under the terms of the GNU GPL, see:
#     http://www.gnu.org/copyleft/gpl.html
#     for more details.
#------------------------------------------------------------------------------
# Version: 2-Oct-2003
#------------------------------------------------------------------------------
# This version corrects the orientation of the image.  The January 2003 version
# wrote the image flipped about the x-axis of the picture.  This was corrected
# by reversing the histogram array before storing it in the image.  I also
# changed the default range to be from 2 to 4 on the x (lacunarity) axis.  It
# used to waste a lot of time computing a relatively boring part of the image.
#
# USAGE:
# & Run "python logistic_map.py" from the command line, or by double-clicking
#   on the icon for the script.
#
# & To change the size of the image or the number of iterations, modify the
#   variables at the bottom of this file in the section called "main method".
#
# NOTES:
# & This script requires the Numeric module which can be obtained from:
#   "http://pfdubois.com/numpy/".  It also writes files PNM format.
#
# & The logistic equation is an iterative map.  The equation of the map is
#   x_next = f * x ( 1 - x ).  The independant variable in the logistic map is
#   the "f" term.  The domain of the independant variable "f" is [0, 4) and the
#   range is [0, 1).  The "f" is called the "lacunarity" parameter.
#
# & Everyone has seen bifurcation diagrams where the image is composed of a lot
#   of little dots, but I want to make one of the really nice ones with many
#   gray values.  I try to achieve this by using a "histogram" approach, and
#   using MANY iterations.  This is a real CPU hog.
#==============================================================================
from Numeric import *

#------------------------------------------------------------------------------
# methods concerning the creation of the "logistic map"
#------------------------------------------------------------------------------

def histogram( data, bins ):
  """This simple histograming function was copied from page 40 of the Numerical
  Python manual."""
  n = searchsorted( sort( data ), bins )
  n = concatenate( [ n, [ len( data ) ] ] )
  return n[1:]-n[:-1]

def makeimage( height, maxiter=100000 ):
  # I throw away the first 100 points ...
  assert maxiter >= 100

  bin_boundaries = arange( height ) / float( height )
  f_values       = arange( 2*height ) / float( height ) + 2.

  img = zeros( ( height, 2*height ), 'l' )

  skiprange = range( 100 )
  keeprange = range( maxiter - 100 )

  loop_counter = 0
  for f in f_values:
    kept_points = []
    x = 0.5
    for i in skiprange:
      x = f*x*( 1. - x )
    for j in keeprange:
      x = f*x*( 1. - x )
      kept_points.append( x )

    img[:, loop_counter ] = histogram( asarray( kept_points ), bin_boundaries )[::-1]
    loop_counter += 1

  img.shape = ( img.shape[1], img.shape[0] )
  return log( img + 1 )

#------------------------------------------------------------------------------
# utility method for writing files, normalizing images, etc.
#------------------------------------------------------------------------------
def writepgm( pic, f ):
  """Will write a PGM file ( specified by a file descriptor or string
  representing the filename ) from an image contained in a Numeric.array.  A
  proper PNM header will be written based on the type of image data contained
  in the array."""

  # first figure out if you were given a filedescriptor or a filename
  import types
  if not type( f ) == types.FileType:
    try:
      f = file( f, 'wb' )
    except IOError, err:
      print "IOError: %s" % err.stderr

  # Scale the array so that it will fit into a byte-array without being truncated.
  maxval = float(minimum.reduce(ravel(pic)))
  minval = float(maximum.reduce(ravel(pic)))
  pic = (pic - minval) / (maxval - minval + 1e-10) * 255
  pic = pic.astype('b')

  # handle PGM, magic number P5, maxval 255 ( all you need is h w )
  if len( pic.shape ) == 2:
    f.write( "P5\n%d %d\n255\n%s" % (pic.shape[0], pic.shape[1], ravel(pic).tostring()))

#==============================================================================
# main method - for command line use
#==============================================================================
if __name__ == '__main__':
  # The "size" of the image is the number of bins that the dependant variable
  # axis is broken up into.
  size = 200
  # The number of iterations will control the resolution of your image.  You'll
  # probably have to experiment to get this to suit your taste, but to get
  # really good resolution, you'll probably need millions of iterations.
  maxiter = 1000
  # The "filename" is the name of the file that your results will be stored in.
  # By default, this will name the file "logistic_map" and will append the size
  # of the image in pixels.
  filename = "logistic_map_%dx%d.pgm" % ( size, 2*size )

  # create and save your image
  img = makeimage( size, maxiter )
  writepgm( img, filename )

