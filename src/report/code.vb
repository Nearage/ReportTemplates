Private Dim Rows As Integer = 0
Private Dim PerPage As Integer = 0

Public Function Init(ByVal Rows As Integer, ByVal PerPage As Integer) As Boolean
    Me.Rows = Rows
    Me.PerPage = PerPage
End Function

Public Function Header(ByVal Row As Integer) As Boolean
    Return (Row Mod Me.Rows) <> 1
End Function

Public Function Footer(ByVal Row As Integer) As Boolean
    Return (Row Mod Me.PerPage) <> 0
End Function