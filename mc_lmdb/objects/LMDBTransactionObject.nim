type
    #C struct.
    CTransaction* {.header: "lmdb.h", importc: "MDB_txn".} = object

    #Pointer.
    Transaction* = ptr CTransaction

    #Flags.
    TransactionFlags* {.pure.} = enum
        None     = 0x00
        ReadOnly = 0x20000

proc `or`*(
    lhs: TransactionFlags,
    rhs: TransactionFlags
): TransactionFlags =
    TransactionFlags(uint(lhs) or uint(rhs))
