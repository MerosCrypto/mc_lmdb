import objects/ModeObject

import objects/EnvironmentObject
export Environment

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
