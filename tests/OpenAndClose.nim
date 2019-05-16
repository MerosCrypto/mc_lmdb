#Opens and closes a Database.

#LMDB lib.
import ../mc_lmdb

#Open a DB.
var lmdb: LMDB = newLMDB("./db/test0", 1024000)
#Close it.
lmdb.close()
