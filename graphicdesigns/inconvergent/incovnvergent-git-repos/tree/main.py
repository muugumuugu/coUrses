#!/usr/bin/python
# -*- coding: utf-8 -*-

from numpy import pi


FNAME = './img/xx'
NMAX = int(2*1e8)

SIZE = 10000
ONE = 1./SIZE


#PI5 = 0.5*pi
MID = 0.5


INIT_BRANCH = SIZE*0.03*ONE
GRAINS = int(SIZE*0.04)

BRANCH_DIMINISH = ONE/27.
BRANCH_SPLIT_DIMINISH = 0.71
BRANCH_SPLIT_ANGLE = 0.3*pi
BRANCH_PROB_SCALE = 1./(INIT_BRANCH)/SIZE*42

BRANCH_ANGLE_MAX = 10.*pi/SIZE
BRANCH_ANGLE_EXP = 2.2

## COLORS AND SHADES
BACK = [1,1,1,0]
FRONT = [0, 0, 0, 0.5]
TRUNK_STROKE = [0, 0, 0, 1]
TRUNK = [1, 1, 1, 1]
TRUNK_SHADE = [0,0,0,0.5]
LEAF = [0,0,1,0.5]


def main():

  from modules.render import Render
  from modules.tree import Tree
  from time import time

  while True:

    render = Render(SIZE, FRONT, BACK, TRUNK, TRUNK_STROKE,GRAINS)
    render.ctx.set_source_rgba(*FRONT)
    render.ctx.set_line_width(ONE)

    # TODO :does not work with transparent bg. use operators
    #render.clear_canvas()

    tree = Tree(
      MID,
      0.9,
      INIT_BRANCH,
      -pi*0.5,
      ONE,
      ONE,
      BRANCH_SPLIT_ANGLE,
      BRANCH_PROB_SCALE,
      BRANCH_DIMINISH,
      BRANCH_SPLIT_DIMINISH,
      BRANCH_ANGLE_MAX,
      BRANCH_ANGLE_EXP
    )

    i = 1
    while tree.Q:

      i += 1
      tree.step()
      map(render.branch2,tree.Q)

      if not i%200:
        print i, len(tree.Q)

    render.sur.write_to_png('/media/var/andreas_tree/test_bp42_{:10.0f}.png'.format(time()))

if __name__ == '__main__':

    main()

