#Environment and Database objects.
import LMDBEnvironmentObject
import LMDBDatabaseObject

#Define a type that includes an environment and a database.
type LMDB* = ref object of RootObj
    env*: Environment
    db*: Database
