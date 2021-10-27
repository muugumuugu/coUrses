#!/usr/bin/python
# -*- coding: utf-8 -*-

def main():

  import numpy as np
  import cairo, Image
  from time import time as time
  from operator import itemgetter
  from matplotlib import pyplot as plt
  import sys

  from scipy.spatial import Delaunay, distance

  colstack = np.column_stack
  pdist    = distance.pdist
  cdist    = distance.cdist
  cos      = np.cos
  sin      = np.sin
  pi       = np.pi
  arctan2  = np.arctan2
  sqrt     = np.sqrt
  square   = np.square
  int      = np.int
  zeros    = np.zeros
  array    = np.array
  rand     = np.random.random
  xand     = np.logical_and

  BACK = 1.
  FRONT = 0.
  ALPHA = 0.7

  pii = 2.*pi
  C = 0.5
  ITTMAX = 1000

  N = 1000
  ONE = 1./N
  STP = ONE

  BLACK_HOLE = STP/2.

  FUZZ = STP

  NUM = 50
  FLOCK_RAD = 0.2
  NEAR_RAD = 0.1
  COHESION_RAD = 0.4

  SEPARATION_PRI = 0.5
  ALIGNMENT_PRI = 0.4
  COHESION_PRI = 0.1

  #def ctx_init():
    #sur = cairo.ImageSurface(cairo.FORMAT_ARGB32,N,N)
    #ctx = cairo.Context(sur)
    #ctx.scale(N,N)
    #ctx.set_source_rgb(BACK,BACK,BACK)
    #ctx.rectangle(0,0,1,1)
    #ctx.fill()
    #return sur,ctx
  #sur,ctx = ctx_init()

  #def stroke(x,y):
      #ctx.rectangle(x,y,1./N,1./N)
      #ctx.fill()
      #return
  #vstroke = np.vectorize(stroke)

  ## CLASSES

  class Meta(object):

    c = [0]
    X = zeros(NUM,dtype=np.float)
    Y = zeros(NUM,dtype=np.float)
    DX = zeros(NUM,dtype=np.float)
    DY = zeros(NUM,dtype=np.float)

    SEPX = zeros(NUM,dtype=np.float)
    SEPY = zeros(NUM,dtype=np.float)
    ALIX = zeros(NUM,dtype=np.float)
    ALIY = zeros(NUM,dtype=np.float)
    COHX = zeros(NUM,dtype=np.float)
    COHX = zeros(NUM,dtype=np.float)

    A = zeros( (NUM,NUM), dtype=np.float )
    R = zeros( (NUM,NUM), dtype=np.float )

    F = zeros( (NUM,NUM), dtype=np.bool )

    def set_dist(self):

      self.R[:] = cdist(*[ colstack(( self.X,self.Y )) ]*2 )

    def iterate(self):

      ##
      alpha = rand( NUM ) *pi*2.
      self.DX[:] += cos( alpha )*FUZZ
      self.DY[:] += sin( alpha )*FUZZ

      ##
      self.X[:] += self.DX[:]
      self.Y[:] += self.DY[:]

      self.DX[:] += self.SEPX[:]*SEPARATION_PRI + \
                        self.ALIX[:]*ALIGNMENT_PRI
      self.DY[:] += self.SEPY[:]*SEPARATION_PRI + \
                        self.ALIY[:]*ALIGNMENT_PRI
      
      ## respawn near other boids when exiting init circle
      mask = sqrt(square(self.X - C) + square(self.Y - C)) > C

      ## or: 
      ## respawn near other boids when exiting unit square
      #xmask = np.logical_or(self.X>1, self.X<0.)
      #ymask = np.logical_or(self.Y>1, self.Y<0.)
      #mask = np.logical_or(xmask,ymask) 

      if mask.any():
        n = mask.sum()
        ind = (rand(n)*NUM).astype(int)

        alpha = rand(n) *pi*2.
        rndx = cos(alpha)*STP
        rndy = sin(alpha)*STP
        self.X[mask] = self.X[ind] + rndx
        self.Y[mask] = self.Y[ind] + rndy

        alpha = rand(n) *pi*2.
        self.DX[mask] = cos(alpha) * STP*2
        self.DY[mask] = sin(alpha) * STP*2

      ## unit square is a torus
      #mask = self.X > 1.
      #self.X[mask] = self.X[mask] - 1.
      #mask = self.X < 0.
      #self.X[mask] = self.X[mask] + 1.

      #mask = self.Y > 1.
      #self.Y[mask] = self.Y[mask] - 1.
      #mask = self.Y < 0.
      #self.Y[mask] = self.Y[mask] + 1.

      ## 
      self.SEPX[:] = 0.
      self.SEPY[:] = 0.
      self.ALIX[:] = 0.
      self.ALIY[:] = 0.

  class Boid(Meta):

    def __init__(self, x,y,dx,dy):
      self.i = self.c[0]
      self.c[0] += 1

      self.X[self.i] = x
      self.Y[self.i] = y
      self.DX[self.i] = dy
      self.DY[self.i] = dx

    def separation(self):

      d = self.R[self.i,:]
      inflock = d < NEAR_RAD
      inflock[self.i] = False

      if inflock.sum() > 0:

        scale = 1./square( self.R[self.i,inflock] )

        dx = ( self.X[self.i] - self.X[inflock] ) * scale
        dy = ( self.Y[self.i] - self.Y[inflock] ) * scale
 
        sx = dx.sum() / N
        sy = dy.sum() / N

        tot = sqrt(square(sx) + square(sy))
        if tot>BLACK_HOLE:
          sx = BLACK_HOLE*sx/tot
          sy = BLACK_HOLE*sy/tot

        self.SEPX[self.i] = sx
        self.SEPY[self.i] = sy

    def alignment(self):

      d = self.R[self.i,:]
      inflock = d < FLOCK_RAD
      inflock[self.i] = False

      if inflock.sum() > 0:

        scale = 1./square( self.R[self.i,inflock] )

        dx = ( self.DX[self.i] - self.DX[inflock] ) * scale
        dy = ( self.DY[self.i] - self.DY[inflock] ) * scale

        sx = dx.sum() / N
        sy = dy.sum() / N

        tot = sqrt(square(sx) + square(sy))
        if tot>BLACK_HOLE:
          sx = BLACK_HOLE*sx/tot
          sy = BLACK_HOLE*sy/tot

        self.ALIX[self.i] = -sx
        self.ALIY[self.i] = -sy

    def cohesion(self):

      d = self.R[self.i,:]
      inflock = d < COHESION_RAD
      inflock[self.i] = False

      if inflock.sum() > 0:

        scale = 1./square( self.R[self.i,inflock] )

        dx = ( self.X[self.i] - self.X[inflock] ) * scale
        dy = ( self.Y[self.i] - self.Y[inflock] ) * scale

        sx = dx.sum() / N
        sy = dy.sum() / N

        tot = sqrt(square(sx) + square(sy))
        if tot>BLACK_HOLE:
          sx = BLACK_HOLE*sx/tot
          sy = BLACK_HOLE*sy/tot

        self.SEPX[self.i] = -sx
        self.SEPY[self.i] = -sy


  # BEGIN

  M = Meta()

  F = []
  for i in xrange(NUM):
    r = rand()*0.3
    alpha = rand()*pi
    x = C + cos( alpha )*r
    y = C + sin( alpha )*r
    the = rand()*pi*2.
    dx = cos( the )*STP
    dy = sin( the )*STP
    dx = 0
    dy = 0
    F.append( Boid(x,y,dx,dy) )


  plt.figure(0)
  plt.ion()

  itt = 0
  ti = time()

  #ctx.set_source_rgba(FRONT,FRONT,FRONT,ALPHA)
  for itt in xrange(ITTMAX):

    if not itt % 2:
      plt.clf()
      plt.plot(M.X,M.Y,'ro')
      plt.axis([0,1,0,1])
      plt.draw()

    M.set_dist()

    for boid in F:
      boid.separation()
      boid.alignment()
      boid.cohesion()

    M.iterate()

    #vstroke(M.X,M.Y)

  #sur.write_to_png('img.png')

if __name__ == '__main__' :
  main()

