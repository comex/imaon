import macros, strutils
import types
include "ltgt"

type
    word*  = int32
    short* = int16

    TShiftKind* = enum
        LSL,
        LSR,
        ASL,
        ASR,
        ROL,
        ROR,
        RRX

    TDerefKind* = enum
        dkOffset,
        dkPreInc,
        dkPostInc

    TDerefSize* = range[1..8]

    TCond* = enum
        AL,
        EQ,
        NE,
        CS,
        CC,
        MI,
        PL,
        VS,
        VC,
        HI,
        LS,
        GE,
        LT,
        GT,
        LE,
        BadCond

    TReg* = enum
        R0,
        R1,
        R2,
        R3,
        R4,
        R5,
        R6,
        R7,
        R8,
        R9,
        R10,
        R11,
        R12,
        SP,
        LR,
        PC

    TInsnFlag* = enum
        ifS, # update condition flags
        ifCond1, ifCond2, ifCond3, ifCond4, # actually the cond is stored here
        ifMagic,
    
    TInsnFlags* = set[TInsnFlag]

var ifSetC* = ifMagic # for things that take TEImm_C, set just carry (ifS may also be set)
var ifSTCL* = ifMagic # for STC and STC2, it's actually a STCL
var ifPLDW* = ifMagic # ditto
var ifCPSIE* = ifMagic # for CPS, enable as opposed to disable

proc rshift*(r : TReg) : TReg =
    return TReg(int(r) or 8)

proc `-`*(a : TReg, b : int) : TReg =
    return TReg(int(a) - b)

template RegList*(ctx : expr, rs : expr) : expr =
    ctx.RegListA(cast[set[TReg]](rs.num))

var aCond1 : TInsnFlags = {ifCond1}
var iCond1 = cast[int](aCond1)

proc fromCond*(input : TCond) : TInsnFlags =
    return cast[TInsnFlags](iCond1 * int(input))

proc fromCond*(input : TBinary) : TInsnFlags =
    return fromCond(TCond(input.num))

proc toCond*(input : TInsnFlags) : TCond =
    return TCond((cast[int](input) div iCond1) and int(high(TCond)))
import allAC


template ctxspec(TAsmCtx : typedesc, TVal : typedesc, TRVal : typedesc) =
    proc Shift*(ctx : TAsmCtx, base : TRVal, kind : TShiftKind, amt : TRVal) : TRVal {.inline.} =
        if ctx.IsZero(amt):
            return base
        return ctx.ShiftA(base, kind, amt)

    proc Deref*(ctx : TAsmCtx, base : TVal, offset : TRVal, size : TDerefSize, index : bool, writeback : bool, add : bool) : TVal =
        var offsetA = offset
        if not add:
            offsetA = ctx.Negate(offsetA)
        var kind : TDerefKind
        if index and writeback:
            kind = dkPreInc
        elif index:
            kind = dkOffset
        elif writeback:
            kind = dkPostInc
        else:
            if not ctx.IsZero(offset):
                raise oops[EInvalidValue]("Since P=0 and W=0, offset should be 0")
            kind = dkOffset
        return ctx.DerefA(base, offsetA, size, kind)
    
    #-

    proc ConvertToVal*(ctx : TAsmCtx, thing : TVal) : TVal =
        return thing

    proc ConvertToVal*(ctx : TAsmCtx, thing : TBinary) : TVal =
        return >ctx.Imm(thing.num)

    proc ConvertToVal*(ctx : TAsmCtx, thing : TReg) : TVal =
        return ctx.Reg(thing)
    
    proc ConvertToVal*(ctx : TAsmCtx, thing : int) : TVal =
        return >ctx.Imm(thing)

    # -
    
    proc ConvertToRVal*(ctx : TAsmCtx, thing : TRVal) : TRVal =
        return thing
    
    proc ConvertToRVal*(ctx : TAsmCtx, thing : TBinary) : TRVal =
        return ctx.Imm(thing.num)

    proc ConvertToRVal*(ctx : TAsmCtx, thing : TReg) : TRVal =
        return <ctx.Reg(thing)
    
    proc ConvertToRVal*(ctx : TAsmCtx, thing : int) : TRVal =
        return ctx.Imm(thing)

    #-

    # true, false, true


foreachAC(ctxspec)


#macro z*(n : expr) : expr =
#    result = newNimNode(nnkCall, n)
#    result.add(n[1])
#    result.add(newIdentNode("ctx"))
#    result.add(n[2])
#    for i in 3..n.len - 1:
#        var call = newNimNode(nnkCall)
#        call.add(newIdentNode(">"))
#        call.add(n[i])
#        result.add(call)


# This is way broken.
# hi i way broken.
proc parseIT*(itcond : TCond, itarg : TBinary) : seq[TCond] =
    var length : int
    if itarg.bit(0):
        length = 3
    elif itarg.bit(1):
        length = 2
    elif itarg.bit(2):
        length = 1
    elif itarg.bit(3):
        length = 0
    var firstcond = int(itcond)
    result = @[itcond]
    for i in countdown(3, 4 - length):
        result.add(TCond((firstcond and 0b1110) or itarg[i].num))
    

