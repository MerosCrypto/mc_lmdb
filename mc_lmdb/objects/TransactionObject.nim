type
    #C struct.
    CTransaction* {.header: "lmdb.h", importc: "MDB_txn".} = object

    #Pointer.
    Transaction* = ptr CTransaction
