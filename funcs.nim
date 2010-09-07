import types
proc ror*(b : TBinary, amt : int) : TBinary =
    result.size = b.size
    result.num = (b.num shr amt) or (b.num shl (b.size - amt))
    result.num = result.num and ((1 shl b.size) - 1)

