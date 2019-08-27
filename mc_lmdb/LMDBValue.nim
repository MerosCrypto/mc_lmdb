#Value object.
import objects/LMDBValueObject
export LMDBValueObject.Value

#Constructor.
proc newValue*(
    valueArg: string = ""
): Value =
    #Extract the argument.
    var value: string = valueArg

    #If we're setting the Value to a string, not just allocating it...
    if value.len > 0:
        #Set the size and data fielda.
        result.mv_size = cuint(value.len)
        result.mv_data = cast[ptr char](alloc0(value.len))
        copyMem(result.mv_data, addr value[0], value.len)

#Converts a Value to a string.
converter toString*(
    value: Value
): string =
    if value.mv_size == 0:
        return ""

    result = newString(value.mv_size)
    copyMem(addr result[0], value.mv_data, result.len)
