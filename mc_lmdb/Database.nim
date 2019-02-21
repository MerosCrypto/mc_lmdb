import Environment

import Value
import Transaction

import objects/DatabaseObject
export DatabaseObject.Database

{.push header: "lmdb.h".}
proc c_mdb_open(
    tx: Transaction,
    name: cstring,
    flags: cuint,
    db: ptr Database
): cint {.importc: "mdb_dbi_open".}

proc c_mdb_put(
    tx: Transaction,
    db: Database,
    key: Value,
    val: Value,
    flags: cuint
): cint {.importc: "mdb_put".}

proc c_mdb_del(
    tx: Transaction,
    db: Database,
    key: Value,
    val: Value,
    flags: cuint
): cint {.importc: "mdb_del".}

proc c_mdb_close(
    env: Environment,
    db: Database
) {.importc: "mdb_dbi_close".}
{.pop.}
