#Error lib.
import Error

#Wrapper files.
import Environment

import Value
import Transaction

#LMDB object.
import objects/LMDBObject

#Database object/flags.
import objects/DatabaseObject
export DatabaseObject.Database
export DatabaseObject.DatabaseFlags
export DatabaseObject.PutFlags
export DatabaseObject.or

#C procs.
{.push header: "lmdb.h".}
proc c_mdb_open(
    tx: Transaction,
    name: ptr char,
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

proc c_mdb_get(
    tx: Transaction,
    db: Database,
    key: Value,
    val: Value
): cint {.importc: "mdb_get".}

proc c_mdb_del(
    tx: Transaction,
    db: Database,
    key: Value,
    val: Value
): cint {.importc: "mdb_del".}

proc c_mdb_close(
    env: Environment,
    db: Database
) {.importc: "mdb_dbi_close".}
{.pop.}

#Constructor.
proc newDatabase*(
    lmdb: LMDB,
    flags: uint = uint(DatabaseFlags.Create),
) =
    var
        #Create a TX to open the DB with.
        tx: Transaction = lmdb.newTransaction()
        #Open the Database.
        err: cint = c_mdb_open(
            tx,
            nil,
            cuint(flags),
            addr lmdb.db
        )
    #Check the error code.
    err.check()

    #Commit the Transaction.
    tx.commit()

#Put a value into the Database.
proc put*(
    lmdb: LMDB,
    keyArg: string,
    valueArg: string,
    flags: uint = 0
) =
    var
        #Create a TX to set the value with.
        tx: Transaction = lmdb.newTransaction()
        #Create a Value of the key.
        key: Value = newValue(keyArg)
        #Create a Value of the value.
        value: Value = newValue(valueArg)

    #Get the value.
    var err: cint = c_mdb_put(tx, lmdb.db, key, value, cuint(flags))
    #Check the error code.
    err.check()

    #Commit the Transaction.
    tx.commit()

#Get a value from the Database.
proc get*(
    lmdb: LMDB,
    keyArg: string
): string =
    var
        #Create a TX to grab the value with.
        tx: Transaction = lmdb.newTransaction(uint(TransactionFlags.ReadOnly))
        #Create a Value of the key.
        key: Value = newValue(keyArg)
        #Create a Value for the value.
        value: Value

    #Get the value.
    var err: cint = c_mdb_get(tx, lmdb.db, key, value)
    #Check the error code.
    err.check()

    #Commit the Transaction.
    tx.commit()

    #Return the value.
    result = value

#Deletes a value from the Database.
proc delete*(
    lmdb: LMDB,
    keyArg: string
) =
    var
        #Create a TX to set the value with.
        tx: Transaction = lmdb.newTransaction()
        #Create a Value of the key.
        key: Value = newValue(keyArg)

    #Get the value.
    var err: cint = c_mdb_del(tx, lmdb.db, key, nil)
    #Check the error code.
    err.check()

    #Commit the Transaction.
    tx.commit()

#Close the DB.
proc close*(
    lmdb: LMDB
) =
    c_mdb_close(lmdb.env, lmdb.db)
