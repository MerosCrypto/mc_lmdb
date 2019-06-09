#Environment and Database objects.
import LMDBEnvironmentObject
import LMDBDatabaseObject

#Tables standard lib.
import tables

#Define a type that includes an environment and databases.
type LMDB* = ref object
    env*: Environment
    dbs*: Table[string, ptr Database]
