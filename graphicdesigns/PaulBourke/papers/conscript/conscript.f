c
c CONSCRIPT version 2.0
c ---------------------
c
c This program generates chicken wire contours and gouraud-shaded surface
c triangles from CCP4 and XPLOR electron density maps.
c
c Copyright 
c Mike Lawrence February 2000
c Biomolecular Research Institute
c 343 Royal Parade
c Parkville 3052
c Victoria
c Australia
c
c This is the Linux g77 version created from the original by Arno Paehler
c
c
      implicit none
      integer maxvert
      parameter (MAXVERT=100000)

      include 'conscript.h'

      character*80 infile,outfile,title(30),cvert,fmt
      character*3 secdir
      character*1 types(4)
      integer*4 sizes(4),isize
      integer shift_left,sl
      external doit

      real*8 cell2(6)
      real*4 v(3),x,y,z
      real*4 o2f(3,3)
      real*4 rhmin,rhmax,rhmean,rhrms

      integer nu1,nu2,nv1,nv2
      integer icxyz(3),lmode,lspgrp
      integer ntitle,i,j

      character*1 let(3)
      data let /'X','Y','Z'/

      logical cont
      logical linfile /.false./
      logical lmtype /.false./
      logical loutfile /.false./
      logical lconlev /.false./
      logical lcent /.false./
      logical lgouraud /.false./
      logical lsurface /.false./
      logical lchicken /.false./
      logical lbox /.false./
      logical linvert /.false./
c
      write(*,*)
      write(*,*)' CONSCRIPT'
      write(*,*)' ---------'
      write(*,*)
      write(*,*)' A program to generate marching-cube isosurfaces of'  
      write(*,*)' electron density maps'
      write(*,*)
      write(*,*)' Copyright. Dr Michael C. Lawrence'
      write(*,*)' Biomolecular Research Institute, '
      write(*,*)' Parkville 3052, Australia.'
      write(*,*)
      
121   call memoparse(.true.)
      call parsefail( )
      call parsesubkey('MAPF','    ',linfile)
      call parsekeyarg('MAPF',infile)

      call parsesubkey('MAPT','    ',lmtype)
      call parsekeyarg('MAPT',mtype)

      call parsesubkey('OBJE','    ',loutfile)
      call parsekeyarg('OBJE',outfile)

      call parsesubkey('CONT','    ',lconlev)
      call parsereal('CONT',conlev)

      call parsesubkey('CENT','   ',lcent)
      call parsesubreal('CENT','    ',1,.true.,x)
      call parsesubreal('CENT','    ',2,.true.,y)
      call parsesubreal('CENT','    ',3,.true.,z)

      call parsesubkey('BOX','    ',lbox)
      call parsesubint('BOX','    ',1,.true.,brick_in(1))
      call parsesubint('BOX','    ',2,.true.,brick_in(2))
      call parsesubint('BOX','    ',3,.true.,brick_in(3))

      call parsesubkey('GOUR','   ',lgouraud)

      call parsesubkey('INVE','   ',linvert)
      
      call parsesubkey('CHIC','    ',lchicken)

      call parsesubkey('SURF','    ',lsurface)

      call parsediagnose (cont)      
      if(cont) go to 121
c
c Do some checks
      if(.not.lcent) then
         write(*,'(/a)') 'Error: no centre given'
         stop
      else if(.not.lbox) then
         write(*,'(/a)') 'Error: no box size given'
         stop
      else if(.not.lmtype) then
         write(*,'(/a)') 'Error: map type not defined'
         stop
      else if(.not.lconlev) then
         write(*,'(/a)') 'Error: no contour level given'
         stop
      else if(.not.lchicken .and. .not.lsurface) then
         write(*,'(/a)') 'Error: output type not defined'
         stop
      else if(lchicken.and.lgouraud) then
         write(*,'(/a)') 
     .     'Error: cannot do Gouraud shading of chicken wire'
         stop
      else if(lchicken.and.lsurface) then
         write(*,'(/a)') 
     .     'Error: can only do one type of plotting at a time'
         stop
      else if(.not.loutfile) then
         write(*,'(/a)') 'Error: object file name not given'
         stop
      else if(.not.linfile) then
         write(*,'(/a)') 'Error: input map file name not given'
         stop
      end if
c
c Assign common block equivalents
c
      lsurf = lsurface
      lchick= lchicken
      lgour = lgouraud
      linv = linvert
c
      call ccpupc(mtype)
      if(mtype.ne.'CCP4'.and.mtype.ne.'XPLU'.and.mtype.ne.'XPLF') then
         write(*,'(/a)') 'Error: unrecognized map format'
         stop
      end if
c
      if(mtype.eq.'CCP4') then

         call mrdhdr(1,infile,title,nsec,iuvw,mygrid,nw1,nu1,nu2,
     *        nv1,nv2,cell,lspgrp,lmode,rhmin,rhmax,rhmean,rhrms)

         iouvw(1) = nu1
         iouvw(2) = nv1
         iouvw(3) = nw1

         nuvw(1) = nu2 - nu1 + 1
         nuvw(2) = nv2 - nv1 + 1
         nuvw(3) = nsec

      else if(mtype(1:1) .eq. 'X') then
         if(mtype.eq.'XPLF') then
            open(1,file=infile,status='old',form='formatted')
         else if(mtype.eq.'XPLU') then
            open(1,file=infile,status='old',form='unformatted')
         end if
c
c Read in map header for XPLOR file
c
c (1) Read title

         if(mtype .eq. 'XPLF') then
            read(1,'(/i8)') ntitle
            read(1,'(a)') (title(j),j=1,ntitle)
         else
            read(1) ntitle,(title(j),j=1,ntitle)
         end if
         write(*,101)
101     format(/' Titles from XPLOR map'/
     .        ' ---------------------'/)
         write(*,'(1x,a)') (title(j),j=1,ntitle)
c     
c (2) Read grid information and set up number of increments

         if(mtype .eq. 'XPLF') then
            read(1,'(9i8)')(mygrid(i),ioxyz(i),iendpoint(i),i=1,3)
         else
            read(1)(mygrid(i),ioxyz(i),iendpoint(i),i=1,3)
         end if
c     
         do 34 i = 1,3
            nxyz(i) = iendpoint(i)-ioxyz(i) + 1
34      continue
c
c (3) Read cell constants and section directions
c
         if(mtype .eq. 'XPLF') then
            read (1,'(6e12.5)')(cell(i),i=1,6)
            read (1,'(3a1)') (secdir(i:i),i=3,1,-1)
         else
            read(1) cell2
            do i = 1, 6
               cell(i) = cell2(i)
            end do
            read(1) (secdir(i:i),i=3,1,-1)
         end if
c
c (4) Set up iuvw
c
         do i = 1, 3
            if(secdir(i:i) .eq. 'X') then
               iuvw(i) = 1
            else if(secdir(i:i) .eq. 'Y') then
               iuvw(i) = 2
            else if(secdir(i:i) .eq. 'Z') then
               iuvw(i) = 3
            else
               write(*,*)' Error in section direction'
               stop
            end if
         end do
c
c Dump header stuff
c
         write (*,1700) (cell(j),j=1,6),ioxyz,nxyz,mygrid,
     +        (let(iuvw(i)),i=1,3)
         
1700    format (/' XPLOR map details'/
     .         ' -----------------'//
     1         ' Cell        : ',6f8.2/
     .         ' Origin      : ',3i5/
     2         ' Extent      : ',3i5/
     .         ' Grid        : ',3i5/
     3         ' Fast axis   : ',a1/
     .         ' Medium axis : ',a1/
     .         ' Slow axis   : ',a1/)
c
c   number of points along u, v, and w
c
         nuvw(1)   = nxyz(iuvw(1))
         nuvw(2)   = nxyz(iuvw(2))
         nuvw(3)   = nxyz(iuvw(3))
c
c
      else
         write(*,*)' Unknown map type'
         stop
      end if
c
c Enter output file
c
      open(2,file=outfile)
c
c   number of points in a map section
c
      layer = nuvw(1) * nuvw(2)
      isize = layer * nuvw(3)

c      write(*,1900) layer,isize
1900  format (' Map section size = ',i8/
     .        ' Map total size   = ',i8)
