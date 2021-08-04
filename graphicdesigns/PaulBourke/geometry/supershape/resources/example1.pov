#version 3.5;
#include "param.inc"
#include "ss_macro1.inc"

// Exanple by Tor Olav Kristensen

object {
  SuperShapeMesh(
    1, 1, 1  77, 0.81, 71.7,
    8, 1, 1, 0.63, 2.92, 0.24,
    100, 50
  )
  pigment { color rgb <1, 1, 1> }
  double_illuminate
  no_shadow
}

camera {
  location <3, 2, 4>*0.6
  look_at <0, 0, 0>
}

light_source { 100*x color rgb <1.0, 0.5, 0.5> }
light_source { 100*y color rgb <0.5, 1.0, 0.5> }
light_source { 100*z color rgb <0.5, 0.5, 1.0> }


