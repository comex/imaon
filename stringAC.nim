#INCLUDED#



type
    TStringVal* {.final, pure.} = object
        case isImm: bool
        of true:  imm: word
        of false: str: string

    TStringAsmCtx* = object
    PStringAsmCtx* = ref TStringAsmCtx

proc `$`*(a : TStringVal) : string =
    if a.isImm:
        return "#" & $a.imm
    elif a.str == nil:
        return "Invalid"
    else:
        return a.str

proc PCrel(input : TStringVal) : TStringVal =
    result.isImm = false
    result.str ="PC+" & $input.imm

proc SPrel(input : TStringVal) : TStringVal =
    result.isImm = false
    result.str = "SP+" & $input.imm

proc newPStringAsmCtx*() : PStringAsmCtx =
    return nil

proc Negate*(ctx : PStringAsmCtx, input : TStringVal) : TStringVal =
    result = input
    if input.isImm:
        result.str = "-" & result.str
    else:
        result.imm = -result.imm

proc IsZero*(ctx : PStringAsmCtx, input : TStringVal) : bool =
    if input.isImm:
        return input.str == "0"
    else:
        return input.imm == 0

proc Imm*(ctx : PStringAsmCtx, input : word) : TStringVal =
    result.isImm = true
    result.imm = input

proc ITarg*(ctx : PStringAsmCtx, input : seq[TCond]) : TStringVal =
    result.isImm = false
    result.str = ""
    for i in 1..input.len - 1:
        result.str.add(if input[i] == input[0]: "T" else: "E")
    

proc Reg*(ctx : PStringAsmCtx, input : TReg) : TStringVal =
    result.isImm = false
    result.str = $input

proc RegListA*(ctx : PStringAsmCtx, input : set[TReg]) : TStringVal =
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
    result.isImm = false
    result.str = res

proc ShiftA*(ctx : PStringAsmCtx, base : TStringVal, kind : TShiftKind, amt : TStringVal) : TStringVal =
    result.isImm = false
    result.str = $base & ", " & $kind & (if amt.isImm: "" else: " ") & $amt

proc DerefA*(ctx : PStringAsmCtx, base : TStringVal, offset : TStringVal, size : TDerefSize, kind : TDerefKind) : TStringVal =
    var sizeA = (if size == 4: "" else: $size)
    var offsetA = offset
    if base.str == "PC" and offsetA.isImm:
        offsetA = PCrel(offsetA)
    elif base.str == "SP" and offsetA.isImm:
        offsetA = SPrel(offsetA)
    var res : string
    case kind
    of dkOffset:
        res = "[$#, $#]$#" % [$base, $offsetA, sizeA]
    of dkPreInc:
        res = "[$#, $#]$#!" % [$base, $offsetA, sizeA]
    of dkPostInc:
        res = "[$#]$#, $#" % [$base, sizeA, $offset]
    result.isImm = false
    result.str = res

proc GenericOp*(ctx : PStringAsmCtx, name : string, flags : TInsnFlags, ents : openarray[TStringVal]) : TStringVal =
    var cond : string = $toCond(flags)
    if cond == "AL": cond = ""
    var S = if ifS in flags: "S" else: ""
    var a = name & S & cond & "  "
    for i in 0..high(ents):
        add(a, $ents[i])
        if i != high(ents): add(a, ", ")
    result.isImm = false
    result.str = a

beLazy(PStringAsmCtx, TStringVal)

