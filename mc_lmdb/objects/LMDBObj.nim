import tables

import EnvironmentObj
export EnvironmentObj
import DatabaseObj

type LMDB* = ref object
  env*: Environment
  dbs*: Table[string, Database]

proc newLMDBObj*(
  env: Environment
): LMDB {.inline.} =
  LMDB(
    env: env,
    dbs: initTable[string, Database]()
  )
