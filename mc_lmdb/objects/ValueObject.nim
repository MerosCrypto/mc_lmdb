type
    #C struct.
    CValue* {.header: "lmdb.h", importc: "MDB_val".} = object
        mv_size*: cuint
        mv_data*: pointer

    #Pointer.
    Value* = ptr CValue
