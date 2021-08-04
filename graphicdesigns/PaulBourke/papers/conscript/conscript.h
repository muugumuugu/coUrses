      character*4 mtype

      common /mapin/ ioxyz, nxyz, iuvw,  igrid, cell
      common /mapin/ mygrid, iendpoint, ixyz
      common /mapin/ layer,nw1,nsec,iouvw,nuvw,iu,iv,iw
      common /mapin/ mtype

      common /input/ lsurf,brick_in,lchick,conlev,f2o, lgour, linv

      real*4 f2o(3,3),cell(6), conlev

      integer nuvw(3),brick_in(3),iouvw(3), ixyz(3)
      integer ioxyz(3), nxyz(3), iuvw(3),  igrid(3)
      integer mygrid(3), iendpoint(3), layer, nw1, nsec,iu,iv,iw

      logical lsurf, lchick, lgour, linv

