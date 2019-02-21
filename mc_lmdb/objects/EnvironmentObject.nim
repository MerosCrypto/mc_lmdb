type
    #C struct.
    CEnvironment {.header: "lmdb.h", importc: "MDB_env".} = object

    #Pointer.
    Environment* = ptr CEnvironment
