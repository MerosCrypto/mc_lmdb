#Include the LMDB header's folder.
const lmdbFolder = currentSourcePath().substr(0, currentSourcePath().len - 12) & "LMDB/"
{.passC: "-I " & lmdbFolder.}

#Link with the static library.
{.passL: lmdbFolder & "liblmdb.a".}

#Mode object.
import mc_lmdb/objects/LMDBModeObject
export LMDBModeObject.Mode

#Error lib.
import mc_lmdb/LMDBError
export LMDBError.LMDBError

#Wrapper files.
import mc_lmdb/LMDBEnvironment
import mc_lmdb/LMDBDatabase

#Provide manual access to the Environment constructor/flags.
export LMDBEnvironment.newEnvironment
export LMDBEnvironment.EnvironmentFlags
export LMDBEnvironment.or

#Provide manual access to the Database constructor/flags.
export LMDBDatabase.newDatabase
export LMDBDatabase.DatabaseFlags
export LMDBDatabase.PutFlags
export LMDBDatabase.or

#Export put, get, and delete.
export LMDBDatabase.put
export LMDBDatabase.get
export LMDBDatabase.delete

#LMDB object.
import mc_lmdb/objects/LMDBObject
export LMDBObject.LMDB

#Opens a database at the path, creating one if it doesn't already exist, with a max size of size (default 1 GB).
proc newLMDB*(path: string, size: int64): LMDB =
    result = LMDB(
        env: newEnvironment(path)
    )
    result.env.setMapSize(size)
    result.newDatabase()

#Closes an Environment and Database.
proc close*(lmdb: LMDB) =
    #Use the file name to prevent this function from calling itself.
    LMDBDatabase.close(lmdb)
    lmdb.env.close()