c
c Echo some input
c
      write(*,175)
175   format (/' Contouring details'/
     .         ' ------------------')
      write(*,171) conlev,x,y,z,brick_in
171   format(/' Contour level        :',f8.3/
     .       ' Centre (orth A)      :',3f8.3/
     .       ' Size of box (f,m,s)  :',3i8/)
c
      call conversion_matrices(cell,o2f,f2o)
c
c C & X Set up reverse pointers
c
      do i = 1, 3
         if     (iuvw(i) .eq. 1) then
            ixyz(1) = i
         else if(iuvw(i) .eq. 2) then
            ixyz(2) = i
         else if(iuvw(i) .eq. 3) then 
            ixyz(3) = i
         end if
      end do
c
c C & X Convert xyz centre to fractional xyz
c
      icxyz(1) = nint((o2f(1,1)*x+o2f(1,2)*y+o2f(1,3)*z)*mygrid(1))
      icxyz(2) = nint((o2f(2,1)*x+o2f(2,2)*y+o2f(2,3)*z)*mygrid(2))
      icxyz(3) = nint((o2f(3,1)*x+o2f(3,2)*y+o2f(3,3)*z)*mygrid(3))
c
c C & X Convert fractional centre to uvw
c
      iu = icxyz(iuvw(1))
      iv = icxyz(iuvw(2))
      iw = icxyz(iuvw(3))
c
      if(mtype(1:1) .eq. 'X') then
c X only Convert origin to uvw
         iouvw(1) = ioxyz(iuvw(1))
         iouvw(2) = ioxyz(iuvw(2))
         iouvw(3) = ioxyz(iuvw(3))
      else
c C only Convert origin to xyz
         ioxyz(1) = iouvw(ixyz(1))
         ioxyz(2) = iouvw(ixyz(2))
         ioxyz(3) = iouvw(ixyz(3))
      end if
c
c Set up memory calls
c
c First array is for entire map
      sizes(1) = isize
      types(1) = 'R'
c Second array is for a single section as double precision     
      sizes(2) = layer 
      types(2) = 'D'
c Third array is for flags (single word)
      sizes(3) = layer * 4
      types(3) = 'I'
c
c Fourth array is for vertices. Difficult to say, get from environment
      call getenv('CONVERT',cvert)
      sl = shift_left(cvert)
c
c Environment not set, use default
      if(sl .le. 0) then
         sizes(4) = MAXVERT * 7
      else
         fmt = ' '
         write(fmt,'(a,i)') 'i',sl
         read(cvert(1:sl),fmt) sizes(4)
c 11      format(i<sl>)
         write(*,129) sizes(4)
129     format(/' Vertex array size set via environment to',i12/)
         sizes(4) = sizes(4) * 7
      end if

      types(4) = 'R'
c
c Now allocate memory and call doit subroutine
c
      call ccpalc(doit,4,types,sizes)
c
c All done
      end
c
c----------------------------------------------------------------------------
c
      subroutine doit(n1,rho,n2,r2,n3,flags,maxvert,corners)
c     ------------------------------------------------------
c
      implicit none
      real*4 rho(*),corners(7,*)
      logical flags(4,*)
      real*8 r2(*)
      integer*4 n1,n2,n3,n4
c
      include 'conscript.h'
c
      integer*4 box_min(3),box_max(3),brick_adjust(3)
      integer ip,kk,ier,i,iorigin,ntotal, maxvert
c
c Set array overflow
      maxvert = maxvert / 7
c
c Read map
c     
      write(*,*)
      write(*,*) 'Reading sections...'
c
c Read XPLOR map here
c
      if(mtype(1:1) .eq. 'X') then
         call read_map(rho,r2)
c
c Read CCP4 map here
c
      else
         call mposn(1,nw1)
         ip = 1
         do kk = 1, nsec
            call mgulpr(1,rho(ip),ier)
            ip = ip + layer
         end do
      end if
c
c Produce output
c
      if(lsurf) then
c
c Compute indices of contouring box origin
c
         box_min(1) = iu -  brick_in(1) / 2. - iouvw(1) 
         box_min(2) = iv -  brick_in(2) / 2. - iouvw(2) 
         box_min(3) = iw -  brick_in(3) / 2. - iouvw(3)
         
         box_max(1) = box_min(1) + brick_in(1) - 1
         box_max(2) = box_min(2) + brick_in(2) - 1
         box_max(3) = box_min(3) + brick_in(3) - 1
c
c Check for overflow
         do i = 1, 3
            box_min(i) = max(1,box_min(i))
            box_max(i) = min(nuvw(i)-1,box_max(i))
            brick_adjust(i) = box_max(i) - box_min(i) + 1
            if(brick_adjust(i) .ne. brick_in(i)) then
               write(*,153)
153           format(/'Requested box size extents outside map',
     .                 '. Box size reduced'/)
            end if
         end do
         write(*,*) 
         write(*,*) ' Actual box used (f,m,s)'
         write(*,*) ' -----------------------'
         write(*,*)
         write(*,*) ' Lower corner ',box_min
         write(*,*) ' Upper corner ',box_max
         write(*,*)

c
c Do triangulation
         call render(rho,nuvw(1),nuvw(2),nuvw(3),
     .               brick_adjust,box_min,conlev,f2o,
     .               ioxyz,mygrid,ixyz,lgour,linv,maxvert,corners)
c
c
      else if (lchick) then
c
c Compute indices of contouring box origin
c
         box_min(1) = iu -  brick_in(1) / 2. - iouvw(1) - 1
         box_min(2) = iv -  brick_in(2) / 2. - iouvw(2) - 1
         box_min(3) = iw -  brick_in(3) / 2. - iouvw(3) - 1

         box_max(1) = box_min(1) + brick_in(1) - 1
         box_max(2) = box_min(2) + brick_in(2) - 1
         box_max(3) = box_min(3) + brick_in(3) - 1

         do i = 1, 3
            box_min(i) = max(1,box_min(i))
            box_max(i) = min(nuvw(i)-1,box_max(i))
            brick_adjust(i) = box_max(i) - box_min(i) + 1
            if(brick_adjust(i) .ne. brick_in(i)) then
               write(*,153)
            end if
         end do
c
         write(*,*) ' Lower corner of box',box_min
         write(*,*) ' Upper corner of box',box_max
c
c Compute absolute origin in scalar array
c
         iorigin = box_min(3) * layer 
     .          + box_min(2) * nuvw(1) + box_min(1) + 1
         ntotal = 0
c
c
         call mesh(rho,flags,conlev,nuvw,brick_adjust,box_min,mygrid,
     +        ntotal,ioxyz,iorigin,f2o,ixyz)
         write(*,*) 
         write(*,*)' Total number of contours segments written:',ntotal

      end if
c
c Write trailer to file
c
      write(2,'(a1)') 'Q'
      close(2)
      end
c
c--------------------------------------------------------------------
c
      subroutine render(rho,nu1,nu2,nu3,ib,ll,conlev,f2o,ioxyz,
     .                  mygrid,ixyz,lgouraud,linvert,maxvert,corner)
c     ---------------------------------------------------------------
c
c Loops all map points, generate triangles, perform gouraud shading
c
      integer ll(3),ioxyz(3),mygrid(3),ixyz(3),ib(3),nu1,nu2,nu3
      real*4 rho(nu1,nu2,nu3),triangles(3,3,16)
      real*4 corner(7,*),rt(3,8),v(3,3),r(3,8)
      real*4 f2o(3,3),val(8),conlev,vx(3,3)
      real*4 d1(3),d2(3),norm(3),d3(3)
      equivalence (ivert,rivert)
      integer compar1,compar2
      integer maxvert
      external compar1,compar2
      logical lgouraud,linvert

      iunit = 1

      r(1,1) = 0
      r(2,1) = 0
      r(3,1) = 0

      r(1,2) = 1
      r(2,2) = 0
      r(3,2) = 0

      r(1,3) = 1
      r(2,3) = 1
      r(3,3) = 0

      r(1,4) = 0
      r(2,4) = 1
      r(3,4) = 0

      r(1,5) = 0
      r(2,5) = 0
      r(3,5) = 1

      r(1,6) = 1
      r(2,6) = 0
      r(3,6) = 1

      r(1,7) = 1
      r(2,7) = 1
      r(3,7) = 1

      r(1,8) = 0
      r(2,8) = 1
      r(3,8) = 1

      it = 0
      ivert = 1
