#Error lib.
import LMDBError

#Environment wrapper.
import LMDBEnvironment

#LMDB object.
import objects/LMDBObject

#transaction object/flags.
import objects/LMDBTransactionObject
export LMDBTransactionObject.Transaction
export LMDBTransactionObject.TransactionFlags
export LMDBTransactionObject.or

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
{.pop.}

#Constructor.
proc newTransaction*(
    lmdb: LMDB,
    flags: uint = 0
): Transaction =
    #Call the C proc.
    var err: cint = c_mdb_txn_begin(
        lmdb.env,
        nil,
        cuint(flags),
        addr result
    )

    #Check the error code.
    err.check()

#Save a TX to disk.
proc commit*(tx: Transaction) =
    #Commit the TX.
    var err: cint = c_mdb_txn_commit(tx)

    #Check the error code.
    err.check()
