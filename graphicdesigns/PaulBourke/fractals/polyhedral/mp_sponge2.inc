// See comments in mp_sponge2.pov
#version unofficial MegaPov 0.5;

#if (SpongeLevel=0)
    box { <-0.5,-0.5,-0.5>,<0.5,0.5,0.5>
        scale SpongeRad
        translate SpongeCen

        texture
        { pigment { color rgb <0.4,0.4,0.4> }
          finish
          { ambient 0
            diffuse 0.6
            brilliance 2
            phong 1
            phong_size 1
            crand 0.03
            metallic
            /*reflect_metallic
            reflection 0.4
            reflection_blur 0.1*/
          }
        }
    }
    #declare SpongeCounter = SpongeCounter + 1
#else #if (SpongeLevel=1)
    light_source
    { SpongeCen color red 0.15 green 0.06 blue 0
      circular
      orient
      area_light <1,0,0>,<0,1,0>,2,2
      adaptive 1
      jitter
    }
    difference {
        box { <-0.5,-0.5,-0.5>,<0.5,0.5,0.5> }
        box { <-0.51,-0.166667,-0.166667>,<0.51,0.166667,0.166667> }
        box { <-0.166667,-0.51,-0.166667>,<0.166667,0.51,0.166667> }
        box { <-0.166667,-0.166667,-0.51>,<0.166667,0.166667,0.51> }
        scale SpongeRad
        translate SpongeCen

        texture
        { pigment { color rgb <0.4,0.4,0.4> }
          finish
          { ambient 0
            diffuse 0.6
            brilliance 2
            phong 1
            phong_size 1
            crand 0.03
            metallic
            /*reflect_metallic
            reflection 0.4
            reflection_blur 0.1*/
          }
        }

 }

    #declare SpongeCounter = SpongeCounter + 4;
#else
    // Recursively draw 20 smaller sponges.  Can't use loops here since
    // the indices would be changed by the recursive calls.
    
    light_source
    { SpongeCen color red (0.4+(rand(RND1)*0.2)) green rand(RND1) blue rand(RND1)
      circular
      orient
      area_light <0.8,0,0>,<0.8,1,0>,3,3
      adaptive 1
      jitter
    }

    #declare SpongeLevel = SpongeLevel - 1;
    #declare SpongeRad = SpongeRad / 3;

    // Top layer

    #declare SpongeCen = SpongeCen + <-SpongeRad,-SpongeRad,-SpongeRad>;
    #include "mp_sponge2.inc"
    #declare SpongeCen = SpongeCen + <SpongeRad,0,0>;
    #include "mp_sponge2.inc"
    #declare SpongeCen = SpongeCen + <SpongeRad,0,0>;
    #include "mp_sponge2.inc"

    #declare SpongeCen = SpongeCen + <-SpongeRad * 2,SpongeRad,0>;
    #include "mp_sponge2.inc"
    #declare SpongeCen = SpongeCen + <SpongeRad * 2,0,0>;
    #include "mp_sponge2.inc"

    #declare SpongeCen = SpongeCen + <-SpongeRad * 2,SpongeRad,0>;
    #include "mp_sponge2.inc"
    #declare SpongeCen = SpongeCen + <SpongeRad,0,0>;
    #include "mp_sponge2.inc"
    #declare SpongeCen = SpongeCen + <SpongeRad,0,0>;
    #include "mp_sponge2.inc"

    // Middle layer

    #declare SpongeCen = SpongeCen + <-SpongeRad * 2,-SpongeRad * 2,SpongeRad>;
    #include "mp_sponge2.inc"
    #declare SpongeCen = SpongeCen + <SpongeRad * 2,0,0>;
    #include "mp_sponge2.inc"

    #declare SpongeCen = SpongeCen + <-SpongeRad * 2,SpongeRad * 2,0>;
    #include "mp_sponge2.inc"
    #declare SpongeCen = SpongeCen + <SpongeRad * 2,0,0>;
    #include "mp_sponge2.inc"

    // Bottom layer

    #declare SpongeCen = SpongeCen + <-SpongeRad * 2,-SpongeRad * 2,SpongeRad>;
    #include "mp_sponge2.inc"
    #declare SpongeCen = SpongeCen + <SpongeRad,0,0>;
    #include "mp_sponge2.inc"
    #declare SpongeCen = SpongeCen + <SpongeRad,0,0>;
    #include "mp_sponge2.inc"

    #declare SpongeCen = SpongeCen + <-SpongeRad * 2,SpongeRad,0>;
    #include "mp_sponge2.inc"
    #declare SpongeCen = SpongeCen + <SpongeRad * 2,0,0>;
    #include "mp_sponge2.inc"

    #declare SpongeCen = SpongeCen + <-SpongeRad * 2,SpongeRad,0>;
    #include "mp_sponge2.inc"
    #declare SpongeCen = SpongeCen + <SpongeRad,0,0>;
    #include "mp_sponge2.inc"
    #declare SpongeCen = SpongeCen + <SpongeRad,0,0>;
    #include "mp_sponge2.inc"

    // Restore to original calling values
    #declare SpongeCen = SpongeCen + <-SpongeRad,-SpongeRad,-SpongeRad>;
    #declare SpongeRad = SpongeRad * 3;
    #declare SpongeLevel = SpongeLevel + 1;
#end
#end

