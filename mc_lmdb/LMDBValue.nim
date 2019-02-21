#Value object.
import objects/LMDBValueObject
export LMDBValueObject.Value

#Constructor.
proc newValue*(valueArg: string): Value =
    #Copy the argument.
    var value: string = valueArg

    #Allocate the Value.
    result = cast[Value](alloc0(sizeof(CValue)))
    #Set the size and data fielda.
    result.mv_size = cuint(value.len)
    result.mv_data = addr value[0]

#Converts a Value to a string.
converter toString*(value: Value): string =
    result = newString(value.mv_size)
    copyMem(addr result[0], value.mv_data, result.len)
