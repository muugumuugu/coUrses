Attribute VB_Name = "Module1"
Option Explicit

'*****************************************************
' Purpose:  tests if a line intersects through a
'           sphere and returns the points
'*****************************************************

'***FULL CREDIT TO PAUL BOURKE AND IEBELE ABEL FOR THIS SOLUTION***

Public Function CheckLineIntersectSphere(p1 As D3DVECTOR, p2 As D3DVECTOR, pSphere As D3DVECTOR, R As Single, I1 As D3DVECTOR, I2 As D3DVECTOR) As Integer
  
  Dim a As Single
  Dim b As Single
  Dim c As Single
  
  Dim D As Single
  Dim Sq As Single
  Dim A2 As Single
  Dim mu As Single
  
  Dim L As D3DVECTOR
  Dim vRel As D3DVECTOR
  
  'calculate vectors
  dx3d.VectorSubtract L, p2, p1
  dx3d.VectorSubtract vRel, p1, pSphere
  
  'set up quadratic equation
  a = (L.X * L.X) + (L.Y * L.Y) + (L.z * L.z)
  b = 2 * ((L.X * vRel.X) + (L.Y * vRel.Y) + (L.z * vRel.z))
  c = (pSphere.X * pSphere.X) + (pSphere.Y * pSphere.Y) + (pSphere.z * pSphere.z) + _
      (p1.X * p1.X) + (p1.Y * p1.Y) + (p1.z * p1.z) - _
      (2 * ((pSphere.X * p1.X) + (pSphere.Y * p1.Y) + (pSphere.z * p1.z))) - _
      (R * R)
  
  'calculate discriminant
  D = (b * b) - (4 * a * c)
  If D < 0 Or a = 0 Then
    'no intersection
    CheckLineIntersectSphere = 0
    
    'return null vectors
    I1 = MakeVector(0, 0, 0)
    I2 = MakeVector(0, 0, 0)
      
  'determine number of solutions
  ElseIf D = 0 Then
    'one intersection
    CheckLineIntersectSphere = 1
    
    'calculate intersect point
    mu = -b / (2 * a)
    I1.X = p1.X + (mu * L.X)
    I1.Y = p1.Y + (mu * L.Y)
    I1.z = p1.z + (mu * L.z)
    
    'return same value for second point
    I2 = I1
    
  Else
    'two intersections
    CheckLineIntersectSphere = 2
    
    'pre-calculate some values
    Sq = Sqr(D): A2 = 2 * a
    
    'calculate first intersect point
    mu = (-b + Sq) / A2
    I1.X = p1.X + (mu * L.X)
    I1.Y = p1.Y + (mu * L.Y)
    I1.z = p1.z + (mu * L.z)
    
    'calculate second intersect point
    mu = (-b - Sq) / A2
    I2.X = p1.X + (mu * L.X)
    I2.Y = p1.Y + (mu * L.Y)
    I2.z = p1.z + (mu * L.z)
  End If

End Function

'*****************************************************
' Purpose:  tests if a line intersects through a
'           ellipse and returns the points
'*****************************************************

Public Function CheckLineIntersectEllipse(p1 As D3DVECTOR, p2 As D3DVECTOR, pEllipse As D3DVECTOR, MajR As Single, MinR As Single, vRot As D3DVECTOR, I1 As D3DVECTOR, I2 As D3DVECTOR) As Integer
  
  Dim I As Integer
  Dim Sx As Single
  
  Dim pT1 As D3DVECTOR
  Dim pT2 As D3DVECTOR
  Dim MatRot As D3DMATRIX
  
  'calculate relative vectors
  Sx = MinR / MajR
  dx3d.VectorSubtract pT1, p1, pEllipse
  dx3d.VectorSubtract pT2, p2, pEllipse

  'create reversed rotation matrix
  MatRot = D3DReverseRotationMatrix(1, 1, 1, -vRot.X, -vRot.Y, -vRot.z, 0, 0, 0)
  
  'get transformed line points so can consider ellipse as sphere
  pT1 = D3DRotateVectorByMatrix(pT1, MatRot)
  pT2 = D3DRotateVectorByMatrix(pT2, MatRot)
  
  'scale z-axis to create sphere
  pT1.z = pT1.z * Sx
  pT2.z = pT2.z * Sx
  
  'check for intersection with relative sphere
  I = CheckLineIntersectSphere(pT1, pT2, MakeVector(0, 0, 0), MinR, I1, I2)
  
  'create correction matrix
  MatRot = D3DCreateRotationMatrix(1, 1, 1 / Sx, vRot.X, vRot.Y, vRot.z, _
    pEllipse.X, pEllipse.Y, pEllipse.z, 0, 0, 0)
  
  'correct points to change sphere intersect to ellipse
  I1 = D3DRotateVectorByMatrix(I1, MatRot)
  I2 = D3DRotateVectorByMatrix(I2, MatRot)
  
End Function

'*****************************************************
' Purpose:  creates a complete 3D rotation matrix
'*****************************************************

