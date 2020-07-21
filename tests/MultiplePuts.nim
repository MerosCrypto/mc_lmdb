#Put multiple values with a single TX.

import ../mc_lmdb

var lmdb: LMDB = newLMDB("./db/MultiplePuts", 1024000)
lmdb.open("")

var tx: Transaction = lmdb.newTransaction()
lmdb.put(tx, "", "key1", "val1")
lmdb.put(tx, "", "key2", "val2")
lmdb.put(tx, "", "key3", "val3")
tx.commit()

if lmdb.get("", "key1") != "val1":
  raise newException(LMDBError, "Put \"val1\" but got \"" & lmdb.get("", "key1") & "\".")
if lmdb.get("", "key2") != "val2":
  raise newException(LMDBError, "Put \"val2\" but got \"" & lmdb.get("", "key2") & "\".")
if lmdb.get("", "key3") != "val3":
  raise newException(LMDBError, "Put \"val3\" but got \"" & lmdb.get("", "key3") & "\".")

lmdb.close()
