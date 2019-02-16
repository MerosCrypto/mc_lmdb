import Mode

{.push header: "lmdb.h".}
type Environment* {.importc: "MDB_env".} = object

proc c_mdb_env_create(
    env: ptr ptr Environment
): cint {.importc: "mdb_env_create".}

proc c_mdb_env_open(
    env: ptr Environment,
    path: cstring,
    flags: cuint,
    mode: Mode
): cint {.importc: "mdb_env_open".}

proc c_mdb_env_close(
    env: ptr Environment
) {.importc: "mdb_env_close".}
{.pop.}
