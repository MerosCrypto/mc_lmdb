#Opens and works with multiple DBs.

import ../mc_lmdb

var first: LMDB = newLMDB("./db/MultipleDB", 1024000, 2)
first.open("1")
first.open("2")
var tx: Transaction = first.newTransaction()
first.put(tx, "1", "key", "val")
first.put(tx, "2", "key2", "val2")
tx.commit()
first.close()

var second: LMDB = newLMDB("./db/MultipleDB", 1024000, 2)
second.open("1")
second.open("2")
if second.get("1", "key") != "val":
  raise newException(LMDBError, "Put \"val\" but got \"" & second.get("", "key") & "\".")
if second.get("2", "key2") != "val2":
  raise newException(LMDBError, "Put \"val\" but got \"" & second.get("", "key") & "\".")
second.close()
