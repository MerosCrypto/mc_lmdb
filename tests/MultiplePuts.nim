#Put multiple values with a single TX.

#LMDB lib.
import ../mc_lmdb

#Open a DB.
var lmdb: LMDB = newLMDB("./db/MultiplePuts", 1024000)
lmdb.open("")

#Put in the values.
lmdb.put(
    "",
    @[
        (key: "key1", value: "val1"),
        (key: "key2", value: "val2"),
        (key: "key3", value: "val3")
    ]
)

#Get the values back.
if lmdb.get("", "key1") != "val1":
    raise newException(LMDBError, "Put \"val1\" but got \"" & lmdb.get("", "key1") & "\".")
if lmdb.get("", "key2") != "val2":
    raise newException(LMDBError, "Put \"val2\" but got \"" & lmdb.get("", "key2") & "\".")
if lmdb.get("", "key3") != "val3":
    raise newException(LMDBError, "Put \"val3\" but got \"" & lmdb.get("", "key3") & "\".")

#Close it.
lmdb.close()
