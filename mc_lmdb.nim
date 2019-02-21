#Include the LMDB header's folder.
const lmdbFolder = currentSourcePath().substr(0, currentSourcePath().len - 12) & "LMDB/"
{.passC: "-I " & lmdbFolder.}

#Link with the static library.
{.passL: lmdbFolder & "liblmdb.a".}

#Mode object.
import mc_lmdb/objects/ModeObject
export ModeObject.Mode

#Wrapper files.
import mc_lmdb/Environment
import mc_lmdb/Database

#Provide manual access to the Environment constructor/flags.
export Environment.newEnvironment
export Environment.EnvironmentFlags
export Environment.or

#Provide manual access to the Database constructor/flags.
export Database.newDatabase
export Database.DatabaseFlags
export Database.PutFlags
export Database.or

#Export get, put, and delete.
export Database.get
export Database.put
export Database.delete

#LMDB object.
import mc_lmdb/objects/LMDBObject
export LMDBObject.LMDB

#Opens a database at the path, creating one if it doesn't already exist.
proc newLMDB*(path: string): LMDB =
    result = LMDB(
        env: newEnvironment(path)
    )
    result.newDatabase()

#Closes an Environment and Database.
proc close*(lmdb: LMDB) =
    Database.close(lmdb)
    lmdb.env.close()
