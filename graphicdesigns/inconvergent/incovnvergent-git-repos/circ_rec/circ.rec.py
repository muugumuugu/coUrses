#!/usr/bin/python
# -*- coding: utf-8 -*-

from numpy import cos, sin, pi
from numpy.random import random as rand
import cairo
from time import time as time

PII   = 2*pi
N     = 5000
BACK  = 1.
FRONT = 0.
ALPHA = 0.2
OUT   = 'cr.c.0'
M     = 9
DEFR  = 0.02
RATIO = 0.5


def ctxInit():
  sur = cairo.ImageSurface(cairo.FORMAT_ARGB32,N,N)
  ctx = cairo.Context(sur)
  ctx.scale(N,N)
  ctx.set_source_rgb(BACK,BACK,BACK)
  ctx.rectangle(0,0,1,1)
  ctx.fill()
  return sur,ctx

def CInit():
  C = []
  #     x,y,r,rep
  m = 1./(M+1)
  for i in xrange(M):
    for j in xrange(M):
      x = m + i*m
      y = m + j*m
      r = DEFR
      rep = 3 + int(rand()*3)
      C.append((x,y,r,rep))

  return C


def main():

  sur,ctx = ctxInit()
  ctx.set_source_rgba(FRONT,FRONT,FRONT,ALPHA)

  C = CInit()

  i = 0
  ti = time()
  while C:
    x,y,r,rep = C.pop()
    if r < 1./N:
      continue
    
    ctx.arc(x,y,r,0.,PII)
    ctx.fill()

    p = rand()*PII
    for t in xrange(rep):
      c = (x + cos(t*PII/rep+p)*r,
           y + sin(t*PII/rep+p)*r,
           r*RATIO,
           rep)
      C.append(c)
    i+=1
    if not i % 1000:
      print i, r, time()-ti
      ti = time()

  sur.write_to_png('{:s}.png'.format(OUT))

  return

if __name__ == '__main__' : main()