c
c Loop boxes
      do k = ll(3),ll(3) + ib(3) - 1
         do j = ll(2),ll(2) + ib(2) - 1
            do i = ll(1),ll(1) + ib(1) - 1
c
c Load coordinates and values of new points
               do m = 1,8
                  rt(1,m) = i+r(1,m) 
                  rt(2,m) = j+r(2,m) 
                  rt(3,m) = k+r(3,m) 
                  val(m) = rho(rt(1,m),rt(2,m),rt(3,m))
               end do
c
c Compute triangles
               call polygonize(rt,val,conlev,triangles,nt)
               if(nt .ne. 0) then
c
c Loop all triangles
                  do m = 1, nt
c Loop all vertices
                     do km = 1,3
c Loop all vertex coordinates
                        do jm = 1, 3
c     
c Convert to xyz order
                           v(jm,km) = triangles(ixyz(jm),km,m) - 1.
c     
c Convert to grid origin 
                           v(jm,km) = v(jm,km) + ioxyz(jm)
c
c Convert to grid fractional
                           v(jm,km) = v(jm,km) / mygrid(jm)
                        end do
c
c Convert to orthogonal angstroms
                        do jm = 1, 3
                           vx(jm,km) = f2o(jm,1)*v(1,km) 
     .                          + f2o(jm,2)*v(2,km) 
     .                          + f2o(jm,3)*v(3,km)
                        end do
c
c Store in corner array
                        do jm = 1, 3
                           corner(jm,ivert) = vx(jm,km)
                        end do
                        corner(7,ivert) = rivert
                        ivert = ivert + 1
                        if(ivert .gt. maxvert) then
                           write(*,*)
     .                     ' Excess of ',maxvert,' vertices generated'
                           write(*,*)
     .                     ' Increase via environment variable CONVERT'
                           stop
                        end if
                     end do
c
c Compute normal
                     call vdif(d1,vx(1,1),vx(1,2))
                     if(linvert) then
                        call vdif(d2,vx(1,3),vx(1,2))
                     else
                        call vdif(d2,vx(1,2),vx(1,3))
                     end if
                     call vdif(d3,vx(1,1),vx(1,3))
                     rl1 = sqrt(dot(d1,d1))
                     rl2 = sqrt(dot(d2,d2))
                     rl3 = sqrt(dot(d3,d3))
c
c If side vectors too short
                     if(  rl1 .le. 0.0001 .or. 
     .                    rl2 .le. 0.0001 .or. 
     .                    rl3 .le. 0.0001) then
                        ivert = ivert - 3
c                        do jj = 1, 3
c                           write(*,*) (vx(ii,jj),ii=1,3)
c                        end do
c                        write(*,*)
                     else
                        call cross(norm,d1,d2)
                        if(.not.lgouraud) then
                           call unit(norm)
                        else
                           area = dot(norm,norm)
                           call unit(norm)
                           norm(1) = norm(1) / area
                           norm(2) = norm(2) / area
                           norm(3) = norm(3) / area
                        end if
c
c Store for preceding three vertices
                        do jm = 4, 6
                           corner(jm,ivert-3) = norm(jm-3)
                           corner(jm,ivert-2) = norm(jm-3)
                           corner(jm,ivert-1) = norm(jm-3)
                        end do
                     end if
                  end do
c     
                  it = it + nt
               end if
            end do
         end do
      end do
      ivert = ivert -1
      write(*,'(a,i10)') 'Total number of triangles generated:',it
c
c Implement Gouraud shading via averaging normals at each vertex

      if(lgouraud) then
         write(*,'(/a)')' Setting up Gouraud shading...'
c
c Sort the vertices
         call qsort(corner,%val(ivert),%val(28),compar1)
         write(*,*)' First sort complete.'
c
c Average the normals
         istart = 1
1002    nnorm = 1
         ip = istart
         xn = corner(4,ip)
         yn = corner(5,ip)
         zn = corner(6,ip)
         xstart = corner(1,ip)
         ystart = corner(2,ip)
         zstart = corner(3,ip)
1001    ip = ip + 1
         xnew = corner(1,ip)
         ynew = corner(2,ip)
         znew = corner(3,ip)
         xnnew = corner(4,ip)
         ynnew = corner(5,ip)
         znnew = corner(6,ip)
         if(xstart .eq. xnew .and. 
     .      ystart .eq. ynew .and. 
     .      zstart .eq. znew) then

            xn = xn + xnnew
            yn = yn + ynnew
            zn = zn + znnew
            go to 1001
         else
            do i = istart, ip - 1
               corner(4,i) = xn
               corner(5,i) = yn
               corner(6,i) = zn
               call unit(corner(4,i))
            end do
            istart = ip
            if(ip .le. ivert) go to 1002
         end if
c
c Resort on vertex number

         call qsort(corner,%val(ivert),%val(28),compar2)
         write(*,*) ' Second sort complete.'
      end if
c
c Write out triangles
      do i = 1, ivert, 3
         write(2,'(a)')'TN 3'
         write(2,'(9f8.3)')(corner(j,i),j=1,6)
         write(2,'(9f8.3)')(corner(j,i+1),j=1,6)
         write(2,'(9f8.3)')(corner(j,i+2),j=1,6)
      end do
c
      return
      end
c
c---------------------------------------------------------------------
c
      integer function compar1(a1,a2)
c     ---------------------------------
c
c Compare function for vertex coordinates
c
      real*4 a1(7),a2(7)
c
      do i = 1, 3
         if(a1(i) .lt. a2(i)) then
            compar1 = -1
            return

         else if(a1(i) .gt. a2(i)) then
            compar1 = 1
            return

         end if

      end do
 
      compar1 = 0

      return
      end
c
c---------------------------------------------------------------------
c
      integer function compar2(a1,a2)
c     ---------------------------------
c
c Compare function for vertex indices

      integer*4 a1(7),a2(7)

      if(a1(7) .lt. a2(7)) then
         compar2 = -1
         return

      else if(a1(7) .gt. a2(7)) then
         compar2 = 1
         return

      end if

      compar2 = 0

      return
      end
c
c--------------------------------------------------------------------
c
      subroutine polygonize(grid,val,isolevel,triangles,ntriang)
