#Error lib.
import Error

#Mode object (there is no wrapper file).
import objects/ModeObject

#Environment object/flags.
import objects/EnvironmentObject
export EnvironmentObject.Environment
export EnvironmentObject.EnvironmentFlags
export EnvironmentObject.or

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

proc c_mdb_env_close(
    env: Environment
) {.importc: "mdb_env_close".}
{.pop.}

#Constructor.
proc newEnvironment*(
    path: string,
    flags: uint = EnvironmentFlags.NoSubDir or EnvironmentFlags.NoTLS or EnvironmentFlags.NoReadAhead,
    mode: uint = 600
): Environment =
    #Create the Environment.
    var err: cint = c_mdb_env_create(addr result)
    #Check the error code.
    err.check()

    #Open the Environment.
    err = c_mdb_env_open(
        result,
        path,
        cuint(flags),
        Mode(mode)
    )
    #Check the error code.
    err.check()

#Close an Environment.
proc close*(env: Environment) =
    c_mdb_env_close(env)
