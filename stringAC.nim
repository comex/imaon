import allAC
import lazyAC
import types, armtypes
import strutils

proc newPStringAsmCtx*() : PStringAsmCtx =
    return nil

proc t(ctx : PStringAsmCtx, a : string) : string=
    return a

proc u(a : string) : string =
    return a

proc Negate*(ctx : PStringAsmCtx, input : string) : string =
    return ctx.t("-" & u(input))

proc IsZero*(ctx : PStringAsmCtx, input : string) : bool =
    return u(input) == "0"

proc Imm*(ctx : PStringAsmCtx, input : word) : string =
    return ctx.t("#" & $input)

proc Reg*(ctx : PStringAsmCtx, input : TReg) : string =
    return ctx.t($input)

proc RegListA*(ctx : PStringAsmCtx, input : set[TReg]) : string =
    var res = "{"
    var ranging = false
    var rangestart : TReg
    for i in R0..SP:
        if i != SP and i in input:
            if not ranging:
                if len(res) > 1: res.add(", ")
                res.add($i)
                ranging = true
                rangestart = i
        else:
            if ranging:
                if rangestart == i - 1:
                    nil
                elif rangestart == i - 2:
                    res.add(", R" & $(i - 1))
                else:
                    res.add("-R" & $(i - 1))
                ranging = false
    if SP in input:
        if len(res) > 1: res.add(", ")
        res.add("SP")
    if LR in input:
        if len(res) > 1: res.add(", ")
        res.add("LR")
    if PC in input:
        if len(res) > 1: res.add(", ")
        res.add("PC")
                
    res.add("}")
    return ctx.t(res)

proc ShiftA*(ctx : PStringAsmCtx, base : string, kind : TShiftKind, amt : string) : string =
    return ctx.t(u(base) & ", " & $kind & (if u(amt)[0] == '#': "" else: " ") & u(amt ))

proc DerefA*(ctx : PStringAsmCtx, base : string, offset : string, size : TDerefSize, kind : TDerefKind) : string =
    var sizeA = (if size == 4: "" else: $size)
    var res : string
    case kind
    of dkOffset:
        res = "[$#, $#]$#" % [u(base), u(offset), sizeA]
    of dkPreInc:
        res = "[$#, $#]$#!" % [u(base), u(offset), sizeA]
    of dkPostInc:
        res = "[$#]$#, $#" % [u(base), sizeA, u(offset)]
    return ctx.t(res)

proc GenericOp*(ctx : PStringAsmCtx, name : string, flags : TInsnFlags, ents : openarray[string]) : string =
    var a = name & "  "
    for i in 0..high(ents):
        add(a, u(ents[i]))
        if i != high(ents): add(a, ", ")
    result = ctx.t(a)
    GCref(a)
    ctx.stringsICareAbout = @[]

beLazy(PStringAsmCtx, string)

