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

#Include the LMDB headers and compile the relevant source files.
const currentFolder = currentSourcePath().substr(0, currentSourcePath().len - 12)
{.passC: "-I" & currentFolder & "LMDB/".}
{.compile: currentFolder & "LMDB/mdb.c".}
{.compile: currentFolder & "LMDB/midl.c".}

#Opens a database at the path, creating one if it doesn't already exist.
proc newLMDB*(
    path: string,
    name: string
): LMDB =
    result = LMDB(
        env: newEnvironment(path)
    )
    result.newDatabase(name)

#Closes an Environment and Database.
proc close*(lmdb: LMDB) =
    Database.close(lmdb)
    lmdb.env.close()
