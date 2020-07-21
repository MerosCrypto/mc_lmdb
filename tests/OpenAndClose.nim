#Opens and closes a Database.

import ../mc_lmdb

var lmdb: LMDB = newLMDB("./db/OpenAndClose", 1024000)
lmdb.close()
