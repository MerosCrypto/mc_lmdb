#Opens and closes a Database.

#LMDB lib.
import ../mc_lmdb

#Open a DB.
var lmdb: LMDB = newLMDB("./test0")
#Close it.
lmdb.close()
