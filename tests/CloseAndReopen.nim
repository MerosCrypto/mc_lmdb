#Closes and reopens a DB.

#LMDB lib.
import ../mc_lmdb

#Open a DB.
var first: LMDB = newLMDB("./db/test2")
#Put in a value.
first.put("key", "val")
#Close it.
first.close()

#Reopen the DB.
var second: LMDB = newLMDB("./db/test2")
#Get the value.
if second.get("key") != "val":
    raise newException(LMDBError, "Put \"val\" but got \"" & second.get("key") & "\".")
#Close it.
second.close()
