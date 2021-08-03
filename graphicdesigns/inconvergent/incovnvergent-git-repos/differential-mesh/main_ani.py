#!/usr/bin/python3
# -*- coding: utf-8 -*-



from numpy import pi
from numpy import sqrt
from numpy import zeros
from numpy import cos
from numpy import sin
from numpy.random import random

MID = 0.5

NMAX = 10e6
SIZE = 512
ONE = 1./SIZE

RAD = 3*ONE
H = sqrt(3.)*RAD
NEARL = 2*RAD
FARL = RAD*15

OPT_STP = 1./SIZE

ATTRACT_STP = OPT_STP*0.1
REJECT_STP = OPT_STP*0.5
TRIANGLE_STP = OPT_STP*0.01
ALPHA = 0.9
DIMINISH = 0.99

SPLIT_LIMIT = H*2
FLIP_LIMIT = NEARL*0.5

MINIMUM_LENGTH = H*0.8
MAXIMUM_LENGTH = H*2


LINEWIDTH = ONE*1.5

BACK = [1,1,1,1]
FRONT = [0,0,0,0.3]
RED = [1,0,0,0.05]
BLUE = [0,0,1,0.3]
GREEN = [0,1,0,0.3]

TWOPI = pi*2.

PROCS = 2


def get_show(dm):

  np_coord = zeros((NMAX,6), 'float')
  # from modules.colors import cyan

  from fn import Fn
  fn = Fn(prefix='./res/')

  def show(render):

    render.clear_canvas()

    num = dm.np_get_triangles_coordinates(np_coord)
    render_triangle = render.triangle
    # render_circle = render.circle

    for f,vv in enumerate(np_coord[:num,:]):

      render.set_front(FRONT)
      render_triangle(*vv,fill=False)

      # rad = ONE*3
      # render.set_front(cyan)
      # render_circle(vv[0], vv[1], rad, fill=True)
      # render_circle(vv[2], vv[3], rad, fill=True)
      # render_circle(vv[4], vv[5], rad, fill=True)

    name = fn.name() + '.png'
    render.write_to_png(name)

  return show


def steps(dm):

  from time import time
  from modules.helpers import print_stats

  from numpy import array

  t1 = time()

  dm.optimize_position(
      ATTRACT_STP,
      REJECT_STP,
      TRIANGLE_STP,
      ALPHA,
      DIMINISH,
      -1
      )

  henum = dm.get_henum()

  surface_edges = array(
      [dm.is_surface_edge(i)>0 \
          for i in range(henum)],
      'bool').nonzero()[0]

  rnd = random(len(surface_edges)*2)
  the = (1.-2*rnd[::2])*pi
  rad = rnd[1::2]*0.5*H
  dx = cos(the)*rad
  dy = sin(the)*rad

  dm.new_triangles_from_surface_edges(
      surface_edges,
      len(surface_edges),
      H,
      dx,
      dy,
      MINIMUM_LENGTH,
      MAXIMUM_LENGTH,
      1
      )

  dm.optimize_edges(
      SPLIT_LIMIT,
      FLIP_LIMIT
      )

  if dm.safe_vertex_positions(3*H)<0:

    print('vertices reached the boundary. stopping.')
    return False

  t2 = time()
  print_stats(0, t2-t1, dm)

  return True


def main():

  from differentialMesh import DifferentialMesh
  from iutils.render import Animate

  DM = DifferentialMesh(NMAX, 2*FARL, NEARL, FARL, PROCS)

  DM.new_faces_in_ngon(MID,MID, H, 6, 0.0)

  show = get_show(DM)

  def wrap(render):

    res = steps(DM)
    show(render)

    return res

  render = Animate(SIZE, BACK, FRONT, wrap)
  # render.get_colors_from_file('../colors/red_earth.gif')
  render.set_line_width(LINEWIDTH)
  render.start()



if __name__ == '__main__' :

  main()

