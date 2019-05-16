#Error lib.
import LMDBError

#Mode object (there is no wrapper file).
import objects/LMDBModeObject

#Environment object/flags.
import objects/LMDBEnvironmentObject
export LMDBEnvironmentObject.Environment
export LMDBEnvironmentObject.EnvironmentFlags
export LMDBEnvironmentObject.or

#C procs.
{.push header: "lmdb.h".}
proc c_mdb_env_create(
    env: ptr Environment
): cint {.importc: "mdb_env_create".}

proc c_mdb_env_open(
    env: Environment,
    path: cstring,
    flags: cuint,
    mode: Mode
): cint {.importc: "mdb_env_open".}

proc c_mdb_env_set_mapsize(
    env: Environment,
    size: int64
): cint {.importc: "mdb_env_set_mapsize".}

proc c_mdb_env_setmaxreaders(
    env: Environment,
    readers: cuint
): cint {.importc: "mdb_env_set_maxreaders".}

proc c_mdb_env_close(
    env: Environment
) {.importc: "mdb_env_close".}
{.pop.}

#Constructor.
proc newEnvironment*(): Environment =
    #Create the Environment.
    var err: cint = c_mdb_env_create(addr result)
    #Check the error code.
    err.check()

#Set the map size.
proc setMapSize*(
    env: Environment,
    size: int64
) =
    #Open the Environment.
    var err: cint = c_mdb_env_set_mapsize(
        env,
        size
    )
    #Check the error code.
    err.check()

proc setMaxReaders*(
    env: Environment,
    readers: int
) =
    #Open the Environment.
    var err: cint = c_mdb_env_set_maxreaders(
        env,
        cuint(readers)
    )
    #Check the error code.
    err.check()

#Open an Environment.
proc open*(
    env: Environment,
    path: string,
    flags: EnvironmentFlags = EnvironmentFlags.NoSubDir or EnvironmentFlags.NoTLS or EnvironmentFlags.NoReadAhead,
    mode: uint = 0o666
) =
    #Open it.
    var err: cint = c_mdb_env_open(
        env,
        path,
        cuint(flags),
        Mode(mode)
    )
    #Check the error code.
    err.check()

#Close an Environment.
proc close*(
    env: Environment
) =
    c_mdb_env_close(env)
