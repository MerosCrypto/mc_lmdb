type
  Database* = cuint

  DatabaseFlags* {.pure.} = enum
    None       = 0x00
    ReverseKey = 0x02
    DupSort    = 0x04
    IntegerKey = 0x08
    DupFixed   = 0x10
    IntegerDup = 0x20
    ReverseDup = 0x40
    Create     = 0x40000

  PutFlags* {.pure.} = enum
    None        = 0x00
    NoOverwrite = 0x10
    NoDupData   = 0x20
    Reserve     = 0x10000
    Append      = 0x20000
    AppendDup   = 0x40000

proc `or`*(
  lhs: DatabaseFlags,
  rhs: DatabaseFlags
): DatabaseFlags =
  DatabaseFlags(uint(lhs) or uint(rhs))

proc `or`*(
  lhs: PutFlags,
  rhs: PutFlags
): PutFlags =
  PutFlags(uint(lhs) or uint(rhs))