c     ----------------------------------------------------------
c
c Generate triangles for each cube
c
      implicit none

      real*4 grid(3,0:7),val(0:7),isolevel,triangles(3,0:2,0:*)
      real*4 vertlist(3,0:11)
      integer i,ii,ntriang
      integer cubeindex

      integer tritable(0:15,0:255)

      data ((tritable(ii,i),ii=0,15),i=0,49)/
     . -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 0,8,3,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 0,1,9,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 1,8,3,9,8,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 1,2,10,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 0,8,3,1,2,10,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 9,2,10,0,2,9,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 2,8,3,2,10,8,10,9,8,-1,-1,-1,-1,-1,-1,-1,
     . 3,11,2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 0,11,2,8,11,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 1,9,0,2,3,11,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 1,11,2,1,9,11,9,8,11,-1,-1,-1,-1,-1,-1,-1,
     . 3,10,1,11,10,3,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 0,10,1,0,8,10,8,11,10,-1,-1,-1,-1,-1,-1,-1,
     . 3,9,0,3,11,9,11,10,9,-1,-1,-1,-1,-1,-1,-1,
     . 9,8,10,10,8,11,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 4,7,8,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 4,3,0,7,3,4,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 0,1,9,8,4,7,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 4,1,9,4,7,1,7,3,1,-1,-1,-1,-1,-1,-1,-1,
     . 1,2,10,8,4,7,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 3,4,7,3,0,4,1,2,10,-1,-1,-1,-1,-1,-1,-1,
     . 9,2,10,9,0,2,8,4,7,-1,-1,-1,-1,-1,-1,-1,
     . 2,10,9,2,9,7,2,7,3,7,9,4,-1,-1,-1,-1,
     . 8,4,7,3,11,2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 11,4,7,11,2,4,2,0,4,-1,-1,-1,-1,-1,-1,-1,
     . 9,0,1,8,4,7,2,3,11,-1,-1,-1,-1,-1,-1,-1,
     . 4,7,11,9,4,11,9,11,2,9,2,1,-1,-1,-1,-1,
     . 3,10,1,3,11,10,7,8,4,-1,-1,-1,-1,-1,-1,-1,
     . 1,11,10,1,4,11,1,0,4,7,11,4,-1,-1,-1,-1,
     . 4,7,8,9,0,11,9,11,10,11,0,3,-1,-1,-1,-1,
     . 4,7,11,4,11,9,9,11,10,-1,-1,-1,-1,-1,-1,-1,
     . 9,5,4,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 9,5,4,0,8,3,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 0,5,4,1,5,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 8,5,4,8,3,5,3,1,5,-1,-1,-1,-1,-1,-1,-1,
     . 1,2,10,9,5,4,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 3,0,8,1,2,10,4,9,5,-1,-1,-1,-1,-1,-1,-1,
     . 5,2,10,5,4,2,4,0,2,-1,-1,-1,-1,-1,-1,-1,
     . 2,10,5,3,2,5,3,5,4,3,4,8,-1,-1,-1,-1,
     . 9,5,4,2,3,11,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 0,11,2,0,8,11,4,9,5,-1,-1,-1,-1,-1,-1,-1,
     . 0,5,4,0,1,5,2,3,11,-1,-1,-1,-1,-1,-1,-1,
     . 2,1,5,2,5,8,2,8,11,4,8,5,-1,-1,-1,-1,
     . 10,3,11,10,1,3,9,5,4,-1,-1,-1,-1,-1,-1,-1,
     . 4,9,5,0,8,1,8,10,1,8,11,10,-1,-1,-1,-1,
     . 5,4,0,5,0,11,5,11,10,11,0,3,-1,-1,-1,-1,
     . 5,4,8,5,8,10,10,8,11,-1,-1,-1,-1,-1,-1,-1,
     . 9,7,8,5,7,9,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 9,3,0,9,5,3,5,7,3,-1,-1,-1,-1,-1,-1,-1/
      data ((tritable(ii,i),ii=0,15),i=50,99)/
     . 0,7,8,0,1,7,1,5,7,-1,-1,-1,-1,-1,-1,-1,
     . 1,5,3,3,5,7,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 9,7,8,9,5,7,10,1,2,-1,-1,-1,-1,-1,-1,-1,
     . 10,1,2,9,5,0,5,3,0,5,7,3,-1,-1,-1,-1,
     . 8,0,2,8,2,5,8,5,7,10,5,2,-1,-1,-1,-1,
     . 2,10,5,2,5,3,3,5,7,-1,-1,-1,-1,-1,-1,-1,
     . 7,9,5,7,8,9,3,11,2,-1,-1,-1,-1,-1,-1,-1,
     . 9,5,7,9,7,2,9,2,0,2,7,11,-1,-1,-1,-1,
     . 2,3,11,0,1,8,1,7,8,1,5,7,-1,-1,-1,-1,
     . 11,2,1,11,1,7,7,1,5,-1,-1,-1,-1,-1,-1,-1,
     . 9,5,8,8,5,7,10,1,3,10,3,11,-1,-1,-1,-1,
     . 5,7,0,5,0,9,7,11,0,1,0,10,11,10,0,-1,
     . 11,10,0,11,0,3,10,5,0,8,0,7,5,7,0,-1,
     . 11,10,5,7,11,5,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 10,6,5,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 0,8,3,5,10,6,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 9,0,1,5,10,6,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 1,8,3,1,9,8,5,10,6,-1,-1,-1,-1,-1,-1,-1,
     . 1,6,5,2,6,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 1,6,5,1,2,6,3,0,8,-1,-1,-1,-1,-1,-1,-1,
     . 9,6,5,9,0,6,0,2,6,-1,-1,-1,-1,-1,-1,-1,
     . 5,9,8,5,8,2,5,2,6,3,2,8,-1,-1,-1,-1,
     . 2,3,11,10,6,5,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 11,0,8,11,2,0,10,6,5,-1,-1,-1,-1,-1,-1,-1,
     . 0,1,9,2,3,11,5,10,6,-1,-1,-1,-1,-1,-1,-1,
     . 5,10,6,1,9,2,9,11,2,9,8,11,-1,-1,-1,-1,
     . 6,3,11,6,5,3,5,1,3,-1,-1,-1,-1,-1,-1,-1,
     . 0,8,11,0,11,5,0,5,1,5,11,6,-1,-1,-1,-1,
     . 3,11,6,0,3,6,0,6,5,0,5,9,-1,-1,-1,-1,
     . 6,5,9,6,9,11,11,9,8,-1,-1,-1,-1,-1,-1,-1,
     . 5,10,6,4,7,8,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 4,3,0,4,7,3,6,5,10,-1,-1,-1,-1,-1,-1,-1,
     . 1,9,0,5,10,6,8,4,7,-1,-1,-1,-1,-1,-1,-1,
     . 10,6,5,1,9,7,1,7,3,7,9,4,-1,-1,-1,-1,
     . 6,1,2,6,5,1,4,7,8,-1,-1,-1,-1,-1,-1,-1,
     . 1,2,5,5,2,6,3,0,4,3,4,7,-1,-1,-1,-1,
     . 8,4,7,9,0,5,0,6,5,0,2,6,-1,-1,-1,-1,
     . 7,3,9,7,9,4,3,2,9,5,9,6,2,6,9,-1,
     . 3,11,2,7,8,4,10,6,5,-1,-1,-1,-1,-1,-1,-1,
     . 5,10,6,4,7,2,4,2,0,2,7,11,-1,-1,-1,-1,
     . 0,1,9,4,7,8,2,3,11,5,10,6,-1,-1,-1,-1,
     . 9,2,1,9,11,2,9,4,11,7,11,4,5,10,6,-1,
     . 8,4,7,3,11,5,3,5,1,5,11,6,-1,-1,-1,-1,
     . 5,1,11,5,11,6,1,0,11,7,11,4,0,4,11,-1,
     . 0,5,9,0,6,5,0,3,6,11,6,3,8,4,7,-1,
     . 6,5,9,6,9,11,4,7,9,7,11,9,-1,-1,-1,-1,
     . 10,4,9,6,4,10,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 4,10,6,4,9,10,0,8,3,-1,-1,-1,-1,-1,-1,-1,
     . 10,0,1,10,6,0,6,4,0,-1,-1,-1,-1,-1,-1,-1,
     . 8,3,1,8,1,6,8,6,4,6,1,10,-1,-1,-1,-1/

      data ((tritable(ii,i),ii=0,15),i=100,149)/
     . 1,4,9,1,2,4,2,6,4,-1,-1,-1,-1,-1,-1,-1,
     . 3,0,8,1,2,9,2,4,9,2,6,4,-1,-1,-1,-1,
     . 0,2,4,4,2,6,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 8,3,2,8,2,4,4,2,6,-1,-1,-1,-1,-1,-1,-1,
     . 10,4,9,10,6,4,11,2,3,-1,-1,-1,-1,-1,-1,-1,
     . 0,8,2,2,8,11,4,9,10,4,10,6,-1,-1,-1,-1,
     . 3,11,2,0,1,6,0,6,4,6,1,10,-1,-1,-1,-1,
     . 6,4,1,6,1,10,4,8,1,2,1,11,8,11,1,-1,
     . 9,6,4,9,3,6,9,1,3,11,6,3,-1,-1,-1,-1,
     . 8,11,1,8,1,0,11,6,1,9,1,4,6,4,1,-1,
     . 3,11,6,3,6,0,0,6,4,-1,-1,-1,-1,-1,-1,-1,
     . 6,4,8,11,6,8,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 7,10,6,7,8,10,8,9,10,-1,-1,-1,-1,-1,-1,-1,
     . 0,7,3,0,10,7,0,9,10,6,7,10,-1,-1,-1,-1,
     . 10,6,7,1,10,7,1,7,8,1,8,0,-1,-1,-1,-1,
     . 10,6,7,10,7,1,1,7,3,-1,-1,-1,-1,-1,-1,-1,
     . 1,2,6,1,6,8,1,8,9,8,6,7,-1,-1,-1,-1,
     . 2,6,9,2,9,1,6,7,9,0,9,3,7,3,9,-1,
     . 7,8,0,7,0,6,6,0,2,-1,-1,-1,-1,-1,-1,-1,
     . 7,3,2,6,7,2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 2,3,11,10,6,8,10,8,9,8,6,7,-1,-1,-1,-1,
     . 2,0,7,2,7,11,0,9,7,6,7,10,9,10,7,-1,
     . 1,8,0,1,7,8,1,10,7,6,7,10,2,3,11,-1,
     . 11,2,1,11,1,7,10,6,1,6,7,1,-1,-1,-1,-1,
     . 8,9,6,8,6,7,9,1,6,11,6,3,1,3,6,-1,
     . 0,9,1,11,6,7,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 7,8,0,7,0,6,3,11,0,11,6,0,-1,-1,-1,-1,
     . 7,11,6,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 7,6,11,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 3,0,8,11,7,6,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 0,1,9,11,7,6,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 8,1,9,8,3,1,11,7,6,-1,-1,-1,-1,-1,-1,-1,
     . 10,1,2,6,11,7,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 1,2,10,3,0,8,6,11,7,-1,-1,-1,-1,-1,-1,-1,
     . 2,9,0,2,10,9,6,11,7,-1,-1,-1,-1,-1,-1,-1,
     . 6,11,7,2,10,3,10,8,3,10,9,8,-1,-1,-1,-1,
     . 7,2,3,6,2,7,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 7,0,8,7,6,0,6,2,0,-1,-1,-1,-1,-1,-1,-1,
     . 2,7,6,2,3,7,0,1,9,-1,-1,-1,-1,-1,-1,-1,
     . 1,6,2,1,8,6,1,9,8,8,7,6,-1,-1,-1,-1,
     . 10,7,6,10,1,7,1,3,7,-1,-1,-1,-1,-1,-1,-1,
     . 10,7,6,1,7,10,1,8,7,1,0,8,-1,-1,-1,-1,
     . 0,3,7,0,7,10,0,10,9,6,10,7,-1,-1,-1,-1,
     . 7,6,10,7,10,8,8,10,9,-1,-1,-1,-1,-1,-1,-1,
     . 6,8,4,11,8,6,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 3,6,11,3,0,6,0,4,6,-1,-1,-1,-1,-1,-1,-1,
     . 8,6,11,8,4,6,9,0,1,-1,-1,-1,-1,-1,-1,-1,
     . 9,4,6,9,6,3,9,3,1,11,3,6,-1,-1,-1,-1,
     . 6,8,4,6,11,8,2,10,1,-1,-1,-1,-1,-1,-1,-1,
     . 1,2,10,3,0,11,0,6,11,0,4,6,-1,-1,-1,-1/

      data ((tritable(ii,i),ii=0,15),i=150,199)/
     . 4,11,8,4,6,11,0,2,9,2,10,9,-1,-1,-1,-1,
     . 10,9,3,10,3,2,9,4,3,11,3,6,4,6,3,-1,
     . 8,2,3,8,4,2,4,6,2,-1,-1,-1,-1,-1,-1,-1,
     . 0,4,2,4,6,2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 1,9,0,2,3,4,2,4,6,4,3,8,-1,-1,-1,-1,
     . 1,9,4,1,4,2,2,4,6,-1,-1,-1,-1,-1,-1,-1,
     . 8,1,3,8,6,1,8,4,6,6,10,1,-1,-1,-1,-1,
     . 10,1,0,10,0,6,6,0,4,-1,-1,-1,-1,-1,-1,-1,
     . 4,6,3,4,3,8,6,10,3,0,3,9,10,9,3,-1,
     . 10,9,4,6,10,4,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 4,9,5,7,6,11,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 0,8,3,4,9,5,11,7,6,-1,-1,-1,-1,-1,-1,-1,
     . 5,0,1,5,4,0,7,6,11,-1,-1,-1,-1,-1,-1,-1,
     . 11,7,6,8,3,4,3,5,4,3,1,5,-1,-1,-1,-1,
     . 9,5,4,10,1,2,7,6,11,-1,-1,-1,-1,-1,-1,-1,
     . 6,11,7,1,2,10,0,8,3,4,9,5,-1,-1,-1,-1,
     . 7,6,11,5,4,10,4,2,10,4,0,2,-1,-1,-1,-1,
     . 3,4,8,3,5,4,3,2,5,10,5,2,11,7,6,-1,
     . 7,2,3,7,6,2,5,4,9,-1,-1,-1,-1,-1,-1,-1,
     . 9,5,4,0,8,6,0,6,2,6,8,7,-1,-1,-1,-1,
     . 3,6,2,3,7,6,1,5,0,5,4,0,-1,-1,-1,-1,
     . 6,2,8,6,8,7,2,1,8,4,8,5,1,5,8,-1,
     . 9,5,4,10,1,6,1,7,6,1,3,7,-1,-1,-1,-1,
     . 1,6,10,1,7,6,1,0,7,8,7,0,9,5,4,-1,
     . 4,0,10,4,10,5,0,3,10,6,10,7,3,7,10,-1,
     . 7,6,10,7,10,8,5,4,10,4,8,10,-1,-1,-1,-1,
     . 6,9,5,6,11,9,11,8,9,-1,-1,-1,-1,-1,-1,-1,
     . 3,6,11,0,6,3,0,5,6,0,9,5,-1,-1,-1,-1,
     . 0,11,8,0,5,11,0,1,5,5,6,11,-1,-1,-1,-1,
     . 6,11,3,6,3,5,5,3,1,-1,-1,-1,-1,-1,-1,-1,
     . 1,2,10,9,5,11,9,11,8,11,5,6,-1,-1,-1,-1,
     . 0,11,3,0,6,11,0,9,6,5,6,9,1,2,10,-1,
     . 11,8,5,11,5,6,8,0,5,10,5,2,0,2,5,-1,
     . 6,11,3,6,3,5,2,10,3,10,5,3,-1,-1,-1,-1,
     . 5,8,9,5,2,8,5,6,2,3,8,2,-1,-1,-1,-1,
     . 9,5,6,9,6,0,0,6,2,-1,-1,-1,-1,-1,-1,-1,
     . 1,5,8,1,8,0,5,6,8,3,8,2,6,2,8,-1,
     . 1,5,6,2,1,6,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 1,3,6,1,6,10,3,8,6,5,6,9,8,9,6,-1,
     . 10,1,0,10,0,6,9,5,0,5,6,0,-1,-1,-1,-1,
     . 0,3,8,5,6,10,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 10,5,6,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 11,5,10,7,5,11,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 11,5,10,11,7,5,8,3,0,-1,-1,-1,-1,-1,-1,-1,
     . 5,11,7,5,10,11,1,9,0,-1,-1,-1,-1,-1,-1,-1,
     . 10,7,5,10,11,7,9,8,1,8,3,1,-1,-1,-1,-1,
     . 11,1,2,11,7,1,7,5,1,-1,-1,-1,-1,-1,-1,-1,
     . 0,8,3,1,2,7,1,7,5,7,2,11,-1,-1,-1,-1,
     . 9,7,5,9,2,7,9,0,2,2,11,7,-1,-1,-1,-1,
     . 7,5,2,7,2,11,5,9,2,3,2,8,9,8,2,-1/

      data ((tritable(ii,i),ii=0,15),i=200,255)/
     . 2,5,10,2,3,5,3,7,5,-1,-1,-1,-1,-1,-1,-1,
     . 8,2,0,8,5,2,8,7,5,10,2,5,-1,-1,-1,-1,
     . 9,0,1,5,10,3,5,3,7,3,10,2,-1,-1,-1,-1,
     . 9,8,2,9,2,1,8,7,2,10,2,5,7,5,2,-1,
     . 1,3,5,3,7,5,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 0,8,7,0,7,1,1,7,5,-1,-1,-1,-1,-1,-1,-1,
     . 9,0,3,9,3,5,5,3,7,-1,-1,-1,-1,-1,-1,-1,
     . 9,8,7,5,9,7,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 5,8,4,5,10,8,10,11,8,-1,-1,-1,-1,-1,-1,-1,
     . 5,0,4,5,11,0,5,10,11,11,3,0,-1,-1,-1,-1,
     . 0,1,9,8,4,10,8,10,11,10,4,5,-1,-1,-1,-1,
     . 10,11,4,10,4,5,11,3,4,9,4,1,3,1,4,-1,
     . 2,5,1,2,8,5,2,11,8,4,5,8,-1,-1,-1,-1,
     . 0,4,11,0,11,3,4,5,11,2,11,1,5,1,11,-1,
     . 0,2,5,0,5,9,2,11,5,4,5,8,11,8,5,-1,
     . 9,4,5,2,11,3,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 2,5,10,3,5,2,3,4,5,3,8,4,-1,-1,-1,-1,
     . 5,10,2,5,2,4,4,2,0,-1,-1,-1,-1,-1,-1,-1,
     . 3,10,2,3,5,10,3,8,5,4,5,8,0,1,9,-1,
     . 5,10,2,5,2,4,1,9,2,9,4,2,-1,-1,-1,-1,
     . 8,4,5,8,5,3,3,5,1,-1,-1,-1,-1,-1,-1,-1,
     . 0,4,5,1,0,5,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 8,4,5,8,5,3,9,0,5,0,3,5,-1,-1,-1,-1,
     . 9,4,5,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 4,11,7,4,9,11,9,10,11,-1,-1,-1,-1,-1,-1,-1,
     . 0,8,3,4,9,7,9,11,7,9,10,11,-1,-1,-1,-1,
     . 1,10,11,1,11,4,1,4,0,7,4,11,-1,-1,-1,-1,
     . 3,1,4,3,4,8,1,10,4,7,4,11,10,11,4,-1,
     . 4,11,7,9,11,4,9,2,11,9,1,2,-1,-1,-1,-1,
     . 9,7,4,9,11,7,9,1,11,2,11,1,0,8,3,-1,
     . 11,7,4,11,4,2,2,4,0,-1,-1,-1,-1,-1,-1,-1,
     . 11,7,4,11,4,2,8,3,4,3,2,4,-1,-1,-1,-1,
     . 2,9,10,2,7,9,2,3,7,7,4,9,-1,-1,-1,-1,
     . 9,10,7,9,7,4,10,2,7,8,7,0,2,0,7,-1,
     . 3,7,10,3,10,2,7,4,10,1,10,0,4,0,10,-1,
     . 1,10,2,8,7,4,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 4,9,1,4,1,7,7,1,3,-1,-1,-1,-1,-1,-1,-1,
     . 4,9,1,4,1,7,0,8,1,8,7,1,-1,-1,-1,-1,
     . 4,0,3,7,4,3,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 4,8,7,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 9,10,8,10,11,8,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 3,0,9,3,9,11,11,9,10,-1,-1,-1,-1,-1,-1,-1,
     . 0,1,10,0,10,8,8,10,11,-1,-1,-1,-1,-1,-1,-1,
     . 3,1,10,11,3,10,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 1,2,11,1,11,9,9,11,8,-1,-1,-1,-1,-1,-1,-1,
     . 3,0,9,3,9,11,1,2,9,2,11,9,-1,-1,-1,-1,
     . 0,2,11,8,0,11,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 3,2,11,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 2,3,8,2,8,10,10,8,9,-1,-1,-1,-1,-1,-1,-1,
     . 9,10,2,0,9,2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 2,3,8,2,8,10,0,1,8,1,10,8,-1,-1,-1,-1,
     . 1,10,2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 1,3,8,9,1,8,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 0,9,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . 0,3,8,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     . -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1/

      integer edgetable(0:255)/
     . X'0'  , X'109', X'203', X'30a', X'406', X'50f', X'605', X'70c',
     . X'80c', X'905', X'a0f', X'b06', X'c0a', X'd03', X'e09', X'f00',
     . X'190', X'99' , X'393', X'29a', X'596', X'49f', X'795', X'69c',
     . X'99c', X'895', X'b9f', X'a96', X'd9a', X'c93', X'f99', X'e90',
     . X'230', X'339', X'33' , X'13a', X'636', X'73f', X'435', X'53c',
     . X'a3c', X'b35', X'83f', X'936', X'e3a', X'f33', X'c39', X'd30',
     . X'3a0', X'2a9', X'1a3', X'aa' , X'7a6', X'6af', X'5a5', X'4ac',
     . X'bac', X'aa5', X'9af', X'8a6', X'faa', X'ea3', X'da9', X'ca0',
     . X'460', X'569', X'663', X'76a', X'66' , X'16f', X'265', X'36c',
     . X'c6c', X'd65', X'e6f', X'f66', X'86a', X'963', X'a69', X'b60',
     . X'5f0', X'4f9', X'7f3', X'6fa', X'1f6', X'ff' , X'3f5', X'2fc',
     . X'dfc', X'cf5', X'fff', X'ef6', X'9fa', X'8f3', X'bf9', X'af0',
     . X'650', X'759', X'453', X'55a', X'256', X'35f', X'55' , X'15c',
     . X'e5c', X'f55', X'c5f', X'd56', X'a5a', X'b53', X'859', X'950',
     . X'7c0', X'6c9', X'5c3', X'4ca', X'3c6', X'2cf', X'1c5', X'cc' ,
     . X'fcc', X'ec5', X'dcf', X'cc6', X'bca', X'ac3', X'9c9', X'8c0',
     . X'8c0', X'9c9', X'ac3', X'bca', X'cc6', X'dcf', X'ec5', X'fcc',
     . X'cc' , X'1c5', X'2cf', X'3c6', X'4ca', X'5c3', X'6c9', X'7c0',
     . X'950', X'859', X'b53', X'a5a', X'd56', X'c5f', X'f55', X'e5c',
     . X'15c', X'55' , X'35f', X'256', X'55a', X'453', X'759', X'650',
     . X'af0', X'bf9', X'8f3', X'9fa', X'ef6', X'fff', X'cf5', X'dfc',
     . X'2fc', X'3f5', X'ff' , X'1f6', X'6fa', X'7f3', X'4f9', X'5f0',
     . X'b60', X'a69', X'963', X'86a', X'f66', X'e6f', X'd65', X'c6c',
     . X'36c', X'265', X'16f', X'66' , X'76a', X'663', X'569', X'460',
     . X'ca0', X'da9', X'ea3', X'faa', X'8a6', X'9af', X'aa5', X'bac',
     . X'4ac', X'5a5', X'6af', X'7a6', X'aa' , X'1a3', X'2a9', X'3a0',
     . X'd30', X'c39', X'f33', X'e3a', X'936', X'83f', X'b35', X'a3c',
     . X'53c', X'435', X'73f', X'636', X'13a', X'33' , X'339', X'230',
     . X'e90', X'f99', X'c93', X'd9a', X'a96', X'b9f', X'895', X'99c',
     . X'69c', X'795', X'49f', X'596', X'29a', X'393', X'99' , X'190',
     . X'f00', X'e09', X'd03', X'c0a', X'b06', X'a0f', X'905', X'80c',
     . X'70c', X'605', X'50f', X'406', X'30a', X'203', X'109', X'0'  /
