type
    #C struct.
    CCursor {.header: "lmdb.h", importc: "MDB_cursor".} = object

    #Pointer.
    Cursor* = ptr CCursor

    #Enum of operations.
    CursorOperation* = enum
        First
        FirstDup
        GetBoth
        GetBothRange
        GetCurrent
        GetMultiple
        Last
        LastDup
        Next
        NextDup
        NextMultiple
        NextNoDup
        Prev
        PrevDup
        PrevNoDup
        Set
        SetKey
        SetRange
