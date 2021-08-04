// Megapov version by Angelo "KeN" Pesce 2001
// STANDARD MENGER SPONGE -- MEDIA VERSION -- SLOOW
#version unofficial MegaPov 0.5;

global_settings
{ assumed_gamma 2
  radiosity
  { pretrace_start 0.0025
    pretrace_end   0.0025
    count 128
    nearest_count 8
    error_bound 1
    recursion_limit 3
    low_error_factor .5
    gray_threshold 0.0
    minimum_reuse 0.015
    brightness 1
    adc_bailout 0.01/2
  }
  reflection_samples 16
}
/*
// With media this is *REALLY* slow
// How I can cast lightvolume in empty areas too???
media
{ scattering
  { 2, color rgb<0.2,0.2,0.2> extinction 0 }
  samples 1,8
  intervals 32
} */

background { color red 0 green 0 blue 0 }

camera
{ location <1,1.5,0.7>
  look_at <0,0,0>
}

/*
camera
{ location <0,0,0>
  look_at <1,0,0>
  spherical_camera
  normal {bumps 0.5} // weird
} */

light_source
{ <4, 6, -7> color red 0.1 green 0.7 blue 0.8
  circular
  orient
  area_light <0.8,0,0>,<0,0.8,0>,4,4
  adaptive 1
  jitter
  media_interaction off
}

// Define "parameters" for the Menger sponge "function"

#declare SpongeCen = <0,0,0>;
#declare SpongeRad = 4.5 / 4.0;  // Determined by XYZ->RGB mapping in sponge.inc
#declare SpongeLevel = 4;        // Controls recursion depth, & hence sponge complexity
#declare SpongeCounter = 0;

// Make top-level "call" to recursive sponge generator

#declare RND1 = seed(0);
#include "mp_sponge2.inc"

#debug concat("\nRendering sponge with ", str(SpongeCounter,1,0),
    " primitives...\n")
