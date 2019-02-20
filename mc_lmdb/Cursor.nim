import Value
import Transaction
import Database

type
    CCursor {.header: "lmdb.h", importc: "MDB_cursor".} = object
    Cursor* = ptr CCursor

    CursorOperation = enum
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

{.push header: "lmdb.h".}
proc c_mdb_cursor_open(
    tx: Transaction,
    db: Database,
    ret: ptr Cursor
): cint {.importc: "mdb_cursor_open".}

proc c_mdb_cursor_get(
    cursor: Cursor,
    key: Value,
    data: Value,
    op: CursorOperation
): cint {.importc: "mdb_cursor_get".}

proc c_mdb_cursor_put(
    cursor: Cursor,
    key: Value,
    data: Value,
    flags: cuint
): cint {.importc: "mdb_cursor_put".}

proc c_mdb_cursor_del(
    cursor: Cursor,
    flags: cuint
): cint {.importc: "mdb_cursor_del".}

proc c_mdb_cursor_close(
    cursor: Cursor
) {.importc: "mdb_cursor_close".}
