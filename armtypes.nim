import macros, strutils
import armops
import types

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

    TEntKind* = enum
        ekNull,
        ekImm,
        ekReg,
        ekRegList,
        ekShift,
        ekDeref,
        ekPCRel,

    TDerefKind* = enum
        dkOffset,
        dkPreInc,
        dkPostInc

    TEntBase* {.acyclic, final, pure.} = object
        case kind*: TEntKind
        of ekImm, ekPCRel:
            imm*: word
        of ekReg:
            regNum*: range[0..15]
        of ekRegList:
            rlNums*: set[range[0..15]]
        of ekShift:
            shiftKind*: TShiftKind
        of ekDeref:
            derefKind*: TDerefKind
        else: nil

    TEnt* {.acyclic, final, pure.} = object
        base*: TEntBase
        arg1: TEntBase
        arg2: TEntBase

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

    TInsn* {.acyclic, final, pure.} = object
        op: TOp
        cond : TCond
        S : bool
        misc: int8
        ents : array[0..4, TEnt]

    PInsn* = ref TInsn

const nullEnt : TEnt

proc do_ror*(b : TBinary, amt : int) : TBinary =
    result.size = b.size
    result.num = (b.num shr amt) or (b.num shl (b.size - amt))
    result.num = result.num and ((1 shl b.size) - 1)

# Todo: maybe this should be an enum?
proc regname(num : int) : string =
    case num
    of 13:
        return "SP"
    of 14:
        return "LR"
    of 15:
        return "PC"
    else:
        return "R" & $num
proc regname(num : range[0..15]) : string =
    return regname(int(num))

proc repr*(ent : TEntBase, insn : const PInsn) : string {.nosideeffect.} =
    case ent.kind
    of ekImm:
        result = '#' & $ent.imm
    of ekPCRel:
        result = "#<" & $ent.imm & ">"
    of ekReg:
        result = regname(ent.regNum)
        if insn != nil and (insn.op == opLDMIA or insn.op == opLDMDB or insn.op == opSTMIA or insn.op == opSTMDB): result.add('!')
    of ekRegList:
        result = "{"
        var ranging = false
        var rangestart : int
        for i in 0..13:
            if i != 13 and i in ent.rlNums:
                if not ranging:
                    if len(result) > 1: result.add(", ")
                    result.add(regname(i))
                    ranging = true
                    rangestart = i
            else:
                if ranging:
                    if rangestart == i - 1:
                        nil
                    elif rangestart == i - 2:
                        result.add(", R" & $(i - 1))
                    else:
                        result.add("-R" & $(i - 1))
                    ranging = false
        if 13 in ent.rlNums:
            if len(result) > 1: result.add(", ")
            result.add("SP")
        if 14 in ent.rlNums:
            if len(result) > 1: result.add(", ")
            result.add("LR")
        if 15 in ent.rlNums:
            if len(result) > 1: result.add(", ")
            result.add("PC")
                    
        result.add("}")
    else:
        result = "???"

proc repr*(ent : TEnt, insn : PInsn) : string {.nosideeffect.} =
    case ent.base.kind
    of ekShift:
        result = "$#, $#$#" % [repr(ent.arg1, insn), $ent.base.shiftKind, repr(ent.arg2, insn)]
    of ekDeref:
        if ent.arg2.kind == ekImm and ent.arg2.imm == 0:
            return "[$#]" % [repr(ent.arg1, insn)]
        elif ent.base.derefKind == dkPreInc:
            return "[$#, $#]!" % [repr(ent.arg1, insn), repr(ent.arg2, insn)]
        elif ent.base.derefKind == dkPostInc:
            return "[$#], $#" % [repr(ent.arg1, insn), repr(ent.arg2, insn)]
        else:
            return "[$#, $#]" % [repr(ent.arg1, insn), repr(ent.arg2, insn)]
    else:
        return repr(ent.base, insn)

proc shift*(r : TEnt) : TEnt =
    result = r
    result.base.regNum = result.base.regNum or 8

macro z*(n : expr) : expr =
    result = newNimNode(nnkCall, n)
    result.add(newIdentNode("Insn"))
    result.add(n[1])#newIdentNode($n[1].ident))
    result.add(n[2])
    if n.len > 3:
        #var prefix = newNimNode(nnkPrefix)
        #prefix.add(newIdentNode("@"))
        var bracket = newNimNode(nnkBracket)
        for i in 3..n.len - 1:
            var call = newNimNode(nnkCall)
            call.add(newIdentNode("@"))
            call.add(n[i])
            bracket.add(call)
        #prefix.add(bracket)
        result.add(bracket)
    #debug(result)

proc Imm*(i : word) : TEnt {.inline.} =
    result.base.kind = ekImm
    result.base.imm = i

proc PCRel*(i : word) : TEnt {.inline.} =
    result.base.kind = ekPCRel
    result.base.imm = i

