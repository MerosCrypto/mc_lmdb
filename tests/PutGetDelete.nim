import ../mc_lmdb

var lmdb: LMDB = newLMDB("./db/PutGetDelete", 1024000)
lmdb.open("")

var tx: Transaction = lmdb.newTransaction()
lmdb.put(tx, "", "key", "val")
tx.commit()

if lmdb.get("", "key") != "val":
  raise newException(LMDBError, "Put \"val\" but got \"" & lmdb.get("", "key") & "\".")

tx = lmdb.newTransaction()
lmdb.delete(tx, "", "key")
tx.commit()

var threw: bool = false
try:
  discard lmdb.get("", "key")
except LMDBError:
  threw = true
if not threw:
  raise newException(LMDBError, "Retreiving a supposedly deleted value didn't throw.")

lmdb.close()