c
c      Determine the index into the edge table which
c      tells us which vertices are inside of the surface
c
      cubeindex = 0
      if (val(0) .lt. isolevel) cubeindex = ior(cubeindex,1)
      if (val(1) .lt. isolevel) cubeindex = ior(cubeindex,2)
      if (val(2) .lt. isolevel) cubeindex = ior(cubeindex,4)
      if (val(3) .lt. isolevel) cubeindex = ior(cubeindex,8)
      if (val(4) .lt. isolevel) cubeindex = ior(cubeindex,16)
      if (val(5) .lt. isolevel) cubeindex = ior(cubeindex,32)
      if (val(6) .lt. isolevel) cubeindex = ior(cubeindex,64)
      if (val(7) .lt. isolevel) cubeindex = ior(cubeindex,128)

c    Cube is entirely in/out of the surface 
c
      if (edgetable(cubeindex) .eq. 0) then
         ntriang = 0
         return
      end if

c    Find the vertices where the surface intersects the cube 
c
      if (btest(edgetable(cubeindex),0))then
         call vertexinterp
     .    (0,vertlist(1,0),isolevel,grid(1,0),grid(1,1),val(0),val(1))
      end if 
      if (btest(edgetable(cubeindex),1))then
         call vertexinterp
     .    (1,vertlist(1,1),isolevel,grid(1,1),grid(1,2),val(1),val(2))
      end if
      if (btest(edgetable(cubeindex),2))then
         call vertexinterp
     .    (2,vertlist(1,2),isolevel,grid(1,2),grid(1,3),val(2),val(3))
      end if
      if (btest(edgetable(cubeindex),3))then
         call vertexinterp
     .    (3,vertlist(1,3),isolevel,grid(1,3),grid(1,0),val(3),val(0))
      end if
      if (btest(edgetable(cubeindex),4))then
         call vertexinterp
     .    (4,vertlist(1,4),isolevel,grid(1,4),grid(1,5),val(4),val(5))
      end if
      if (btest(edgetable(cubeindex),5))then
         call vertexinterp
     .    (5,vertlist(1,5),isolevel,grid(1,5),grid(1,6),val(5),val(6))
      end if
      if (btest(edgetable(cubeindex),6))then
         call vertexinterp
     .    (6,vertlist(1,6),isolevel,grid(1,6),grid(1,7),val(6),val(7))
      end if
      if (btest(edgetable(cubeindex),7))then
         call vertexinterp
     .    (7,vertlist(1,7),isolevel,grid(1,7),grid(1,4),val(7),val(4))
      end if
      if (btest(edgetable(cubeindex),8))then
         call vertexinterp
     .    (8,vertlist(1,8),isolevel,grid(1,0),grid(1,4),val(0),val(4))
      end if
      if (btest(edgetable(cubeindex),9))then
         call vertexinterp
     .    (9,vertlist(1,9),isolevel,grid(1,1),grid(1,5),val(1),val(5))
      end if
      if (btest(edgetable(cubeindex),10))then
         call vertexinterp
     .    (10,vertlist(1,10),isolevel,grid(1,2),grid(1,6),val(2),val(6))
      end if
      if (btest(edgetable(cubeindex),11))then
         call vertexinterp
     .    (11,vertlist(1,11),isolevel,grid(1,3),grid(1,7),val(3),val(7))
      end if

