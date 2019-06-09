#Closes and reopens a DB.

#LMDB lib.
import ../mc_lmdb

#Open a DB.
var first: LMDB = newLMDB("./db/CloseAndReopen", 1024000)
first.open("")
#Put in a value.
first.put("", "key", "val")
#Close it.
first.close()

#Reopen the DB.
var second: LMDB = newLMDB("./db/CloseAndReopen", 1024000)
second.open("")
#Get the value.
if second.get("", "key") != "val":
    raise newException(LMDBError, "Put \"val\" but got \"" & second.get("", "key") & "\".")
#Close it.
second.close()
