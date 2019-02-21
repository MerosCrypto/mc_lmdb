#Value object.
import objects/ValueObject
export Value

#Constructor.
proc newValue*(valueArg: string): Value =
    #Copy the argument.
    var value: string = valueArg

    #Allocate the Value.
    result = cast[Value](alloc0(sizeof(CValue)))
    #Set the size and data fielda.
    result.mv_size = cuint(value.len)
    result.mv_data = addr value[0]
