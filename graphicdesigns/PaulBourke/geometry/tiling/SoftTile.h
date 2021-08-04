
/*
 * Makes a texture continuously tilable
 */

image SoftTile(
image	input=		0,	// Input image
int	xTiles=		1,	// Number of tiles in X
int	yTiles=		1,	// Number of tiles in Y
float	maskShape=	0.0,	// Controls mask shape		[0=Square --> 1=Round ]
float	softenMask=	2.1,	// Controls mask profile	[1=linear --> 2= Bell ]
int	showDebug=	0	// Debug: 0 shows image, 1 shows image, blend mask and profile
)
{
    /* Create a linear, squarish mix mask base shape
    -------------------------------------------------*/
    Ramp1= Ramp(512, 512, 4, 1, 0.5, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0);
    Solarize1= Solarize(Ramp1, 0.5, 1);
    Orient1 = Orient(Solarize1, 1, 0, 0);
    Min1 = Min(Orient1, Solarize1, 1, 100);

    /* Create a linear, circular mix mask base shape
    -------------------------------------------------*/
    RGrad1= RGrad(512, 512, 4, width/2, height/2, 1, 0, width/2, 0.5, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0);

    /* Mix the two shapes and fit to input image size
    --------------------------------------------------*/
    MixShapes= Mix(Min1,RGrad1,1,maskShape*100,"rgba");
    Resize1= Clamp(Resize(MixShapes, input.width, input.height, "default", 0)); // Clamp to bypass a bug in resize
    FinalMask= ContrastLum(Resize1, softenMask, 0.206, 1);

    /* Interpolate between original and half scrolled image
    ------------------------------------------------------*/
    ScrolledImage= Scroll(input, width/2, height/2, 0, 0.5, 0);
    ScrolledMask= Scroll(FinalMask, width/2, height/2, 0, 0.5, 0);
    Img1= IMult(input,FinalMask);
    Img2= IMult(ScrolledImage,ScrolledMask);
    Sum= IAdd(Img1,Img2);
    MaskSum= IAdd(FinalMask,ScrolledMask);
    Result= Bytes(IDiv(Sum,MaskSum),input.bytes);

    /* Tile it
    -----------*/
    Tile1= Tile(Result, xTiles, yTiles);

    /* Add some debug nodes: show mask, show mask profile
    ------------------------------------------------------*/
    PlotScanline1= PlotScanline(FinalMask, width, 256,FinalMask.height/2);
    Debug1= Pan(PlotScanline1,Tile1.width,0);
    Debug2= Pan(FinalMask,Tile1.width,max(Tile1.height,Debug1.height));
    Debug3= Screen(Debug1,Debug2);
    Debug4= Screen(Debug3,Tile1);
    Debug5= Pan(ScrolledMask,0,max(Tile1.height,Debug1.height));
    Debug6= Screen(Debug4,Debug5);
    Debug7= Viewport(Debug6,dod[0],dod[1],dod[2],dod[3]);
    Debug8= Resize(Debug7,Tile1.width,Tile1.height);

    return Select(showDebug?2:1, Tile1, Debug8, 0);
}


