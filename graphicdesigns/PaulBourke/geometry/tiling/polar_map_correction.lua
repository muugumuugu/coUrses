--
-- polar map correction, based on Paul Bourke's algo/details 
-- converted to Lua/gluas by Philip Staiger, TheBest3D.com 
-- on November 8, 2006 in about 2 hours - that was fun!

-- also did a little bit of optimizations to reduce repetitive 
-- calculations when indexing an array (using the 'indx' variable
--
-- Note: in gluas, width and height are built-in variables, set
-- automatically to the width and height of the image (in pixels of course)
 


PI =  3.1415926535           -- memories from college :-)
TWOPI = 2 * PI

 
local imageoutR = {height*width}   -- preallocate buffers of desired size
local imageoutG = {height*width}
local imageoutB = {height*width}

local x, y, r, g, b, a, x2

local i, j, theta, phi, phi2, indx
 

-- let's get busy
--
-- transform each pixel and temporarily store in the out buffers
 
   indx = 0                -- optimized for speed

   for y=0, height-1 do

        theta = PI * (y - (height-1)/2.0) / (height-1)

        for x=0, width-1 do

           phi  = TWOPI * (x - width/2.0) / width 
           phi2 = phi * math.cos(theta) 
           x2  = phi2 *  width / TWOPI +  width/2 

           if ( ( x2 < 0 ) or ( x2 > width-1 ) ) then

    -- something bad happened - flag as red? - Should never happen 
              r = 1.0
              g = 0.0
              b = 0.0
           else
              r, g, b = get_rgb( x2, y )
           end

           -- temporarily store the pixel in the out buffers
           imageoutR[indx] = r
           imageoutG[indx] = g
           imageoutB[indx] = b

           indx = indx + 1     -- optimized for speed
       end
        
       progress( y / height)
 
   end

--
--   finally send stored 'out' image back out to the imaging system
--
--

indx = 0                    -- optimized for better speed
for y = 0, height - 1 do
  for x = 0, width - 1 do 

    r = imageoutR[indx] 
    g = imageoutG[indx] 
    b = imageoutB[indx] 
 
    set_rgb(x, y, r, g, b)

    indx = indx + 1          -- optimized for better speed

  end
  progress(y / height)
end











