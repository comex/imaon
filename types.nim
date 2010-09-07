type
    TEndian* = enum
        LittleEndian,
        BigEndian

const endian : TEndian = LittleEndian

proc oops*[T]() : ref T =
    new(result)

proc oops*[T](msg : string) : ref T =
    new(result)
    result.msg = msg

template orr*(a : expr, b : expr) : stmt =
    a = a or b

type 
    TBinary* = object
        size*: int
        num*: int

proc `==`*(a : TBinary, b : TBinary) : bool {.inline.} =
    return a.num == b.num

proc `$`*(b : TBinary) : string =
    result = "b\""
    var a = 1 shl (b.size - 1)
    for i in 0..b.size - 1:
        if (b.num and a) != 0:
            result.add("1")
        else:
            result.add("0")
        a = a shr 1
    result.add("\"")


proc Binary*(num : int, size : int) : TBinary {.inline.} =
    result.num = num
    result.size = size

proc b*(b : string) : TBinary {.inline.} =
    result.size = len(b)
    result.num = 0
    var a = 1
    for i in countdown(b.len - 1, 0):
        if b[i] == '1':
            orr(result.num, a)
        elif b[i] != '0':
            raise oops[EInvalidValue]("Invalid binary string: " & b)
        a = a shl 1

proc cat*(bs : openarray[TBinary]) : TBinary =
    var shift = 0
    result.num = 0
    for i in countdown(bs.len - 1, 0):
        orr(result.num, bs[i].num shl shift)
        inc(shift, bs[i].size)
    result.size = shift

proc `[,]`*(b : TBinary, hi_p : int, lo_p : int) : TBinary {.inline.} =
    var hi = hi_p
    var lo = lo_p
    when endian == BigEndian:
        hi = b.size - hi
        lo = b.size - lo
    if hi < lo: swap(hi, lo)
    if hi >= b.size or lo < 0:
         raise oops[EInvalidIndex]()
    result.size = hi - lo + 1
    result.num = (b.num and ((1 shl (hi + 1)) - 1)) shr lo

proc `[]`*(b : TBinary, i : int) : TBinary {.inline.} =
    if i >= b.size:
        raise oops[EInvalidIndex]()
    result.size = 1
    result.num = (b.num and (1 shl i)) shr i

proc bclear*(b : TBinary, i : int) : TBinary {.inline.} =
    result.size = b.size
    result.num = b.num and (not (1 shl i))

proc bset*(b : TBinary, i : int) : TBinary {.inline.} =
    result.size = b.size
    result.num = b.num or (1 shl i)
    
proc bit*(b : TBinary, i : int) : bool {.inline.} =
    when endian == BigEndian:
        i = b.size - i
    return (b.num and (1 shl i)) != 0

proc bit*(b : TBinary) : bool {.inline.} =
    if b.size != 1:
        raise oops[EInvalidValue]("bit() only meaningful for 1-bit strings")
    return b.num != 0

proc bit*(b : int) : bool {.inline.} =
    return b != 0

proc sxt*(b : TBinary) : TBinary =
    result.num = b.num
    result.size = 32
    if b[b.size-1].bit:
        orr(result.num, not (1 shl (b.size - 1)))

proc zxt*(b : TBinary) : TBinary {.inline.} =
    result.num = b.num
    result.size = 32

