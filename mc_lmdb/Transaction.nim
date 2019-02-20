import Environment

type
    CTransaction {.header: "lmdb.h", importc: "MDB_txn".} = object
    Transaction* = ptr CTransaction

{.push header: "lmdb.h".}
proc c_mdb_txn_begin(
    env: Environment,
    parent: Transaction,
    flags: cuint,
    ret: ptr Transaction
): cint {.importc: "mdb_txn_begin".}

proc c_mdb_txn_commit(
    tx: Transaction
): cint {.importc: "mdb_txn_commit".}

proc c_mdb_txn_abort(
    tx: Transaction
) {.importc: "mdb_txn_abort".}
{.pop.}

proc newTransaction(): Transaction =
    discard
