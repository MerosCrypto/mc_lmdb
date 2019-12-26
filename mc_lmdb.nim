#Include the LMDB header's folder.
const lmdbFolder = currentSourcePath().substr(0, currentSourcePath().len - 12) & "LMDB/"
{.passC: "-I " & lmdbFolder.}

#Link with the static library.
when defined(Windows):
    {.passL: "advapi32.lib".}
    {.passL: lmdbFolder & "lmdb.lib".}
else:
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

#Tables lib.
import tables

#Opens an environment at the path, creating one if it doesn't already exist, with a max size of size.
proc newLMDB*(
    path: string,
    size: int64,
    quantity: int = 1,
    readers: int = 126
): LMDB =
    result = LMDB(
        env: newEnvironment(),
        dbs: initTable[string, ptr Database]()
    )
    result.env.setMaxDBs(quantity)
    result.env.setMapSize(size)
    result.env.setMaxReaders(readers)
    result.env.open(path)

#Open a DB.
proc open*(
    lmdb: LMDB,
    name: string = ""
) =
    lmdb.newDatabase(name)

#Closes an Environment and Database.
proc close*(
    lmdb: LMDB
) =
    #Use the file name to prevent this function from calling itself.
    LMDBDatabase.close(lmdb)
    lmdb.env.close()
