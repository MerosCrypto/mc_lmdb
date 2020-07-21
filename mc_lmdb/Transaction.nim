import LMDBError

import objects/LMDBObj
import Environment

type
  Transaction* {.header: "lmdb.h", importc: "MDB_txn*".} = ptr object

  TransactionFlags* {.pure.} = enum
    None     = 0x00
    ReadOnly = 0x20000

proc `or`*(
  lhs: TransactionFlags,
  rhs: TransactionFlags
): TransactionFlags =
  TransactionFlags(uint(lhs) or uint(rhs))

{.push header: "lmdb.h".}
proc c_mdb_txn_begin*(
  env: Environment,
  parent: Transaction,
  flags: cuint,
  ret: ptr Transaction
): cint {.importc: "mdb_txn_begin".}

proc c_mdb_txn_commit(
  tx: Transaction
): cint {.importc: "mdb_txn_commit".}
{.pop.}

proc newTransaction*(
  lmdb: LMDB,
  flags: TransactionFlags = TransactionFlags.None
): Transaction {.inline.} =
  c_mdb_txn_begin(
    lmdb.env,
    nil,
    cuint(flags),
    addr result
  ).check()

proc commit*(
  tx: Transaction
) {.inline.} =
  c_mdb_txn_commit(tx).check()
