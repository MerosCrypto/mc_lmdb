type
    #C struct.
    CTransaction* {.header: "lmdb.h", importc: "MDB_txn".} = object

    #Pointer.
    Transaction* = ptr CTransaction

    #Flags.
    TransactionFlags* = enum
        ReadOnly = 0x20000

proc `or`*(lhs: TransactionFlags, rhs: TransactionFlags): uint =
    uint(lhs) or uint(rhs)

proc `or`*(lhs: uint, rhs: TransactionFlags): uint =
    lhs or uint(rhs)
