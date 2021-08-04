#!/usr/bin/env python
#
# -----------------------------------------------------------------------------------------------
# POLAR MAP CORRECTION PYTHON SCRIPT PLUGIN FOR GIMP.
#
# Polar map correction algorithm by Paul Bourke.
# (http://paulbourke.net/texture_colour/tiling/)
#
# Heavily based on the Lua\gluas adaptation by Philip Staiger, TheBest3D.com.
# (http://paulbourke.net/texture_colour/tiling/polar_map_correction.lua)
#
# Includes GIMP pixel-operations array optimisation by Akkana and Joao.
# (http://shallowsky.com/blog/gimp/pygimp-pixel-ops.html)
#
# Adapted to GIMP Python-Fu by Rafael Navega.
#
# Public Domain, 2015.
#
# -----------------------------------------------------------------------------------------------
#
# INSTALLATION:
#
# 1) Exit GIMP. 
# 2) Drop this PY file in your GIMP plug-ins folder. This is platform specific.
#    In Windows it's usually in [drive]:\Documents and settings\YourUsername\.gimp-2.8\plug-ins.
# 3) Restart GIMP. The plugin should be available in Filters->Distorts->Polar Correction.
#
# -----------------------------------------------------------------------------------------------
#
# USAGE:
#
# When executed, this plugin will distort the active layer to compensate for the distortion 
# introduced by spherical mapping
#
# - Use this with textures meant for spherical environment maps.
# - The plugin acts on the ENTIRE layer, even if parts of it are outside of the canvas.
#       In case there's some offset problems you can try using 'Layer->Layer To Image Size' to 
#       crop its boundaries to the canvas before using the plugin.
#
# -----------------------------------------------------------------------------------------------

import math
from gimpfu import *
from array import *

def python_polar_correction(img, layer) :
        
    gimp.progress_init("Correcting image...")
    pdb.gimp_image_undo_group_start(img)

    try:
        PI = math.pi
        TWOPI = 2.0 * math.pi
        
        # Obtain layer dimensions.
        
        width = layer.width
        height = layer.height
        
        # Create a source buffer from where we read pixels.
        
        srcRgn = layer.get_pixel_rgn(0, 0, width, height, False, False)
        src_pixels = array("B", srcRgn[0:width, 0:height])

        # Get the layer position.
        
        pos = 0        
        for i in range(len(img.layers)):
            if(img.layers[i] == layer):
                pos = i
        
        # Create a new layer to save the results (otherwise it's not possible to undo the operation).
        
        newLayer = gimp.Layer(img, layer.name + " temp", width, height, layer.type, layer.opacity, layer.mode)
        img.add_layer(newLayer, pos)
        layerName = layer.name

        # Clear the new layer.
        
        pdb.gimp_edit_clear(newLayer)
        newLayer.flush()        
        
        p_size = len(srcRgn[0,0])
        dstRgn = newLayer.get_pixel_rgn(0, 0, width, height, True, True)
        dest_pixels = array("B", srcRgn[0:width, 0:height])
        
        for y in xrange(0, height - 1) :
            
            theta = PI * (y - (height-1.0) / 2.0) / (height-1.0)
            
            for x in xrange(0, width - 1) :
        
                phi = TWOPI * (x - width/2.0) / float(width)
                phi2 = phi * math.cos(theta)
                x2 = phi2 * width / TWOPI + width/2.0
                    
                src_pos = (int(x2) + width * y) * p_size
                dst_pos = (x + width * y ) * p_size
                    
                if ( ( x2 < 0 ) or ( x2 > width - 1 ) ) :
                    
                    # Something bad happened. Colour it red? Should never happen.
                
                    if layer.has_alpha :
                        pixel = array("B","\xff\x00\x00\xff")
                    else :
                        pixel = array("B","\xff\x00\x00")
                
                else :                
                    pixel = src_pixels[ src_pos : src_pos + p_size ]
                
                dest_pixels[ dst_pos : dst_pos + p_size ] = pixel
            
            gimp.progress_update(float(y) / float(height))            
        
        # Finally, copy the whole array back to the pixel region:
        
        dstRgn[0:width, 0:height] = dest_pixels.tostring() 
        
        newLayer.flush()
        newLayer.merge_shadow(True)
        newLayer.update(0, 0, width, height)           
        
        # Remove the old layer.
        
        img.remove_layer(layer)
        
        # Change the name of the new layer (two layers can not have the same name).
        
        newLayer.name = layerName
        
        pdb.gimp_selection_none(img)
        pdb.gimp_image_undo_group_end(img)
        
        gimp.displays_flush()

    except Exception as err:
        gimp.message("Unexpected error: " + str(err))
    
    pdb.gimp_image_undo_group_end(img)
    pdb.gimp_progress_end()

register(
    "python_fu_polar_correction",
    "Polar corrects a texture",
    "Manipulates a texture to compensate for the distortion when it is spherically mapped",
    "Rafael Navega",
    "Public Domain",
    "2015",
    "<Image>/Filters/Distorts/Polar Correction",
    "RGB, RGB*",
    [],
    [],
    python_polar_correction)

main()