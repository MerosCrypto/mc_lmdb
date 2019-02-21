#Wrapper files.
import Error

import Environment

#LMDB object file.
import LMDB

type
    #C struct.
    CTransaction {.header: "lmdb.h", importc: "MDB_txn".} = object
    #Pointer.
    Transaction* = ptr CTransaction

#Transaction flags.
const ReadOnly: cuint = 0x20000

#C procs.
{.push header: "lmdb.h".}
proc c_mdb_txn_begin(
    env: Environment,
    parent: Transaction,
    flags: cuint,
    ret: ptr Transaction
): cint {.importc: "mdb_txn_begin".}

proc c_mdb_txn_commit(
    tx: Transaction
): cint {.importc: "mdb_txn_commit".}

proc c_mdb_txn_abort(
    tx: Transaction
) {.importc: "mdb_txn_abort".}
{.pop.}

#Constructor.
proc newTransaction*(lmdb: LMDB, readOnly: bool = false): Transaction =
    #Call the C proc.
    var err: cint = c_mdb_txn_begin(
        lmdb.env,
        nil,
        if readOnly: ReadOnly else: 0,
        addr result
    )

    #If there was an error, raise it.
    if err != 0:
        raise err.toError()

#Save a TX to disk.
proc commit*(tx: Transaction) =
    #Commit the TX.
    var err: cint = c_mdb_txn_commit(tx)

    #If there was an error, raise it.
    if err != 0:
        raise err.toError()

#Cancel a TX.
proc abort*(tx: Transaction) =
    c_mdb_txn_abort(tx)

#Free a TX.
proc free*(tx: Transaction) =
    dealloc(tx)