c    Create the triangle 
      ntriang = 0
      i = 0
100   continue
      triangles(1,0  ,ntriang) = vertlist(1,tritable(i  ,cubeindex))
      triangles(2,0  ,ntriang) = vertlist(2,tritable(i  ,cubeindex))
      triangles(3,0  ,ntriang) = vertlist(3,tritable(i  ,cubeindex))
      triangles(1,1  ,ntriang) = vertlist(1,tritable(i+1,cubeindex))
      triangles(2,1  ,ntriang) = vertlist(2,tritable(i+1,cubeindex))
      triangles(3,1  ,ntriang) = vertlist(3,tritable(i+1,cubeindex))
      triangles(1,2  ,ntriang) = vertlist(1,tritable(i+2,cubeindex))
      triangles(2,2  ,ntriang) = vertlist(2,tritable(i+2,cubeindex))
      triangles(3,2  ,ntriang) = vertlist(3,tritable(i+2,cubeindex))
      i = i + 3
      ntriang = ntriang + 1
      if(tritable(i,cubeindex) .ne. -1) go to 100
c
      return
      end
c
c---------------------------------------------------------------------
c
      subroutine vertexinterp(n,p,isolevel,p1,p2,valp1,valp2)
c     --------------------------------------------------------
c
c   Linearly interpolate the position where an isosurface cuts
c   an edge between two vertices, each with their own scalar value
c
      implicit none

      real*4 isolevel
      real*4 p(3),p1(3),p2(3)
      real*4 valp1,valp2,mu
      integer*4 i,n

      if (abs(isolevel-valp1) .lt. 0.00001) then
         do i = 1, 3
            p(i) = p1(i)
         end do
         return
      end if
      if (abs(isolevel-valp2) .lt. 0.00001) then
         do i = 1, 3
            p(i) = p2(i)
         end do
         return
      end if
      if (abs(valp1-valp2) .lt. 0.00001) then
         do i = 1, 3
            p(i) = p1(i)
         end do
         return
      end if

      mu = (isolevel - valp1) / (valp2 - valp1)
      p(1) = p1(1) + mu * (p2(1) - p1(1))
      p(2) = p1(2) + mu * (p2(2) - p1(2))
      p(3) = p1(3) + mu * (p2(3) - p1(3))

      return
      end
