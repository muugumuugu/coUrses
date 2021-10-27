#!/usr/bin/python
# -*- coding: utf-8 -*-

from numpy import pi


SIZE = 560
ONE = 1./SIZE


MID = 0.5

INIT_BRANCH = SIZE*0.03*ONE
GRAINS = int(SIZE*0.02)

BRANCH_DIMINISH = ONE/32

BRANCH_SPLIT_DIMINISH = 0.71
BRANCH_PROB_SCALE = 1./(INIT_BRANCH)/SIZE*20

BRANCH_SPLIT_ANGLE = 0.3*pi
BRANCH_ANGLE_MAX = 5.*pi/SIZE
BRANCH_ANGLE_EXP = 2

## COLORS AND SHADES
BACK = [1,1,1,1]
FRONT = [0, 0, 0, 0.5]
TRUNK_STROKE = [0, 0, 0, 1]
TRUNK = [1, 1, 1, 1]
TRUNK_SHADE = [0,0,0,0.5]
#TRUNK_SHADE = [1,1,1,0.5]
LEAF = [0,0,1,0.5]

STEPS_ITT = 1

i = 0


def main():

  from modules.render import Animate
  from modules.tree import Tree
  import gtk

  tree = Tree(
    MID,
    0.95,
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

  def wrap(steps_itt,render):

    global i

    tree.step()
    map(render.branch2,tree.Q)

    if tree.Q:
      render.sur.write_to_png('{:05d}.png'.format(i))
      i += 1
      return True
    else:
      #tree.init()
      #render.clear_canvas()
      return False


  render = Animate(
    SIZE,
    FRONT,
    BACK,
    TRUNK,
    TRUNK_STROKE,
    GRAINS,
    STEPS_ITT, wrap
  )
  render.ctx.set_source_rgba(*FRONT)
  render.ctx.set_line_width(ONE)

  gtk.main()


if __name__ == '__main__':

    main()

