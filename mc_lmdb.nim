const lmdbFolder = currentSourcePath().substr(0, currentSourcePath().len - 12) & "LMDB/libraries/liblmdb/"
{.passC: "-I " & lmdbFolder.}

when defined(Windows):
  {.passL: "advapi32.lib".}
  {.passL: lmdbFolder & "lmdb.lib".}
else:
  {.passL: lmdbFolder & "liblmdb.a".}

import mc_lmdb/LMDBError
export LMDBError.LMDBError

import mc_lmdb/objects/LMDBObj
export LMDBObj

import mc_lmdb/Environment
import mc_lmdb/Database
import mc_lmdb/Transaction
export EnvironmentFlags, Environment.`or`
export newDatabase, put, delete, get
export Transaction

#Opens an environment at the path, creating one if it doesn't already exist, with a max size of size.
proc newLMDB*(
  path: string,
  size: int64,
  quantity: int = 1,
  readers: int = 126
): LMDB =
  result = newLMDBObj(newEnvironment())
  result.env.setMaxDBs(quantity)
  result.env.setMapSize(size)
  result.env.setMaxReaders(readers)
  result.env.open(path)

proc open*(
  lmdb: LMDB,
  name: string = ""
) {.inline.} =
  lmdb.newDatabase(name)

proc close*(
  lmdb: LMDB
) =
  Database.close(lmdb)
  lmdb.env.close()