c
c--------------------------------------------------------------------
c
      subroutine read_map(rho,r2)
c     ---------------------------
c
      implicit none

      real*4 rho(*)
      real*8 r2(*)
c
      include 'conscript.h'
c
      integer ibase,k,l

      ibase = 1

      do k = 1, nxyz(iuvw(3))
         if( mtype .eq. 'XPLF') then
            read(1,'(I8)') l
            call getsecf(1,layer,rho(ibase))
         else
            read(1) l
            call getsecu(1,layer,rho(ibase),r2)
         end if

         ibase = ibase + layer

      end do

      return
      end
c
c--------------------------------------------------------------------
c
      subroutine getsecf(iunit,n,r)
c     -----------------------------

      implicit none

      integer*4 iunit,n
      real*4 r(n)

      read(iunit,'(6e12.5)') r

      return
      end
c
c---------------------------------------------------------------------
c
      subroutine getsecu(iunit,n,r1,r2)
c     ---------------------------------

      implicit none

      integer*4 i,iunit,n
      real*4 r1(n)
      real*8 r2(n)

      read(iunit) r2
      do i = 1, n
         r1(i) = r2(i)
      end do

      return
      end

c
c---------------------------------------------------------------------
c
      subroutine conversion_matrices(cell,o2f,f2o)
c     --------------------------------------------
c
      implicit none

      real cell(6),o2f(3,3),f2o(3,3), sin_a1
      real cos_angles(3), sin_angles(3), cos_a(3), abcs(3)
      real volume,d2r
      integer i,j

      d2r=acos(-1.)/180.
c
c Zero matrices
c
      do j = 1, 3
         do i = 1, 3
            o2f(i,j) = 0.
            f2o(i,j) = 0.
         end do
      end do
c
c Set up sines and cosines
c
      do i = 1, 3
         cos_angles(i) = cos(d2r*cell(i+3))
         sin_angles(i) = sin(d2r*cell(i+3))
      end do
c
c Compute cell volume
c
      volume = cell(1) * cell(2) * cell(3) * 
     .         sqrt(1. + 
     .            2. * cos_angles(1) * cos_angles(2) * cos_angles(3)
     .               - cos_angles(1) ** 2 
     .               - cos_angles(2) ** 2 
     .               - cos_angles(3) ** 2)
c
c Compute some terms
c
      cos_a(1) = (cos_angles(2) * cos_angles(3) - cos_angles(1)) 
     .               / (sin_angles(2) * sin_angles(3))
      cos_a(2) = (cos_angles(3) * cos_angles(1) - cos_angles(2)) 
     .               / (sin_angles(3) * sin_angles(1))
      cos_a(3) = (cos_angles(1) * cos_angles(2) - cos_angles(3)) 
     .               / (sin_angles(1) * sin_angles(2))
c
      abcs(1) = cell(2) * cell(3) * sin_angles(1) / volume
      abcs(2) = cell(1) * cell(3) * sin_angles(2) / volume
      abcs(3) = cell(1) * cell(2) * sin_angles(3) / volume

      sin_a1 = sqrt(1. - cos_a(1) ** 2)
c
c Compute orthogonal to fractional matrix
c
      o2f(1,1) = 1. / cell(1)
      o2f(1,2) =  - cos_angles(3) / (sin_angles(3) * cell(1))
      o2f(1,3) =  - (cos_angles(3) * sin_angles(2) * cos_a(1)
     .                + cos_angles(2) * sin_angles(3)) 
     .            / (sin_angles(2) * sin_a1 * sin_angles(3) * cell(1))
      o2f(2,2) = 1. / (sin_angles(3) * cell(2))
      o2f(2,3) = cos_a(1) / (sin_a1 * sin_angles(3) * cell(2))
      o2f(3,3) = 1. / (sin_angles(2) * sin_a1 * cell(3))
