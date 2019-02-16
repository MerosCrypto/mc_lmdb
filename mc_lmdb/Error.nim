proc c_mdb_strerror(code: cint): cstring {.header: "lmdb.h", importc: "mdb_strerror".}
