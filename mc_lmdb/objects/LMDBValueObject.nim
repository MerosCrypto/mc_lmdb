#C struct.
type Value* {.header: "lmdb.h", importc: "MDB_val".} = object
    mv_size*: cuint
    mv_data*: pointer
