#!/usr/bin/python
# -*- coding: utf-8 -*-

from __future__ import print_function

def get_stack(path):

  from glob import glob
  from scipy.ndimage import imread

  files = sorted(glob(path+'*.png'))

  stack = imread(files[0])[:,:,0]/256.

  for f in sorted(files[1:]):
    print(f)
    img = imread(f)/256.
    stack += img[:,:,0]/256.

  return stack

def do_stack(stack):

  mv = stack[:].max()
  print(mv)
  stack[:,:] /= mv

  return stack

def export(img, path):

  #from scipy.ndimage import imwrite
  from scipy.misc import imsave


  imsave(path+'res.png', img)


def main(path):

  stack = get_stack(path)
  s = do_stack(stack)

  export(s, './')


if __name__ == '__main__' :

  import sys
  argv = sys.argv
  main(argv[1])

