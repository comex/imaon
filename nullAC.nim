#INCLUDED#
# Doesn't actually do anything except make sure you did your homework.
type TNullAsmCtx* = object
type PNullAsmCtx* = ref TNullAsmCtx
type TNullVal* = object
type TNullRVal* = object


proc newPNullAsmCtx*() : PNullAsmCtx {.inline.} =
    return nil

proc ConvertToVal*(ctx : PNullAsmCtx, input : TNullRVal) : TNullVal {.inline.} =
    nil

proc ConvertToRVal*(ctx : PNullAsmCtx, input : TNullVal) : TNullRVal {.inline.} =
    nil

proc Negate*(ctx : PNullAsmCtx, input : TNullRVal) : TNullRVal {.inline.} =
    nil

proc IsZero*(ctx : PNullAsmCtx, input : TNullRVal) : bool {.inline.} =
    return false
    
proc Imm*(ctx : PNullAsmCtx, input : word) : TNullRVal {.inline.} =
    nil

proc PCrel*(ctx : PNullAsmCtx, input : word) : TNullRVal {.inline.} =
    nil

proc ITarg*(ctx : PNullAsmCtx, input : seq[TCond]) : TNullRVal {.inline.} =
    nil

proc CPSarg*(ctx : PNullAsmCtx, I : bool, F : bool) : TNullRVal {.inline.} =
    nil

proc Reg*(ctx : PNullAsmCtx, input : TReg) : TNullVal {.inline.} =
    nil

proc RegListA*(ctx : PNullAsmCtx, input : set[TReg]) : TNullVal {.inline.} =
    nil

proc ShiftA*(ctx : PNullAsmCtx, base : TNullRVal, kind : TShiftKind, amt : TNullRVal) : TNullRVal {.inline.} =
    nil

proc DerefA*(ctx : PNullAsmCtx, base : TNullVal, offset : TNullRVal, size : TDerefSize, kind : TDerefKind) : TNullVal {.inline.} =
    nil

proc GenericOp*(ctx : PNullAsmCtx, iname : TOpName, name : string, flags : TInsnFlags, ents : openarray[TNullVal]) : TNullVal {.inline.} =
    nil

beLazy(PNullAsmCtx, TNullVal)


