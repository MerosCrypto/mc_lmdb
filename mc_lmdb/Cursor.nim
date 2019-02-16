import Environment

import Value
import Transaction
import Database

type
    Cursor {.header: "lmdb.h", importc: "MDB_cursor".} = object

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
    tx: ptr Transaction,
    db: Database,
    ret: ptr ptr Cursor
): cint {.importc: "mdb_cursor_open".}

proc c_mdb_cursor_get(
    cursor: ptr Cursor,
    key: ptr Value,
    data: ptr Value,
    op: CursorOperation
): cint {.importc: "mdb_cursor_get".}

proc c_mdb_cursor_put(
    cursor: ptr Cursor,
    key: ptr Value,
    data: ptr Value,
    flags: cuint
): cint {.importc: "mdb_cursor_put".}

proc c_mdb_cursor_del(
    cursor: ptr Cursor,
    flags: cuint
): cint {.importc: "mdb_cursor_del".}

proc c_mdb_cursor_close(
    cursor: ptr Cursor
) {.importc: "mdb_cursor_close".}
