#LMDB Exception.
type LMDBError = object of Exception

#C proc to convert an error code to a string.
proc c_mdb_strerror(code: cint): cstring {.header: "lmdb.h", importc: "mdb_strerror".}

#Nim converter to run an error code into an Exception.
converter toError*(code: cint): ref LMDBError =
    newException(LMDBError, $c_mdb_strerror(code))