Public Function D3DCreateRotationMatrix(Sx!, Sy!, Sz!, Rx!, Ry!, Rz!, Tx!, Ty!, Tz!, Dx!, dy!, Dz!) As D3DMATRIX

  Dim matT As D3DMATRIX
  Dim matInvT As D3DMATRIX
  
  Dim MatRot As D3DMATRIX
  Dim matTemp As D3DMATRIX
   
  '==========================================================================
  ' Tranformations must be applied in order else strange results occur
  '  1) Scale
  '  2) Rotation (usually Z,X,Y)
  '  3) Translation
  '  4) Affine transformation for differential centre of rotation
  '==========================================================================
        
  'create identity matrix
  dx3d.IdentityMatrix MatRot
        
  'scale the object in model space
  MatRot.rc11 = Sx!
  MatRot.rc22 = Sy!
  MatRot.rc33 = Sz!
        
  'Rotate around Z-axis  (Roll)
  If Rz! <> 0 Then
    dx3d.RotateZMatrix matTemp, Rz! * Rad             'Rotate Z matrix
    dx3d.MatrixMultiply MatRot, MatRot, matTemp       'Multiply matrices together
  End If
        
  'Rotate around X-axis  (Pitch)
  If Rx! <> 0 Then
    dx3d.RotateXMatrix matTemp, Rx! * Rad             'Rotate X matrix
    dx3d.MatrixMultiply MatRot, MatRot, matTemp       'Multiply matrices together
  End If
        
  'Rotate around Y-axis  (Yaw)
  If Ry! <> 0 Then
    dx3d.RotateYMatrix matTemp, Ry! * Rad             'Rotate Y matrix
    dx3d.MatrixMultiply MatRot, MatRot, matTemp       'Multiply matrices together
  End If
  
  'Translate object into world space
  MatRot.rc41 = Tx!
  MatRot.rc42 = Ty!
  MatRot.rc43 = Tz!
  
  'check if shifting centre of rotation
  If Dx! <> 0 Or dy! <> 0 Or Dz! = 0 Then
    dx3d.IdentityMatrix matT
    matInvT = matT
    
    'translation matrix
    matT.rc41 = Dx!
    matT.rc42 = dy!
    matT.rc43 = Dz!
    
    'Inverse translation matrix
    matInvT.rc41 = -Dx!
    matInvT.rc42 = -dy!
    matInvT.rc43 = -Dz!

    'Affine transformation
    dx3d.MatrixMultiply MatRot, matT, MatRot
    dx3d.MatrixMultiply MatRot, MatRot, matInvT
  End If
  
  'return created rotation matrix
  D3DCreateRotationMatrix = MatRot
  
End Function

'*****************************************************
' Purpose:  creates a reversed 3D rotation matrix
'*****************************************************

Public Function D3DReverseRotationMatrix(Sx!, Sy!, Sz!, Rx!, Ry!, Rz!, Tx!, Ty!, Tz!) As D3DMATRIX
  
  Dim matT As D3DMATRIX
  Dim matInvT As D3DMATRIX
  
  Dim MatRot As D3DMATRIX
  Dim matTemp As D3DMATRIX
   
  '==========================================================================
  ' Tranformations must be applied in reversed order for working back
  ' Y-axis rotation (yaw)
  ' X-axis rotation (pitch)
  ' Z-axis rotation (roll)
  '==========================================================================
        
  'create identity matrix
  dx3d.IdentityMatrix MatRot
  
  'create scaling matrix
  MatRot.rc11 = Sx!
  MatRot.rc22 = Sy!
  MatRot.rc33 = Sz!
        
  'Rotate around Y-axis  (Yaw)
  If Ry! <> 0 Then
    dx3d.RotateYMatrix matTemp, Ry! * Rad             'Rotate Y matrix
    dx3d.MatrixMultiply MatRot, MatRot, matTemp       'Multiply matrices together
  End If
        
  'Rotate around X-axis  (Pitch)
  If Rx! <> 0 Then
    dx3d.RotateXMatrix matTemp, Rx! * Rad             'Rotate X matrix
    dx3d.MatrixMultiply MatRot, MatRot, matTemp       'Multiply matrices together
  End If
  
  'Rotate around Z-axis  (Roll)
  If Rz! <> 0 Then
    dx3d.RotateZMatrix matTemp, Rz! * Rad             'Rotate Z matrix
    dx3d.MatrixMultiply MatRot, MatRot, matTemp       'Multiply matrices together
  End If
  
  'create translation matrix
  MatRot.rc41 = Tx!
  MatRot.rc42 = Ty!
  MatRot.rc43 = Tz!
  
  'return reversed rotation matrix
  D3DReverseRotationMatrix = MatRot
  
End Function

'*****************************************************
' Purpose:  rotates a vector by a matrix
'*****************************************************

Public Function D3DRotateVectorByMatrix(V As D3DVECTOR, Mat As D3DMATRIX) As D3DVECTOR
      
  D3DRotateVectorByMatrix.X = (V.X * Mat.rc11) + (V.Y * Mat.rc21) + (V.z * Mat.rc31) + Mat.rc41
  D3DRotateVectorByMatrix.Y = (V.X * Mat.rc12) + (V.Y * Mat.rc22) + (V.z * Mat.rc32) + Mat.rc42
  D3DRotateVectorByMatrix.z = (V.X * Mat.rc13) + (V.Y * Mat.rc23) + (V.z * Mat.rc33) + Mat.rc43
  
End Function


