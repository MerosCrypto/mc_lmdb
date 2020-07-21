type LMDBError* = object of CatchableError

proc c_mdb_strerror(
  code: cint
): cstring {.header: "lmdb.h", importc: "mdb_strerror".}

proc check*(
  code: cint
) =
  if code != 0:
    raise newException(LMDBError, $c_mdb_strerror(code))
