#Environment and Database objects.
import EnvironmentObject
import DatabaseObject

#Define a type that includes an environment and a database.
type LMDB* = ref object of RootObj
    env*: Environment
    db*: Database
