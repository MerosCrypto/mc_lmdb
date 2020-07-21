import tables

import objects/DatabaseObj
import objects/LMDBObj
export DatabaseObj

import LMDBError
import Environment
import Transaction

{.push header: "lmdb.h".}
type Value* {.importc: "MDB_val".} = object
  mv_size: cuint
  mv_data: pointer

proc c_mdb_open(
  tx: Transaction,
  name: ptr char,
  flags: cuint,
  db: ptr Database
): cint {.importc: "mdb_dbi_open".}

proc c_mdb_put(
  tx: Transaction,
  db: Database,
  key: ptr Value,
  val: ptr Value,
  flags: cuint
): cint {.importc: "mdb_put".}

proc c_mdb_get(
  tx: Transaction,
  db: Database,
  key: ptr Value,
  val: ptr Value
): cint {.importc: "mdb_get".}

proc c_mdb_del(
  tx: Transaction,
  db: Database,
  key: ptr Value,
  val: ptr Value
): cint {.importc: "mdb_del".}

proc c_mdb_close(
  env: Environment,
  db: Database
) {.importc: "mdb_dbi_close".}
{.pop.}

proc newValue*(
  val: string = ""
): Value =
  if val.len > 0:
    result.mv_size = cuint(val.len)
    result.mv_data = cast[ptr char](alloc0(val.len))
    copyMem(result.mv_data, unsafeAddr val[0], val.len)

converter toString*(
  val: Value
): string =
  if val.mv_size == 0:
    return ""
  result = newString(val.mv_size)
  copyMem(addr result[0], val.mv_data, result.len)

proc newDatabase*(
  lmdb: LMDB,
  name: string,
  flags: DatabaseFlags = DatabaseFlags.Create
) =
  var name: string = name

  var tx: Transaction
  c_mdb_txn_begin(
    lmdb.env,
    nil,
    cuint(TransactionFlags.None),
    addr tx
  ).check()

  var db: Database
  c_mdb_open(
    tx,
    if name.len == 0: nil else: (addr name[0]),
    cuint(flags),
    addr db
  ).check()
  lmdb.dbs[name] = db

  tx.commit()

proc put*(
  lmdb: LMDB,
  tx: Transaction,
  name: string,
  key: string,
  val: string,
  flags: PutFlags = PutFlags.None
) =
  var
    keyVal: Value = newValue(key)
    valVal: Value = newValue(val)
  c_mdb_put(tx, lmdb.dbs[name], addr keyVal, addr valVal, cuint(flags)).check()

proc delete*(
  lmdb: LMDB,
  tx: Transaction,
  name: string,
  key: string
) =
  var keyVal: Value = newValue(key)
  c_mdb_del(tx, lmdb.dbs[name], addr keyVal, nil).check()

proc get*(
  lmdb: LMDB,
  name: string,
  key: string
): string =
  var
    tx: Transaction = lmdb.newTransaction(TransactionFlags.ReadOnly)
    key: Value = newValue(key)
    val: Value = newValue()

  var err: cint = c_mdb_get(tx, lmdb.dbs[name], addr key, addr val)
  tx.commit()
  err.check()

  result = val

proc close*(
  lmdb: LMDB
) =
  for key in lmdb.dbs.keys():
    c_mdb_close(lmdb.env, lmdb.dbs[key])
