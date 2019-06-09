#Opens and works with multiple DBs.

#LMDB lib.
import ../mc_lmdb

#Open a DB.
var first: LMDB = newLMDB("./db/MultipleDB", 1024000, 2)
first.open("1")
#Put in a value.
first.put("1", "key", "val")

#Open a second DB.
first.open("2")
#Put in a value.
first.put("2", "key2", "val2")

#Close the environment.
first.close()

#Reopen the DBs.
var second: LMDB = newLMDB("./db/MultipleDB", 1024000, 2)
second.open("1")
second.open("2")
#Test the values.
if second.get("1", "key") != "val":
    raise newException(LMDBError, "Put \"val\" but got \"" & second.get("", "key") & "\".")
if second.get("2", "key2") != "val2":
    raise newException(LMDBError, "Put \"val\" but got \"" & second.get("", "key") & "\".")
#Close it.
second.close()
