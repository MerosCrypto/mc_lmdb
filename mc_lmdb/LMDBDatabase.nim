#Error lib.
import LMDBError

#Wrapper files.
import LMDBEnvironment

import LMDBValue
import LMDBTransaction

#LMDB object.
import objects/LMDBObject

#Database object/flags.
import objects/LMDBDatabaseObject
export LMDBDatabaseObject.Database
export LMDBDatabaseObject.DatabaseFlags
export LMDBDatabaseObject.PutFlags
export LMDBDatabaseObject.or

#Table standard lib.
import tables

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
    key: ptr Value,
    val: ptr Value,
    flags: cuint
): cint {.importc: "mdb_put".}

proc c_mdb_get(
    tx: Transaction,
    db: Database,
    key: ptr Value,
    val: ptr Value
): cint {.importc: "mdb_get".}

proc c_mdb_del(
    tx: Transaction,
    db: Database,
    key: ptr Value,
    val: ptr Value
): cint {.importc: "mdb_del".}

proc c_mdb_close(
    env: Environment,
    db: Database
) {.importc: "mdb_dbi_close".}
{.pop.}

#Constructor.
proc newDatabase*(
    lmdb: LMDB,
    nameArg: string,
    flags: DatabaseFlags = DatabaseFlags.Create,
) =
    #Extract the name argument.
    var name: string = nameArg

    #Allocate the DBs.
    lmdb.dbs[name] = cast[ptr Database](alloc0(sizeof(Database)))

    var
        #Create a TX to open the DB with.
        tx: Transaction = lmdb.newTransaction()
        #Open the Database.
        err: cint = c_mdb_open(
            tx,
            if name == "": nil else: (addr name[0]),
            cuint(flags),
            lmdb.dbs[name]
        )
    #Check the error code.
    err.check()

    #Commit the Transaction.
    tx.commit()

#Put a value into the Database.
proc put*(
    lmdb: LMDB,
    name: string,
    keyArg: string,
    valueArg: string,
    flags: PutFlags = PutFlags.None
) =
    var
        #Create a TX to set the value with.
        tx: Transaction = lmdb.newTransaction()
        #Create a Value of the key.
        key: Value = newValue(keyArg)
        #Create a Value of the value.
        value: Value = newValue(valueArg)

    #Set the value.
    var err: cint = c_mdb_put(tx, lmdb.dbs[name][], addr key, addr value, cuint(flags))
    #Check the error code.
    err.check()
    #Commit the Transaction.
    tx.commit()

#Put a value into the Database.
proc put*(
    lmdb: LMDB,
    name: string,
    values: seq[tuple[key: string, value: string]],
    flags: PutFlags = PutFlags.None
) =
    var
        #Create a TX to set the values with.
        tx: Transaction = lmdb.newTransaction()
        #Value for the key.
        key: Value
        #Value for the value.
        value: Value

    for val in values:
        key = newValue(val.key)
        value = newValue(val.value)

        #Set the value.
        if val.key != key:
            doAssert(false, "Value has a different value than the string.")
        var err: cint = c_mdb_put(tx, lmdb.dbs[name][], addr key, addr value, cuint(flags))
        #Check the error code.
        err.check()

    #Commit the Transaction.
    tx.commit()

#Get a value from the Database.
proc get*(
    lmdb: LMDB,
    name: string,
    keyArg: string
): string =
    var
        #Create a TX to grab the value with.
        tx: Transaction = lmdb.newTransaction(TransactionFlags.ReadOnly)
        #Create a Value of the key.
        key: Value = newValue(keyArg)
        #Create a Value for the value.
        value: Value = newValue()

    #Get the value.
    var err: cint = c_mdb_get(tx, lmdb.dbs[name][], addr key, addr value)
    #Commit the Transaction.
    tx.commit()
    #Check the error code.
    err.check()

    #Return the value.
    result = value

#Deletes a value from the Database.
proc delete*(
    lmdb: LMDB,
    name: string,
    keyArg: string
) =
    var
        #Create a TX to set the value with.
        tx: Transaction = lmdb.newTransaction()
        #Create a Value of the key.
        key: Value = newValue(keyArg)

    #Get the value.
    var err: cint = c_mdb_del(tx, lmdb.dbs[name][], addr key, nil)
    #Commit the Transaction.
    tx.commit()
    #Check the error code.
    err.check()

#Close the DB.
proc close*(
    lmdb: LMDB
) =
    for key in lmdb.dbs.keys():
        c_mdb_close(lmdb.env, lmdb.dbs[key][])
