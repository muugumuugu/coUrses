'
' VBA implementation of theory by Brandon Crosby 9-6-05 (in VBA using 2 dimensions)
'
' Based in part on C code by Damian Coventry Tuesday, 16 July 2002
'
' Theory by Paul Bourke
 
Public Function lineMagnitude(x1 As Double, y1 As Double, x2 As Double, y2 As Double) As Double
    lineMagnitude = Sqr((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
End Function
 
Public Function DistancePointLine(px As Double, py As Double, x1 As Double, y1 As Double, x2 As Double, y2 As Double) As Double
    ' px,py is the point to test.
    ' x1,y1,x2,y2 is the line to check distance.
    '
    ' Returns distance from the line, or if the intersecting point on the line nearest
    ' the point tested is outside the endpoints of the line, the distance to the
    ' nearest endpoint.
    '
    ' Returns 9999 on 0 denominator conditions.
    Dim LineMag As Double, u As Double
    Dim ix As Double, iy As Double ' intersecting point
   
    LineMag = lineMagnitude(x1, y1, x2, y2)
    If LineMag < 0.00000001 Then DistancePointLine = 9999: Exit Function
   
    u = (((px - x1) * (x2 - x1)) + ((py - y1) * (y2 - y1)))
    u = u / (LineMag * LineMag)
    If u < 0.00001 Or u > 1 Then
        '// closest point does not fall within the line segment, take the shorter distance
        '// to an endpoint
        ix = lineMagnitude(px, py, x1, y1)
        iy = lineMagnitude(px, py, x2, y2)
        If ix > iy Then DistancePointLine = iy Else DistancePointLine = ix
    Else
        ' Intersecting point is on the line, use the formula
        ix = x1 + u * (x2 - x1)
        iy = y1 + u * (y2 - y1)
        DistancePointLine = lineMagnitude(px, py, ix, iy)
    End If
End Function
 
Private Sub testLinePointDistance()
    ' testing to immediate window
    Debug.Print "Distance from 5,5 to (10,10)-(20,20): " & DistancePointLine(5, 5, 10, 10, 20, 20)
    Debug.Print "Distance from 15,15 to (10,10)-(20,20): " & DistancePointLine(15, 15, 10, 10, 20, 20)
    Debug.Print "Distance from 15,15 to (20,10)-(20,20): " & DistancePointLine(15, 15, 20, 10, 20, 20)
    Debug.Print "Distance from 0,15 to (20,10)-(20,20): " & DistancePointLine(0, 15, 20, 10, 20, 20)
    Debug.Print "Distance from 0,25 to (20,10)-(20,20): " & DistancePointLine(0, 25, 20, 10, 20, 20)
    Debug.Print "Distance from -13,-25 to (-50,10)-(20,20): " & DistancePointLine(-13, -25, -50, 10, 20, 20)
 
    'Results:
    'Distance from 5,5 to (10,10)-(20,20): 7.07106781186548
    'Distance from 15,15 to (10,10)-(20,20): 0
    'Distance from 15,15 to (20,10)-(20,20): 5
    'Distance from 0,15 to (20,10)-(20,20): 20
    'Distance from 0,25 to (20,10)-(20,20): 20.6155281280883
    'Distance from -13,-25 to (-50,10)-(20,20): 39.8808224589213
End Sub

