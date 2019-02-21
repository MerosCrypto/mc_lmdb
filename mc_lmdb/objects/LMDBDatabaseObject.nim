type
    #Database 'object' (it's a primitive but still has a typedef...).
    Database* = cuint

    #Databse Flags.
    DatabaseFlags* = enum
        ReverseKey = 0x02
        DupSort    = 0x04
        IntegerKey = 0x08
        DupFixed   = 0x10
        IntegerDup = 0x20
        ReverseDup = 0x40
        Create     = 0x40000

    #Put Flags.
    PutFlags* = enum
        NoOverwrite = 0x10
        NoDupData   = 0x20
        Reserve     = 0x10000
        Append      = 0x20000
        AppendDup   = 0x40000

proc `or`*(lhs: DatabaseFlags, rhs: DatabaseFlags): uint =
    uint(lhs) or uint(rhs)

proc `or`*(lhs: uint, rhs: DatabaseFlags): uint =
    lhs or uint(rhs)

proc `or`*(lhs: PutFlags, rhs: PutFlags): uint =
    uint(lhs) or uint(rhs)

proc `or`*(lhs: uint, rhs: PutFlags): uint =
    lhs or uint(rhs)
