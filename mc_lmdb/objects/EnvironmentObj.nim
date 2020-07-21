type
  CEnvironment* {.header: "lmdb.h", importc: "MDB_env", incompleteStruct.} = object
  Environment* = ptr CEnvironment

  Mode* = uint16

  EnvironmentFlags* {.pure.} = enum
    None        = 0x0
    FixedMap    = 0x1
    NoSubDir    = 0x4000
    NoSync      = 0x10000
    ReadOnly    = 0x20000
    NoMetaSync  = 0x40000
    WriteMap    = 0x80000
    MapAsync    = 0x100000
    NoTLS       = 0x200000
    NoLock      = 0x400000
    NoReadAhead = 0x800000
    NoMemInit   = 0x1000000

proc `or`*(
  lhs: EnvironmentFlags,
  rhs: EnvironmentFlags
): EnvironmentFlags =
  EnvironmentFlags(uint(lhs) or uint(rhs))
