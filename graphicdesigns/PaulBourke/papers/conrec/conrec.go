// Copyright ©2015 The gonum Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package conrec

import (
	"math"
	"sort"

	"github.com/gonum/matrix/mat64"
)

type point struct {
	X, Y float64
}

type line struct {
	p1, p2 point
}

func sect(h, p [5]float64, v1, v2 int) float64 {
	return (h[v2]*p[v1] - h[v1]*p[v2]) / (h[v2] - h[v1])
}

// ConrecLine performs an operation with a line at a given height derived
// from data over the 2D interval (i, j) to (i+1, j+1).
type ConrecLine func(i, j int, l line, height float64)

// Conrec is a Go translation of C version of CONREC by Paul Bourke:
//  http://paulbourke.net/papers/conrec/conrec.c
//
// Conrec takes d, an m×n matrix, an m-long row coordinates slice, an
// n-long column coordinates slice, a slice of contour heights and
// a ConrecLine function.
// Conrec panics if len(row) != m or len(col) != n.
//
// For full details of the algorithm, see the paper at
// http://paulbourke.net/papers/conrec/
func Conrec(d mat64.Matrix, row, col, heights []float64, fn ConrecLine) {
	r, c := d.Dims()
	if len(row) != r {
		panic("conrec: row coordinates mismatch matrix row dimension")
	}
	if len(col) != c {
		panic("conrec: col coordinates mismatch matrix col dimension")
	}

	sort.Float64s(heights)

	var (
		p1, p2 point

		h      [5]float64
		sh     [5]int
		xh, yh [5]float64

		im = [4]int{0, 0, 1, 1}
		jm = [4]int{0, 1, 1, 0}

		cases = [3][3][3]int{
			{{0, 0, 8}, {0, 2, 5}, {7, 6, 9}},
			{{0, 3, 4}, {1, 3, 1}, {4, 3, 0}},
			{{9, 6, 7}, {5, 2, 0}, {8, 0, 0}},
		}
	)

	for i, rv := range row[:len(row)-1] {
		for j, cv := range col[:len(col)-1] {
			dmin := math.Min(
				math.Min(d.At(i, j), d.At(i, j+1)),
				math.Min(d.At(i+1, j), d.At(i+1, j+1)),
			)

			dmax := math.Max(
				math.Max(d.At(i, j), d.At(i, j+1)),
				math.Max(d.At(i+1, j), d.At(i+1, j+1)),
			)

			if dmax < heights[0] || heights[len(heights)-1] < dmin {
				continue
			}

			for k := 0; k < len(heights); k++ {
				if heights[k] < dmin || dmax < heights[k] {
					continue
				}
				for m := 4; m >= 0; m-- {
					if m > 0 {
						h[m] = d.At(i+im[m-1], j+jm[m-1]) - heights[k]
						xh[m] = col[j+jm[m-1]]
						yh[m] = row[i+im[m-1]]
					} else {
						h[0] = 0.25 * (h[1] + h[2] + h[3] + h[4])
						xh[0] = 0.50 * (cv + col[j+1])
						yh[0] = 0.50 * (rv + row[i+1])
					}
					if h[m] > 0 {
						sh[m] = 1
					} else if h[m] < 0 {
						sh[m] = -1
					} else {
						sh[m] = 0
					}
				}

				/*
				   Note: at this stage the relative heights of the corners and the
				   centre are in the h array, and the corresponding coordinates are
				   in the xh and yh arrays. The centre of the box is indexed by 0
				   and the 4 corners by 1 to 4 as shown below.
				   Each triangle is then indexed by the parameter m, and the 3
				   vertices of each triangle are indexed by parameters m1,m2,and m3.
				   It is assumed that the centre of the box is always vertex 2
				   though this isimportant only when all 3 vertices lie exactly on
				   the same contour level, in which case only the side of the box
				   is drawn.

				      vertex 4 +-------------------+ vertex 3
				               | \               / |
				               |   \    m-3    /   |
				               |     \       /     |
				               |       \   /       |
				               |  m=2    X   m=2   |       the centre is vertex 0
				               |       /   \       |
				               |     /       \     |
				               |   /    m=1    \   |
				               | /               \ |
				      vertex 1 +-------------------+ vertex 2
				*/

				/* Scan each triangle in the box */
				for m := 1; m <= 4; m++ {
					m1 := m
					const m2 = 0
					var m3 int
					if m != 4 {
						m3 = m + 1
					} else {
						m3 = 1
					}
					switch cases[sh[m1]+1][sh[m2]+1][sh[m3]+1] {
					case 0:
						continue
					case 1: // Line between vertices 1 and 2
						p1 = point{X: xh[m1], Y: yh[m1]}
						p2 = point{X: xh[m2], Y: yh[m2]}

					case 2: // Line between vertices 2 and 3
						p1 = point{X: xh[m2], Y: yh[m2]}
						p2 = point{X: xh[m3], Y: yh[m3]}

					case 3: // Line between vertices 3 and 1
						p1 = point{X: xh[m3], Y: yh[m3]}
						p2 = point{X: xh[m1], Y: yh[m1]}

					case 4: // Line between vertex 1 and side 2-3
						p1 = point{X: xh[m1], Y: yh[m1]}
						p2 = point{X: sect(h, xh, m2, m3), Y: sect(h, yh, m2, m3)}

					case 5: // Line between vertex 2 and side 3-1
						p1 = point{X: xh[m2], Y: yh[m2]}
						p2 = point{X: sect(h, xh, m3, m1), Y: sect(h, yh, m3, m1)}

					case 6: // Line between vertex 3 and side 1-2
						p1 = point{X: xh[m3], Y: yh[m3]}
						p2 = point{X: sect(h, xh, m1, m2), Y: sect(h, yh, m1, m2)}

					case 7: // Line between sides 1-2 and 2-3
						p1 = point{X: sect(h, xh, m1, m2), Y: sect(h, yh, m1, m2)}
						p2 = point{X: sect(h, xh, m2, m3), Y: sect(h, yh, m2, m3)}

					case 8: // Line between sides 2-3 and 3-1
						p1 = point{X: sect(h, xh, m2, m3), Y: sect(h, yh, m2, m3)}
						p2 = point{X: sect(h, xh, m3, m1), Y: sect(h, yh, m3, m1)}

					case 9: // Line between sides 3-1 and 1-2
						p1 = point{X: sect(h, xh, m3, m1), Y: sect(h, yh, m3, m1)}
						p2 = point{X: sect(h, xh, m1, m2), Y: sect(h, yh, m1, m2)}

					default:
						panic("cannot reach")
					}

					fn(i, j, line{p1: p1, p2: p2}, heights[k])
				}
			}
		}
	}
}
