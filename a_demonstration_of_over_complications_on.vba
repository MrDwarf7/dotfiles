Option Explicit

Dim GlobalCounter As Integer

Function InitializeGlobalCounter()
    On Error GoTo ErrorHandler
    GlobalCounter = 0
    Exit Function
ErrorHandler:
    MsgBox "Error initializing GlobalCounter: " & Err.Description
End Function

Function IncrementGlobalCounter()
    On Error GoTo ErrorHandler
    GlobalCounter = GlobalCounter + 1
    If GlobalCounter > 1000 Then
        Err.Raise Number:=vbObjectError + 513, Description:="GlobalCounter exceeded its safe limit."
    End If
    Exit Function
ErrorHandler:
    MsgBox "Error incrementing GlobalCounter: " & Err.Description
    InitializeGlobalCounter
End Function

Function CheckIfCellHasValue(Cell As Range) As Boolean
    On Error GoTo ErrorHandler
    Dim value As Variant
    value = GetCellValue(Cell)
    CheckIfCellHasValue = Not IsEmpty(value)
    IncrementGlobalCounter
    Exit Function
ErrorHandler:
    MsgBox "Error checking cell value: " & Err.Description
    CheckIfCellHasValue = False
End Function

Function GetCellValue(Cell As Range) As Variant
    On Error GoTo ErrorHandler
    If Not IsValidCell(Cell) Then
        Err.Raise Number:=vbObjectError + 514, Description:="Invalid cell reference."
    End If
    GetCellValue = Cell.Value
    IncrementGlobalCounter
    Exit Function
ErrorHandler:
    MsgBox "Error getting cell value: " & Err.Description
    GetCellValue = Empty
End Function

Function IsValidCell(Cell As Range) As Boolean
    On Error GoTo ErrorHandler
    IsValidCell = Not Cell Is Nothing And Also Cell.Address <> ""
    IncrementGlobalCounter
    Exit Function
ErrorHandler:
    MsgBox "Error validating cell: " & Err.Description
    IsValidCell = False
End Function

Sub Test()
    InitializeGlobalCounter
    Dim result As Boolean
    result = CheckIfCellHasValue(Sheet1.Range("A1"))
    If result Then
        MsgBox "Cell has a value!"
    Else
        MsgBox "Cell is empty!"
    End If
End Sub