c
c Compute fractional to orthogonal matrix
c
      f2o(1,1) =  cell(1)
      f2o(1,2) =  cos_angles(3) * cell(2)
      f2o(1,3) =  cos_angles(2) * cell(3)
      f2o(2,2) =  sin_angles(3) * cell(2)
      f2o(2,3) =  - sin_angles(2) * cos_a(1) * cell(3)
      f2o(3,3) = sin_angles(2) * sin_a1 * cell(3)
c
      return
      end
c
c---------------------------------------------------------------------
c
      subroutine mesh(rho,flags,conlev,macs,brick_adjust,
     .              box_min,mygrid,ntotal,ioxyz,origin,f2o,ixyz)
c     -------------------------------------------------------------
c
      real conlev
      integer origin,orig
      real rho(*),vector(3),f2o(3,3)
      real v(3),oldvec(3)

      integer brick_adjust(3),box_min(3),macs(3),mygrid(3)
      integer ioxyz(3),ixyz(3)
      integer ulu,ulv,uu,vv,ww
      integer step(3)

      logical fin,flag,psbit,right
      logical flags (4,*)
c
      step(1) = 1
      step(2) = macs(1)
      step(3) = macs(1)*macs(2)
      list = 0
      kut = 0
c
c Next sectioning direction
c
   10 kut = kut + 1
      if (kut.ge.4) return
      ii = kut + 1
      if (ii.ge.4) ii = 1
      jj = ii + 1
      if (jj.ge.4) jj = 1
      orig = origin - step(kut)
      ww = 0
c
c  next plane
c
   20 ww = ww + 1
      if (ww.ge.brick_adjust(kut)) go to 10
c
      orig = step(kut) + orig
      fin = .false.
      n = brick_adjust(ii)*brick_adjust(jj)
c
c
      do i = 1,n
        do j = 1,4
          flags(j,i) = .false.
       end do
      end do
c
      uu = 1
      vv = 1
      ulu = brick_adjust(ii)
      ulv = brick_adjust(jj)
      llu = 1
      llv = 2
      ku = 1
      kv = 0
      mode = 1
      m = orig
      mm = 1
c
c search path
c
      i = 0
      if (rho(m).ge.conlev) i = 1

   50 l = m
      ll = mm
c
c turn corners
c       finish if an about turn is required
c
60    continue
      if(mode .eq. 1) then
         if (uu.lt.ulu) then
            m = step(ii) + l
            mm = ll + 1
            uu = uu + 1
            go to 140
         end if
         if (fin) go to 20
         fin = .true.
         ulu = ulu - 1
         ku = 0
         kv = 1
         mode = 2
      end if

      if(mode .eq. 2) then
         if (vv.lt.ulv)then
            m = step(jj) + l
            mm = brick_adjust(ii) + ll
            vv = vv + 1
            go to 140
         end if
         if (fin) go to 20
         fin = .true.
         ulv = ulv - 1
         ku = -1
         kv = 0
         mode = 3
      end if

      if(mode .eq. 3) then
         if (uu.gt.llu)then
            m = l - step(ii)
            mm = ll - 1
            uu = uu - 1
            go to 140 
         end if
         if (fin) go to 20
         fin = .true.
         llu = llu + 1
         ku = 0
         kv = -1
         mode = 4
      end if

      if(mode .eq. 4) then
         if (vv.gt.llv) then
            m = l - step(jj)
            mm = ll - brick_adjust(ii)
            vv = vv - 1 
            go to 140
         end if
         if (fin) go to 20
         fin = .true.
         llv = llv + 1
         ku = 1
         kv = 0
         mode = 1
      end if

      go to 60
c
c straight steps
  140 fin = .false.
c
c test for contour
c
  150 j = 0
      if (rho(m).ge.conlev) j = 1
      if (i.eq.j) go to 50
c
c   contour crossed
c
      i = j
c
c   have we been here before?
c
      if (flags(mode,mm)) go to 50
c
c   no, so record state of search path
c       and initiate chase path
c
      n = m
      nn = mm
      ju = uu
      jv = vv
      k = j
      psbit = .false.
c
c   select even parity path
c
      if (mod(uu+vv+mode+j,2).ne.0) go to 160
      node = mode
      right = .false.
      go to 260
  160 node = mode + 2
      if (node.ge.5) node = node - 4
      right = .true.
      i = m
      m = l
      l = i
      i = mm
      mm = ll
      ll = i
      i = 1 - j
      uu = uu - ku
      vv = vv - kv
      go to 260
c
c  turn corners
c
  170 right = .not. right
  180 if (right) go to 190
c
c  turn left
c
      node = node - 1
      if (node.lt.1) node = 4
      go to 200
c
c turn right
c
  190 node = node + 1
      if (node.ge.5) node = 1
c
c step and test for boundary
c
  200 l = m
      ll = mm
      go to (210,220,230,240) node
  210 uu = uu + 1
      if (uu.gt.brick_adjust(ii)) go to 320
      m = step(ii) + l
      mm = ll + 1
      go to 250
  220 vv = vv + 1
      if (vv.gt.brick_adjust(jj)) go to 320
      m = step(jj) + l
      mm = brick_adjust(ii) + ll
      go to 250
  230 uu = uu - 1
      if (uu.lt.1) go to 320
      m = l - step(ii)
      mm = ll - 1
      go to 250
  240 vv = vv - 1
      if (vv.lt.1) go to 320
      m = l - step(jj)
      mm = ll - brick_adjust(ii)
c
c  test for contours
c
  250 j = 0
      if (rho(m).ge.conlev) j = 1
      if (i.eq.j) go to 180
c
c  contour crossed so
c
      i = j

260   continue
      x = (rho(m)-conlev)/ (rho(m)-rho(l))
      vector(ii) = real(uu-1+box_min(ii))
      vector(jj) = real(vv-1+box_min(jj))
      vector(kut) = real(ww-1+box_min(kut))
      if(node.eq.1) then
         vector(ii) = vector(ii) - x
      else if(node.eq.2) then
         vector(jj) = vector(jj) - x
      else if (node.eq.3) then
         vector(ii) = vector(ii) + x
      else if(node.eq.4) then
         vector(jj) = vector(jj) + x
      end if
c
      flag = flags(node,mm)
c
c       transform back to xyz order
      do jm = 1, 3
         v(jm) = vector(ixyz(jm))
      end do
c     transform to fractional
      do jm = 1, 3
         v(jm) = (v(jm) + ioxyz(jm)) / mygrid(jm)
      end do
c     transform to orthogonal angstroms
      do jm = 1, 3
         vector(jm) = f2o(jm,1)*v(1)
     .        + f2o(jm,2)*v(2)
     .        + f2o(jm,3)*v(3)
      end do
c     
      if(psbit) then
         write(2,298) oldvec,vector
298     format('L 2',6f10.3)
         ntotal = ntotal + 1
      end if
      do jm = 1, 3
         oldvec(jm) = vector(jm)
      end do
      psbit = .true.

c
c   record our visit
c
      flags(node,mm) = .true.
      flags(mod(node+1,4)+1,ll) = .true.
c
c  have we finished this contour?
c
      if (.not.flag) go to 170
c
c   contour closed or boundary reached
c       therefore resume search path
c
  320 m = n
      mm = nn
      uu = ju
      vv = jv
      i = k
      go to 150
c
      end
c
c---------------------------------------------------------------------
c
        integer function shift_left(line)
c       ---------------------------------
c
c Shift left takes the string line and trims any leading blanks
c
c It returns the position of the last non-blank character in the
c shifted string.
c
c It returns the value of -1 if the string is entirely blank
c
        implicit none
        character*(*) line
        character*80 buffer
        integer plen,nc,i,nchar,n
c
        nc = plen(line)
        do i = 1, nc
           n = i
           if(line(i:i) .ne. ' ') then
c found a non-blank
              nchar = nc - n + 1
              buffer(1:nchar) = line(n:nc)
              line(1:nchar) = buffer(1:nchar)
              shift_left = nchar
              return
           end if
        end do
c
c Error
        shift_left = -1
        return

        end
c
c---------------------------------------------------------------------
c
      integer function plen(str)
c     --------------------------
c
c     This function gives the location of the last printable character 
c
      character str*(*)
      integer   temp
      i = len(str)
     
      do plen=i,1,-1
         temp = ibits(ichar(str(plen:plen)),0,7)
         if ((temp.ne.127).and.(temp.gt.32)) return
      end do

      return
      end
