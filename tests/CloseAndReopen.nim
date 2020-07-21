#Closes and reopens a DB.

import ../mc_lmdb

var first: LMDB = newLMDB("./db/CloseAndReopen", 1024000)
first.open("")
var tx: Transaction = first.newTransaction()
first.put(tx, "", "key", "val")
tx.commit()
first.close()

var second: LMDB = newLMDB("./db/CloseAndReopen", 1024000)
second.open("")
if second.get("", "key") != "val":
  raise newException(LMDBError, "Put \"val\" but got \"" & second.get("", "key") & "\".")
second.close()
