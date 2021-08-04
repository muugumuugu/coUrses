<html>
<head>
<title>SVGAlib - Fractal Fern</title>
</head>

<body bgcolor="#FFFFFF">

<p><table cellspacing=0 cellpadding=0 border=0 width=622>
   <tr>
      <td valign=top width=500>
         <table cellspacing=0 cellpadding=0 border=0 width=500>
            <tr>
               <td width=40 align=center>
                  &nbsp;
               </td>
               <td width=460>
                  <font face="arial,helvetica">
                  <b>Fractal Fern</b>
                  </font>
               </td>
            </tr>
            <tr>
               <td>
                  &nbsp;
               </td>
               <td>
                  <img src="line.gif" width=160 height=2 alt="">
               </td>
            </tr>
            <tr>
               <td colspan=2>
                  <font face="arial,helvetica" size=-1>
                  <ul>
                  <li>Paul Bourke
                  <li>Jay Link &lt;<a href="mailto:jlink@svgalib.org">jlink@svgalib.org</a>&gt;
                  </ul>
                  </font>
               </td>
            </tr>
            <tr>
               <td>
                  &nbsp;
               </td>
               <td>
                  <img src="line.gif" width=160 height=2 alt="">
               </td>
            </tr>
         </table>
      </td>
   </tr>
</table>

<p><pre>
   /*--------------------------------------------------*
       Pre-SVGAlib code by Paul Bourke:
       Usage:  &lt;program name&gt; &lt;n steps&gt;
       (Try 50,000 steps -- it won't take long).
    *--------------------------------------------------*/

#include &lt;stdio.h&gt;
#include &lt;stdlib.h&gt;
#include &lt;math.h&gt;
#include &lt;vga.h&gt;

#define NX 1024
#define NY 768
#define MIN(x,y) (x &lt; y ? x : y)

double a[4] = {0.0,0.2,-0.15,0.75};
double b[4] = {0.0,-0.26,0.28,0.04};
double c[4] = {0.0,0.23,0.26,-0.04};
double d[4] = {0.16,0.22,0.24,0.85};
double e[4] = {0.0,0.0,0.0,0.0};
double f[4] = {0.0,1.6,0.44,1.6};

int main(int argc, char *argv[])
{
   int i,j,k;
   int n;
   int ix,iy;
   double r,x,y,xlast=1,ylast=1;
   double xmin=1e32,xmax=-1e32,ymin=1e32,ymax=-1e32,scale,xmid,ymid;

   if (argc &lt; 2) {
      fprintf(stderr,"Usage: %s nsteps\n",argv[0]);
      exit(0);
   }
   n = atoi(argv[1]);

   vga_init();
   vga_setmode(G1024x768x256);
   vga_setcolor(15);

   for (j=0; j &lt; 2 ; j++) {
      for (i=0; i &lt; n; i++) {
         r = rand() % 100;
         if (r &lt; 10)
            k = 0;
         else if (r &lt; 18)
            k = 1;
         else if (r &lt; 26)
            k = 2;
         else
            k = 3;
         x = a[k] * xlast + b[k] * ylast + e[k];
         y = c[k] * xlast + d[k] * ylast + f[k];
         xlast = x;
         ylast = y;
         if (x &lt; xmin) xmin = x;
         if (y &lt; ymin) ymin = y;
         if (x &gt; xmax) xmax = x;
         if (y &gt; ymax) ymax = y;
         if (j == 1) {
            scale = MIN(NX / (xmax - xmin),NY / (ymax - ymin));
            xmid = (xmin + xmax) / 2;
            ymid = (ymin + ymax) / 2;
            ix = NX / 2 + (x - xmid) * scale;
            iy = NY / 2 + (y - ymid) * scale;
            vga_drawpixel(ix, iy);
         }
      }
   }

   vga_getch();
   vga_setmode(TEXT);
   return 0;
}
</pre>

</body>
</html>
