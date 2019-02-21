#LMDB Exception.
type LMDBError* = object of Exception

#C proc to convert an error code to a string.
proc c_mdb_strerror(code: cint): cstring {.header: "lmdb.h", importc: "mdb_strerror".}

#Checks an error code for an error; if one exists, raises it.
proc check*(code: cint) =
    if code != 0:
        raise newException(LMDBError, $c_mdb_strerror(code))
