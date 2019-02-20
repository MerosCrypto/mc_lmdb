type
    CValue {.header: "lmdb.h", importc: "MDB_val".} = object
    Value* = ptr CValue
