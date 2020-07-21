import LMDBError

import objects/EnvironmentObj
export EnvironmentObj

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

proc c_mdb_env_set_maxdbs(
  env: Environment,
  quantity: cuint
): cint {.importc: "mdb_env_set_maxdbs".}

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

proc newEnvironment*(): Environment {.inline.} =
  c_mdb_env_create(addr result).check()

proc setMaxDBs*(
  env: Environment,
  quantity: int
) {.inline.} =
  c_mdb_env_set_maxdbs(env, cuint(quantity)).check()

proc setMapSize*(
  env: Environment,
  size: int64
) {.inline.} =
  c_mdb_env_set_mapsize(env, size).check()

proc setMaxReaders*(
  env: Environment,
  readers: int
) {.inline.} =
  c_mdb_env_set_maxreaders(env, cuint(readers)).check()

proc open*(
  env: Environment,
  path: string,
  flags: EnvironmentFlags = EnvironmentFlags.NoSubDir or
                            EnvironmentFlags.NoTLS or
                            EnvironmentFlags.NoReadAhead,
  mode: uint = 0o666
) {.inline.} =
  c_mdb_env_open(env, path, cuint(flags), Mode(mode)).check()

proc close*(
  env: Environment
) {.inline.} =
  c_mdb_env_close(env)
