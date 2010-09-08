#INCLUDED#

type TStringAsmCtx* = object
type PStringAsmCtx* = ref TStringAsmCtx

proc newPStringAsmCtx*() : PStringAsmCtx =
    return nil

proc Negate*(ctx : PStringAsmCtx, input : string) : string =
    return ("-" & input)

proc IsZero*(ctx : PStringAsmCtx, input : string) : bool =
    return input == "0"

proc Imm*(ctx : PStringAsmCtx, input : word) : string =
    return ("#" & $input)

proc Reg*(ctx : PStringAsmCtx, input : TReg) : string =
    return ($input)

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
    return (res)

proc ShiftA*(ctx : PStringAsmCtx, base : string, kind : TShiftKind, amt : string) : string =
    return (base & ", " & $kind & (if amt[0] == '#': "" else: " ") & amt)

proc DerefA*(ctx : PStringAsmCtx, base : string, offset : string, size : TDerefSize, kind : TDerefKind) : string =
    var sizeA = (if size == 4: "" else: $size)
    var res : string
    case kind
    of dkOffset:
        res = "[$#, $#]$#" % [base, offset, sizeA]
    of dkPreInc:
        res = "[$#, $#]$#!" % [base, offset, sizeA]
    of dkPostInc:
        res = "[$#]$#, $#" % [base, sizeA, offset]
    return (res)

proc GenericOp*(ctx : PStringAsmCtx, name : string, flags : TInsnFlags, ents : openarray[string]) : string =
    var cond : string = $toCond(flags)
    if cond == "AL": cond = ""
    var a = name & cond & "  "
    for i in 0..high(ents):
        add(a, ents[i])
        if i != high(ents): add(a, ", ")
    result = a

beLazy(PStringAsmCtx, string)

