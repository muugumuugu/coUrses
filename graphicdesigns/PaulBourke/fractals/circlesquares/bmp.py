from Numeric import arange, array, maximum, minimum, ones, ravel, zeros
from operator import mul

#------------------------------------------------------------------------------#
#                              utility functions                               #
#------------------------------------------------------------------------------#

def _raw(t, pad=-1):
  """
  Given an integer 't', return its raw binary representation, padded to 'pad'
  bytes.  If the raw representation has more than 'pad' bytes, the high order
  bytes are truncated.
  """
  s = hex(t)[2:]
  s = s.replace("L", "")
  if len(s) % 2 == 1:
    s = "0" + s

  s_len = len(s)

  if pad < 0:
    pad = s_len/2

  retval = []
  for i in range(0, s_len, 2):
    retval.append(chr(int(s[i:i+2], 16)))

  retval.reverse()  # put the bytes in little endian order
  if pad > s_len/2: # pad the array to the correct number of bytes
    retval += ['\x00',]*(pad-s_len/2)

  return ''.join(retval)

#------------------------------------------------------------------------------#
#                                  colormaps                                   #
#------------------------------------------------------------------------------#

def gamma(n=256, exponet=2.2):
  """Creates an n-entry colormap with a logarithmic intensity variation."""
  ct = arange(n)
  ct = pow(ct, 1./exponet)
  ct = (ct-ct[0])/(ct[-1]-ct[0])*255
  ct = ct.astype('b')

  retval = zeros((n,4), 'b')
  retval[:,0] = ct
  retval[:,1] = ct
  retval[:,2] = ct
  
  return retval.tostring()

def linear(n=256):
  """Creates an n-entry colormap with a linear intensity variation."""
  ct = arange(0, n, 1, 'b')
  retval = zeros((n,4), 'b')

  retval[:,0] = ct
  retval[:,1] = ct
  retval[:,2] = ct
  
  return retval.tostring()

#------------------------------------------------------------------------------#
#                              BMP output routine                              #
#------------------------------------------------------------------------------#

def bmp_output(a, fname):
  f = file(fname, "wb")
  imgsize = reduce(mul, a.shape)

  # NOTE! this assumes little-endian (Intel i386) byte ordering!
  # Information on the BMP format was found at:
  # http://www.fortunecity.com/skyscraper/windows/364/bmpffrmt.html

  # BMP file header
  f.write("BM")                  # bfType(2) - always 'BM'
  f.write(_raw(imgsize+1078, 4)) # bfSize(4) - size of file w/1078 header bytes
  f.write(_raw(0, 2))            # bfReserved1(2) - always 0x0000
  f.write(_raw(0, 2))            # bfReserved2(2) - always 0x0000
  f.write(_raw(1078, 4))         # bfOffBits(4) - raster offset
  
  # BMP info header
  f.write(_raw(40, 4))           # biSize(4) - size of 'info' structure
  f.write(_raw(a.shape[0], 4))   # biWidth(4) - image width in pixels
  f.write(_raw(a.shape[1], 4))   # biHeight(4) - image height in pixels
  f.write(_raw(1, 2))            # biPlanes(2) - number of bitplanes on target
  f.write(_raw(8, 2))            # biBitCount(2) - bpp, usually 8
  f.write(_raw(0, 4))            # biCompression(4) - compression method (none)
  f.write(_raw(imgsize, 4))      # biSizeImage(4) - size of image structure
  f.write(_raw(0, 4))            # biXPelsPerMeter(4) - pixels per meter
  f.write(_raw(0, 4))            # biYPelsPerMeter(4) - pixels per meter
  f.write(_raw(256, 4))          # biClrUsed(4) - number of colors in colormap
  f.write(_raw(256, 4))          # biClrImportant(4) - ? important colors ?

  # BMP colormap
  f.write(gamma())

  # BMP image structure
  if not a.typecode() == 'b':
    maxval = maximum.reduce(ravel(a))
    minval = minimum.reduce(ravel(a))
    a = (a-minval)/(maxval-minval+1e-10)*255
    a = a.astype('b')

  tempmat = zeros(a.shape, 'b')
  for row in range(a.shape[0]):
    tempmat[row] = a[a.shape[0]-row-1]
  f.write(tempmat.tostring())
  f.close()
  del(tempmat)

#------------------------------------------------------------------------------#
#                                  unit test                                   #
#------------------------------------------------------------------------------#

if __name__ == "__main__":
  a = arange(0, 1024, 1, 'd')
  a.shape = (32, 32)
  bmp_output(a, "bmp_unittest.bmp")
