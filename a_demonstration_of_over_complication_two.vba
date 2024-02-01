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

Function RedundantCheck(Value As Variant) As Boolean
    On Error GoTo ErrorHandler
    ' Simulating a redundant check that's always true
    RedundantCheck = (2 - 1 + 1 = 2)
    If Not RedundantCheck Then
        Err.Raise Number:=vbObjectError + 515, Description:="Failed the redundant check."
    End If
    IncrementGlobalCounter
    Exit Function
ErrorHandler:
    MsgBox "Error in RedundantCheck: " & Err.Description
    RedundantCheck = False
End Function

Function CheckIfCellHasValue(Cell As Range) As Boolean
    On Error GoTo ErrorHandler
    Dim value As Variant
    value = GetCellValue(Cell)
    If Not RedundantCheck(value) Then
        Err.Raise Number:=vbObjectError + 516, Description:="Value failed the redundant check."
    End If
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

Function ValidateGlobalCounter()
    On Error GoTo ErrorHandler
    ' Another unnecessary function to validate the global counter for no real reason
    If GlobalCounter < 0 Then
        Err.Raise Number:=vbObjectError + 517, Description:="GlobalCounter is unexpectedly negative."
    End If
    Exit Function
ErrorHandler:
    MsgBox "Error validating GlobalCounter: " & Err.Description
End Function

Sub Test()
    InitializeGlobalCounter
    ValidateGlobalCounter
    Dim result As Boolean
    result = CheckIfCellHasValue(Sheet1.Range("A1"))
    If result Then
        MsgBox "Cell has a value!"
    Else
        MsgBox "Cell is empty!"
    End If
End Sub