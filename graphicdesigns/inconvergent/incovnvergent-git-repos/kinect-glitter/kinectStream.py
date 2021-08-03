#!/usr/bin/env python

import freenect
import matplotlib.pyplot as plt
from scipy.signal import argrelmax
import signal
import numpy as np
from scipy import ndimage
from numpy import array, abs, \
                  clip, unravel_index, argmax, nanargmax, isnan,\
                  concatenate, cross, reshape
from numpy.linalg import norm
from sys import stdout
from time import time

plt.ion()

h = 480.
w = 640.

keep_running = True



do_depth_plot = False
do_time = False

#do_depth_plot = True
#do_time = True

kern_size = 40

df_lim = 0.2


def in_place_normalize(d):
  clip(d, 0, 2**10 - 1, d)
  top = d.max()
  bottom = d.min()
  d[:,:] = (d[:,:]-bottom) / (top-bottom)

def in_place_smooth(d):
  d[:,:] = ndimage.uniform_filter(d, kern_size) 

def in_place_clear_boundary(d,v):
  d[:,0] = v
  d[:,-1] = v
  d[0,:] = v
  d[-1,:] = v

def get_depth():
  
  data_prev = np.zeros(shape=(h,w), dtype='float')
  data = np.zeros(shape=(h,w), dtype='float')
  image = np.zeros(shape=(h,w,3), dtype='float')

  normals = np.zeros(shape=(h,w,3), dtype='float')
  df = np.zeros(shape=(h,w), dtype='float')
  xy_prev = array([0.,0.])
  xy = array([0.,0.])
  m_prev = [0]
  itt = [0]
  times = []
  points = []

  if do_depth_plot:
    plt.figure(1)
    image[10,11,:] = 1
    image[10,10,:] = 0
    handle = plt.imshow(image, interpolation='nearest', animated=True)
    plt.xlim([0,w])
    plt.ylim([h,0])
    plt.tight_layout()

  def depth(dev, in_data, timestamp):
    
    t0 = time()
    itt[0] += 1

    data[:] = in_data[:,::-1]

    in_place_normalize(data)

    shadowmask = data >= 1.0
    #set_normals(normals,data,kern=200)

    in_place_smooth(data)

    df[:] = data_prev[:] - data[:]
    df[df<0.05] = 0.0
    #in_place_clear_boundary(df,-1000.0)

    pm = argmax(df)
    j,i = unravel_index(pm, (h,w))
    m = data[j,i]

    xy[:] = [i/w,j/h]

    data_prev[:] = data[:]
    xy_prev[:] = xy[:]
    m_prev[0] = m

    if df[j,i]>df_lim:
      stdout.write('{:f};{:f};{:d};'.format(xy[0],xy[1],itt[0]))
      stdout.flush()

    if do_time:
      print('\ntime: {:1.5f}s'.format(time()-t0))

    if not do_depth_plot:
      return

    #image[:,:,0] = data
    #image[:,:,1] = data
    #image[:,:,2] = data

    image[:,:,0] = df/df.max()
    image[:,:,1] = data
    image[:,:,2] = 1.0
    image[shadowmask,2] = 0.0
    image[shadowmask,1] = 0.0
    image[shadowmask,0] = 0.0

    handle.set_data(image) 

    if df[j,i]>df_lim:
      try:
        l = points.pop()
        l.remove()
      except IndexError:
        pass
      new_l = plt.plot(i,j, 'ro', ms=20)
      points.extend(new_l)
      #print('*'*40)

    plt.draw()

    return

  return depth

def body(*args):
    if not keep_running:
        raise freenect.Kill


def handler(signum, frame):
    global keep_running
    keep_running = False


print('Press Ctrl-C in terminal to stop')
signal.signal(signal.SIGINT, handler)
freenect.runloop(depth=get_depth(),
                 body=body)