proc Reg*(r : range[0..15]) : TEnt {.inline.} =
    result.base.kind = ekReg
    result.base.regNum = r

proc RegList*(rs : TBinary) : TEnt {.inline.} =
    result.base.kind = ekRegList
    result.base.rlNums = cast[set[range[0..15]]](rs.num)

var SP* : TEnt = Reg(13)
var LR* : TEnt = Reg(14)
var PC* : TEnt = Reg(15)

proc rshift*(r : TEnt) : TEnt =
    return Reg(r.base.regNum + 8)

proc Shift*(base : TEnt, kind : TShiftKind, amt : TEnt) : TEnt =
    if amt.base.kind == ekImm and amt.base.imm == 0: return base
    result.base.kind = ekShift
    result.arg1 = base.base
    result.base.shiftKind = kind
    result.arg2 = amt.base

proc Deref*(base : TEnt, offset : TEnt, index : bool, writeback : bool, add : bool) : TEnt =
    result.base.kind = ekDeref
    result.arg1 = base.base
    result.arg2 = offset.base
    if result.arg1.kind == ekReg and result.arg1.regNum == 15 and result.arg2.kind == ekImm:
        result.arg2.kind = ekPCRel
    if not add:
        if result.arg2.kind != ekImm:
            raise oops[EInvalidValue]("I don't know how to negate $#" % [repr(offset, nil)])
        result.arg2.imm = -result.arg2.imm
    if index and writeback:
        result.base.derefKind = dkPreInc
    elif index:
        result.base.derefKind = dkOffset
    elif writeback:
        result.base.derefKind = dkPostInc
    else:
        if result.arg2.kind != ekImm or result.arg2.imm != 0:
            raise oops[EInvalidValue]("Since P=0 and W=0, $# should be 0" % [repr(offset, nil)])

proc Deref*(base : TEnt, offset : TEnt) : TEnt =
    return Deref(base, offset, true, false, true)

proc `@`*(e : TEnt) : TEnt =
    return e

proc `@`*(i : word) : TEnt =
    return Imm(i) 

proc `@`*(i : TBinary) : TEnt =
    return Imm(i.num)

proc `!`*(i : TBinary) : word =
    return i.num

# hack!
proc Cond*(input : int) : int =
    if input == 14:
        return 0 shl 1
    elif input == 15:
        return 15 shl 1
    else:
        return (input + 1) shl 1
proc Cond*(input : TBinary) : int =
    return Cond(input.num)
proc Cond*(input : TCond) : int =
    return Cond(int(input))

proc Insn*(op : TOp, flags : int, ents : array[0..4, TEnt]) : PInsn =
    new(result)
    result.op = op
    result.S = (flags and 1) != 0
    result.cond = TCond((flags shr 1) and 0b1111)
    result.misc = int8(flags shr 5)
    result.ents = ents

proc Insn*(op : TOp, flags : int) : PInsn =
    var a : seq[TEnt] = @[]
    return Insn(op, flags, a)

# This is way broken.
proc parseIT(insn : PInsn) : seq[TCond] =
    var misc : TBinary
    misc.size = 4
    misc.num = int(insn.misc)
    var length : int
    if misc.bit(0):
        length = 3
    elif misc.bit(1):
        length = 2
    elif misc.bit(2):
        length = 1
    elif misc.bit(3):
        length = 0
    var firstcond = int(insn.cond)
    result = @[insn.cond]
    for i in countdown(3, 4 - length):
        result.add(TCond((firstcond and 0b1110) or misc[i].num))
    

proc `$`*(insn : PInsn) : string =
    result = copy($insn.op, 2)
    if insn.S:
        result.add("S")
    if insn.op == opIT:
        var conds = parseIT(insn)
        for i in 1..conds.len - 1:
            result.add(if conds[i] == conds[0]: "T" else: "E")
        result.add(" ")
    if insn.cond != AL:
        result.add($insn.cond)
    
    var ents = insn.ents
    for i in 0..len(ents) - 1:
        if i == 0: result.add(" ")
        result.add(repr(ents[i], insn))
        if i != len(ents) - 1: result.add(", ")

# ugh
proc `==`*(a : TEntBase, b : TEntBase) : bool =
    if a.kind != b.kind: return False
    case a.kind
    of ekImm, ekPCRel:
        return a.imm == b.imm
    of ekReg:
        return a.regNum == b.regNum 
    of ekRegList:
        return a.rlNums == b.rlNums 
    of ekShift:
        return a.shiftKind == b.shiftKind
    of ekDeref:
        return a.derefKind == b.derefKind
    of ekNull:
        return true

proc `==`*(a : TEnt, b : TEnt) : bool =
    return a.base == b.base and a.arg1 == b.arg1 and a.arg2 == b.arg2

#echo(z(MOV, 1, Reg(4), Shift(Imm(24), ROR, 2)))
#var s = b"1010101"
#s = cat(b"00", s)
#echo("it is: $#" % $s)
#echo(s[2])
#echo(s[42])
