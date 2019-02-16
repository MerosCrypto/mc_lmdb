import Environment

import Value
import Transaction

type Database* = cuint

{.push header: "lmdb.h".}
proc c_mdb_open(
    tx: ptr Transaction,
    name: cstring,
    flags: cuint,
    db: ptr Database
): cint {.importc: "mdb_dbi_open".}

proc c_mdb_put(
    tx: ptr Transaction,
    db: Database,
    key: ptr Value,
    val: ptr Value,
    flags: cuint
): cint {.importc: "mdb_put".}

proc c_mdb_del(
    tx: ptr Transaction,
    db: Database,
    key: ptr Value,
    val: ptr Value,
    flags: cuint
): cint {.importc: "mdb_del".}

proc c_mdb_close(
    env: ptr Environment,
    db: Database
) {.importc: "mdb_dbi_close".}
{.pop.}
