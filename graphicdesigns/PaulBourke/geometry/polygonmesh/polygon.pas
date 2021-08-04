unit polygon;

//Author: Rodrigo Alves Pons 
//email: rodpons@ig.com.br
//webpage: www.geocities.com/rodrigo_alves_pons/
//Version: 2006-12-07
//functions to calculate the area and centroid of a polygon,
//according to the algorithm defined at:
//http://local.wasp.uwa.edu.au/~pbourke/geometry/polyarea/

interface

type

tPoint = record
    X:double;
    Y:double;
end;

function PolygonArea(N:integer;Points:Array of tPoint): double;

function PolygonCentroid(N:integer;Points:Array of tPoint;area:double): tPoint;


implementation

function PolygonArea(N:integer;Points:Array of tPoint): double;
var
  i,j:integer;
  area:double;
begin
  area:=0;
  For i:= 0 to N-1 do
  begin
    j:=(i + 1) mod N;
    area := area + Points[i].X * Points[j].Y - Points[j].X * Points[i].Y;
  end;
  PolygonArea := area / 2;
end;

function PolygonCentroid(N:integer;Points:Array of tPoint;area:double): tPoint;
var
  i,j:integer;
  C:tPoint;
  P:double;
begin
    C.X := 0;
    C.Y := 0;
    For i := 0 to N-1 do
    begin
         j:=(i + 1) mod N;
         P:= Points[i].X * Points[j].Y - Points[j].X * Points[i].Y;
         C.X := C.X + (Points[i].X + Points[j].X) * P;
         C.Y := C.Y + (Points[i].Y + Points[j].Y) * P;
    end;
    C.X := C.X / (6 * area);
    C.Y := C.Y / (6 * area);
    PolygonCentroid := C;
end;

end.
