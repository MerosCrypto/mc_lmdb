#Puts in an Entry, Gets the Entry, and then Deletes the Entry.

#LMDB lib.
import ../mc_lmdb

#Open a DB.
var lmdb: LMDB = newLMDB("./db/test1", 1024000)

#Put in a value.
lmdb.put("key", "val")
#Get the value back.
if lmdb.get("key") != "val":
    raise newException(LMDBError, "Put \"val\" but got \"" & lmdb.get("key") & "\".")

#Delete the value.
lmdb.delete("key")

#Make sure getting the value throws.
var threw: bool = false
try:
    discard lmdb.get("key")
except LMDBError:
    threw = true
if not threw:
    raise newException(LMDBError, "Retreiving a supposedly deleted value didn't throw.")

#Close it.
lmdb.close()
