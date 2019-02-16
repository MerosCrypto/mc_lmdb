import Environment

{.push header: "lmdb.h".}
type Transaction* {.importc: "MDB_txn".} = object

proc c_mdb_txn_begin(
    env: ptr Environment,
    parent: ptr Transaction,
    flags: cuint,
    ret: ptr ptr Transaction
): cint {.importc: "mdb_txn_begin".}

proc c_mdb_txn_commit(
    tx: ptr Transaction
): cint {.importc: "mdb_txn_commit".}

proc c_mdb_txn_abort(
    tx: ptr Transaction
) {.importc: "mdb_txn_abort".}
{.pop.}
