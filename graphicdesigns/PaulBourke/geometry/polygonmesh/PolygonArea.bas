Attribute VB_Name = "Module1"
'Author: Rodrigo Alves Pons
'email: rodpons@ig.com.br
'webpage: www.geocities.com/rodrigo_alves_pons/
'Version: 2007-01-05
'functions to calculate the area and centroid of a polygon,
'according to the algorithm defined at:
'http://local.wasp.uwa.edu.au/~pbourke/geometry/polyarea/

Option Explicit

Type tPoint
    X As Double
    Y As Double
End Type

Function PolygonArea(N As Integer, Points() As tPoint) As Double
    Dim i As Integer, j As Integer
    Dim area As Double
    area = 0
    For i = 0 To N - 1
        j = (i + 1) Mod N
        area = area + Points(i).X * Points(j).Y - Points(j).X * Points(i).Y
    Next i
    PolygonArea = area / 2
End Function

Function PolygonCentroid(N As Integer, Points() As tPoint, area As Double) As tPoint
    Dim i As Integer, j As Integer
    Dim C As tPoint
    Dim P As Double
    
    C.X = 0
    C.Y = 0
    For i = 0 To N - 1
        j = (i + 1) Mod N
        P = Points(i).X * Points(j).Y - Points(j).X * Points(i).Y
        C.X = C.X + (Points(i).X + Points(j).X) * P
        C.Y = C.Y + (Points(i).Y + Points(j).Y) * P
    Next i
    C.X = C.X / (6 * area)
    C.Y = C.Y / (6 * area)
    PolygonCentroid = C
End Function
