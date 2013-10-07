Attribute VB_Name = "A"
Option Explicit

Function Func1() As Boolean
    gFunc1 = True
End Function

Public Function Func2(ByVal a As Integer) As Boolean
    Func2 = True
End Function

Friend Function Func3() As Boolean

End Function

Private Function Func4() As Boolean

End Function

Sub S1()

End Sub

Private Sub S2()

End Sub

Public Sub S3()

End Sub

Public Property Get P1() As Boolean
End Property

Public Property Let P2(ByVal a As Boolean)
End Property
