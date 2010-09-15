import types
proc bROR*(b : TBinary, amt : int) : TBinary =
    result.size = b.size
    result.num = (b.num shr amt) or (b.num shl (b.size - amt))
    result.num = result.num and ((1 shl b.size) - 1)

proc sxt*(b : TBinary) : TBinary =
    result.num = b.num
    result.size = 32
    if b[b.size-1].bit:
        orr(result.num, not ((1 shl b.size) - 1))

proc zxt*(b : TBinary) : TBinary {.inline.} =
    result.num = b.num
    result.size = 32

